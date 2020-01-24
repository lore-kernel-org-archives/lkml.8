Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F773C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96DF20704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="kWooy/ll";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D1aaetkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388342AbgAXQdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:33:23 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43543 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726454AbgAXQdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 11:33:22 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2A4F421F92;
        Fri, 24 Jan 2020 11:33:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 24 Jan 2020 11:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=EBr2n5r06Qk8M8EcrP2ppV6Pux2
        ICKEX+0XMuXgRpvk=; b=kWooy/ll1OWesspYToz7Vl9DfpYVdVDC/9aBpGqdpRf
        bDPrNyHjyACHyFbc7EutLp+T9BLMCfTcOqaWDM5VLVO4yTK3s2oYHtQevl1Vc50T
        S2dtTjXkTS1UD2+71l9a3YYIbS9wyeK9m+ti0dDoEpG9J8K8as2NOcWwjBqFYNQf
        XyMyRYLTngbX1vmJQ+jQvx+Fx4e4A3Y0VMGa826v5MOcDjc+juaqlaUCa3C1VoXD
        XQRRMBtZpJ5h/3UuQSw4b7HpyHxykWWvmWoHsXzoKuT7kaL2uwJcBqVZdkvMUw3V
        XOh22vus8VOCF25gutkXhF6qzEikhAfQdBl3W4+xHZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=EBr2n5
        r06Qk8M8EcrP2ppV6Pux2ICKEX+0XMuXgRpvk=; b=D1aaetkkx/4bsrcZZ8VC7o
        apDNLwpPCHz7/I0jr9/JqahYe+/Ib74FFKDeJvBHe5cPPsdMZDh7nmiDvVtPlb2W
        A8SFZnuX5yo36l4Sq1q1oLZC/dP/i+Q8jOr3xKxVU3sQ0SnokMzD9yMdbGU/hajY
        BAzw4BvkxS9+pMOUQFFqmJ3x0X+xKnguKcz1/ekNPmoP5zZTdADa+I2E2N5ET98U
        zC+hkp0deXt5bsfg1r5unP8ACP2mUYBe85ZUrI/VvPt/LqKvt65Qzai+duM2GFlK
        6kF1PonuE53HrcuNjOTwldYYF3PCZXsW3md5u3PuHvvngenvwI6VsQyg88iwlRgA
        ==
X-ME-Sender: <xms:UBwrXre8l04Zxc1Er61PYFZ7Pa2iNplRj9LB2gWTSLGo_Kcg2VuXrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrvdeggdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:UBwrXsp1DT-h61_rPcdMsvhBOTOJAKNshlS1_mslv_n7vulV0zwk8w>
    <xmx:UBwrXoE4X4MjR1adJ-KFDVWmKKFkKC3sCIEICNq29iSG5To5oigrww>
    <xmx:UBwrXl8UQkRBbNQHe6_tDbCTtMD5NUYLlHd9J2XpL7TrjOUetCTlxQ>
    <xmx:URwrXpBt_H-qeUhtY7nJbYWBh3ughy4qVwZSuASyEpF_A05ow1kzRw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 382C63280063;
        Fri, 24 Jan 2020 11:33:20 -0500 (EST)
Date:   Fri, 24 Jan 2020 17:33:18 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 3/9] arm64: dts: allwinner: pinebook: Remove unused
 AXP803 regulators
Message-ID: <20200124163318.y3pykbfgpwsqiru6@gilmour.lan>
References: <20200119163104.13274-1-samuel@sholland.org>
 <20200119163104.13274-3-samuel@sholland.org>
 <20200121090539.mgswdzfharrfy5ad@gilmour.lan>
 <8006a501-733e-b998-edb3-378769cd3a4c@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8006a501-733e-b998-edb3-378769cd3a4c@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 09:14:02PM -0600, Samuel Holland wrote:
> On 1/21/20 3:05 AM, Maxime Ripard wrote:
> > On Sun, Jan 19, 2020 at 10:30:58AM -0600, Samuel Holland wrote:
> >> The Pinebook does not use the CSI bus on the A64. In fact it does not
> >> use GPIO port E for anything at all. Thus the following regulators are
> >> not used and do not need voltages set:
> >>
> >>  - ALDO1: Connected to VCC-PE only
> >>  - DLDO3: Not connected
> >>  - ELDO3: Not connected
> >>
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >>  .../boot/dts/allwinner/sun50i-a64-pinebook.dts   | 16 +---------------
> >>  1 file changed, 1 insertion(+), 15 deletions(-)
> >>
> >> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> >> index ff32ca1a495e..8e7ce6ad28dd 100644
> >> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> >> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> >> @@ -202,9 +202,7 @@
> >>  };
> >>
> >>  &reg_aldo1 {
> >> -	regulator-min-microvolt = <2800000>;
> >> -	regulator-max-microvolt = <2800000>;
> >> -	regulator-name = "vcc-csi";
> >> +	regulator-name = "vcc-pe";
> >>  };
> >
> > If it's connected to PE, I'd expect the voltage to be at 3.3v?
>
> If we provide voltage constraints, the regulator core will enable the regulator
> and set its voltage at boot. That seems like a bit of a waste.

I'm not sure the regulator core enables them if there's neither
regulator-boot-on nor regulator-always-on.

> I don't think the voltage really matters, since nothing is plugged in to the
> port. ALDO1 can't go over 3.3V anyway, so even if it does get turned on for some
> reason, nothing will get damaged.

Looking at the schematics, it looks like the PE pins are connected to
the front-facing camera?

Maxime
