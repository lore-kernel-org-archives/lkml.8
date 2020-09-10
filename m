Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC6A0C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8603820BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="qOxgMVv5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbgIJKNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgIJKNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:13:10 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAF1C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:13:09 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id t16so5716090edw.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=fHEQ//3DcujcMv4gTr3j5aDEGhr1+DlUwrVUW/iKvTY=;
        b=qOxgMVv51GMUW6S4uODs9cAp+YoZeTNPf4tLpl7RhFHiJtM3MRcm8gbC3GWQSuUbev
         B5VZM45NTWDOrKRqapF8BfiFKtFFWbfcWiu9xaEGT03WeVXlsj11DLeZsVbRoHd5wUea
         F0McPPHTETKDDnaDXvbJ7g2XFvcbQHxVaddlQ3D9SgN7M9vfm7nkKqwIfEJdH570isgP
         2+9bxhvkuN3geNqzdMpIDmFuUj/j9SHmJwV2ySp057dhi5aiMKgGBEMn6D+zygzv6iUm
         tk1bK14xkgxCTxVWXR/6v84kuAI+w+oSSA38dEAeXpnwc/nY+2LVct0xfkHKSM0OYuuy
         OocQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=fHEQ//3DcujcMv4gTr3j5aDEGhr1+DlUwrVUW/iKvTY=;
        b=GDuNONJACJedVcipYWbc3kLLeHgwJxtietMgZsY+FhoBv0ap5+LRKFR4+VPzl41g29
         FxYRawuvR8M4BBzkl/knSng7vOXDJZ3mMIrpRfGCQavRwkL+l+wCUXfcAm7HUge0Bf+Q
         hh34sMHctjcKQXebJ5dbqbUydIrl6McaEvvsEMHG2ipKQYqVWLAvnquf3KD4opcbpjxe
         lt2cXE5b6KlLMIz+kNWplGkmAe7yGijHsZ/HnnIYdA7ZfDpRxvV2xNUsInu9MLyQ6IyU
         rdg0pRMgCFiHHTXcoI3k/5z/TukZ4iNFQeqd/U6M2BaN5yx+RY7GYznQcc1DgyjmAI2j
         vdJQ==
X-Gm-Message-State: AOAM533LCHs7RmANcO2+DA+o7EsJGgyq6MHbDKojWPbZ8qsZnvye0Ff0
        XCAdA38B+2Lt2c9WfHe1uyG68A==
X-Google-Smtp-Source: ABdhPJxFIjIJebjpWL/qMUXv26+ujn92RXolP+EybKqV9y1lLsrwEvgD1ocOnLdaTi85RA6WWNu49A==
X-Received: by 2002:aa7:dcc1:: with SMTP id w1mr8190081edu.360.1599732787805;
        Thu, 10 Sep 2020 03:13:07 -0700 (PDT)
Received: from localhost (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.gmail.com with ESMTPSA id op24sm6275279ejb.87.2020.09.10.03.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 03:13:07 -0700 (PDT)
References: <20200907093810.6585-1-narmstrong@baylibre.com> <20200907093810.6585-4-narmstrong@baylibre.com>
User-agent: mu4e 1.3.3; emacs 26.3
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] clk: meson: axg: add Video Clocks
In-reply-to: <20200907093810.6585-4-narmstrong@baylibre.com>
Date:   Thu, 10 Sep 2020 12:13:05 +0200
Message-ID: <1jy2li9bym.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 07 Sep 2020 at 11:38, Neil Armstrong <narmstrong@baylibre.com> wrote:

> Add the Video Clocks present on the Amlogic AXg SoCs.
>
> The AXG only has a single ENCL CTS clock and even if VCLK exist along VCLK2,
> only VCLK2 is used since it clocks the MIPI DSI IP directly.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/clk/meson/axg.c | 774 ++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/meson/axg.h |  21 +-
>  2 files changed, 794 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
> index 13fc0006f63d..2550616c14b0 100644
> --- a/drivers/clk/meson/axg.c
> +++ b/drivers/clk/meson/axg.c
> @@ -1026,6 +1026,704 @@ static struct clk_regmap axg_sd_emmc_c_clk0 = {
>  	},
>  };
>  
> +/* VPU Clock */
> +
> +static const struct clk_hw *axg_vpu_parent_hws[] = {
> +	&axg_fclk_div4.hw,
> +	&axg_fclk_div3.hw,
> +	&axg_fclk_div5.hw,
> +	&axg_fclk_div7.hw,
> +};
> +
> +static struct clk_regmap axg_vpu_0_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_VPU_CLK_CNTL,
> +		.mask = 0x3,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vpu_0_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		/*
> +		 * bits 9:10 selects from 4 possible parents:
> +		 * fclk_div4, fclk_div3, fclk_div5, fclk_div7,
> +		 */

These comments (and the same bellow) are not very useful

> +		.parent_hws = axg_vpu_parent_hws,
> +		.num_parents = ARRAY_SIZE(axg_vpu_parent_hws),

Could you add a comment here explaining why parenting needs to be
manually controlled ?

> +		.flags = CLK_SET_RATE_NO_REPARENT,
> +	},
> +};
> +
> +static struct clk_regmap axg_vpu_0_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_VPU_CLK_CNTL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vpu_0_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &axg_vpu_0_sel.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap axg_vpu_0 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VPU_CLK_CNTL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vpu_0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &axg_vpu_0_div.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,

Why is UNUSED required ?

> +	},
> +};
> +
> +static struct clk_regmap axg_vpu_1_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_VPU_CLK_CNTL,
> +		.mask = 0x3,
> +		.shift = 25,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vpu_1_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		/*
> +		 * bits 25:26 selects from 4 possible parents:
> +		 * fclk_div4, fclk_div3, fclk_div5, fclk_div7,
> +		 */
> +		.parent_hws = axg_vpu_parent_hws,
> +		.num_parents = ARRAY_SIZE(axg_vpu_parent_hws),
> +		.flags = CLK_SET_RATE_NO_REPARENT,
> +	},
> +};
> +
> +static struct clk_regmap axg_vpu_1_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_VPU_CLK_CNTL,
> +		.shift = 16,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vpu_1_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &axg_vpu_1_sel.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap axg_vpu_1 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VPU_CLK_CNTL,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vpu_1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &axg_vpu_1_div.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static struct clk_regmap axg_vpu = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_VPU_CLK_CNTL,
> +		.mask = 1,
> +		.shift = 31,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vpu",
> +		.ops = &clk_regmap_mux_ops,
> +		/*
> +		 * bit 31 selects from 2 possible parents:
> +		 * vpu_0 or vpu_1
> +		 */
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&axg_vpu_0.hw,
> +			&axg_vpu_1.hw
> +		},
> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_NO_REPARENT,
> +	},
> +};
> +
> +/* VAPB Clock */
> +
> +static const struct clk_hw *axg_vapb_parent_hws[] = {
> +	&axg_fclk_div4.hw,
> +	&axg_fclk_div3.hw,
> +	&axg_fclk_div5.hw,
> +	&axg_fclk_div7.hw,
> +};

This is the same as the vpu table. Could they share a single table ?

> +
> +static struct clk_regmap axg_vapb_0_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_VAPBCLK_CNTL,
> +		.mask = 0x3,
> +		.shift = 9,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vapb_0_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		/*
> +		 * bits 9:10 selects from 4 possible parents:
> +		 * fclk_div4, fclk_div3, fclk_div5, fclk_div7,
> +		 */
> +		.parent_hws = axg_vapb_parent_hws,
> +		.num_parents = ARRAY_SIZE(axg_vapb_parent_hws),
> +		.flags = CLK_SET_RATE_NO_REPARENT,
> +	},
> +};
> +
> +static struct clk_regmap axg_vapb_0_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_VAPBCLK_CNTL,
> +		.shift = 0,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vapb_0_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&axg_vapb_0_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap axg_vapb_0 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VAPBCLK_CNTL,
> +		.bit_idx = 8,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vapb_0",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&axg_vapb_0_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static struct clk_regmap axg_vapb_1_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_VAPBCLK_CNTL,
> +		.mask = 0x3,
> +		.shift = 25,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vapb_1_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		/*
> +		 * bits 25:26 selects from 4 possible parents:
> +		 * fclk_div4, fclk_div3, fclk_div5, fclk_div7,
> +		 */
> +		.parent_hws = axg_vapb_parent_hws,
> +		.num_parents = ARRAY_SIZE(axg_vapb_parent_hws),
> +		.flags = CLK_SET_RATE_NO_REPARENT,
> +	},
> +};
> +
> +static struct clk_regmap axg_vapb_1_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_VAPBCLK_CNTL,
> +		.shift = 16,
> +		.width = 7,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vapb_1_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&axg_vapb_1_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT,
> +	},
> +};
> +
> +static struct clk_regmap axg_vapb_1 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VAPBCLK_CNTL,
> +		.bit_idx = 24,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vapb_1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&axg_vapb_1_div.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static struct clk_regmap axg_vapb_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_VAPBCLK_CNTL,
> +		.mask = 1,
> +		.shift = 31,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vapb_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		/*
> +		 * bit 31 selects from 2 possible parents:
> +		 * vapb_0 or vapb_1
> +		 */
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&axg_vapb_0.hw,
> +			&axg_vapb_1.hw
> +		},
> +		.num_parents = 2,
> +		.flags = CLK_SET_RATE_NO_REPARENT,
> +	},
> +};
> +
> +static struct clk_regmap axg_vapb = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VAPBCLK_CNTL,
> +		.bit_idx = 30,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vapb",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &axg_vapb_sel.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +/* Video Clocks */
> +
> +static const struct clk_hw *axg_vclk_parent_hws[] = {
> +	&axg_gp0_pll.hw,
> +	&axg_fclk_div4.hw,
> +	&axg_fclk_div3.hw,
> +	&axg_fclk_div5.hw,
> +	&axg_fclk_div2.hw,
> +	&axg_fclk_div7.hw,
> +	&axg_mpll1.hw,
> +};
> +
> +static struct clk_regmap axg_vclk_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_VID_CLK_CNTL,
> +		.mask = 0x7,
> +		.shift = 16,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = axg_vclk_parent_hws,
> +		.num_parents = ARRAY_SIZE(axg_vclk_parent_hws),
> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
> +	},

Why is NOCACHE ? Is there something poking behind CCF back ? if yes, why
is this required ?

> +};
> +
> +static struct clk_regmap axg_vclk2_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_VIID_CLK_CNTL,
> +		.mask = 0x7,
> +		.shift = 16,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk2_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = axg_vclk_parent_hws,
> +		.num_parents = ARRAY_SIZE(axg_vclk_parent_hws),
> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
> +	},
> +};
> +
> +static struct clk_regmap axg_vclk_input = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VID_CLK_DIV,
> +		.bit_idx = 16,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk_input",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk_sel.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static struct clk_regmap axg_vclk2_input = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VIID_CLK_DIV,
> +		.bit_idx = 16,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk2_input",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk2_sel.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static struct clk_regmap axg_vclk_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_VID_CLK_DIV,
> +		.shift = 0,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&axg_vclk_input.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_GET_RATE_NOCACHE,
> +	},
> +};
> +
> +static struct clk_regmap axg_vclk2_div = {
> +	.data = &(struct clk_regmap_div_data){
> +		.offset = HHI_VIID_CLK_DIV,
> +		.shift = 0,
> +		.width = 8,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk2_div",
> +		.ops = &clk_regmap_divider_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&axg_vclk2_input.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_GET_RATE_NOCACHE,
> +	},
> +};
> +
> +static struct clk_regmap axg_vclk = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VID_CLK_CNTL,
> +		.bit_idx = 19,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk_div.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static struct clk_regmap axg_vclk2 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VIID_CLK_CNTL,
> +		.bit_idx = 19,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk2",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk2_div.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static struct clk_regmap axg_vclk_div1 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VID_CLK_CNTL,
> +		.bit_idx = 0,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk_div1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static struct clk_regmap axg_vclk_div2_en = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VID_CLK_CNTL,
> +		.bit_idx = 1,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk_div2_en",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static struct clk_regmap axg_vclk_div4_en = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VID_CLK_CNTL,
> +		.bit_idx = 2,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk_div4_en",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static struct clk_regmap axg_vclk_div6_en = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VID_CLK_CNTL,
> +		.bit_idx = 3,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk_div6_en",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static struct clk_regmap axg_vclk_div12_en = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VID_CLK_CNTL,
> +		.bit_idx = 4,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk_div12_en",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static struct clk_regmap axg_vclk2_div1 = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VIID_CLK_CNTL,
> +		.bit_idx = 0,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk2_div1",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk2.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static struct clk_regmap axg_vclk2_div2_en = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VIID_CLK_CNTL,
> +		.bit_idx = 1,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk2_div2_en",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk2.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static struct clk_regmap axg_vclk2_div4_en = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VIID_CLK_CNTL,
> +		.bit_idx = 2,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk2_div4_en",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk2.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static struct clk_regmap axg_vclk2_div6_en = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VIID_CLK_CNTL,
> +		.bit_idx = 3,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk2_div6_en",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk2.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static struct clk_regmap axg_vclk2_div12_en = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VIID_CLK_CNTL,
> +		.bit_idx = 4,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "vclk2_div12_en",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) { &axg_vclk2.hw },
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
> +static struct clk_fixed_factor axg_vclk_div2 = {
> +	.mult = 1,
> +	.div = 2,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk_div2",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&axg_vclk_div2_en.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor axg_vclk_div4 = {
> +	.mult = 1,
> +	.div = 4,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk_div4",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&axg_vclk_div4_en.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor axg_vclk_div6 = {
> +	.mult = 1,
> +	.div = 6,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk_div6",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&axg_vclk_div6_en.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor axg_vclk_div12 = {
> +	.mult = 1,
> +	.div = 12,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk_div12",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&axg_vclk_div12_en.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor axg_vclk2_div2 = {
> +	.mult = 1,
> +	.div = 2,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk2_div2",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&axg_vclk2_div2_en.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor axg_vclk2_div4 = {
> +	.mult = 1,
> +	.div = 4,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk2_div4",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&axg_vclk2_div4_en.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor axg_vclk2_div6 = {
> +	.mult = 1,
> +	.div = 6,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk2_div6",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&axg_vclk2_div6_en.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static struct clk_fixed_factor axg_vclk2_div12 = {
> +	.mult = 1,
> +	.div = 12,
> +	.hw.init = &(struct clk_init_data){
> +		.name = "vclk2_div12",
> +		.ops = &clk_fixed_factor_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&axg_vclk2_div12_en.hw
> +		},
> +		.num_parents = 1,
> +	},
> +};
> +
> +static u32 mux_table_cts_sel[] = { 0, 1, 2, 3, 4, 8, 9, 10, 11, 12 };
> +static const struct clk_hw *axg_cts_parent_hws[] = {
> +	&axg_vclk_div1.hw,
> +	&axg_vclk_div2.hw,
> +	&axg_vclk_div4.hw,
> +	&axg_vclk_div6.hw,
> +	&axg_vclk_div12.hw,
> +	&axg_vclk2_div1.hw,
> +	&axg_vclk2_div2.hw,
> +	&axg_vclk2_div4.hw,
> +	&axg_vclk2_div6.hw,
> +	&axg_vclk2_div12.hw,
> +};
> +
> +static struct clk_regmap axg_cts_encl_sel = {
> +	.data = &(struct clk_regmap_mux_data){
> +		.offset = HHI_VIID_CLK_DIV,
> +		.mask = 0xf,
> +		.shift = 12,
> +		.table = mux_table_cts_sel,
> +	},
> +	.hw.init = &(struct clk_init_data){
> +		.name = "cts_encl_sel",
> +		.ops = &clk_regmap_mux_ops,
> +		.parent_hws = axg_cts_parent_hws,
> +		.num_parents = ARRAY_SIZE(axg_cts_parent_hws),
> +		.flags = CLK_SET_RATE_NO_REPARENT | CLK_GET_RATE_NOCACHE,
> +	},
> +};
> +
> +static struct clk_regmap axg_cts_encl = {
> +	.data = &(struct clk_regmap_gate_data){
> +		.offset = HHI_VID_CLK_CNTL2,
> +		.bit_idx = 3,
> +	},
> +	.hw.init = &(struct clk_init_data) {
> +		.name = "cts_encl",
> +		.ops = &clk_regmap_gate_ops,
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&axg_cts_encl_sel.hw
> +		},
> +		.num_parents = 1,
> +		.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
> +	},
> +};
> +
>  static u32 mux_table_gen_clk[]	= { 0, 4, 5, 6, 7, 8,
>  				    9, 10, 11, 13, 14, };
>  static const struct clk_parent_data gen_clk_parent_data[] = {
> @@ -1246,6 +1944,49 @@ static struct clk_hw_onecell_data axg_hw_onecell_data = {
>  		[CLKID_HIFI_PLL_DCO]		= &axg_hifi_pll_dco.hw,
>  		[CLKID_PCIE_PLL_DCO]		= &axg_pcie_pll_dco.hw,
>  		[CLKID_PCIE_PLL_OD]		= &axg_pcie_pll_od.hw,
> +		[CLKID_VPU_0_DIV]		= &axg_vpu_0_div.hw,
> +		[CLKID_VPU_0_SEL]		= &axg_vpu_0_sel.hw,
> +		[CLKID_VPU_0]			= &axg_vpu_0.hw,
> +		[CLKID_VPU_1_DIV]		= &axg_vpu_1_div.hw,
> +		[CLKID_VPU_1_SEL]		= &axg_vpu_1_sel.hw,
> +		[CLKID_VPU_1]			= &axg_vpu_1.hw,
> +		[CLKID_VPU]			= &axg_vpu.hw,
> +		[CLKID_VAPB_0_DIV]		= &axg_vapb_0_div.hw,
> +		[CLKID_VAPB_0_SEL]		= &axg_vapb_0_sel.hw,
> +		[CLKID_VAPB_0]			= &axg_vapb_0.hw,
> +		[CLKID_VAPB_1_DIV]		= &axg_vapb_1_div.hw,
> +		[CLKID_VAPB_1_SEL]		= &axg_vapb_1_sel.hw,
> +		[CLKID_VAPB_1]			= &axg_vapb_1.hw,
> +		[CLKID_VAPB_SEL]		= &axg_vapb_sel.hw,
> +		[CLKID_VAPB]			= &axg_vapb.hw,
> +		[CLKID_VCLK]			= &axg_vclk.hw,
> +		[CLKID_VCLK2]			= &axg_vclk2.hw,
> +		[CLKID_VCLK_SEL]		= &axg_vclk_sel.hw,
> +		[CLKID_VCLK2_SEL]		= &axg_vclk2_sel.hw,
> +		[CLKID_VCLK_INPUT]		= &axg_vclk_input.hw,
> +		[CLKID_VCLK2_INPUT]		= &axg_vclk2_input.hw,
> +		[CLKID_VCLK_DIV]		= &axg_vclk_div.hw,
> +		[CLKID_VCLK2_DIV]		= &axg_vclk2_div.hw,
> +		[CLKID_VCLK_DIV2_EN]		= &axg_vclk_div2_en.hw,
> +		[CLKID_VCLK_DIV4_EN]		= &axg_vclk_div4_en.hw,
> +		[CLKID_VCLK_DIV6_EN]		= &axg_vclk_div6_en.hw,
> +		[CLKID_VCLK_DIV12_EN]		= &axg_vclk_div12_en.hw,
> +		[CLKID_VCLK2_DIV2_EN]		= &axg_vclk2_div2_en.hw,
> +		[CLKID_VCLK2_DIV4_EN]		= &axg_vclk2_div4_en.hw,
> +		[CLKID_VCLK2_DIV6_EN]		= &axg_vclk2_div6_en.hw,
> +		[CLKID_VCLK2_DIV12_EN]		= &axg_vclk2_div12_en.hw,
> +		[CLKID_VCLK_DIV1]		= &axg_vclk_div1.hw,
> +		[CLKID_VCLK_DIV2]		= &axg_vclk_div2.hw,
> +		[CLKID_VCLK_DIV4]		= &axg_vclk_div4.hw,
> +		[CLKID_VCLK_DIV6]		= &axg_vclk_div6.hw,
> +		[CLKID_VCLK_DIV12]		= &axg_vclk_div12.hw,
> +		[CLKID_VCLK2_DIV1]		= &axg_vclk2_div1.hw,
> +		[CLKID_VCLK2_DIV2]		= &axg_vclk2_div2.hw,
> +		[CLKID_VCLK2_DIV4]		= &axg_vclk2_div4.hw,
> +		[CLKID_VCLK2_DIV6]		= &axg_vclk2_div6.hw,
> +		[CLKID_VCLK2_DIV12]		= &axg_vclk2_div12.hw,
> +		[CLKID_CTS_ENCL_SEL]		= &axg_cts_encl_sel.hw,
> +		[CLKID_CTS_ENCL]		= &axg_cts_encl.hw,
>  		[NR_CLKS]			= NULL,
>  	},
>  	.num = NR_CLKS,
> @@ -1341,6 +2082,39 @@ static struct clk_regmap *const axg_clk_regmaps[] = {
>  	&axg_hifi_pll_dco,
>  	&axg_pcie_pll_dco,
>  	&axg_pcie_pll_od,
> +	&axg_vpu_0_div,
> +	&axg_vpu_0_sel,
> +	&axg_vpu_0,
> +	&axg_vpu_1_div,
> +	&axg_vpu_1_sel,
> +	&axg_vpu_1,
> +	&axg_vpu,
> +	&axg_vapb_0_div,
> +	&axg_vapb_0_sel,
> +	&axg_vapb_0,
> +	&axg_vapb_1_div,
> +	&axg_vapb_1_sel,
> +	&axg_vapb_1,
> +	&axg_vapb_sel,
> +	&axg_vapb,
> +	&axg_vclk,
> +	&axg_vclk2,
> +	&axg_vclk_sel,
> +	&axg_vclk2_sel,
> +	&axg_vclk_input,
> +	&axg_vclk2_input,
> +	&axg_vclk_div,
> +	&axg_vclk2_div,
> +	&axg_vclk_div2_en,
> +	&axg_vclk_div4_en,
> +	&axg_vclk_div6_en,
> +	&axg_vclk_div12_en,
> +	&axg_vclk2_div2_en,
> +	&axg_vclk2_div4_en,
> +	&axg_vclk2_div6_en,
> +	&axg_vclk2_div12_en,
> +	&axg_cts_encl_sel,
> +	&axg_cts_encl,
>  };
>  
>  static const struct meson_eeclkc_data axg_clkc_data = {
> diff --git a/drivers/clk/meson/axg.h b/drivers/clk/meson/axg.h
> index 0431dabac629..a8787b394a47 100644
> --- a/drivers/clk/meson/axg.h
> +++ b/drivers/clk/meson/axg.h
> @@ -139,8 +139,27 @@
>  #define CLKID_HIFI_PLL_DCO			88
>  #define CLKID_PCIE_PLL_DCO			89
>  #define CLKID_PCIE_PLL_OD			90
> +#define CLKID_VPU_0_DIV				91
> +#define CLKID_VPU_1_DIV				94
> +#define CLKID_VAPB_0_DIV			98
> +#define CLKID_VAPB_1_DIV			101
> +#define CLKID_VCLK_SEL				108
> +#define CLKID_VCLK2_SEL				109
> +#define CLKID_VCLK_INPUT			110
> +#define CLKID_VCLK2_INPUT			111
> +#define CLKID_VCLK_DIV				112
> +#define CLKID_VCLK2_DIV				113
> +#define CLKID_VCLK_DIV2_EN			114
> +#define CLKID_VCLK_DIV4_EN			115
> +#define CLKID_VCLK_DIV6_EN			116
> +#define CLKID_VCLK_DIV12_EN			117
> +#define CLKID_VCLK2_DIV2_EN			118
> +#define CLKID_VCLK2_DIV4_EN			119
> +#define CLKID_VCLK2_DIV6_EN			120
> +#define CLKID_VCLK2_DIV12_EN			121
> +#define CLKID_CTS_ENCL_SEL			132
>  
> -#define NR_CLKS					91
> +#define NR_CLKS					134
>  
>  /* include the CLKIDs that have been made part of the DT binding */
>  #include <dt-bindings/clock/axg-clkc.h>

Overall, there is quite an heavy use of CLK_IGNORE_USED and
CLK_GET_RATE_NOCACHE which seems to indicate that something else is
poking around in the clocks registers

Details about why it should be done this way, and not through CCF API,
should be provided.
