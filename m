Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A60AC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A17E20578
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 10:44:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgC0Kn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 06:43:59 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58081 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbgC0Kn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 06:43:58 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1jHmSv-0001Op-Nz; Fri, 27 Mar 2020 11:43:53 +0100
Received: from mgr by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mgr@pengutronix.de>)
        id 1jHmSu-0004GC-Gm; Fri, 27 Mar 2020 11:43:52 +0100
Date:   Fri, 27 Mar 2020 11:43:52 +0100
From:   Michael Grzeschik <mgr@pengutronix.de>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     alexandru.Ardelean@analog.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, balbi@kernel.org,
        gregkh@linuxfoundation.org, bigeasy@linutronix.de,
        m.olbrich@pengutronix.de, kernel@pengutronix.de
Subject: Re: [PATCH] usb: dwc3: gadget: don't dequeue requests on already
 disabled endpoints
Message-ID: <20200327104352.GF27849@pengutronix.de>
References: <dc52d6a0-12ed-a34c-01c4-0fc5ccbf7b1d@metafoo.de>
 <20200327084302.606-1-m.grzeschik@pengutronix.de>
 <f746cc1f-b5e2-af0a-d946-edce634c46c3@metafoo.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EDJsL2R9iCFAt7IV"
Content-Disposition: inline
In-Reply-To: <f746cc1f-b5e2-af0a-d946-edce634c46c3@metafoo.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:40:34 up 36 days, 18:11, 85 users,  load average: 0.51, 0.21,
 0.14
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mgr@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EDJsL2R9iCFAt7IV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2020 at 10:14:10AM +0100, Lars-Peter Clausen wrote:
> On 3/27/20 9:43 AM, Michael Grzeschik wrote:
> > dwc3_gadget_ep_disable gets called before the last request gets
> > dequeued.
> >=20
> > In __dwc3_gadget_ep_disable all started, pending and cancelled
> > lists for this endpoint will call dwc3_gadget_giveback in
> > dwc3_remove_requests.
> >=20
> > After that no list containing the afterwards dequed request,
> > therefor it is not necessary to run the dequeue routine.
> >=20
> > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > ---
> > @Lars-Peter Clausen:
> >=20
> > This patch addresses the case that not queued requests get dequeued.
> > The only case that this happens seems on disabling the gadget.
>=20
>=20
> I don't believe it does. Calling usb_ep_dequeue() is not limited to be
> called after the endpoint has been disabled. It is part of the API and can
> be called at any time. E.g. with function_fs you can abort a queued trans=
fer
> from userspace at any time.

OK, can you give me an Userspace example how to simply trigger the
issue. I tried to figure your mentioned function stack but it would
be much easier if it could be reproduced.

The patch on the other hand can stand on itself, as it then
fixes another code path that is much more common.

Regads,
Michael

> >=20
> >   drivers/usb/dwc3/gadget.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >=20
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > index 9a6f741d1db0dc..5d4fa8d6c93e49 100644
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@ -1609,6 +1609,9 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *=
ep,
> >   	trace_dwc3_ep_dequeue(req);
> > +	if (!(dep->flags & DWC3_EP_ENABLED))
> > +		return 0;
> > +
> >   	spin_lock_irqsave(&dwc->lock, flags);
> >   	list_for_each_entry(r, &dep->pending_list, list) {
>=20
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--EDJsL2R9iCFAt7IV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElXvEUs6VPX6mDPT8C+njFXoeLGQFAl592N0ACgkQC+njFXoe
LGQtSw/9FwbQzq60D+PS5pBU5U5GKKy5ji9a4ukn3qdw/DMIYlV8Q6b/upxspaPP
g+1LQ/WmyxD+fhu2W9s9ylRvXaLa3ZuDiKDNpaFpt/q9DRM182FDg3pOc1nOAOn2
Rot5Hk2NkrgDwDLRBv45cHT8omfckLTmheZGl0XM5T/rIAsy2Qhr0KmEVYWnUQpy
v7COEA3YjfvFQUlLJDz3+ZRkvaWjcyqCVQb2SF9CjINbeO9/DchfubzmXXFH1qA+
7X8HqM6+t/JJbfmQnp/6HgmCV/kN27EjCZ7xhMNAWW3eYf883g/hmSx5+PmHrsvC
HVCCHnlsKA1QnDpTSAX4Tqt7w1kNiWOfrX00q/pH3/VNaS1mK175seUYtm/PlHz6
1QhkxktjPDJFXISHv9ig0wirK6Ox+M6I5QgzPIN7aqjL4Re0GRZQPvYv2EP8u7uf
f53+AwhSvPeVunxCFMSDusXgiKhKxEFkyNvSP4HGBC0biZqhjMkMIF3TMuBWx8u0
KRX2l1rnLFxwx4mKXfZ2811nhLB7me5wn6e3nGDC9I113JDEXMb37Yq8O5HxzJ8L
ZBSt2XvfeEy6Iut6hmsVCi2c1TdTrKwv8hk1QB3Kb2/6ZCFJoCiqorR2gm6Ul+Rt
Y4LbBdRUhR/C7ol6s5iC/NRB5fmw+buTkpUuCRkhqJGdrF5wm04=
=3ul1
-----END PGP SIGNATURE-----

--EDJsL2R9iCFAt7IV--
