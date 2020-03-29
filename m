Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262FCC2D0E5
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 19:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 004D92073E
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 19:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgC2TC4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 15:02:56 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:60165 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgC2TCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 15:02:55 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1jIdCr-00046Z-5E; Sun, 29 Mar 2020 21:02:49 +0200
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1jIdCm-0006jm-AW; Sun, 29 Mar 2020 21:02:44 +0200
Date:   Sun, 29 Mar 2020 21:02:44 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     lars@metafoo.de, alexandru.Ardelean@analog.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, bigeasy@linutronix.de,
        m.olbrich@pengutronix.de, kernel@pengutronix.de
Subject: Re: [PATCH] usb: dwc3: gadget: don't dequeue requests on already
 disabled endpoints
Message-ID: <20200329190244.GK27849@pengutronix.de>
References: <dc52d6a0-12ed-a34c-01c4-0fc5ccbf7b1d@metafoo.de>
 <20200327084302.606-1-m.grzeschik@pengutronix.de>
 <875zeokhoa.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mhjHhnbe5PrRcwjY"
Content-Disposition: inline
In-Reply-To: <875zeokhoa.fsf@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 20:52:30 up 39 days,  2:22, 58 users,  load average: 0.13, 0.15,
 0.11
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mhjHhnbe5PrRcwjY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2020 at 10:27:49AM +0200, Felipe Balbi wrote:
>=20
> Hi,
>=20
> Michael Grzeschik <m.grzeschik@pengutronix.de> writes:
> > dwc3_gadget_ep_disable gets called before the last request gets
> > dequeued.
> >
> > In __dwc3_gadget_ep_disable all started, pending and cancelled
> > lists for this endpoint will call dwc3_gadget_giveback in
> > dwc3_remove_requests.
> >
> > After that no list containing the afterwards dequed request,
> > therefor it is not necessary to run the dequeue routine.
> >
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > ---
> > @Lars-Peter Clausen:
> >
> > This patch addresses the case that not queued requests get dequeued.
> > The only case that this happens seems on disabling the gadget.
> >
> >  drivers/usb/dwc3/gadget.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 9a6f741d1db0dc..5d4fa8d6c93e49 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -1609,6 +1609,9 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *=
ep,
> > =20
> >  	trace_dwc3_ep_dequeue(req);
> > =20
> > +	if (!(dep->flags & DWC3_EP_ENABLED))
> > +		return 0;
>=20
> which driver is trying to call dequeue after the endpoint is disabled?
> Got some tracepoints of the problem happening?

I see the case when using uvc-gadget.

Look into uvc_v4l2_release in uvc_v4l2.c:

uvc_function_disconnect
   composite_disconnect
      reset_config
         uvc_function_disable->usb_ep_disable

uvcg_video_enable
   usb_ep_dequeue
      dwc3_gadget_ep_dequeue

Regards,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--mhjHhnbe5PrRcwjY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAl6A8NEACgkQC+njFXoe
LGQ0Fw/+L4PbKGZHpzrxaBgwG1dm6EU0lA3n6u3ux58FXsiXsYDXbwuzWBCgPpwJ
xYN743ySqpShHXwsdt0z1wVYOqYy9BEtMWaUO6Ln62gwgSsHDKVZPdX182YcA2dv
WBtgJaGdUNbIC+4Ea5QVuPBhw0LCBxoZNQ1Mm+QdjIcDWv5O8mt5ljjJEetu4M2o
kc3Ejo2j9qlow9NLkPtrSYCim2Muopwtsh50mUOgZlrn28a3C8gW4ojFVlEqAPLU
ru28cD7xiiyqWAaYa7Y4hsw06pd/PndtqJt9YEbv7QLIvxFpxmMDiJagEH2UWjY4
ZjjyhWn1Ou8FztMuCvj6Jkqh7gxgVjhKmAo3/n4jnEW+MKDqrqbAcDjE7PnV/dqf
WmRMaQCFDmvczaVlTtIP82Wo9jzc068KLfyexun0X9qb2Up+ewXVezEFeKAwSHtv
z+PimwJcW5YLryJlvwiQEXew3ymLInsQbTCE4JU3mJjq2z4vVGTH/x1iQcXD4YXP
7PWDVKUokGFAGeLTPc7ZrlnhuIOBd5Uv7EMk6mwMoohITPqatZ0Zwdyq5YNcgz3f
pLt6XKvU/Xl8yp/nu5YDRHmse/cEMApp2RYSfBakb7+vKQVDp8Hh/PAa7qrenPqm
xZmIkQHQkNdc3AfE7i5vjhgxbaYIrolJH9GTVEkWeyahgC8o2dw=
=FcUx
-----END PGP SIGNATURE-----

--mhjHhnbe5PrRcwjY--
