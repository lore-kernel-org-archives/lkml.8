Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AEC8C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F4222522
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ns6+GodD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgA1RnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 12:43:06 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44626 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgA1RnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:43:05 -0500
Received: by mail-pg1-f195.google.com with SMTP id x7so7351901pgl.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 09:43:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G04x8476nlRwMoS791EOJ6boBhRRBrF1hDA0bU861cc=;
        b=ns6+GodDmZj1qux8lOkolFF0tVvlWwySGfBojg6+kBcxRXz1b7A403EwYW+tjaNOGr
         tkspoCr3bftdSCnD7Bx62QqXmXJHqTwk5DIDQ1VH1IKdqWUzqQzBNfqqhFslObS6lZrn
         QHujz5wRSR3Fp3cYjsNHNSUY5C6gTc8LKCIlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G04x8476nlRwMoS791EOJ6boBhRRBrF1hDA0bU861cc=;
        b=sCcuMisVkNYLwOlVr8SK7886u0YHtvC2kCQqS89QaIAS2kBbp1RJ8iXynnjvB5nd+W
         nTqzQeTd85v0we5HPjz+P6HEU57fJR7hMaR5STDCfY3hJTUsSy2NblGIrYG0rjqQMD68
         eTeDxszej2FJUAQie0xz59BYZpeOjqbiew73nnwzpi5Q0Y5uhnLum0TzjxulPDBoqlms
         guR/x0ZiCSU4d1hwOQM0VxKBivvqEPAuNfv2t6JR6lEr3ryAhtMUhogXA2tRdA9xXzWJ
         ujAhGKFdfAd4fQHqcHR717PuKnwulVpmOKY8Wqd5m6d0pTqt+jWF2i+5JSaJ4CNNiA/7
         0DQw==
X-Gm-Message-State: APjAAAUqnDgnI/xXydtgHapP4DEGMwpHF6j8pxIxFJU1IHXIcKAmv0q7
        4YuV/jKTDO9CxaEMG4vnZM32dw==
X-Google-Smtp-Source: APXvYqxSOemF9qw2kW6ZxPefKrBcxmuZ0GN4JhdOH+GB/inoDCy3xQvLMlT5IKP/XRBqjrpTP/1jqg==
X-Received: by 2002:a62:2ca:: with SMTP id 193mr5074976pfc.137.1580233384989;
        Tue, 28 Jan 2020 09:43:04 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id h128sm20716988pfe.172.2020.01.28.09.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 09:43:04 -0800 (PST)
Date:   Tue, 28 Jan 2020 09:43:02 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, harigovi@codeaurora.org,
        kalyan_t@codeaurora.org, Mark Rutland <mark.rutland@arm.com>,
        linux-clk@vger.kernel.org, hoegsberg@chromium.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] clk: qcom: rcg2: Don't crash if our parent
 can't be found; return an error
Message-ID: <20200128174302.GA46072@google.com>
References: <20200124224225.22547-1-dianders@chromium.org>
 <20200124144154.v2.1.I7487325fe8e701a68a07d3be8a6a4b571eca9cfa@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200124144154.v2.1.I7487325fe8e701a68a07d3be8a6a4b571eca9cfa@changeid>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 02:42:16PM -0800, Douglas Anderson wrote:
> When I got my clock parenting slightly wrong I ended up with a crash
> that looked like this:
> 
>   Unable to handle kernel NULL pointer dereference at virtual
>   address 0000000000000000
>   ...
>   pc : clk_hw_get_rate+0x14/0x44
>   ...
>   Call trace:
>    clk_hw_get_rate+0x14/0x44
>    _freq_tbl_determine_rate+0x94/0xfc
>    clk_rcg2_determine_rate+0x2c/0x38
>    clk_core_determine_round_nolock+0x4c/0x88
>    clk_core_round_rate_nolock+0x6c/0xa8
>    clk_core_round_rate_nolock+0x9c/0xa8
>    clk_core_set_rate_nolock+0x70/0x180
>    clk_set_rate+0x3c/0x6c
>    of_clk_set_defaults+0x254/0x360
>    platform_drv_probe+0x28/0xb0
>    really_probe+0x120/0x2dc
>    driver_probe_device+0x64/0xfc
>    device_driver_attach+0x4c/0x6c
>    __driver_attach+0xac/0xc0
>    bus_for_each_dev+0x84/0xcc
>    driver_attach+0x2c/0x38
>    bus_add_driver+0xfc/0x1d0
>    driver_register+0x64/0xf8
>    __platform_driver_register+0x4c/0x58
>    msm_drm_register+0x5c/0x60
>    ...
> 
> It turned out that clk_hw_get_parent_by_index() was returning NULL and
> we weren't checking.  Let's check it so that we don't crash.
> 
> Fixes: ac269395cdd8 ("clk: qcom: Convert to clk_hw based provider APIs")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> I haven't gone back and tried to reproduce this same crash on older
> kernels, but I'll put the blame on commit ac269395cdd8 ("clk: qcom:
> Convert to clk_hw based provider APIs").  Before that if we got a NULL
> parent back it was fine and dandy since a NULL "struct clk" is valid
> to use but a NULL "struct clk_hw" is not.
> 
> Changes in v2:
> - Patch ("clk: qcom: rcg2: Don't crash...") new for v2.
> 
>  drivers/clk/qcom/clk-rcg2.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
> index da045b200def..9098001ac805 100644
> --- a/drivers/clk/qcom/clk-rcg2.c
> +++ b/drivers/clk/qcom/clk-rcg2.c
> @@ -218,6 +218,9 @@ static int _freq_tbl_determine_rate(struct clk_hw *hw, const struct freq_tbl *f,
>  
>  	clk_flags = clk_hw_get_flags(hw);
>  	p = clk_hw_get_parent_by_index(hw, index);
> +	if (!p)
> +		return -EINVAL;
> +
>  	if (clk_flags & CLK_SET_RATE_PARENT) {
>  		rate = f->freq;
>  		if (f->pre_div) {

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
