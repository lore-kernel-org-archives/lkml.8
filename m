Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B4FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD1122075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="lNL3Z/WO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LIl0fW4u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgHYNrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:47:13 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:39921 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbgHYNf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:35:58 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id AFF56C35;
        Tue, 25 Aug 2020 09:35:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 25 Aug 2020 09:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=hyCbQ6GxSGnAME6TSw9/3QnI85f
        CzPq3Dg+93LtepbY=; b=lNL3Z/WOChypZ0XMF3XoHjLjUNB4+HkPNuoMICVQ7US
        /2BNJjgPrHtCly5r8CX51JLwavcZwZMmGD43sMrwX1D22nIbOSJYxG8P0bhlg6Y/
        aRCorLaV0g2XTiiVRu2XSjp6CXO6paRkw1egXgKNSaKxntxYT/Kj1THhdFTEY/T/
        TWmbLu/UpTtYszvoZ/IJ2vtRLOyFxuFxk/UniJ27fzhrTOM2ZbwEzACZlFKixcNf
        G4qN17U0Kwo3a3Yqdp/bwlTyr6ZKKl39zrFq16+pp/Cz5qBEz20D3kIWRbzxwg0T
        u0E+HHNnwyQoaGbQHiQCUa266G1kOWRb1GgMhowKB2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=hyCbQ6
        GxSGnAME6TSw9/3QnI85fCzPq3Dg+93LtepbY=; b=LIl0fW4uS317bQG3pF5Tma
        FolHv34speli74dcZ7X3S2F2/MgWWgjhaISICQy5Hmyi8ku+J4dCm2c7ETXq+uYb
        +0HwY+W6PNMl9w37S2WLjTGe5mx15zNKphcILRniERSpEQlYfGgFJPt6KJSZWzND
        dXvHPAkYY4NroDltl085dlHtJmU365QPG0CktdGWO5YoyLHyqzH1Lj+ZQJ1mL/4e
        1/eIbvdvn9Ra5NUg9jkaAr5y0SFNI8UgzIHqb18gDgkNbdr6VA3fHRZ2ACqVxfjx
        LJ9zlToJVHx7Me1otPNgP9eXALIGhsSiPCbqvcItsESZG9bg3y+yfZFxbtYDfu9w
        ==
X-ME-Sender: <xms:vRNFX9g35huffs9_Ttxg9qTP0ZlVd0oIYaaEc8XT4BYRiFibRBN-2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepleenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:vRNFXyDzR8qDj6qGhHHJsM3oIW8IGLfuTv9X8e9BmOPcgC0IoQXJZg>
    <xmx:vRNFX9Gc8Z2v_KHfZigmS-1wnVqGwfW4_nUF8SM1r_p5cp64PYBzgA>
    <xmx:vRNFXyT3UmaMx8Qf2ZDf9xsHLoATkJAsFP0XBk7sekNvzHiNJ8s8Zg>
    <xmx:vRNFX-8UtFIzTeZi_5o8N5cCFv2UapO0DEtuJH7sdy-GRm3BUHUC_g>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id DCB42328005A;
        Tue, 25 Aug 2020 09:35:56 -0400 (EDT)
Date:   Tue, 25 Aug 2020 10:39:32 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stefan Monnier <monnier@iro.umontreal.ca>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] ARM: dts: sun4i: Enable HDMI support on the Mele A1000
Message-ID: <20200825083932.mx4rqmw22zbuyi3m@gilmour.lan>
References: <20200821171833.28177-1-monnier@iro.umontreal.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vxyjlkbxrz4btpud"
Content-Disposition: inline
In-Reply-To: <20200821171833.28177-1-monnier@iro.umontreal.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vxyjlkbxrz4btpud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2020 at 01:18:33PM -0400, Stefan Monnier wrote:
> Enable the display pipeline and HDMI output.
>=20
> Signed-off-by: Stefan Monnier <monnier@iro.umontreal.ca>

Applied, thanks!
Maxime

--vxyjlkbxrz4btpud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0TORAAKCRDj7w1vZxhR
xS8zAP9h2ZEWi24iVyNsvYYO+OY5Uu6eR5DCBb1CJEkNsFJfYgD5AYiZPUM//hrp
eZ0Qx7FksSbJ5UX4/LsQhTF6xxB1Fgc=
=GDf+
-----END PGP SIGNATURE-----

--vxyjlkbxrz4btpud--
