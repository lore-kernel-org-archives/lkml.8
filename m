Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42309C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1905A206B6
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgF3DzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 23:55:15 -0400
Received: from shelob.surriel.com ([96.67.55.147]:58356 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgF3DzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 23:55:14 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1jq7MM-0006ta-Uk; Mon, 29 Jun 2020 23:55:02 -0400
Message-ID: <6917929c7dd7786b5b673743ce45bbcd56e6b1f1.camel@surriel.com>
Subject: Re: XHCI vs PCM2903B/PCM2904 part 2
From:   Rik van Riel <riel@surriel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb <linux-usb@vger.kernel.org>, alsa-devel@alsa-project.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Date:   Mon, 29 Jun 2020 23:55:02 -0400
In-Reply-To: <b98bfefc2911e5265b6c28d9730a18e7953b847c.camel@surriel.com>
References: <273cc1c074cc4a4058f31afe487fb233f5cf0351.camel@surriel.com>
         <20200520163840.GA11084@rowland.harvard.edu>
         <667d8d156fa5d8420ef1c3b1d08b94a10d2398cc.camel@surriel.com>
         <20200520203417.GA23602@rowland.harvard.edu>
         <d75c3a3cda51149a054838652243de2b8ac20854.camel@surriel.com>
         <059878e7-75b8-e033-ec9f-7e6b73df8f78@linux.intel.com>
         <b98bfefc2911e5265b6c28d9730a18e7953b847c.camel@surriel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ZRKuGvfuaKsRX315ie48"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZRKuGvfuaKsRX315ie48
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-06-29 at 23:21 -0400, Rik van Riel wrote:

> > Could you add the code below and take new traces, it will show the
> > endpoint
> > state after the Babble error.
>=20
> Hi Mathias,
>=20
> I have finally rebooted into a kernel with your tracepoint.
> After a babble error, I get the following info in the trace.
>=20
> [  556.716334] xhci_hcd 0000:00:14.0: Babble error for slot 13 ep 8
> on
> endpoint
>=20
>  28672.016 :0/0 xhci-hcd:xhci_handle_tx_event(info: 196609, info2:
> 12845096, deq: 69501877488, tx_info: 12845252)
>  34816.037 :0/0 xhci-hcd:xhci_handle_tx_event(info: 196609, info2:
> 12845096, deq: 69501877856, tx_info: 12845252)
>  38912.043 :0/0 xhci-hcd:xhci_handle_tx_event(info: 196609, info2:
> 12845096, deq: 69501870176, tx_info: 12845252)

OK, this is strange indeed.
info: 0x30001
info2: 0xc40028
tx_info: c400c4

That suggests the device state is EP_STATE_DISABLED, but
we never got the error from the EP_STATE_DISABLED test near
the start of handle_tx_event(). If we had, the big switch
statement containing the code below would have been bypassed.

Unless I am mistaken, does that mean the endpoint context
(*ep_ctx) got modified while the code was in the middle of
handle_tx_event()?

What would cause that? A subsequent transfer to an endpoint
while it is in EP_STATE_HALTED, which the comment suggests=20
is the expected endpoint state for a babble error?

> > diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-
> > ring.c
> > index 0fda0c0f4d31..373d89ef7275 100644
> > --- a/drivers/usb/host/xhci-ring.c
> > +++ b/drivers/usb/host/xhci-ring.c
> > @@ -2455,6 +2455,7 @@ static int handle_tx_event(struct xhci_hcd
> > *xhci,
> >  	case COMP_BABBLE_DETECTED_ERROR:
> >  		xhci_dbg(xhci, "Babble error for slot %u ep %u on
> > endpoint\n",
> >  			 slot_id, ep_index);
> > +		trace_xhci_handle_tx_event(ep_ctx);
> >  		status =3D -EOVERFLOW;
> >  		break;
> >  	/* Completion codes for endpoint error state */
> > diff --git a/drivers/usb/host/xhci-trace.h b/drivers/usb/host/xhci-
> > trace.h
> > index b19582b2a72c..5081df079f4a 100644
> > --- a/drivers/usb/host/xhci-trace.h
> > +++ b/drivers/usb/host/xhci-trace.h
> > @@ -360,6 +360,11 @@ DEFINE_EVENT(xhci_log_ep_ctx,
> > xhci_add_endpoint,
> >  	TP_ARGS(ctx)
> >  );
> > =20
> > +DEFINE_EVENT(xhci_log_ep_ctx, xhci_handle_tx_event,
> > +	TP_PROTO(struct xhci_ep_ctx *ctx),
> > +	TP_ARGS(ctx)
> > +);
> > +
> >  DECLARE_EVENT_CLASS(xhci_log_slot_ctx,
> >  	TP_PROTO(struct xhci_slot_ctx *ctx),
> >  	TP_ARGS(ctx),
> >=20
> >=20
> >=20
--=20
All Rights Reversed.

--=-ZRKuGvfuaKsRX315ie48
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl76t5YACgkQznnekoTE
3oM51wf+IDH4yBPUjkRX/nVrBrZmFVKaBY8Tlnvrh9/2TO3yFreONlaz/te9FHcj
8Q85/ykFQZZ6qKohlJZ8vIcIx49kiuotuzQnoyF3Uo5MyyVjbJKVezxEJcbuiZLu
BWg90C6vgRyBr202vA72pcHek7oL5vz5J0+QXYuH21xeioKoD0PcP2919erBqXOs
/vxEGnhKIdd8V2AixZdi/SytlFiUkxD6nxHqzSnv7d0vkSIqojtAHzainNv0yDZC
MlwdTG49W0YYS4h9Id3AvP89xAwdXOSkyC2OCiDA2WllGO8lRpN5GYb3OaFd/iGh
Qru+7Fiu6PS7Y1eVnmIolXKhMeEnTA==
=HhVq
-----END PGP SIGNATURE-----

--=-ZRKuGvfuaKsRX315ie48--

