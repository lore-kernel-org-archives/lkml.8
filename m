Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D537EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 21:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B03BA20734
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 21:25:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="E2lkvmrg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ndRnP7VR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgGRVYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 17:24:47 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:39507 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726863AbgGRVYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 17:24:46 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7116D5810DE;
        Sat, 18 Jul 2020 17:24:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sat, 18 Jul 2020 17:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=s
        HEwXJQUgU9S74Ll25+cHaTeMsTz76blspps5t8z770=; b=E2lkvmrgmOhg6jvxZ
        ksiN+QjHqFz/aIR5jIEQu4nKeAaiJdOPbXWO6+PWp3K69+C4IZUNNOq0RNNfqpNb
        vaIua9I/YeKqqjqEd3kVsd/rSOh72aLo+EfAufByyHWWwoguCJGe3PAFk3RND2q8
        FPSRRRdLNRwSCs9utPGA8fZFDHdd237fUhUpMhI1KMR9zMsz3+nPhahCUX75B10O
        ZglYNZGbvF84mP8a/FjtwBpIz8oPgfM7fCeu3JAgdZAUI4NJN03EY8uj77q07aT5
        IM4lmy1upV6Mq75UT6WIYcKAOoQsOQfbZOHZL2vdI1Sp/eLQ5nJxXh3EQrdphiLT
        yn08w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=sHEwXJQUgU9S74Ll25+cHaTeMsTz76blspps5t8z7
        70=; b=ndRnP7VRrrfY+m17sgAqH47arpZhXSq2xK9XmX28JS35JQE8hwGh0dWFg
        WINdnjad5cNeC+xYLsMhbfWNXjCXQt4d4N5d7FS+rKnwXnRN560/Q6u+AHKW+JLi
        NBqkK9WsY0ixtEp357eD/0HXDWsOsfVpqXxlXsPvl7vZwwqT3OzWsQ21/B2zp4vq
        X0TTYjTAqOXbzk8ntrJdBILYye4Qt7oCUPJ0htcb/sLiarYddrlzw7uJ8PdBFaa8
        03XR9nZDmQCjWrrHjDzbOE/Qt6a2E8EGv3mvovf9sUTCLLcRF3oJ9m+nEu/uSThE
        Kcy9xNhfKCJfH7JX+8qdsSXxcgA6A==
X-ME-Sender: <xms:m2gTXz-fuC_JfmSyq9uxHla6nqomR1SOEbyQk66F5pBseFK203AWsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrfeelgdduieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfelkeduveejtdejhfeiledvhfeggeeiieeklefhfeefffffffeg
    udetteelieejnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:m2gTX_uDuOjWGzDr24tL4I-q4DAwPx1gAej0zW-tQysaXRVx6mdAsQ>
    <xmx:m2gTXxAM6CnlPiBfNzSGdHxAvfUhMGnVRWhQTfz8KE9gSZetpY8b2A>
    <xmx:m2gTX_fuRpYCj37uezXant-OtPA7zgCa3Suf5DCVOmEUr0y-9XT4JA>
    <xmx:nWgTXxn6mUUtuAVJOAqDwh3m_y3x3oeWioYGomxGkhsscAEyFIrKww>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id DA0DF3280059;
        Sat, 18 Jul 2020 17:24:42 -0400 (EDT)
Subject: Re: [linux-sunxi] [PATCH 10/16] arm: dts: sunxi: h3/h5: Add DAI node
 for HDMI
To:     peron.clem@gmail.com, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20200704113902.336911-1-peron.clem@gmail.com>
 <20200704113902.336911-11-peron.clem@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <290468b2-8e4f-3881-1bc5-7a154c74e2a6@sholland.org>
Date:   Sat, 18 Jul 2020 16:24:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200704113902.336911-11-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clément,

On 7/4/20 6:38 AM, Clément Péron wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> Add the new DAI block for I2S2 which is used for HDMI audio.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> index 22d533d18992..9be13378d4df 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -662,6 +662,19 @@ i2s1: i2s@1c22400 {
>  			status = "disabled";
>  		};
>  
> +		i2s2: i2s@1c22800 {
> +			#sound-dai-cells = <0>;
> +			compatible = "allwinner,sun8i-h3-i2s";
> +			reg = <0x01c22800 0x400>;
> +			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&ccu CLK_BUS_I2S2>, <&ccu CLK_I2S2>;
> +			clock-names = "apb", "mod";
> +			dmas = <&dma 27>;
> +			resets = <&ccu RST_BUS_I2S2>;
> +			dma-names = "tx";

`make dtbs_check` reports:

i2s@1c22800: dma-names:0: 'rx' was expected
i2s@1c22800: dma-names: ['tx'] is too short
i2s@1c22800: dmas: [[28, 27]] is too short

Regards,
Samuel

> +			status = "disabled";
> +		};
> +
>  		codec: codec@1c22c00 {
>  			#sound-dai-cells = <0>;
>  			compatible = "allwinner,sun8i-h3-codec";
> 

