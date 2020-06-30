Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE4DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C52D2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 18:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgF3SwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 14:52:13 -0400
Received: from shelob.surriel.com ([96.67.55.147]:34738 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgF3SwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 14:52:12 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1jqLMP-0002vL-Gr; Tue, 30 Jun 2020 14:52:01 -0400
Message-ID: <d1afa4db34ab5c25646c4823d6de6b6c8b1caa26.camel@surriel.com>
Subject: Re: XHCI vs PCM2903B/PCM2904 part 2
From:   Rik van Riel <riel@surriel.com>
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb <linux-usb@vger.kernel.org>, alsa-devel@alsa-project.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Date:   Tue, 30 Jun 2020 14:52:01 -0400
In-Reply-To: <4a463fe0-f1af-a0f9-af2e-e36c060e8105@linux.intel.com>
References: <273cc1c074cc4a4058f31afe487fb233f5cf0351.camel@surriel.com>
         <20200520163840.GA11084@rowland.harvard.edu>
         <667d8d156fa5d8420ef1c3b1d08b94a10d2398cc.camel@surriel.com>
         <20200520203417.GA23602@rowland.harvard.edu>
         <d75c3a3cda51149a054838652243de2b8ac20854.camel@surriel.com>
         <059878e7-75b8-e033-ec9f-7e6b73df8f78@linux.intel.com>
         <b98bfefc2911e5265b6c28d9730a18e7953b847c.camel@surriel.com>
         <6917929c7dd7786b5b673743ce45bbcd56e6b1f1.camel@surriel.com>
         <90D456E4-328F-49F7-99C4-D729E38FA04E@surriel.com>
         <4a463fe0-f1af-a0f9-af2e-e36c060e8105@linux.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-7NyvvUamcwuVGpiWU8yI"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7NyvvUamcwuVGpiWU8yI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-06-30 at 17:27 +0300, Mathias Nyman wrote:
> On 30.6.2020 16.08, Rik van Riel wrote:
> > I misread the code, it's not a bitfield, so state 1 means an
> > endpoint marked with running state. The next urb is never getting a
> > response, though.
> >=20
> > However, the xhci spec says an endpoint is halted upon a babble
> > error.
>=20
> I was looking at the same, so according to specs this state shouldn't
> be possible.=20

The PCM2903B chip, and potentially the hub it is behind,
are USB2 devices, though. Does USB2 know about halted
endpoints?

> > The code right above the babble handling case adds halted into the
> > endpoint state itself. Does the code handling the babble error need
> > to do something similar to trigger cleanup elsewhere?=20
>=20
> It's a flag to prevent ringing the doorbell for a halted endpoint.
> Anyway, reset endpoint is meant to recover an endpoint in a halted
> state.
> Resetting non-halted endpoints will just lead to a context state
> error, and
> besides, isoc endpoints shouldn't halt.
>=20
> Anyways, I haven't got any better idea at the moment.
> You can try and see what a forced reset does with:

So close. Looks like something in the XHCI/USB stack isn't
doing the reset because something is in an unexpected state?

[   51.706798] xhci_hcd 0000:00:14.0: WARN Set TR Deq Ptr cmd failed
due to incorrect slot or ep state.
[   51.706802] got overflow, ep->flags =3D 2
[   51.932550] usb 3-9.7.5: reset high-speed USB device number 18 using
xhci_hcd
[   68.830396] xhci_hcd 0000:00:14.0: WARN Set TR Deq Ptr cmd failed
due to incorrect slot or ep state.
[   68.830409] got overflow, ep->flags =3D 2
[   70.077981] rfkill: input handler disabled
[  157.992374] got overflow, ep->flags =3D 2
[  157.992406] xhci_hcd 0000:00:14.0: WARN Set TR Deq Ptr cmd failed
due to incorrect slot or ep state.

> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-
> ring.c
> index 2c255d0620b0..d79aca0df6d4 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -1900,8 +1900,7 @@ static int
> xhci_requires_manual_halt_cleanup(struct xhci_hcd *xhci,
>                  * endpoint anyway.  Check if a babble halted the
>                  * endpoint.
>                  */
> -               if (GET_EP_CTX_STATE(ep_ctx) =3D=3D EP_STATE_HALTED)
> -                       return 1;
> +               return 1;
> =20
>         return 0;
>  }
>=20
> Traces also showed thet endpoint doorbell was rang after th babble
> error, so
> we know that didn't help restarting the endpoint.
>=20
> -Mathias
>=20
--=20
All Rights Reversed.

--=-7NyvvUamcwuVGpiWU8yI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl77idEACgkQznnekoTE
3oOwewf9FAxDEi8WPoGf33q9NOf2hCogJJp7urP2XP7E/QmVcG/436/AKPveEYUq
9TTYSyrG8hI2uBCVldmJ3lDoTQv3NkHcvAZWe9lstt3xS0/nF+8cIBNHajimu0DC
cvMzjYfijmQJWNEet6V2E4QheDO0/8VMsSMtlYoChBQMwipsmpboABbaTMU169Fw
uaCOOWd2BZ/elsOXwsNiodYU8bxFcBlUIjUEvX7ZWMwwd3PGkOAUEeXpBfzQ6qhc
iJ4LeQwR6pvp7iilULgw3VkY4fRkBlaPu7AByi/785254NFkx2AKkJwf//ulP4BD
V7DyRlP/ixVcmCLCLUGsOkEbgXoZxQ==
=3MRP
-----END PGP SIGNATURE-----

--=-7NyvvUamcwuVGpiWU8yI--

