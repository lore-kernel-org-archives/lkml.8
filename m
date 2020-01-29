Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D81C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 20:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E4320702
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 20:31:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iRu2wYYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgA2UbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 15:31:19 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39333 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgA2UbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 15:31:19 -0500
Received: by mail-pj1-f65.google.com with SMTP id e9so310992pjr.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 12:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=twsM+yroWqwEy5YDl4BwCUXNaUNw/X2g2lDDxs0RGBo=;
        b=iRu2wYYSeljrB5HIM7LJymxUTy2vq4UG/nbxVTsG+319wy6rA8ZdqP/P6DfqqSIam5
         ihG/SfhKvPvETULCRbTKnRQkLMp3A496MzuE+uC+pgKyGDO7iiftEC4cfT2NpolyA6pK
         7TdFmuY6NNDzaTQlVDm8lOMCYu2AFw9Z3m5BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=twsM+yroWqwEy5YDl4BwCUXNaUNw/X2g2lDDxs0RGBo=;
        b=BzPxG+YNHzvjBt7BJ4/JPRVxotGel6bCMxKuWCs48ZaXlfHv6abovdD4QSQz8Bfp6e
         MN52Wlfe6q1k03APUKPziS0FYWFjVrh0OwRlhcfZvX+do2uAEaQOGrrdoAr2nx8u6KuO
         /RbAyluv9KHKhH5T4Rtux00LjX3AXM2IjAS4MZvHz8GEBVRQDS76kX2R0rVTPk+9isX7
         tbSCag/p34Up7SrmP/jIyTZaHidm9c+zBmkSXGmLn6oLuKXjD/0ZFUBaeZ7IZJgla6W9
         /OUFYAUri6zKK1P8yn3Gx/4mvC/HMvD39O7tiQ+4E/Dpu8j4iYmPfolqPiYEDT5+rtZw
         Vatg==
X-Gm-Message-State: APjAAAVRiPzShoxcjANDQ5IBH3OrBpN0uVndFbdpZIZNQlhUgUrq7gkU
        VtzVvFdMzFTrUvKbbbJjzI5o+Q==
X-Google-Smtp-Source: APXvYqxLlF5bIBa3UsXRcl3rKxQPx7bBEA9J/JLzVNFNQnlAu8EbwrNwSb8G6pGmgYMcYMWWGz+aJQ==
X-Received: by 2002:a17:90a:2004:: with SMTP id n4mr1680868pjc.20.1580329878812;
        Wed, 29 Jan 2020 12:31:18 -0800 (PST)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id 2sm3529519pgo.79.2020.01.29.12.31.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 12:31:18 -0800 (PST)
Date:   Wed, 29 Jan 2020 12:31:16 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Sandeep Maheswaram <sanm@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/8] phy: qcom-qusb2: Add generic QUSB2 V2 PHY support
Message-ID: <20200129203116.GD71044@google.com>
References: <1580305919-30946-1-git-send-email-sanm@codeaurora.org>
 <1580305919-30946-4-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1580305919-30946-4-git-send-email-sanm@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 07:21:54PM +0530, Sandeep Maheswaram wrote:
> Add generic QUSB2 V2 PHY table so the respective phys
> can use the same table.
> 
> Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qusb2.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> index bf94a52..70c9da6 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (c) 2017, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2017, 2019, The Linux Foundation. All rights reserved.
>   */
>  
>  #include <linux/clk.h>
> @@ -177,7 +177,7 @@ static const struct qusb2_phy_init_tbl msm8998_init_tbl[] = {
>  	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_DIGITAL_TIMERS_TWO, 0x19),
>  };
>  
> -static const unsigned int sdm845_regs_layout[] = {
> +static const unsigned int qusb2_v2_regs_layout[] = {
>  	[QUSB2PHY_PLL_CORE_INPUT_OVERRIDE] = 0xa8,
>  	[QUSB2PHY_PLL_STATUS]		= 0x1a0,
>  	[QUSB2PHY_PORT_TUNE1]		= 0x240,
> @@ -191,7 +191,7 @@ static const unsigned int sdm845_regs_layout[] = {
>  	[QUSB2PHY_INTR_CTRL]		= 0x230,
>  };
>  
> -static const struct qusb2_phy_init_tbl sdm845_init_tbl[] = {
> +static const struct qusb2_phy_init_tbl qusb2_v2_init_tbl[] = {
>  	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_ANALOG_CONTROLS_TWO, 0x03),
>  	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CLOCK_INVERTERS, 0x7c),
>  	QUSB2_PHY_INIT_CFG(QUSB2PHY_PLL_CMODE, 0x80),
> @@ -258,10 +258,10 @@ static const struct qusb2_phy_cfg msm8998_phy_cfg = {
>  	.update_tune1_with_efuse = true,
>  };
>  
> -static const struct qusb2_phy_cfg sdm845_phy_cfg = {
> -	.tbl		= sdm845_init_tbl,
> -	.tbl_num	= ARRAY_SIZE(sdm845_init_tbl),
> -	.regs		= sdm845_regs_layout,
> +static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {
> +	.tbl		= qusb2_v2_init_tbl,
> +	.tbl_num	= ARRAY_SIZE(qusb2_v2_init_tbl),
> +	.regs		= qusb2_v2_regs_layout,
>  
>  	.disable_ctrl	= (PWR_CTRL1_VREF_SUPPLY_TRIM | PWR_CTRL1_CLAMP_N_EN |
>  			   POWER_DOWN),
> @@ -774,8 +774,8 @@ static const struct of_device_id qusb2_phy_of_match_table[] = {
>  		.compatible	= "qcom,msm8998-qusb2-phy",
>  		.data		= &msm8998_phy_cfg,
>  	}, {
> -		.compatible	= "qcom,sdm845-qusb2-phy",
> -		.data		= &sdm845_phy_cfg,
> +		.compatible	= "qcom,qusb2-v2-phy",
> +		.data		= &qusb2_v2_phy_cfg,
>  	},
>  	{ },
>  };

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
