Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5817C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:25:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54FB206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgC3IZ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:25:57 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42637 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbgC3IZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:25:56 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1jIpjy-00021V-UM; Mon, 30 Mar 2020 10:25:50 +0200
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1jIpjw-0002dB-LS; Mon, 30 Mar 2020 10:25:48 +0200
Date:   Mon, 30 Mar 2020 10:25:48 +0200
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     lars@metafoo.de, alexandru.Ardelean@analog.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, bigeasy@linutronix.de,
        m.olbrich@pengutronix.de, kernel@pengutronix.de
Subject: Re: [PATCH] usb: dwc3: gadget: don't dequeue requests on already
 disabled endpoints
Message-ID: <20200330082548.GL27849@pengutronix.de>
References: <dc52d6a0-12ed-a34c-01c4-0fc5ccbf7b1d@metafoo.de>
 <20200327084302.606-1-m.grzeschik@pengutronix.de>
 <875zeokhoa.fsf@kernel.org>
 <20200329190244.GK27849@pengutronix.de>
 <87sghq2tum.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wZdghQXYJzyo6AGC"
Content-Disposition: inline
In-Reply-To: <87sghq2tum.fsf@kernel.org>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:41:05 up 39 days, 15:11, 80 users,  load average: 1.00, 0.56,
 0.31
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wZdghQXYJzyo6AGC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2020 at 10:18:57AM +0300, Felipe Balbi wrote:
>=20
> Hi,
>=20
> Michael Grzeschik <mgr@pengutronix.de> writes:
> >> > dwc3_gadget_ep_disable gets called before the last request gets
> >> > dequeued.
> >> >
> >> > In __dwc3_gadget_ep_disable all started, pending and cancelled
> >> > lists for this endpoint will call dwc3_gadget_giveback in
> >> > dwc3_remove_requests.
> >> >
> >> > After that no list containing the afterwards dequed request,
> >> > therefor it is not necessary to run the dequeue routine.
> >> >
> >> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> >> > ---
> >> > @Lars-Peter Clausen:
> >> >
> >> > This patch addresses the case that not queued requests get dequeued.
> >> > The only case that this happens seems on disabling the gadget.
> >> >
> >> >  drivers/usb/dwc3/gadget.c | 3 +++
> >> >  1 file changed, 3 insertions(+)
> >> >
> >> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> >> > index 9a6f741d1db0dc..5d4fa8d6c93e49 100644
> >> > --- a/drivers/usb/dwc3/gadget.c
> >> > +++ b/drivers/usb/dwc3/gadget.c
> >> > @@ -1609,6 +1609,9 @@ static int dwc3_gadget_ep_dequeue(struct usb_e=
p *ep,
> >> > =20
> >> >  	trace_dwc3_ep_dequeue(req);
> >> > =20
> >> > +	if (!(dep->flags & DWC3_EP_ENABLED))
> >> > +		return 0;
> >>=20
> >> which driver is trying to call dequeue after the endpoint is disabled?
> >> Got some tracepoints of the problem happening?
> >
> > I see the case when using uvc-gadget.
> >
> > Look into uvc_v4l2_release in uvc_v4l2.c:
> >
> > uvc_function_disconnect
> >    composite_disconnect
> >       reset_config
> >          uvc_function_disable->usb_ep_disable
> >
> > uvcg_video_enable
> >    usb_ep_dequeue
> >       dwc3_gadget_ep_dequeue
>=20
> Oh, I see what you mean. We get a disconnect, which disables the
> endpoints, which forces all requests to be dequeued. Now I remember why
> this exists: we giveback the requests from disconnect because not all
> gadget drivers will call usb_ep_dequeue() if simply told about the
> disconnect. Then UDC drivers have to be a little more careful and make
> sure that all requests are givenback.
>=20
> In any case, why is it a problem to call usb_ep_dequeue()? Is it only
> because of that dev_err()? We could just remove that message,
> really.

In my case, it is not a problem removing the dev_err. The ep_dequeue
will only be called once for each request at the stream end. I don't
know about the case Lars has mentioned.

If we have to search all lists for the request every n times while in
traffic, only to find out that it was not enqueued, I think it would be
worth it to keep the dev_err and let these cases trigger so we have an
option to find and avoid/fix these.

> Eventually, I want to move more of this logic into UDC core so
> udc drivers can be simplified. For that work, though, first we would
> have to add a "generic" struct usb_ep_hw implementation and manage list
> of requests as part of UDC core as well.

I don't know about the cases you plan to abstract but it sounds
like a good idea to get some gadget logic out of the drivers.

Thanks,
Michael

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--wZdghQXYJzyo6AGC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAl6BrQUACgkQC+njFXoe
LGTnRQ/+MzuaYcXWW6Wcfj5AJjiqb9RuzdHPUCrc48bZJFhaDOoJwO/eJ9C9zZM0
/AAXJi9e/f89wRvMAQ1CyN6qT2SPqYxlZSKO4zuFyjyuslfujPCg4r372zisXFQJ
mJpLileNOs8meBP4jfaD6ikGC5Vqb4J1YK7JX7dWAiqOKeJ1xFWTaU/QrQxwYVzU
uL8PB/EZf/Y8EQrYIOaln0DvbJuVNllpK2uzwkjSnEe1lM9VCeiMcD+GJB+kkkNd
dpATvxEqhVBWq9Xu0biwcWWrDfLtYBccxNd77Qy7IPIYWTiWHJaQFrkijsj5TevY
oGWIZ/UvzUrSssu6VUgLXhoi1xaizjnGprL9WY2vx6E5nOiuUpWqQ8A/ahukuG58
S01liCaic7NjcNyPtAO+zLaZt+oR06WO/t2B7GArhnTY7o4l69zGIIkRvUhYc94z
o42iUvghfbCXHmQaqK9ar3cT0brFmYDTm7vEJxpAPJbKKkgkmqPCqSqQOKp3iYF7
dgrVLdC1tvtoCiA51OPitqVttoyJZsLmRTGQbvExI54sqgh4ynJh7031SbPEd59Z
T8oCl/fAoTZG4xWthYZUFP+uXAF/ALzMIyi3ggwJA4dJKc1q8GZ7aCOV52na8Lpl
sqoEAw20vuLEXDfuwKT5FkyCWIQ6szWYn+U5wExMzV7zdvjZxg8=
=ON5s
-----END PGP SIGNATURE-----

--wZdghQXYJzyo6AGC--
