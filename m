Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E02C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF0720665
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b="No0CuSot";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ff1sMqy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgHYORG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:17:06 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:47035 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725893AbgHYORD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:17:03 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 92F813AF;
        Tue, 25 Aug 2020 10:17:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 25 Aug 2020 10:17:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=o4Lgifyp6W7gEhgYNRBq4AIfWx0
        xVuzp5rgo9pBKgBM=; b=No0CuSotdI6rBYOJZmSN6m8miWTATw9x7LO8FJbD5QQ
        m/HxjtATj8pORlb7Dde/zpSG6heMDm9e7RTvhonGyV4IIE2uYEz2zNazAgDt2dc7
        4A6znrDdKu6hzYuGC5S2YZTNZ17tZwXHHsTIljMrlJmmBAJutKKRcmbF8okRSiqM
        iiK4D9jkM38OHGdzZIdOCnB+aORLMOyn7OASirDGcr51RxZcQoOrZfY7AVfYX7z/
        ucn9ZXZVH2orKW8DXU8sgzP5wFqQvQWt2cu3D2LG2nUNOCR1ynnhVpFVhfwLZqIo
        UnWkxnI0rpTx29xLbP0yosiiz2gy8Q4jU9xIgmnPFEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=o4Lgif
        yp6W7gEhgYNRBq4AIfWx0xVuzp5rgo9pBKgBM=; b=Ff1sMqy0x1iaKl5oKb6FrK
        vITwkCDvOQaMbh7hiYTA7D714s6VzqvhHn/9PZ1Q0QgCoGKzFxLm9zbdCtnE+mVd
        RVS1sWY0DhfP6Nff4DJXPo7J1XOS5WAbbmQpgnCwFLogWQpcAVD+6VtjJukZXHJE
        RJocyM2zRyf3EVHNh/QXK5ue0gj95oaeOEn8CN86BOaVfoC8IK4sefgZ6q4kJY3E
        a3WghN3/i09pyic/RnKXFVVfQLxY6InSCvMbfx96VnxbS7yMtpQsVdJ4FqHqi/UR
        Qgnz7U01h+sHCxJNojDh+UkOaWRTTcc1c+6Rd/HF/lCOGXH5a0euU1O2RYvUWhuw
        ==
X-ME-Sender: <xms:XB1FX_23WUIRllq9I7ClalBpKp5UqhbKD8VkMm5SGarpQnZSTcLukg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvuffkfhggtggujgesghdtreertddt
    vdenucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkhessh
    htfigtgidrgiihiieqnecuggftrfgrthhtvghrnhepgeehheefffegkeevhedthffgudfh
    geefgfdthefhkedtleffveekgfeuffehtdeinecukfhppeejiedrvdehtddrkeegrddvfe
    einecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphgr
    thhrihgtkhesshhtfigtgidrgiihii
X-ME-Proxy: <xmx:XR1FX-HAsibN46gL8N_ZUtchWFogcS9yaCOdvdovIZjqLZXEqFkRLw>
    <xmx:XR1FX_6dMvgavyz0wDouI87qnxnFWEkZQEOYuIcmQDL5vf3DGttZZg>
    <xmx:XR1FX03lilZ2fK5mgJlbXTXLeTRJRTuCAMqgBxCckGNANM8KAvhqhA>
    <xmx:XR1FX34WSXav1jL3B1NFeRxoFHvnNYNJ4xPXZ6mou_INlHvEPG0Aqw>
Received: from localhost (76-250-84-236.lightspeed.austtx.sbcglobal.net [76.250.84.236])
        by mail.messagingengine.com (Postfix) with ESMTPA id B288730600DC;
        Tue, 25 Aug 2020 10:17:00 -0400 (EDT)
Date:   Tue, 25 Aug 2020 09:16:59 -0500
From:   Patrick Williams <patrick@stwcx.xyz>
To:     rentao.bupt@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Subject: Re: [PATCH 2/5] ARM: dts: aspeed: cmm: Set 32MB FMC flash layout
Message-ID: <20200825141659.GF3532@heinlein>
References: <20200824211948.12852-1-rentao.bupt@gmail.com>
 <20200824211948.12852-3-rentao.bupt@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qftxBdZWiueWNAVY"
Content-Disposition: inline
In-Reply-To: <20200824211948.12852-3-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qftxBdZWiueWNAVY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2020 at 02:19:45PM -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
>=20
> Set 32MB FMC flash layout in CMM device tree explicitly because the flash
> layout settings were removed from "ast2500-facebook-netbmc-common.dtsi".
>=20
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
>  arch/arm/boot/dts/aspeed-bmc-facebook-cmm.dts | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

--=20
Patrick Williams

--qftxBdZWiueWNAVY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAl9FHVsACgkQqwNHzC0A
wRkjWw/9FtRE8urbMeaUc/+Q93LgKAnLTuU8vpixijtbDKEVuKWgib/4SNMsTdxd
IYR2elUt707beUXkDTXWJUxqLBFAfztUeI0bHy1b4ruP3GapIJgQK/439AQMBcx/
ohfmqKHlL2fFva/3A6zzCOEZy8jmQbbwu26zrW1K+ieYIWaZh48cZf3cZVgDG9mz
bcwnGOWmLRz4qo4CwN+XfMJ23mTOCQZSZUFt9Tn+tDqVRLWhosFVkSUAKwRjEbn+
XeyhjoWHAwOwWkTfU43ssybrj/PqHBM+Gr8OV9X92kF7alA59chjs8fA2ukqzAzr
/I4kqVlWguKb1tdFDuqTiJBKqOIZQtKBt0meWmHy0Auh2SL3ihR5WTiLpOdscOWy
NIqgYbtbx2TmtHYG7iuYUIeXy6mqlTo5xQuHii7UAMEMjpphQNFbTb/VBhk5t/sO
++PeSEkONdZSyBDZUUGcA2+EtspANKgi8gi41EHxcghhGaxmXKZSxWNqToOmVdbg
xqozF0ezD18b5Wy8u+6aMZLWxqdVA2B7SrrECF0WxMK/0/rDbhTF5VshxB7HdUrY
Y5F2XaX0PngEn9oQ25quTwkrO6rnHQR/B7trGPLQVI+Wj9OT/lmc7vCf6tXwtGIY
fxvKNjdni0yEAMJqDy+nLKXgg0ddvftM+P4HA3b6HPg0mUhb0Mo=
=n2kh
-----END PGP SIGNATURE-----

--qftxBdZWiueWNAVY--
