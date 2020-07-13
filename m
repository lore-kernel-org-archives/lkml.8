Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2EAC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEEAD2068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594618392;
	bh=xHhlhOG2O5smTAneN0ZnuiRbm7rrhPP60vF/0+KOSM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=In7g5X6tlj0ZdGjaL7CW15epO5F+B1J+oTAfZOKBb3MON4U9ASMIadnXsZxyN4y++
	 ybhjvLiN3T6KeFopC03Cr8kdx3+nUTRjCP+t1Q302d0TQt++zUawRdIDYDKz32pu1h
	 AWGGg1SyKi8ZEqkKPZFgylYgSpgBCp1UZIY/5E7s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgGMFdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:33:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:59390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgGMFdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 01:33:01 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC5402068F;
        Mon, 13 Jul 2020 05:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594618380;
        bh=xHhlhOG2O5smTAneN0ZnuiRbm7rrhPP60vF/0+KOSM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SDy5y0Xs12hnjkGWFqhjDKbEIXVc0CnyWy7cI5B9idC9gkLt1ktAu0W7oQJ7e4lwY
         MC/rNJ+kVDnhp2yca4crjhjsgxbqRDpeZdamgs2IX9jbiAU9BChpzBrEp69QcInYHg
         tyaay/MDgtmEWuDRUSVStCAy25Etw+IG0ywLx6lA=
Date:   Mon, 13 Jul 2020 11:02:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@codeaurora.org>,
        Jonathan McDowell <noodles@earth.li>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [RESEND PATCH v7 1/2] phy: qualcomm: add qcom ipq806x dwc usb
 phy driver
Message-ID: <20200713053255.GY34333@vkoul-mobl>
References: <20200615205333.20747-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615205333.20747-1-ansuelsmth@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-06-20, 22:53, Ansuel Smith wrote:

> @@ -0,0 +1,593 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (c) 2014-2015, Code Aurora Forum. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

You have SPDX tag, so we dont need the license text, please remove this.
Also we are in 2020 now so Copyright looks incorrect

> +static int qcom_ipq806x_usb_ss_phy_init(struct phy *phy)
> +{
> +	struct usb_phy *phy_dwc3 = phy_get_drvdata(phy);
> +	int ret;
> +	u32 data = 0;

Superfluous init

> +static int qcom_ipq806x_usb_phy_probe(struct platform_device *pdev)
> +{
> +	struct usb_phy	*phy_dwc3;
> +	struct phy_provider		*phy_provider;
> +	struct phy			*generic_phy;
> +	const struct of_device_id *match;
> +	const struct phy_drvdata *data;
> +	struct resource			*res;
> +	resource_size_t			size;

Pls pick one, tabs or single spaces, not both. and reverse christmas
looks better :)

> +	struct device_node *np;
> +
> +	phy_dwc3 = devm_kzalloc(&pdev->dev, sizeof(*phy_dwc3), GFP_KERNEL);
> +	if (!phy_dwc3)
> +		return -ENOMEM;
> +
> +	match = of_match_node(qcom_ipq806x_usb_phy_table, pdev->dev.of_node);
> +	data = match->data;

How about using of_device_get_match_data() instead?
-- 
~Vinod
