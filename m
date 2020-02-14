Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DDEC3B199
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E8F72187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 13:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="WQdKfuQW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pl+lU99i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729241AbgBNNRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 08:17:45 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58351 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727822AbgBNNRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 08:17:45 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 1D3E022011;
        Fri, 14 Feb 2020 08:17:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 14 Feb 2020 08:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=yIcERtbjOyld2DTwCIiHP6QaU/B
        JF9w5HQlKcFGKTqs=; b=WQdKfuQWVKuQkxuiJmdm+s7miq9OD8UDZVzDXhSV/7V
        6IFHZ2erktu6UYLpcevB9m6KLlRNFGoRdKPln5CZ8NX8nMRWyl2mTi5yNjeRDr+n
        NAS6wsX5tiLzqQbwhe50CcLft3bHM1BAJ1AtGMEcnRVYoTVG2T3WnROGs4NNXtwM
        xa2pZBj2YekfMqoA0bZ7RbOe93TGWroGHUZJH0kUGhvVulpxmpjWHlLt/mcFaBYS
        BeB0Z9wpu9kf74g10Ni4V5UKHvslWpL772dE33j1Z2u7iOu21d7PtejL/d7mZRev
        PqftQHsI95oX0f5/1Ssrf3+jGV8UQWtkSC8BA6kw1Gg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=yIcERt
        bjOyld2DTwCIiHP6QaU/BJF9w5HQlKcFGKTqs=; b=Pl+lU99itVieG6AcpLX1pU
        XIlYCZb0ZCOYY1ODsCrbz72dEjqMv28mZLnBk3i04GPoectac56cpM5IbBLbG2IF
        zkAolA4dS+NQoLRp1FgHpaNTv+MJgXDhbBCQUuodeecu3yDVpGSoGVXioMUVoLl9
        mBrpjbTP78+jyd9djbTyn4zYiAT9PghSJurLWzlE2bf5yNRWTGxAdar4d54HsIif
        nwE2zEkVyQZ/qJlTc7XRZpBZDtCAMBkwPW+jjrqLqrskVoQeQ+lunk7xiPVWeGNA
        tW58lS2QuCUdLVCo58mBuRFwvwfiOOhWDJoHQrwoX9z0QIq3OCYlEJVFRTT0Ursw
        ==
X-ME-Sender: <xms:951GXnGN9YQzLWi9Q1Sqycw5Gea-yPLD1IJEPitZwLoql4dq7JBeVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjedtgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:951GXsgRlWqR3IOfir4_gCjDQOqBOKAmjp5p16ZSirRv1IhSg5Nz5w>
    <xmx:951GXgdUGyPA9ncKDrp2nwBwzMRjinwZXSx-5z4uTTwlU4vCneTMGQ>
    <xmx:951GXiw3hljaGpNlTsWBcLqvTS04oORq9s-3Egz4gqFFdvMT-UDgJQ>
    <xmx:-J1GXrt1AsDKbfoi3XoKFQDmLaZHUo6-wtD9avk5veTDzGJJ2KC3qg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 25C4D30606E9;
        Fri, 14 Feb 2020 08:17:43 -0500 (EST)
Date:   Fri, 14 Feb 2020 14:17:41 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Alexandre GRIVEAUX <agriveaux@deutnet.info>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sun5i: Add dts for inet86v_rev2
Message-ID: <20200214131741.u46urhpwzzjpflfb@gilmour.lan>
References: <20200210103552.3210406-1-agriveaux@deutnet.info>
 <20200211131517.e7lpjtz2njekadee@gilmour.lan>
 <864838c2-1b1d-433a-ca04-0d91c8b5b8ca@deutnet.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ar2jus4mu24srbt4"
Content-Disposition: inline
In-Reply-To: <864838c2-1b1d-433a-ca04-0d91c8b5b8ca@deutnet.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ar2jus4mu24srbt4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 12, 2020 at 10:45:03AM +0100, Alexandre GRIVEAUX wrote:
> Le 11/02/2020 =E0 14:15, Maxime Ripard a =E9crit=A0:
> > On Mon, Feb 10, 2020 at 11:35:52AM +0100, agriveaux@deutnet.info wrote:
> >> From: Alexandre GRIVEAUX <agriveaux@deutnet.info>
> >>
> >> Add Inet 86V Rev 2 support, based upon Inet 86VS.
> >>
> >> Missing things:
> >> - Accelerometer (MXC6225X)
> >> - Touchpanel (Sitronix SL1536)
> >> - Nand (29F32G08CBACA)
> >> - Camera (HCWY0308)
> >>
> >> Signed-off-by: Alexandre GRIVEAUX <agriveaux@deutnet.info>
> > Please read the documentation I sent you yesterday. In particular,
> > when submitting multiple versions, you should remove have the version
> > number in the title and a changelog.
> >
> > Also, please ask questions if you're unsure about something, or
> > discuss something you do not agree with instead of ignoring the
> > comment.
> >
> > Maxime
>
>
> Seem I misusing 'git send-email' because i already changed the subject
> line (same apply to u-boot):
>
> git send-email --from agriveaux@deutnet.info --to
> robh+dt@kernel.org,mark.rutland@arm.com,mripard@kernel.org,wens@csie.org
> --cc
> linux-kernel@vger.kernel.org,devicetree@vger.kernel.org,agriveaux@deutnet=
=2Einfo
> --subject '[v2] ARM: dts: sun5i: Add dts for inet86v_rev2' --compose
> /tmp/linux/0001-ARM-dts-sun5i-Add-dts-for-inet86v_rev2.patch
>
> It's the first time i use git send-email, previously i used mutt to send
> patchsets (on mips mostly).
>
>
> Effectively i've forgot the changelog...

A simpler way, especially for a single patch, would be to use

git send-email -v2 --to $recipients --annotate $COMMIT^..$COMMIT

You can even keep the change log in the commit log itself by using ---
as a separator, so something like:

ARM: dts: my super title

Some nice awesome change

---

Changes from v1:
  - Whatever.

> At why do we need another device tree:
>
> inet86vs use a GSL1680 touchpanel controller and 4GB nand [0]
>
> inet86vsuse a Sitonix SL1536 touchpanel controller and 8GB nand (can
> have 16GB nand)[1]

NAND size will be discovered so it's not really a concern. For the
touchscreen, you should make that clear in your commit log.

Maxime

--ar2jus4mu24srbt4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXkad9QAKCRDj7w1vZxhR
xZpWAP9pFTRWCaqwBVNYBKiE2xBXLEgGjm4qKL3sDt2A4qc+jQEA7egdAvStILOP
lE8wqwqZROoKZ3bdJi2AwXA9ZxiyjwU=
=ZA/T
-----END PGP SIGNATURE-----

--ar2jus4mu24srbt4--
