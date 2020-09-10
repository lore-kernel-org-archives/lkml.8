Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643D2C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FF8E2078E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="FN6J7VZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbgIJKQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730465AbgIJKQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:16:03 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F16BC061757
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:16:00 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id a12so5694060eds.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=zkwyqV72nYwWA5qlqge5HoFYS2okYOL1NjxqW6/mtcU=;
        b=FN6J7VZPxc8Z7St7J3X3gJ0rRRZo9/Y9WOwr9pPqMClujr7J1zsQ0cqLmUONyhp/74
         KwlFnjeH7kP0DmloyOI99P+oPdevKJVzRRWxZ7KczhnIcUN/XOtgU9LStxF5d8X/06cA
         dLWZ2uAHZjgAjfKPT5c22lIvYAfBKeb27KP1wYO4g/VfTte15A2HlbwfjNOpN5lTP1au
         0/USmfJ9D27SQ+LtUN9cZc4IFiVhu6LSJAtFH5bIxbdx3MSo+GPx54Um6WPJoEj7ERhT
         WSNm/5kzVazfk2seS5NOiR/sK8zIa8EiYzXde2CJZBAIWh1/zHVVGsBCvv4YtewISrPm
         q/Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=zkwyqV72nYwWA5qlqge5HoFYS2okYOL1NjxqW6/mtcU=;
        b=aK/L/k/ET1JndhwHdjIVLPmt/+v/JpIok5RzqQXDQSInhWGX1e0/XJNSyWbMqR1/ef
         qOK6vW2+qxkoHWz+d9bZ8Kf0CJ8z/wNRwIZ8DCRB3vqA5iVWCXsqEympoOPnPxeBrfmD
         Vu4yZ1j0Nth0rPbC7OqyPOy91C1qDNW2P7iVxlZIhZxeCfqfmu4pNcpg9nCnx5rEnFIC
         /HDvWde5I0mWvfzq6W1RWJ5oqEJN36H7BuXVnbCGiv7RKSKqzOsIdSkctpdfz3BEQ0Nd
         Y0XWPRAsxPzT2bTzuPmAi1QXXsraU15xKOw26TikGVFKSmhzCfDZDE+Q2Wnsna5eWQjZ
         Qu0A==
X-Gm-Message-State: AOAM533xMece6dttLv/tF4QdryGWdDHRXY3s1UgwUBvxvab1gtR2REZB
        dP+9RH6p5i5pfLg53YZGg5UhTZgcQNj3TA==
X-Google-Smtp-Source: ABdhPJzumU+Ux5za/Pav8t+NenxZdYdqetAJ30ort4kgOcQXtM/idiX6Om16/teSDCXUuxE0wOPlaw==
X-Received: by 2002:a50:e70e:: with SMTP id a14mr8226265edn.93.1599732959326;
        Thu, 10 Sep 2020 03:15:59 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id m10sm6675588edf.11.2020.09.10.03.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 03:15:58 -0700 (PDT)
References: <20200907093810.6585-1-narmstrong@baylibre.com> <20200907093810.6585-5-narmstrong@baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] clk: meson: axg: add MIPI DSI Host clock
In-reply-to: <20200907093810.6585-5-narmstrong@baylibre.com>
Date:   Thu, 10 Sep 2020 12:15:57 +0200
Message-ID: <1jwo129btu.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 07 Sep 2020 at 11:38, Neil Armstrong <narmstrong@baylibre.com> wrote:

> This adds the MIPI DSI Host clock, used to measure the signal timings (ENC VSYNC or
> DW-MIPI-DSI eDPI timings).
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/clk/meson/axg.c | 66 +++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/axg.h |  4 ++-
>  2 files changed, 69 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
> index 2550616c14b0..0094ca6388d8 100644
> --- a/drivers/clk/meson/axg.c
> +++ b/drivers/clk/meson/axg.c
> @@ -1724,6 +1724,66 @@ static struct clk_regmap axg_cts_encl = {
>  	},
>  };
>  
> +/* MIPI DSI Host Clock */
> +
> +static const struct clk_parent_data axg_vdin_meas_parent_data[] = {
> +	{ .fw_name = "xtal", },
> +	{ .hw = &axg_fclk_div4.hw },
> +	{ .hw = &axg_fclk_div3.hw },
> +	{ .hw = &axg_fclk_div5.hw },
> +	{ },
> +	{ },

As you've done in other patches, I'd prefer if you used an index table
instead of having empty entries.

> +	{ .hw = &axg_fclk_div2.hw },
> +	{ .hw = &axg_fclk_div7.hw },
> +};
> +
> +static struct clk_regmap axg_vdin_meas_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_VDIN_MEAS_CLK_CNTL,
> +		.mask = 0x7,
> +		.shift = 21,
> +		.flags = CLK_MUX_ROUND_CLOSEST,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vdin_meas_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_data = axg_vdin_meas_parent_data,
> +		.num_parents = ARRAY_SIZE(axg_vdin_meas_parent_data),
> +		.flags = CLK_SET_RATE_NO_REPARENT,

A comment about why manual control is required would be nice.

> +	},
> +};
> +
> +static struct clk_regmap axg_vdin_meas_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_VDIN_MEAS_CLK_CNTL,
> +		.shift = 12,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vdin_meas_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&axg_vdin_meas_sel.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap axg_vdin_meas = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VDIN_MEAS_CLK_CNTL,
> +		.bit_idx = 20,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vdin_meas",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&axg_vdin_meas_div.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
>  static u32 mux_table_gen_clk[]	= { 0, 4, 5, 6, 7, 8,
>  				    9, 10, 11, 13, 14, };
>  static const struct clk_parent_data gen_clk_parent_data[] = {
> @@ -1987,6 +2047,9 @@ static struct clk_hw_onecell_data axg_hw_onecell_data = {
>  		[CLKID_VCLK2_DIV12]		= &axg_vclk2_div12.hw,
>  		[CLKID_CTS_ENCL_SEL]		= &axg_cts_encl_sel.hw,
>  		[CLKID_CTS_ENCL]		= &axg_cts_encl.hw,
> +		[CLKID_VDIN_MEAS_SEL]		= &axg_vdin_meas_sel.hw,
> +		[CLKID_VDIN_MEAS_DIV]		= &axg_vdin_meas_div.hw,
> +		[CLKID_VDIN_MEAS]		= &axg_vdin_meas.hw,
>  		[NR_CLKS]			= NULL,
>  	},
>  	.num = NR_CLKS,
> @@ -2115,6 +2178,9 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
>  	&axg_vclk2_div12_en,
>  	&axg_cts_encl_sel,
>  	&axg_cts_encl,
> +	&axg_vdin_meas_sel,
> +	&axg_vdin_meas_div,
> +	&axg_vdin_meas,
>  };
>  
>  static const struct meson_eeclkc_data axg_clkc_data = {
> diff --git a/drivers/clk/meson/axg.h b/drivers/clk/meson/axg.h
> index a8787b394a47..481b307ea3cb 100644
> --- a/drivers/clk/meson/axg.h
> +++ b/drivers/clk/meson/axg.h
> @@ -158,8 +158,10 @@
>  #define CLKID_VCLK2_DIV6_EN			120
>  #define CLKID_VCLK2_DIV12_EN			121
>  #define CLKID_CTS_ENCL_SEL			132
> +#define CLKID_VDIN_MEAS_SEL			134
> +#define CLKID_VDIN_MEAS_DIV			135
>  
> -#define NR_CLKS					134
> +#define NR_CLKS					137
>  
>  /* include the CLKIDs that have been made part of the DT binding */
>  #include <dt-bindings/clock/axg-clkc.h>

