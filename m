Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3982CC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A8B8206D4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="qH0x9AqW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iGBdKFsC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgIDDSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 23:18:49 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:54097 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729528AbgIDDSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:18:45 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 6FD431284;
        Thu,  3 Sep 2020 23:18:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 03 Sep 2020 23:18:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=d
        aya0oYspjG9Gt00RdJSVZlyB/j1e0iHqyBf8JDOAHI=; b=qH0x9AqWShHLGvJbB
        7WcnSKZuR70hZW8ewBHikke14/RXA8iKU/mEzz0GIrLcaBzADVkQO5lzqnRi8mYm
        Xy00p/D0HT0UmACc1lGMyuGbGt2yg1RYNX5Kkf6BV6hYerXKMbCD5ZrB3jup7Q7w
        iE4VSpaSVXDpndzBYdxK4dR9M2hdc2JXXQX5eqOpuuOMxmyASfk4lPsQRNkQAzY7
        9A9DckA8bFLWaDa8/SaelMBPxQSwl4FNutnLFMYq23qmVTvSz5OQB43KhwUCD007
        n87tBPRbzG1E0SSfvTaH1wR2MmELcMJXHvjF1ldAafJePKDJZbCLIknt9vmYSLul
        +jLFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=daya0oYspjG9Gt00RdJSVZlyB/j1e0iHqyBf8JDOA
        HI=; b=iGBdKFsC7cY4mTqOmEfFlQKxEdwHyo1tR7qFwoMoacPY7KvfRFKQGb2fo
        OfLo138V2tSHV9tMGKGYna31Q5n0MnZekdwrIS3DTaSJw/fvRlBUhHAa82FEOT+v
        7Y44RuqcZU/22xfJFaDHBRfCTlwPvcl7gj7Z4f+F8DeHrwYZ/IzGBU6x5WrWRwpv
        oVrcWmnQYUJa4OKDErzDyHmeO0plOzB4RgCbLR5mtlDYZ9eGVegyjOsB3AOsa/EZ
        bZhsGVr3VmI/x0NUAj3sGpzqy52GlXTmL3Y7+KBhQy0vTSrDFw1ToMfX/uJYMneq
        01erHy6INxtw4C9A++lTMSEzNunyA==
X-ME-Sender: <xms:ErJRX56UYu_vQFidW29eL1TaTHtWJrt8O7yvn0EpgZ6tslVOizgTSw>
    <xme:ErJRX25XHcw6Q65G_OWOfyyo84-0xsJ5-pW9tUxJVY7k9nJMS8nGSdIIHMwEey4jd
    m5Dr09dsGrifu85cA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegvddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfelkeduveejtdejhfeiledvhfeggeeiieeklefhfeefffffffeg
    udetteelieejnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:ErJRXwdm0znDTekQkNpFRQKbhtAKv3wpFUv2oOzFO8zqvcmj0TS_nw>
    <xmx:ErJRXyInBPKHnNQ5vu1Ha2kaImMh0C6LIlQaLxxooKZZv_I3vojWcQ>
    <xmx:ErJRX9L5iJJURgSbz473jBhbVTvc7YfkTP_ECs06ZMhEX0NV4Eoojw>
    <xmx:E7JRX3CAaQ_5Az1QgjcryG6sjtQ9nSOqGLhE0CbjaIDwHdDRSHcbucvrBQU>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 546CF328005A;
        Thu,  3 Sep 2020 23:18:41 -0400 (EDT)
Subject: Re: [PATCH v2 03/20] ASoC: sun4i-i2s: Adjust LRCLK width
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <maxime@cerno.tech>
References: <20200903203034.1057334-1-peron.clem@gmail.com>
 <20200903203034.1057334-4-peron.clem@gmail.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <e4c5eb23-e932-148c-5da6-90584c95cc81@sholland.org>
Date:   Thu, 3 Sep 2020 22:18:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200903203034.1057334-4-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clément,

On 9/3/20 3:30 PM, Clément Péron wrote:
> From: Marcus Cooper <codekipper@gmail.com>
> 
> Some codecs such as i2s based HDMI audio and the Pine64 DAC require
> a different amount of bit clocks per frame than what is calculated
> by the sample width. Use the values obtained by the tdm slot bindings
> to adjust the LRCLK width accordingly.
> 
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> Acked-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index acf24f512f2c..1b4482b0f4af 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -478,6 +478,9 @@ static int sun8i_i2s_set_chan_cfg(const struct sun4i_i2s *i2s,
>  		return -EINVAL;
>  	}
>  
> +	if (i2s->slot_width)
> +		lrck_period = i2s->slot_width;
> +

Same as patch 2, this duplicates logic in sun4i_i2s_hw_params, and would need to
be multiplied by `slots` for PCM (DSP_A/B) mode.

Regards,
Samuel

>  	regmap_update_bits(i2s->regmap, SUN4I_I2S_FMT0_REG,
>  			   SUN8I_I2S_FMT0_LRCK_PERIOD_MASK,
>  			   SUN8I_I2S_FMT0_LRCK_PERIOD(lrck_period));
> 

