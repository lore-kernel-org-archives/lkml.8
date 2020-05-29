Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3DCC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F734204EA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:29:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDpAVMHj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436620AbgE2C35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 22:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406807AbgE2C3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:29:55 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFF8C08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 19:29:54 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z26so445898pfk.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 19:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3l/uy9rkSgcqOcPxEDKlHX2a7wRD2FJSR8LJkg5Mydk=;
        b=PDpAVMHjMU8db05ww6y3TqOibPw36FTVxG+D7IDJUwbM1cQCQXH7DmukxiTiLAOMne
         XDEnWH4pU5A2U0tBJSbRNF8XGvgU4EX3zrSzgjE35h7Z1Lz/FioBStsmSfmf0HFIifXC
         hO4cctO+/7ye+4E9wOy7DiPLuPSct4qM9RT74aK8vz+/rsR7Yx65qWT/hN7NJSkW6WFw
         j00nHXD9zgWFtVnD0PrpN1fPnSuLkNAF5nJsD7IRvBpCyemRAgNY0oOR2inpmTaztsHq
         hLsznz5dVev3nGHMHgj8hPXVGTaOkh3O7kw4uSowLYmqtcrxJDtROsLmSxuqCgu4sODz
         eR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3l/uy9rkSgcqOcPxEDKlHX2a7wRD2FJSR8LJkg5Mydk=;
        b=qtBJviW3n1DmrSoPO8++1TNgEebxUn6tNv6DyMMCh4m7qyPgM7+MQ1YRROeUculiBW
         dj3pVl36t1lS9ztef9rr3HBcLMxBRgjgB4D8anmCFnycw4dNANz1jkZJQ0xVJWjajI/7
         t3+J0P+DJLoUqOlKQWciwgsvkt7ZVPrPNRtMTPMWfITMC2PTfcsPUQ3O2LnDhg4kJamX
         HfgKi23M9JFIJCQKRp6LA4c5cDEFhXN7QrAzcJXO2zf8nAeQ1Yvxy/49ZUiFrU4v8fTb
         9dJUo2NyEHV5JV9u1p15nTJUR0B8D9orZ5117mC2HkJnY0cOs4dAAIgixu9Z7PFRMwgY
         WZIg==
X-Gm-Message-State: AOAM532lw06fwrcZcxzT6GeW3xxe0KBoBYLf3PP0F/DgJRHe2onp7XL2
        rboamJ7gePInGr99IdbV27tiaQ==
X-Google-Smtp-Source: ABdhPJxhTrem+6swxocNd1/XW0+hUviSs6g6emgO+YsgjaI4iM4SJVt84no+lZF35PTPOpy7jDNRFw==
X-Received: by 2002:a65:52cd:: with SMTP id z13mr5961753pgp.259.1590719393398;
        Thu, 28 May 2020 19:29:53 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id v9sm5541381pgj.54.2020.05.28.19.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 19:29:52 -0700 (PDT)
Date:   Thu, 28 May 2020 19:28:47 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Sumit Semwal <sumit.semwal@linaro.org>
Cc:     agross@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, nishakumari@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org,
        rnayak@codeaurora.org
Subject: Re: [PATCH v3 5/5] regulator: qcom: labibb: Add SC interrupt handling
Message-ID: <20200529022847.GO279327@builder.lan>
References: <20200528154625.17742-1-sumit.semwal@linaro.org>
 <20200528154625.17742-6-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528154625.17742-6-sumit.semwal@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 28 May 08:46 PDT 2020, Sumit Semwal wrote:

> From: Nisha Kumari <nishakumari@codeaurora.org>
> 
> Add Short circuit interrupt handling and recovery for the lab and
> ibb regulators on qcom platforms.
> 
> The client panel drivers need to register for REGULATOR_EVENT_OVER_CURRENT
> notification which will be triggered on short circuit. They should
> try to enable the regulator once, and if it doesn't get enabled,
> handle shutting down the panel accordingly.
> 
> Signed-off-by: Nisha Kumari <nishakumari@codeaurora.org>

It would be nice to see a short summary of your changes from the
original patch here, like:

[sumit: Changed this and that]

> Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>
> 
> --
> v2: sumits: reworked handling to user regmap_read_poll_timeout, and handle it
>      per-regulator instead of clearing both lab and ibb errors on either irq
>      triggering. Also added REGULATOR_EVENT_OVER_CURRENT handling and
>      notification to clients.
> v3: sumits: updated as per review comments of v2: removed spurious check for
>      irq in handler and some unused variables; inlined some of the code,
>      omitted IRQF_TRIGGER_RISING as it's coming from DT.
> 
> ---
>  drivers/regulator/qcom-labibb-regulator.c | 92 +++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
> 
> diff --git a/drivers/regulator/qcom-labibb-regulator.c b/drivers/regulator/qcom-labibb-regulator.c
> index 634d08461c6e..695ffac71e81 100644
> --- a/drivers/regulator/qcom-labibb-regulator.c
> +++ b/drivers/regulator/qcom-labibb-regulator.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  // Copyright (c) 2020, The Linux Foundation. All rights reserved.
>  
> +#include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/of_irq.h>
>  #include <linux/of.h>
> @@ -18,6 +19,7 @@
>  #define REG_LABIBB_ENABLE_CTL		0x46
>  #define LABIBB_STATUS1_VREG_OK_BIT	BIT(7)
>  #define LABIBB_CONTROL_ENABLE		BIT(7)
> +#define LABIBB_STATUS1_SC_DETECT_BIT	BIT(6)
>  
>  #define LAB_ENABLE_CTL_MASK		BIT(7)
>  #define IBB_ENABLE_CTL_MASK		(BIT(7) | BIT(6))
> @@ -27,12 +29,17 @@
>  #define IBB_POLL_ENABLED_TIME		(LABIBB_ENABLE_TIME * 10)
>  #define LABIBB_OFF_ON_DELAY		(8200)
>  
> +#define POLLING_SCP_DONE_INTERVAL_US	5000
> +#define POLLING_SCP_TIMEOUT		16000
> +
>  struct labibb_regulator {
>  	struct regulator_desc		desc;
>  	struct device			*dev;
>  	struct regmap			*regmap;
>  	struct regulator_dev		*rdev;
>  	u16				base;
> +	int				sc_irq;

This is now a local variable in register_labibb_regulator().

> +	int				vreg_enabled;

bool is a better representation of this (and the vreg_ prefix doesn't
really add value).

>  	u8				type;
>  };
>  
> @@ -65,6 +72,8 @@ static int qcom_labibb_regulator_enable(struct regulator_dev *rdev)
>  	if (ret < 0)
>  		dev_err(reg->dev, "Write failed: enable %s regulator\n",
>  			reg->desc.name);
> +	else
> +		reg->vreg_enabled = 1;

No I see why you add these wrappers around the regmap in the previous
patch.

My request to not print an error message on enable/disable errors
remains.

>  
>  	return ret;
>  }
> @@ -78,6 +87,8 @@ static int qcom_labibb_regulator_disable(struct regulator_dev *rdev)
>  	if (ret < 0)
>  		dev_err(reg->dev, "Disable failed: disable %s\n",
>  			reg->desc.name);
> +	else
> +		reg->vreg_enabled = 0;
>  
>  	return ret;
>  }
> @@ -88,11 +99,70 @@ static struct regulator_ops qcom_labibb_ops = {
>  	.is_enabled		= qcom_labibb_regulator_is_enabled,
>  };
>  
> +static irqreturn_t labibb_sc_err_handler(int irq, void *_reg)
> +{
> +	int ret;
> +	u16 reg;
> +	unsigned int val;
> +	struct labibb_regulator *labibb_reg = _reg;
> +	bool in_sc_err, scp_done = false;
> +
> +	ret = regmap_read(labibb_reg->regmap,
> +			  labibb_reg->base + REG_LABIBB_STATUS1, &val);
> +	if (ret < 0) {
> +		dev_err(labibb_reg->dev, "sc_err_irq: Read failed, ret=%d\n",
> +			ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	dev_dbg(labibb_reg->dev, "%s SC error triggered! STATUS1 = %d\n",
> +		labibb_reg->desc.name, val);
> +
> +	in_sc_err = !!(val & LABIBB_STATUS1_SC_DETECT_BIT);
> +
> +	/*
> +	 * The SC(short circuit) fault would trigger PBS(Portable Batch
> +	 * System) to disable regulators for protection. This would
> +	 * cause the SC_DETECT status being cleared so that it's not
> +	 * able to get the SC fault status.
> +	 * Check if the regulator is enabled in the driver but
> +	 * disabled in hardware, this means a SC fault had happened
> +	 * and SCP handling is completed by PBS.
> +	 */
> +	if (!in_sc_err) {
> +

Empty line

Regards,
Bjorn

> +		reg = labibb_reg->base + REG_LABIBB_ENABLE_CTL;
> +
> +		ret = regmap_read_poll_timeout(labibb_reg->regmap,
> +					reg, val,
> +					!(val & LABIBB_CONTROL_ENABLE),
> +					POLLING_SCP_DONE_INTERVAL_US,
> +					POLLING_SCP_TIMEOUT);
> +
> +		if (!ret && labibb_reg->vreg_enabled) {
> +			dev_dbg(labibb_reg->dev,
> +				"%s has been disabled by SCP\n",
> +				labibb_reg->desc.name);
> +			scp_done = true;
> +		}
> +	}
> +
> +	if (in_sc_err || scp_done) {
> +		regulator_lock(labibb_reg->rdev);
> +		regulator_notifier_call_chain(labibb_reg->rdev,
> +						REGULATOR_EVENT_OVER_CURRENT,
> +						NULL);
> +		regulator_unlock(labibb_reg->rdev);
> +	}
> +	return IRQ_HANDLED;
> +}
> +
>  static int register_labibb_regulator(struct labibb_regulator *reg,
>  				const struct labibb_regulator_data *reg_data,
>  				struct device_node *of_node)
>  {
>  	struct regulator_config cfg = {};
> +	int ret;
>  
>  	reg->base = reg_data->base;
>  	reg->type = reg_data->type;
> @@ -108,6 +178,28 @@ static int register_labibb_regulator(struct labibb_regulator *reg,
>  	reg->desc.poll_enabled_time = reg_data->poll_enabled_time;
>  	reg->desc.off_on_delay = LABIBB_OFF_ON_DELAY;
>  
> +	reg->sc_irq = -EINVAL;
> +	ret = of_irq_get_byname(of_node, "sc-err");
> +	if (ret < 0) {
> +		dev_err(reg->dev, "Unable to get sc-err, ret = %d\n",
> +			ret);
> +		return ret;
> +	} else
> +		reg->sc_irq = ret;
> +
> +	if (reg->sc_irq > 0) {
> +		ret = devm_request_threaded_irq(reg->dev,
> +						reg->sc_irq,
> +						NULL, labibb_sc_err_handler,
> +						IRQF_ONESHOT,
> +						"sc-err", reg);
> +		if (ret) {
> +			dev_err(reg->dev, "Failed to register sc-err irq ret=%d\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
>  	cfg.dev = reg->dev;
>  	cfg.driver_data = reg;
>  	cfg.regmap = reg->regmap;
> -- 
> 2.26.2
> 
