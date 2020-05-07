Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B59C54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6746221973
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgEGULJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:11:09 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:49935 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726367AbgEGULI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:11:08 -0400
X-Originating-IP: 93.29.109.196
Received: from aptenodytes (196.109.29.93.rev.sfr.net [93.29.109.196])
        (Authenticated sender: paul.kocialkowski@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 9AAF360002;
        Thu,  7 May 2020 20:11:03 +0000 (UTC)
Date:   Thu, 7 May 2020 22:11:03 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v6 2/3] drm: Add support for the LogiCVC display
 controller
Message-ID: <20200507201103.GH2422122@aptenodytes>
References: <20200430192746.1866325-1-paul.kocialkowski@bootlin.com>
 <20200430192746.1866325-3-paul.kocialkowski@bootlin.com>
 <CACvgo51mRse3su4exyTqXYJRPPc0VqaX9+tRyKUuBPtm5Q+6XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GBDnBH7+ZvLx8QD4"
Content-Disposition: inline
In-Reply-To: <CACvgo51mRse3su4exyTqXYJRPPc0VqaX9+tRyKUuBPtm5Q+6XQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GBDnBH7+ZvLx8QD4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Emil,

Thanks for the review!

On Mon 04 May 20, 14:28, Emil Velikov wrote:
> Just had a casual quick look for custom KMS properties, since new
> drivers made that mistake in the past.
> Thanks for not including any o/

Yeah I made sure not to include any, I know it easily gets very problematic=
 and
creates disparity between drivers while needing to be kept alive even when a
standard way arises due to the no API breakage policy.

The not-for-merge patch that I've sent does introduce some for the colorkey,
and that's why they are marked as such :)

> I made a couple of trivial suggestions - if you agree, feel free to
> keep them as follow-up patches.
>=20
> On Thu, 30 Apr 2020 at 20:28, Paul Kocialkowski
> <paul.kocialkowski@bootlin.com> wrote:
>=20
> > +int logicvc_of_property_parse_u32(struct device_node *of_node,
> > +                                 const char *name, u32 *target)
> > +{
> > +       struct logicvc_of_property *property;
> > +       const char *string;
> > +       u32 value;
> > +       int ret;
> > +
> > +       property =3D logicvc_of_property_lookup(name);
> > +       if (!property)
> > +               return -EINVAL;
> > +
> One could have the logicvc_of_properties[] entries indexed with the
> logicvc_of_property_parse_{u32,bool} caller, using that instead of the
> name string.

Do I understand correctly that you're suggesting passing each entry's
struct logicvc_of_property pointer to the function?

I went for strings to make the code explicit and easy to read so I'd really
like to keep it that way and avoid passing things like
&logicvc_of_properties[4] or an index integer.

> Aside: I suspect the array (as most other arrays in this patch) should
> be annotated const, correct?

Ah yes that's a good point, thanks!

>=20
> > +       if (property->range[0] || property->range[1])
> > +               if (value < property->range[0] || value > property->ran=
ge[1])
> Combine the two ifs?

Definitely :)

Cheers,

Paul

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--GBDnBH7+ZvLx8QD4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAl60a1cACgkQ3cLmz3+f
v9E6Vgf8CXAsmdWf2+5+7oCdYtuBoURivQuOltkFzZfR1KVdwskBr3MzQylFa+BC
BaWUbsS4uTtbg4FtS3cI90/tkzRtMSZ56a7qjKWYeXCDzLBtaLmC5AEIIwlvb/Wt
sUvIZj6EWrVdQo5I3fy0d9vsBtpOjbxAvpxYH911fQYsuv7pHUl3wAOXtUHxpEi9
jf8GpBYOe+D0kMmWPoCx4/39rhbj9o5pfDW4tQFhLRdo+I9KnvoF4m1C7ciYqkNd
zP88gw8Deq4HpwnQsuLaYfUz9ep2aPoS6/GHhfIyfkhN0yCLeEoeuu7vMzBs5CV8
SofL8WIK/ckDaOpdHqLj8wQeV89m3w==
=ybwB
-----END PGP SIGNATURE-----

--GBDnBH7+ZvLx8QD4--
