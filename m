Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60089C2D0EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3394C21D92
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="i9oZ+y2G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505525AbgDPKlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 06:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505042AbgDPKik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 06:38:40 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A030C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 03:38:37 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d27so4275393wra.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 03:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=pSjSCo+R3nw6Mi3WgTdlVGEQK1cZ5sHURhNm1msjdTw=;
        b=i9oZ+y2GOFfxTK1a5ceBZ6AFtsRyWZturgwWSIzu0ubbthr/zDvbQIlhqpL9KQ+Akf
         iRHamma5/OBwrFLC7wFH2TGQpQI8Uqr/mK2ZlnGswi7y4iSeL3PAbHFVttOAeb2yJMg6
         wbjEn2oAT+H4FpDaBQYfOSlS3HVjxO0y4fG8sFsSMFyrDBdlJZklr/Uv8NL7uZ6ZVrGB
         QcBEqdQMhigJmJRKosP/nueTsLOcT0Lp9ckPDHZip8stn+yTKyQKeINIQjPOcLac54ES
         ewZXUEaNNSEHp4rS5VebyWCJRGnhEerGVxVMh0oKL2fmEAwsEkSpD3nethOrJj97Gbd4
         dqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=pSjSCo+R3nw6Mi3WgTdlVGEQK1cZ5sHURhNm1msjdTw=;
        b=i78qk7IjmUM6WtVSbH2ld3aW/GSS6+TtS8TZFDFAGGy9axaXyBs6FbvqBfkOl44PJa
         HQ3BfdWuLX2tCjA+FbBf5x8JQ8MJypxBwKdBQv0+01qN65hcpvVmJ81Qp3NNpM/rF1/W
         VYHXWMkZgXs+7GqF1eM1bSkF32DkpKl8IP0Elmaa7IAJJQMtTdZHIyXVeOSGWYp+o1f0
         3zvaPGaOVNw6WLspuq/NXT/FKs6Pb8J+VjabSMFTKhI5x623hi4rso+eEO/ZrAmh/cDL
         W0T6x1lB/bAivnFloSRGw6Hbwxbet93H8byU0lkibkQqnMRKS21Z539pqTzFnFP9pR/W
         BqNg==
X-Gm-Message-State: AGi0Pub2y2ln1ASoGTgjlBz1PcxRR6B+deEejsQEBOVQSo5mwCsd7N3P
        PSm8rj88/wIPgHyusQhpXchSgw==
X-Google-Smtp-Source: APiQypJRkCtqhGOi3dzTBuCbBVYy1aeVZ14BVM0pG6hWY3E79FseizYNTA5LM6TJWETKq3a/bTDp4A==
X-Received: by 2002:adf:e591:: with SMTP id l17mr5282824wrm.268.1587033516109;
        Thu, 16 Apr 2020 03:38:36 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id y16sm26567044wrp.78.2020.04.16.03.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 03:38:35 -0700 (PDT)
References: <20200414200017.226136-1-martin.blumenstingl@googlemail.com> <20200414200017.226136-3-martin.blumenstingl@googlemail.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
Cc:     narmstrong@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] clk: meson: meson8b: Fix the polarity of the RESET_N lines
In-reply-to: <20200414200017.226136-3-martin.blumenstingl@googlemail.com>
Date:   Thu, 16 Apr 2020 12:38:34 +0200
Message-ID: <1ja73bbtqt.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue 14 Apr 2020 at 22:00, Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> CLKC_RESET_VID_DIVIDER_CNTL_RESET_N_POST and
> CLKC_RESET_VID_DIVIDER_CNTL_RESET_N_PRE are active low. This means:
> - asserting them requires setting the register value to 0
> - de-asserting them requires setting the register value to 1
>
> Set the register value accordingly for these two reset lines by setting
> the inverted the register value compared to all other reset lines.
>
> Fixes: 189621726bc2f6 ("clk: meson: meson8b: register the built-in reset controller")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  drivers/clk/meson/meson8b.c | 81 ++++++++++++++++++++++++++-----------
>  1 file changed, 58 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
> index 90d284ffc780..fa251e45e208 100644
> --- a/drivers/clk/meson/meson8b.c
> +++ b/drivers/clk/meson/meson8b.c
> @@ -3506,54 +3506,87 @@ static struct clk_regmap *const meson8b_clk_regmaps[] = {
>  static const struct meson8b_clk_reset_line {
>  	u32 reg;
>  	u8 bit_idx;
> +	bool active_low;
>  } meson8b_clk_reset_bits[] = {
>  	[CLKC_RESET_L2_CACHE_SOFT_RESET] = {
> -		.reg = HHI_SYS_CPU_CLK_CNTL0, .bit_idx = 30
> +		.reg = HHI_SYS_CPU_CLK_CNTL0,
> +		.bit_idx = 30,
> +		.active_low = false,
>  	},
>  	[CLKC_RESET_AXI_64_TO_128_BRIDGE_A5_SOFT_RESET] = {
> -		.reg = HHI_SYS_CPU_CLK_CNTL0, .bit_idx = 29
> +		.reg = HHI_SYS_CPU_CLK_CNTL0,
> +		.bit_idx = 29,
> +		.active_low = false,
>  	},
>  	[CLKC_RESET_SCU_SOFT_RESET] = {
> -		.reg = HHI_SYS_CPU_CLK_CNTL0, .bit_idx = 28
> +		.reg = HHI_SYS_CPU_CLK_CNTL0,
> +		.bit_idx = 28,
> +		.active_low = false,
>  	},
>  	[CLKC_RESET_CPU3_SOFT_RESET] = {
> -		.reg = HHI_SYS_CPU_CLK_CNTL0, .bit_idx = 27
> +		.reg = HHI_SYS_CPU_CLK_CNTL0,
> +		.bit_idx = 27,
> +		.active_low = false,
>  	},
>  	[CLKC_RESET_CPU2_SOFT_RESET] = {
> -		.reg = HHI_SYS_CPU_CLK_CNTL0, .bit_idx = 26
> +		.reg = HHI_SYS_CPU_CLK_CNTL0,
> +		.bit_idx = 26,
> +		.active_low = false,
>  	},
>  	[CLKC_RESET_CPU1_SOFT_RESET] = {
> -		.reg = HHI_SYS_CPU_CLK_CNTL0, .bit_idx = 25
> +		.reg = HHI_SYS_CPU_CLK_CNTL0,
> +		.bit_idx = 25,
> +		.active_low = false,
>  	},
>  	[CLKC_RESET_CPU0_SOFT_RESET] = {
> -		.reg = HHI_SYS_CPU_CLK_CNTL0, .bit_idx = 24
> +		.reg = HHI_SYS_CPU_CLK_CNTL0,
> +		.bit_idx = 24,
> +		.active_low = false,
>  	},
>  	[CLKC_RESET_A5_GLOBAL_RESET] = {
> -		.reg = HHI_SYS_CPU_CLK_CNTL0, .bit_idx = 18
> +		.reg = HHI_SYS_CPU_CLK_CNTL0,
> +		.bit_idx = 18,
> +		.active_low = false,
>  	},
>  	[CLKC_RESET_A5_AXI_SOFT_RESET] = {
> -		.reg = HHI_SYS_CPU_CLK_CNTL0, .bit_idx = 17
> +		.reg = HHI_SYS_CPU_CLK_CNTL0,
> +		.bit_idx = 17,
> +		.active_low = false,
>  	},
>  	[CLKC_RESET_A5_ABP_SOFT_RESET] = {
> -		.reg = HHI_SYS_CPU_CLK_CNTL0, .bit_idx = 16
> +		.reg = HHI_SYS_CPU_CLK_CNTL0,
> +		.bit_idx = 16,
> +		.active_low = false,
>  	},
>  	[CLKC_RESET_AXI_64_TO_128_BRIDGE_MMC_SOFT_RESET] = {
> -		.reg = HHI_SYS_CPU_CLK_CNTL1, .bit_idx = 30
> +		.reg = HHI_SYS_CPU_CLK_CNTL1,
> +		.bit_idx = 30,
> +		.active_low = false,
>  	},
>  	[CLKC_RESET_VID_CLK_CNTL_SOFT_RESET] = {
> -		.reg = HHI_VID_CLK_CNTL, .bit_idx = 15
> +		.reg = HHI_VID_CLK_CNTL,
> +		.bit_idx = 15,
> +		.active_low = false,
>  	},
>  	[CLKC_RESET_VID_DIVIDER_CNTL_SOFT_RESET_POST] = {
> -		.reg = HHI_VID_DIVIDER_CNTL, .bit_idx = 7
> +		.reg = HHI_VID_DIVIDER_CNTL,
> +		.bit_idx = 7,
> +		.active_low = false,
>  	},
>  	[CLKC_RESET_VID_DIVIDER_CNTL_SOFT_RESET_PRE] = {
> -		.reg = HHI_VID_DIVIDER_CNTL, .bit_idx = 3
> +		.reg = HHI_VID_DIVIDER_CNTL,
> +		.bit_idx = 3,
> +		.active_low = false,
>  	},
>  	[CLKC_RESET_VID_DIVIDER_CNTL_RESET_N_POST] = {
> -		.reg = HHI_VID_DIVIDER_CNTL, .bit_idx = 1
> +		.reg = HHI_VID_DIVIDER_CNTL,
> +		.bit_idx = 1,
> +		.active_low = true,
>  	},
>  	[CLKC_RESET_VID_DIVIDER_CNTL_RESET_N_PRE] = {
> -		.reg = HHI_VID_DIVIDER_CNTL, .bit_idx = 0
> +		.reg = HHI_VID_DIVIDER_CNTL,
> +		.bit_idx = 0,
> +		.active_low = true,
>  	},
>  };
>  
> @@ -3562,22 +3595,24 @@ static int meson8b_clk_reset_update(struct reset_controller_dev *rcdev,
>  {
>  	struct meson8b_clk_reset *meson8b_clk_reset =
>  		container_of(rcdev, struct meson8b_clk_reset, reset);
> -	unsigned long flags;
>  	const struct meson8b_clk_reset_line *reset;
> +	unsigned long flags;
> +	unsigned int value;

suggestion:

unsigned int value = 0;

>  
>  	if (id >= ARRAY_SIZE(meson8b_clk_reset_bits))
>  		return -EINVAL;
>  
>  	reset = &meson8b_clk_reset_bits[id];
>  
> +	if (assert == reset->active_low)
> +		value = 0;
> +	else
> +		value = BIT(reset->bit_idx);

if (assert ^ reset->active_low)
	value = BIT(reset->bit_idx);

?

> +
>  	spin_lock_irqsave(&meson_clk_lock, flags);
>  
> -	if (assert)
> -		regmap_update_bits(meson8b_clk_reset->regmap, reset->reg,
> -				   BIT(reset->bit_idx), BIT(reset->bit_idx));
> -	else
> -		regmap_update_bits(meson8b_clk_reset->regmap, reset->reg,
> -				   BIT(reset->bit_idx), 0);
> +	regmap_update_bits(meson8b_clk_reset->regmap, reset->reg,
> +			   BIT(reset->bit_idx), value);
>  
>  	spin_unlock_irqrestore(&meson_clk_lock, flags);

