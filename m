Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F42EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC79D206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgF3D3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 23:29:14 -0400
Received: from shelob.surriel.com ([96.67.55.147]:56760 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbgF3D3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 23:29:14 -0400
X-Greylist: delayed 447 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Jun 2020 23:29:13 EDT
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1jq6q1-0006Nm-7o; Mon, 29 Jun 2020 23:21:37 -0400
Message-ID: <b98bfefc2911e5265b6c28d9730a18e7953b847c.camel@surriel.com>
Subject: Re: XHCI vs PCM2903B/PCM2904 part 2
From:   Rik van Riel <riel@surriel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb <linux-usb@vger.kernel.org>, alsa-devel@alsa-project.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Date:   Mon, 29 Jun 2020 23:21:36 -0400
In-Reply-To: <059878e7-75b8-e033-ec9f-7e6b73df8f78@linux.intel.com>
References: <273cc1c074cc4a4058f31afe487fb233f5cf0351.camel@surriel.com>
         <20200520163840.GA11084@rowland.harvard.edu>
         <667d8d156fa5d8420ef1c3b1d08b94a10d2398cc.camel@surriel.com>
         <20200520203417.GA23602@rowland.harvard.edu>
         <d75c3a3cda51149a054838652243de2b8ac20854.camel@surriel.com>
         <059878e7-75b8-e033-ec9f-7e6b73df8f78@linux.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-7H8YpOtf/vhHCGpd5MEU"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7H8YpOtf/vhHCGpd5MEU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[keeping old context since it's been a month...]

On Mon, 2020-05-25 at 12:37 +0300, Mathias Nyman wrote:
> On 21.5.2020 6.45, Rik van Riel wrote:
> > On Wed, 2020-05-20 at 16:34 -0400, Alan Stern wrote:
> > > On Wed, May 20, 2020 at 03:21:44PM -0400, Rik van Riel wrote:
> > > > Interesting. That makes me really curious why things are
> > > > getting stuck, now...
> > >=20
> > > This could be a bug in xhci-hcd.  Perhaps the controller's
> > > endpoint=20
> > > state needs to be updated after one of these errors
> > > occurs.  Mathias=20
> > > will know all about that.
> >=20
> > I am seeing something potentially interesting in the
> > giant trace. First the final enqueue/dequeue before
> > the babble error:
> >=20
> >           <idle>-0     [005] d.s. 776367.638233: xhci_inc_enq: ISOC
> > 0000000033a6879e: enq 0x0000001014070420(0x0000001014070000) deq
> > 0x0000001014070360(0x0000001014070000) segs 2 stream 0 free_trbs
> > 497
> > bounce 196 cycle 1
> >=20
> > The next reference to 0x0000001014070360 is the babble error,
> > and some info on the ISOC buffer itself:
> >=20
> >           <idle>-0     [005] d.h. 776367.639187: xhci_handle_event:
> > EVENT: TRB 0000001014070360 status 'Babble Detected' len 196 slot
> > 15 ep
> > 9 type 'Transfer Event' flags e:C
> >           <idle>-0     [005] d.h. 776367.639195:
> > xhci_handle_transfer:
> > ISOC: Buffer 0000000e2676f400 length 196 TD size 0 intr 0 type
> > 'Isoch'
> > flags b:i:I:c:s:I:e:C
> > n
> > Immediately after the babble error, the next request is enqueued,
> > and the doorbell is rung:
> >=20
> >           <idle>-0     [005] d.h. 776367.639196: xhci_inc_deq: ISOC
> > 0000000033a6879e: enq 0x0000001014070420(0x0000001014070000) deq
> > 0x0000001014070370(0x0000001014070000) segs 2 stream 0 free_trbs
> > 498 bounce 196 cycle 1
> >           <idle>-0     [005] d.h. 776367.639197: xhci_urb_giveback:
> > ep4in-isoc: urb 0000000072126553 pipe 135040 slot 15 length 196/196
> > sgs 0/0 stream 0 flags 00000206
> >           <idle>-0     [005] d.h. 776367.639197: xhci_inc_deq:
> > EVENT 0000000097f84b16: enq 0x00000010170b5000(0x00000010170b5000)
> > deq 0x00000010170b5670(0x00000010170b5000) segs 1 stream 0
> > free_trbs 254 bounce 0 cycle 1
> >           <idle>-0     [005] ..s. 776367.639212: xhci_urb_enqueue:
> > ep4in-isoc: urb 0000000072126553 pipe 135040 slot 15 length 0/196
> > sgs 0/0 stream 0 flags 00000206
> >           <idle>-0     [005] d.s. 776367.639214: xhci_queue_trb:
> > ISOC: Buffer 0000000e2676f400 length 196 TD size 0 intr 0 type
> > 'Isoch' flags b:i:I:c:s:I:e:c
> >           <idle>-0     [005] d.s. 776367.639214: xhci_inc_enq: ISOC
> > 0000000033a6879e: enq 0x0000001014070430(0x0000001014070000) deq
> > 0x0000001014070370(0x0000001014070000) segs 2 stream 0 free_trbs
> > 497 bounce 196 cycle 1
> >           <idle>-0     [005] d.s. 776367.639215:
> > xhci_ring_ep_doorbell: Ring doorbell for Slot 15 ep4in
> >=20
> > However, after that point, no more xhci_handle_transfer: ISOC
> > lines ar seen in the log. The doorbell line above is the last
> > line in the log for ep4in.
> >=20
> > Is this some area where USB3 and USB2 behave differently?
>=20
> It acts as if the endpoint is no longer running.
>=20
> If the endpoint would be halted then
> xhci_requires_manual_halt_cleanup() should
> reset the endpoints and it would show in the traces.
>=20
> Could you add the code below and take new traces, it will show the
> endpoint
> state after the Babble error.

Hi Mathias,

I have finally rebooted into a kernel with your tracepoint.
After a babble error, I get the following info in the trace.

[  556.716334] xhci_hcd 0000:00:14.0: Babble error for slot 13 ep 8 on
endpoint

 28672.016 :0/0 xhci-hcd:xhci_handle_tx_event(info: 196609, info2:
12845096, deq: 69501877488, tx_info: 12845252)
 34816.037 :0/0 xhci-hcd:xhci_handle_tx_event(info: 196609, info2:
12845096, deq: 69501877856, tx_info: 12845252)
 38912.043 :0/0 xhci-hcd:xhci_handle_tx_event(info: 196609, info2:
12845096, deq: 69501870176, tx_info: 12845252)

I hope this is useful :)

> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-
> ring.c
> index 0fda0c0f4d31..373d89ef7275 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -2455,6 +2455,7 @@ static int handle_tx_event(struct xhci_hcd
> *xhci,
>  	case COMP_BABBLE_DETECTED_ERROR:
>  		xhci_dbg(xhci, "Babble error for slot %u ep %u on
> endpoint\n",
>  			 slot_id, ep_index);
> +		trace_xhci_handle_tx_event(ep_ctx);
>  		status =3D -EOVERFLOW;
>  		break;
>  	/* Completion codes for endpoint error state */
> diff --git a/drivers/usb/host/xhci-trace.h b/drivers/usb/host/xhci-
> trace.h
> index b19582b2a72c..5081df079f4a 100644
> --- a/drivers/usb/host/xhci-trace.h
> +++ b/drivers/usb/host/xhci-trace.h
> @@ -360,6 +360,11 @@ DEFINE_EVENT(xhci_log_ep_ctx, xhci_add_endpoint,
>  	TP_ARGS(ctx)
>  );
> =20
> +DEFINE_EVENT(xhci_log_ep_ctx, xhci_handle_tx_event,
> +	TP_PROTO(struct xhci_ep_ctx *ctx),
> +	TP_ARGS(ctx)
> +);
> +
>  DECLARE_EVENT_CLASS(xhci_log_slot_ctx,
>  	TP_PROTO(struct xhci_slot_ctx *ctx),
>  	TP_ARGS(ctx),
>=20
>=20
>=20
--=20
All Rights Reversed.

--=-7H8YpOtf/vhHCGpd5MEU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl76r8AACgkQznnekoTE
3oOnJAgAqIU1wK6FVNYgdtzF7fZpGRBrZ0LvLsVY2moqdjCcJ3htP4bdNKnAyLGK
vEvkA4baneooSIgsRmZxzCVseQXkSDPDKN9Zw3nC4Ohig3wSmy8/w/sYIgMpsfwS
vUUdjgrNe0ivvwL6MvVchsAfAugJ8Xs1rE9pCpdEXi5vdGEdOCA9UtSCRl2wk3oP
YJWurHs68aU/Ge4S1oo8cnNp+IDYhRUxyAwBGKquigzYu+s3+dPig9EgxmJYilXM
9SEtxfeA8wcTqCoRXghDKW1zAxBGOE/5B449DoWLLrM2L/+W7obklS8EpQbxuF3p
GQsehy0WurxKnM8sRMrVtE7m55z8CA==
=ZBQZ
-----END PGP SIGNATURE-----

--=-7H8YpOtf/vhHCGpd5MEU--

