Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53B6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 938EB2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391169AbgFXONi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:13:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:37602 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388395AbgFXONi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:13:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 81222AD4B;
        Wed, 24 Jun 2020 14:13:36 +0000 (UTC)
Message-ID: <d4aa38dc0cbedd31530abf0aedbe57be22f84f88.camel@suse.de>
Subject: Re: [PATCH 15/50] staging: vchi: Unify struct shim_service and
 struct vchi_service_handle
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        kernel-list@raspberrypi.com, linux-kernel@vger.kernel.org,
        laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Date:   Wed, 24 Jun 2020 16:13:35 +0200
In-Reply-To: <20200624141141.GA30990@kadam>
References: <20200623164235.29566-1-nsaenzjulienne@suse.de>
         <20200623164235.29566-16-nsaenzjulienne@suse.de>
         <20200624141141.GA30990@kadam>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-D6XZ5Zq2MMerpxiHnmSD"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-D6XZ5Zq2MMerpxiHnmSD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-06-24 at 17:11 +0300, Dan Carpenter wrote:
> On Tue, Jun 23, 2020 at 06:42:01PM +0200, Nicolas Saenz Julienne wrote:
> > @@ -437,12 +432,10 @@ static void service_free(struct shim_service *ser=
vice)
> > =20
> >  int32_t vchi_service_open(struct vchiq_instance *instance,
> >  	struct service_creation *setup,
> > -	struct vchi_service_handle **handle)
> > +	struct vchi_service **service)
> >  {
> > -	struct shim_service *service =3D service_alloc(instance, setup);
> > -
> > -	*handle =3D (struct vchi_service_handle *)service;
> > =20
> > +	*service =3D service_alloc(instance, setup);
> >  	if (service) {
>=20
> This should be checking "*service".
>=20

Of course, thanks!

Reards,
Nicolas



--=-D6XZ5Zq2MMerpxiHnmSD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7zX48ACgkQlfZmHno8
x/5i/Qf/Rep33QfS1bSFPqml0IX6kfyvuerSi3oN3ZCHXzvIJEZN/Ffytl7MiODb
Zqd/ysG9Tkyx8SLCYW4tKmJwvSrfn3TJM4mtfHpEYcmjr9pUNVXVhf1WhsWMAna+
3UVSV3KNfKoCK4kJK9oDl6w20j3oW5JjTnVOwm1seC4jJrpa4ZXL8ufr55BjTucg
HleB4wa5SNcUs3NNhywa1bk6PfOWmnt9S7qQycGaOLeBhiXHS9HH9q1HL6S8Glnl
kD1XfTqUs1XMwDJ/wPWSAnjgiWID4bF6c0ys5OOoGy1Q5CF1hnWHmn9mKfyNw+n1
+HZvhgJpSG/7SBLRKHGG31TX9Gnzvg==
=OTJq
-----END PGP SIGNATURE-----

--=-D6XZ5Zq2MMerpxiHnmSD--

