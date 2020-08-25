Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4E0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C343920706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=stwcx.xyz header.i=@stwcx.xyz header.b="IUgbMKUu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nHb4Xtuo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726191AbgHYOST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:18:19 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:34201 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725893AbgHYOSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:18:10 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 8C501D3E;
        Tue, 25 Aug 2020 10:18:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 25 Aug 2020 10:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=QmEs8/Z0/o2w/oQl3zJBNrpba7k
        QG47nIMOSPlw4dkQ=; b=IUgbMKUuJGl2klzpvew5RZOXzxgT4oxejy6EcWkXt4c
        UmyCtEnguOaFbzspswsQsu5s5TsfByHsUqtkVTCZoE+LkCMIYulwRO7mePSc4BKH
        WnTfha7iIJK4fnOi8soaGNQ6pIu6ae0Xt7R3HaRnAV63iXkR5at9V2hpdn/Vwz5B
        kevUcTmVG8VhWaCjgB41Dj+ANMU2XXMD2vC5f08GYP0dhP4uWwGvnh0LrXyz9wRj
        J53F5jLvUNWKvGeY1z+ggp4ZWs5LLXJPWWLJCGX7/C6iJMGm0safbUnMB5Eax7TI
        41ldXbU8p1pUY0sSTqXWT4eeEpXT+ha+x5cBJdpEAbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=QmEs8/
        Z0/o2w/oQl3zJBNrpba7kQG47nIMOSPlw4dkQ=; b=nHb4Xtuo+K7SOY6c/qS+IU
        YTsTc0DPytVZGtDx3dgxVumIGtrYkZSs1jEsDfPCG/22iA+CHNHdTwmQ4bHMBKz/
        DRIM032/qsTPORddjzPW7avZdhY7AfjUjCCVPgtj+nuCMhwEeMwAZ5MYAiiQ0E1w
        ZIC0GM6qLyiqoj4fCNp3ptjh/X0djxHKYv8F+oELfCE52e/DCyOhet6zuPDPxuPh
        3dRD1earO1ucHV9D7NDXJylSe86RW7tKmQnpF4M4/nBOLd2V7KNBE+zcwPvxpoSk
        H+TFpbnd4hjXkwQs4NW7fmbFGlcQ3AwNDa7NWkPpyEU3uyQ+PIPODHMYywugBcPQ
        ==
X-ME-Sender: <xms:oB1FXwslh79Ia_3uIbKVs_-iycyPE_Uhv1YJck48pSUI5NDS78DQGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfeehmdenucfjughrpeffhffvuffkfhggtggujgesghdtreertddt
    vdenucfhrhhomheprfgrthhrihgtkhcuhghilhhlihgrmhhsuceophgrthhrihgtkhessh
    htfigtgidrgiihiieqnecuggftrfgrthhtvghrnhepgeehheefffegkeevhedthffgudfh
    geefgfdthefhkedtleffveekgfeuffehtdeinecukfhppeejiedrvdehtddrkeegrddvfe
    einecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphgr
    thhrihgtkhesshhtfigtgidrgiihii
X-ME-Proxy: <xmx:oR1FX9fD7O9Uu6rejzrAklCAVWAPVPlLVRaloHh_uErln5vbASUbcg>
    <xmx:oR1FX7zkVtPHNmeLkTKeVixGVexe5wTRWm2uf66wOQUwyB_0R3SpmQ>
    <xmx:oR1FXzO4szcvhvCBvmRI0uxmX7Dg5vdUjq_-7Z3XlHW-lIvk2j28Bw>
    <xmx:oR1FXwzjA0Tse1MRnIqNuiKAyXDNXBKJPYxX2z_ZpgezICBQxLaygQ>
Received: from localhost (76-250-84-236.lightspeed.austtx.sbcglobal.net [76.250.84.236])
        by mail.messagingengine.com (Postfix) with ESMTPA id BB28130600B9;
        Tue, 25 Aug 2020 10:18:08 -0400 (EDT)
Date:   Tue, 25 Aug 2020 09:18:08 -0500
From:   Patrick Williams <patrick@stwcx.xyz>
To:     rentao.bupt@gmail.com
Cc:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Subject: Re: [PATCH 4/5] ARM: dts: aspeed: minipack: Update 64MB FMC flash
 layout
Message-ID: <20200825141808.GH3532@heinlein>
References: <20200824211948.12852-1-rentao.bupt@gmail.com>
 <20200824211948.12852-5-rentao.bupt@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="smOfPzt+Qjm5bNGJ"
Content-Disposition: inline
In-Reply-To: <20200824211948.12852-5-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--smOfPzt+Qjm5bNGJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2020 at 02:19:47PM -0700, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
>=20
> Set 64Mb FMC flash layout in Minipack device tree explicitly because the
> flash layout was removed from "ast2500-facebook-netbmc-common.dtsi".
>=20
> Please note "data0" partition' size is updated to 4MB to be consistent
> with other Facebook OpenBMC platforms.
>=20
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> ---
>  .../boot/dts/aspeed-bmc-facebook-minipack.dts | 47 ++++++++++++++++++-
>  1 file changed, 45 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

--=20
Patrick Williams

--smOfPzt+Qjm5bNGJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAl9FHZ8ACgkQqwNHzC0A
wRmoQA/7BzbYGmsNhCqDgSK2BBGRdfOQXzsHB7RX5l1njoX0+O85xoTB5XUVuqP2
DhjGuc4+QprGKmCnHeatfbQUOwDqWPQvFvKnEIjRlsnXSK2xYVubqHkJQnz6Is+5
LP0Zw3lIZVYVXFmjM3WOaRlnNkPSAz0UoyxwAwZzSodN/0Vp9udCHnIpIT8IafB9
4+wtW4KqfuFpJ721upa/9KrxsBB2+P0tQcmCwBEROIcL3Cj5HQz606T96vVAI+Y7
7Hh4GfLCpkePKECh+vWlQmGUp6ASUXnm3GHwX55/l+QZM4EWI5W9i8C3feJ9XYu3
aL0RD3gMbhKIykUnciO3UPGYWPPGAdqepk7/t4kEP6+ygMieYPvTO+6gHpd99XOG
NMhkNvQObj+Ypuvg88/LZZwgMXO/MmPerZ8HULEukSm20qblGgjTY1BMyAbraEld
Mtn4Q7axAuN3QeSlCgrtlJOvdhVaJdorznfuTM9LkW6+8Ct5ZMS+f3lyMRMT8Ch8
fBqVNIXVS7uCWRRZrDamDE32ioO0xQEZtDBIy2ZAaW0UMtNNkYWPBytsxIRrok1R
yFHZBON12LtqCXXtycVCCFBspH9FzpXeJixAAsCp3o0DpMf1W1QznwbYtyzsRJBP
9lp4G+UBpOsmFWpVK01kOaLv6URm7f+zBWfQKN2AV5Yy7XFHZoI=
=YxTc
-----END PGP SIGNATURE-----

--smOfPzt+Qjm5bNGJ--
