Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65957C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 354A820707
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="E/SbbEeS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="l6+I15Gu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgH0Pl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:41:27 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:53113 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726266AbgH0PlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:41:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id E7620580189;
        Thu, 27 Aug 2020 11:41:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 27 Aug 2020 11:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=5kjKXc18Mu8gbbHx1ieZ1Dlzopi
        c4BvIVhQuWyLHDzc=; b=E/SbbEeS7mdWMbtVEiwC7QsoNlhw0jZSbz/5Mql10Lx
        Q7ukAac1iGuPFOKtcAmqXRQFH6XvNp5YR/3Mh04lTQUQkR+w0KP3qJW09EnF9n8B
        xlJWjyMwC57Ut5mR01wdlQ5dDyEW5xn4z3af0uZ0jLj8IL3NAGusRwDE+pkZ62aU
        gCbRj0hezNzGNuqz+eOww2oKuaBn6yRRkKu51pm+zyNf6w8UTUR2RNFiN/QLlaJ2
        QfH5uULGWNB8kSDZkK1pASj7OwhdoMMNvLh/aG3zQZvHG6DypfsG3BFBF9p8SJCj
        C/iQgYLL+mivb5BtztlRKxkLuD2IfDDFnsnDQc3P4kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=5kjKXc
        18Mu8gbbHx1ieZ1Dlzopic4BvIVhQuWyLHDzc=; b=l6+I15GuAxpFB8YtSRbE1s
        Y8xGYtkcBStDbRyKFUg2ESe+koMvKa+o2zuLuGOg/GU/7w/EnmAMMTvjkCHSs2Ig
        LjU4+XwSfim3NAmyLeBysI20DgThUcwR9Tm2O/wBUDN+YD6dsiSIZPp6NvLfjOf8
        h+SyTSKyHrA7SUxIVlqUTujAazp6czMm/q5ljSc3CWfoOPS9J4DeUg8iQJnJ1J0a
        he0heNeFiupUVM3dsGTy1o3IGAxgBjjCm29w5Sc3iTQ6VCcgTsgWZYLMXAVRPCWd
        Xe9LyyBcP59VQAf1D3tExhhE6CAf2AZ1wRYCtuj9W6PkQCdeYKh9InkOTBTKSHDw
        ==
X-ME-Sender: <xms:IdRHX2hu0jZ6A9mtK_k4EfA-FHZTPF9uEIFZMtDeKHQAyFuAEx7UOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvgedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuddvudfhkeekhefgffetffelgffftdehffduffegveetffehueeivddvjedv
    gfevnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:IdRHX3COoKZWmhu6z4ZWlBXFW0xuOyeln6lVhkLkBvjk3A5tFIN-yA>
    <xmx:IdRHX-Gd9ZhZw2KSvA16SUrx1HF-7eVNO3Tkl2hCm0bhxUv2qlnjKw>
    <xmx:IdRHX_TKu7odB_HGKP-LBqIAYKZPOPqNAPAqKpoqhsMxrBCjS6irLA>
    <xmx:I9RHX7eQ6XS2mAMtW8CI-LdK9OMLEaXw_uJBApKYgM4x8dLy86hp4w>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6E044306005F;
        Thu, 27 Aug 2020 11:41:21 -0400 (EDT)
Date:   Thu, 27 Aug 2020 17:41:19 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?S8OpdmluIEwnaMO0cGl0YWw=?= <kevin.lhopital@bootlin.com>
Cc:     linux-media@vger.kernel.org, mchehab@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        yong.deng@magewell.com, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        paul.kocialkowski@bootlin.com, thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 5/7] media: sunxi: sun6i-csi: Add support of MIPI CSI-2
 for A83T
Message-ID: <20200827154119.ljxvjb2fe7xeg2xo@gilmour.lan>
References: <20200821145935.20346-1-kevin.lhopital@bootlin.com>
 <20200821145935.20346-6-kevin.lhopital@bootlin.com>
 <20200825143704.qkg2re5bxm2cufnd@gilmour.lan>
 <20200826111728.21d52c34@lhopital-XPS-13-9360>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="frux7y34gyxq2g4n"
Content-Disposition: inline
In-Reply-To: <20200826111728.21d52c34@lhopital-XPS-13-9360>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--frux7y34gyxq2g4n
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2020 at 11:17:28AM +0200, K=E9vin L'h=F4pital wrote:
> > > +	mdelay(10); =20
> >=20
> > Why do you need an mdelay here?
>=20
> yes a msleep could be more correct here.

My question was more about whether/why you need one in the first place,
not necessarily how you would implement that delay.

Maxime

--frux7y34gyxq2g4n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0fUHwAKCRDj7w1vZxhR
xe20AP9MrwIj1p6+Wb9mEL56E2ynthsYRloqePkJXIFLXvvYKwD/bsjv+odRNGt0
Wkpfn5tU6gwLEWbuHgviKzUwChkfHA4=
=ZP4Z
-----END PGP SIGNATURE-----

--frux7y34gyxq2g4n--
