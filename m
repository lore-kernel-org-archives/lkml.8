Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3119C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD7C020578
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="L5c2JhCC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MSgwcIOh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgCIPTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:19:13 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43549 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726446AbgCIPTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:19:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5C3C9220BD;
        Mon,  9 Mar 2020 11:19:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 09 Mar 2020 11:19:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=/JPDb7JZb245BQ0JKZ050bxEsfb
        WQHkBiU4vwt4NoJw=; b=L5c2JhCCO8JJzN92UkJlQp988apYtWXsX/tztvNhJrR
        CHAQCi7ObXXy1M6BR58JMZOf4qP+wGgdDxiTYbDEdZwcI/Zpjneai63YqKDD126K
        CS4Q2xOT7MDipse+GqpOon4bcW9nVRojs69jI6SfjP+wssNM29Cso18S8/N44fgi
        pWBqdK+/s3l3v0yBWbrtbOXkGxw8sMAlx5vsHWaUp4+X6iLgnyVT7GYeu0mxnSvm
        NgpKyf6MBtwPv3eKhpIygCBVCnBhaY9SCEUaQr2fElbKY5rc+LXgkx3Q4dNk1xiD
        6nDM46gSfRrq+NUxPlSXFXOYggH962/dRs7MH8ia2SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/JPDb7
        JZb245BQ0JKZ050bxEsfbWQHkBiU4vwt4NoJw=; b=MSgwcIOhE/mkeOpm4c4bel
        LDLDuqLcQwGduHHp4XFaV0Cv2mb5jVG3GrkMRdZiRdmW9wba+X1344gxIP4cv8Kl
        jetUfJI7WK4BJucfsg7mjOb7CPhSRRQgog/dxXvyftxYN/HlV07V8+IN4PDXAjsZ
        5j7DYdzDo1EN5cq+4mSk63XMiCopklooadN7KFNGdD3Szgb5by4GTHt2JaBr9jyN
        FJSl5Sal7d8ydMzf/EjP2XeR6qHqgweamkXFNG/tDWTFDnlbDTug6jPuXgZmgfjO
        +Gd4SlGbA/dPzZHqiHQX7HoPiEE89239RxOpptoGnn+3P5WbawRmeKXERIs82vyA
        ==
X-ME-Sender: <xms:bl5mXlXNnGXqAx1aTjZD4juTlwHGcpVCqEQwyRSLToVUuYfOj6IF6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddukedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuffhomhgrih
    hnpehinhhfrhgruggvrggurdhorhhgnecukfhppeeltddrkeelrdeikedrjeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvse
    gtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:bl5mXkEJIASZKCuUPId8-MJ8b2AEkehqodn2I41oagWxX6ko4x_LjA>
    <xmx:bl5mXoNy3OWQ3pmDMwbrKw6Hr3XBs5fmiTQN1d5we4ZA_1tJiJ0rZA>
    <xmx:bl5mXoW_6OnAHq-ijqYQu3d-bzgxMKSRYTjFkcwlZjxBPe4cEgmrPw>
    <xmx:cF5mXvv3eVSsBzst4zFDuUJQ0lq36jWOyfBpEVp7yUEzIA8SDlgJOA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 65C6A3280065;
        Mon,  9 Mar 2020 11:19:10 -0400 (EDT)
Date:   Mon, 9 Mar 2020 16:19:09 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 0/2] arm64: dts: allwinner: h6: orangepi-one-plus:
 ethernet and HDMI
Message-ID: <20200309151909.qkcybvtqhltjx5pf@gilmour.lan>
References: <20200308164840.110747-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3gs76qg3etkdsmvv"
Content-Disposition: inline
In-Reply-To: <20200308164840.110747-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3gs76qg3etkdsmvv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 08, 2020 at 05:48:38PM +0100, Jernej Skrabec wrote:
> This short series enables ethernet on OrangePi One Plus and HDMI output on
> OrangePi One Plus and OrangePi Lite 2 (shared DTSI).
>
> Note that patch 2 (HDMI) is based on top of:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2020-March/716661.html

Applie,d thanks

Maxime

--3gs76qg3etkdsmvv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXmZebQAKCRDj7w1vZxhR
xVcCAP9k/liklt0k0GvaDRpxWuOHqUvfue+5kYy/cdlvN/wBIwEAyIyQ0RG1R3DX
9zu2J6e9HAhBaxRD1aSRE6arYFJ4cwY=
=xynm
-----END PGP SIGNATURE-----

--3gs76qg3etkdsmvv--
