Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E5AC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BAF220714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 20:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Otp+UNWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgC0UNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 16:13:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38504 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727143AbgC0UNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 16:13:44 -0400
Received: by mail-pl1-f195.google.com with SMTP id w3so3849890plz.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 13:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XhU5dkf+ZTFzNb1QmGiIQhhaLxi5TPXALzliiK+B0q0=;
        b=Otp+UNWzkaVwwdZoA1fgdsRme1cx8OpYNhYDlU21TmcGwHuvzzcC2tY9yB2w2uRfFh
         rblQDwHYDCPZ/xmIgjQgb9rOn81PEakAHbp8Q77oglA8Q9a1o6zECVjF7UlXAnaFIJOJ
         311vkXB2D8cOaKcbzujmZ4uJ3wohLDz+HdVRIBLrNiXdmTM4RQl2WIIv68NFlA2Igr78
         IIQznvGo6/UdgEJQpeXoNQZ4SqieTxtDlIurHG+RwQzv1UTGhxuVUIIH1zYzl/ZXvJ9r
         dKK+wfhlak0GdloYXGTY9/Mks62Z/NUdIiI6wiKMj9gaPECfbLVkCE4ZkdexD4NklPkW
         VwEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XhU5dkf+ZTFzNb1QmGiIQhhaLxi5TPXALzliiK+B0q0=;
        b=bIqr2MCZH76B9NkylsCvevVv1hmS8CMhCwoY87c6i+pFe3Lh2cRDLnrAh5kgxFf8qZ
         1FT/eWc9inBNoIe1LhjgXuyupGj64dHeKi9NBuCAQsLkgoPgFNDOeYw5KPRqH9B2eyHl
         IX7FQTvegipKfP208GPie/fypaMn6ecdRqs8EaeQ221yzJ5pEsrtVEl7F1zoXvjeq4yf
         zA0D2vTXYt5/QZQUqZgQxNHiZfybyeMUbGTVGSUrma/gKMppMLZjaycl/l9rqi4Zkmih
         l+G9i+x5QNQ+W0eOhWa2UvAwOrZ1tjbHYKToTCfL2aQgxbmf2wPbNax1A1Y3LjS/UbNq
         kSjA==
X-Gm-Message-State: ANhLgQ24wwCSXMm5XijYzob+5gcJpCwofHj7ZyaqHVF+AkVfT4PwQDVz
        96Y1JBEXnTfD8ELxOPjSRYAawg==
X-Google-Smtp-Source: ADFU+vtypJ3T1KKc0IaK5UlJDGPSaHU9nsH0EP7C8OyXPdFKXrJ8TrYtnkEJ0sexOpHJ6nM7vP5+XQ==
X-Received: by 2002:a17:90a:35ce:: with SMTP id r72mr1221770pjb.126.1585340023041;
        Fri, 27 Mar 2020 13:13:43 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id t4sm4786614pfb.156.2020.03.27.13.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 13:13:42 -0700 (PDT)
Date:   Fri, 27 Mar 2020 13:13:40 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Ajay Kishore <akisho@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pinctrl: qcom: use scm_call to route GPIO irq to Apps
Message-ID: <20200327201340.GA211617@minitux>
References: <20200326173524.15236-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326173524.15236-1-ansuelsmth@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 26 Mar 10:35 PDT 2020, Ansuel Smith wrote:

> From: Ajay Kishore <akisho@codeaurora.org>
> 
> For IPQ806x targets, TZ protects the registers that are used to
> configure the routing of interrupts to a target processor.
> To resolve this, this patch uses scm call to route GPIO interrupts
> to application processor. Also the scm call interface is changed.
> 
> Signed-off-by: Ajay Kishore <akisho@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>

Thanks for respinning this Ansuel, just some minor things below.

> ---
> v2:
> * Move static varibale in msm_pinctrl struct
> * Revert '4b024225c4a8 ("pinctrl: use devm_platform_ioremap_resource() to simplify code")'
>   to get base_reg addr
> 
>  drivers/pinctrl/qcom/pinctrl-msm.c | 37 ++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 9a8daa256a32..9627ebd41ff9 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -22,6 +22,8 @@
>  #include <linux/reboot.h>
>  #include <linux/pm.h>
>  #include <linux/log2.h>
> +#include <linux/qcom_scm.h>
> +#include <linux/io.h>
>  
>  #include <linux/soc/qcom/irq.h>
>  
> @@ -60,6 +62,9 @@ struct msm_pinctrl {
>  	struct irq_chip irq_chip;
>  	int irq;
>  
> +	int route_to_apps;

We "always" route our interrupts to apps, so please rename this to
intr_target_use_scm. And using "bool" instead would make it clear that
this is a binary flag.

> +	u32 base_reg;

Even though I think it's fine that you only fill in the first entry,
please make this phys_base[MAX_NR_GPIO]; next to regs.

> +
>  	raw_spinlock_t lock;
>  
>  	DECLARE_BITMAP(dual_edge_irqs, MAX_NR_GPIO);
> @@ -883,10 +888,27 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>  		clear_bit(d->hwirq, pctrl->dual_edge_irqs);
>  
>  	/* Route interrupts to application cpu */
> -	val = msm_readl_intr_target(pctrl, g);
> -	val &= ~(7 << g->intr_target_bit);
> -	val |= g->intr_target_kpss_val << g->intr_target_bit;
> -	msm_writel_intr_target(val, pctrl, g);
> +	if (pctrl->route_to_apps && pctrl->base_reg) {

I meant that you could fill out "base_reg" only if it's supposed to be
used, but looking at your patch I think it's nicer to have a separate
flag - so you can omit the check for base_reg != NULL here.

> +		u32 addr = pctrl->base_reg + g->intr_target_reg;
> +		int ret;
> +
> +		qcom_scm_io_readl(addr, &val);
> +
> +		val &= ~(7 << g->intr_target_bit);
> +		val |= g->intr_target_kpss_val << g->intr_target_bit;
> +
> +		ret = qcom_scm_io_writel(addr, val);
> +		if (ret)
> +			dev_err(pctrl->dev,
> +				"Failed routing %lu interrupt to Apps proc",
> +				d->hwirq);
> +		}
> +	} else {
> +		val = msm_readl_intr_target(pctrl, g);
> +		val &= ~(7 << g->intr_target_bit);
> +		val |= g->intr_target_kpss_val << g->intr_target_bit;
> +		msm_writel_intr_target(val, pctrl, g);
> +	}
>  
>  	/* Update configuration for gpio.
>  	 * RAW_STATUS_EN is left on for all gpio irqs. Due to the
> @@ -1241,6 +1263,8 @@ int msm_pinctrl_probe(struct platform_device *pdev,
>  	pctrl->dev = &pdev->dev;
>  	pctrl->soc = soc_data;
>  	pctrl->chip = msm_gpio_template;
> +	pctrl->route_to_apps = of_device_is_compatible(pctrl->dev->of_node,
> +					"qcom,ipq8064-pinctrl");
>  
>  	raw_spin_lock_init(&pctrl->lock);
>  
> @@ -1253,9 +1277,12 @@ int msm_pinctrl_probe(struct platform_device *pdev,
>  				return PTR_ERR(pctrl->regs[i]);
>  		}
>  	} else {
> -		pctrl->regs[0] = devm_platform_ioremap_resource(pdev, 0);
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		pctrl->regs[0] = devm_ioremap_resource(&pdev->dev, res);
>  		if (IS_ERR(pctrl->regs[0]))
>  			return PTR_ERR(pctrl->regs[0]);
> +		else

No need for the else, as the "positive" case is a return.

Thank you,
Bjorn

> +			pctrl->base_reg = res->start;
>  	}
>  
>  	msm_pinctrl_setup_pm_reset(pctrl);
> -- 
> 2.25.1
> 
