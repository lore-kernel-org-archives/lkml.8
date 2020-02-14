Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC58C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3579F24649
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 15:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="yROXWEyy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eZz9oCPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbgBNPDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:03:52 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:53367 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729568AbgBNPDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:03:50 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5B09E21EA7;
        Fri, 14 Feb 2020 10:03:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 14 Feb 2020 10:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=jYZ/ja4iJGYnt7/lz+TnPFTC+sp
        g0HFZPU3salWJn5s=; b=yROXWEyysHhj/JBFaqOPnh831Pk8/t3rcOj765F6Vt7
        AKGOGSFl7pI8JlBT5kMmAP8Afz7k7XVKQ7hsPK/I4uG8nyaUtzKIvPMc5P3OfCEX
        jeSTkrGgRXGDifHU1XpoSWQQW7xaXlY669JrDyHYhK7RL1qh/62Yj2+tQP3uZnx8
        H4wHTKC7XYO45dqRiy4pxq87K4QClwAPf+VNEf5FoXK3bY033Jb1gl+Qh0C6FCE7
        lTXYSvIl81zI0fmKcD3Ne3lEPla+pNIK4s5Rq3FeKCthyOcmcEFCEEGQurnksnQ9
        ULu9FBmdWTkv21ki8GjvF2h9btWz0lDgkXIdyT1vITA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=jYZ/ja
        4iJGYnt7/lz+TnPFTC+spg0HFZPU3salWJn5s=; b=eZz9oCPy0M90LIiHTXINc2
        vhsHElbuCS0yc3WCE76cgDMAGQnUjpwQYM5czZ9DBNxrq4gxG3K7ajBSL7RPuJvd
        y4cSehXREHII7dhQs7Icr+2q9NO22YKBP/kPMbVMVb4h0qVpvVq1nRCDriTsuJS1
        1x2fecvOL1DO0PlUc5QhtVJx/vWrY+8Hg0KIRRM1VE8hb/k8RKopcJD7MjuVGaG2
        XSs4nrTX1vZGxEgeRNSpgyT+sTfrfPgpVj9t26/mqS/DbNzkevbgBv/8SJ1UyU9P
        lZtS2wn4SNs9iClPkcTUWkpQGeOfDkGUB0hAsiwsMSv7LCo514ewzHkP+Vvx1RYQ
        ==
X-ME-Sender: <xms:0bZGXu3b8_nZrEwos6Qs5eyYyI_Kcb_Hse2jZBin7UXchkd8NAfmWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjedtgdejfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:0bZGXo2FbXgc58cFZ9n1AJvQiy5RbL2GxfYrr8D6BAAWFzXtFrGgHg>
    <xmx:0bZGXlexDPRwW_IfdgsAYR1K0E1QjjAHqwybP8dYzMajwfcpjyDLQA>
    <xmx:0bZGXqKtgjj1E5hDCQrBx5xdh2Boa79MiMvC3l1RGwtCX-JPh8x5tQ>
    <xmx:1bZGXq79eZ39-HjlJyq7pdIH6r6eblQANn5l7i45CvzC7pvYyqtOCQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 63D4A3280065;
        Fri, 14 Feb 2020 10:03:45 -0500 (EST)
Date:   Fri, 14 Feb 2020 16:03:43 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 3/9] arm64: dts: allwinner: pinebook: Remove unused
 AXP803 regulators
Message-ID: <20200214150343.7nn4ovmtm7tuz5qf@gilmour.lan>
References: <20200119163104.13274-1-samuel@sholland.org>
 <20200119163104.13274-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3ki72llztinxksue"
Content-Disposition: inline
In-Reply-To: <20200119163104.13274-3-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3ki72llztinxksue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 19, 2020 at 10:30:58AM -0600, Samuel Holland wrote:
> The Pinebook does not use the CSI bus on the A64. In fact it does not
> use GPIO port E for anything at all. Thus the following regulators are
> not used and do not need voltages set:
>
>  - ALDO1: Connected to VCC-PE only
>  - DLDO3: Not connected
>  - ELDO3: Not connected
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied, thanks!
Maxime

--3ki72llztinxksue
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXka2zwAKCRDj7w1vZxhR
xY44AP0czZQey3xSnwLKppvGWIIPwWWcGREom04q9kJ3D3ZsvAEAkHuJVUNpyN2v
xumTYpqi90IwDQHuwMCwpBqjPAX2Kwg=
=zPwE
-----END PGP SIGNATURE-----

--3ki72llztinxksue--
