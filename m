Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2980C2D0E9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 00:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C81520714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 00:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BaPu37FN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbgCZAs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 20:48:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35922 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbgCZAs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 20:48:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id g2so1495488plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 17:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZxzmZfPQ1xcC/8WFAa5OQo5qBlQ7cBwjnS72WYBmhnM=;
        b=BaPu37FN/CsRiMEyYm+HmvCnIO8JDg5UEBcKiVnvhIRayz4l+DZ6c/rOFuGixsI5HJ
         8fp359TgrVh+iMC8jKBDpIqdsWb2aGsb4iEGmDMvGtdS69HT47g6S+e/owlZ+tSjAYXD
         56OeO3FBLPHnHriiGYcrSYnkeA3hJ8DFG5vcX4ij4fa73nKUZiFOGDd4/KWwDPCCN9nY
         2EuSs91uRxCixGPZUo2fKE+Ny31dQi7T5260bKFwPflt9L4i3r/ZhUmkCouEBivHpPhE
         ititO+ThCogxJzxi4HqALVxxsrRZMUx8Obvswcsjkl/Ovlfz/0y6fccNseM+u+YzK14y
         OO6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZxzmZfPQ1xcC/8WFAa5OQo5qBlQ7cBwjnS72WYBmhnM=;
        b=p2sYNgsu4MdokmNEG2MJwlWJFdD7zp979sR+8O75LXM6p7SnXDeVRu6n0CL0OLDZ01
         RhP1pwQQsQtOf5ije7StkuzkWSw3u90v44VPQGJb05xzsRq6zU6sb8qxJkCM3KrJJ/YS
         lpRB1MgZk6u9PHcBls3SKXS5UQSvdH7z+3XfdUis0kQV9uK6iJe0l43D6FFGshSdwMPQ
         tuea8f0p2ab/Mz7tcfEVy6fluVPE+mas6velAxuwtjsV4f7O1yKpKFvoSBzfusaIgAjG
         P96hazpp9V52+0vsyk8xc/hW8/7v+xX9zeVoo7uIEuf/d32m5ZcrWH0L6KhyyKbwN4id
         sd6A==
X-Gm-Message-State: ANhLgQ3cA5EGPegHlIAM4S5KGqFaFrxLL/EeY2MRBOU5n+3bEfur/2IO
        JwYBureZzYJLk3wBrWBHhcdShA==
X-Google-Smtp-Source: ADFU+vtw3sinPXugyhL8FDCWdq3ewIqgQgO1/OskBNO4Ad9/Uea+Sz3NiutRtgjrIwX+CfwM4abhRA==
X-Received: by 2002:a17:902:b592:: with SMTP id a18mr2419130pls.98.1585183736437;
        Wed, 25 Mar 2020 17:48:56 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id z15sm273726pfg.152.2020.03.25.17.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 17:48:55 -0700 (PDT)
Date:   Wed, 25 Mar 2020 17:48:53 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     agross@kernel.org, Ajay Kishore <akisho@codeaurora.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: qcom: use scm_call to route GPIO irq to Apps
Message-ID: <20200326004853.GH119913@minitux>
References: <20200313191513.11365-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313191513.11365-1-ansuelsmth@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 13 Mar 12:15 PDT 2020, Ansuel Smith wrote:

> For IPQ806x targets, TZ protects the registers that are used to
> configure the routing of interrupts to a target processor.
> To resolve this, this patch uses scm call to route GPIO interrupts
> to application processor. Also the scm call interface is changed.
> 

Oh no...but this does look pretty reasonable after all, some comments
and suggestions below.

> Signed-off-by: Ajay Kishore <akisho@codeaurora.org>

With this --author should be Ajay.

> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 36 ++++++++++++++++++++++++++----
>  1 file changed, 32 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 9a8daa256a32..a83cfd1da219 100644
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
> @@ -710,6 +712,9 @@ static void msm_gpio_irq_mask(struct irq_data *d)
>  	const struct msm_pingroup *g;
>  	unsigned long flags;
>  	u32 val;
> +	u32 addr;
> +	int ret;
> +	const __be32 *reg;
>  
>  	if (d->parent_data)
>  		irq_chip_mask_parent(d);
> @@ -863,6 +868,7 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>  	const struct msm_pingroup *g;
>  	unsigned long flags;
>  	u32 val;
> +	int ret;
>  
>  	if (d->parent_data)
>  		irq_chip_set_type_parent(d, type);
> @@ -882,11 +888,33 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>  	else
>  		clear_bit(d->hwirq, pctrl->dual_edge_irqs);
>  
> +	ret = of_device_is_compatible(pctrl->dev->of_node,
> +					"qcom,ipq8064-pinctrl");

This won't change in runtime, so I would like for you to query this
during probe and then carry the result in msm_pinctrl.

>  	/* Route interrupts to application cpu */
> -	val = msm_readl_intr_target(pctrl, g);
> -	val &= ~(7 << g->intr_target_bit);
> -	val |= g->intr_target_kpss_val << g->intr_target_bit;
> -	msm_writel_intr_target(val, pctrl, g);
> +	if (!ret) {
> +		val = msm_readl_intr_target(pctrl, g);
> +		val &= ~(7 << g->intr_target_bit);
> +		val |= g->intr_target_kpss_val << g->intr_target_bit;
> +		msm_writel_intr_target(val, pctrl, g);
> +	} else {
> +		const __be32 *reg = of_get_property(pctrl->dev->of_node,
> +						    "reg", NULL);

This too will be static, and we already resolve this, properly, with
address translation etc during probe.

So if you do a partial rollback of '4b024225c4a8 ("pinctrl: use
devm_platform_ioremap_resource() to simplify code")' you can stash the
base address of the resource in msm_pinctrl, and then make your change
conditional on this being NULL or not.

> +
> +		if (reg) {
> +			u32 addr = be32_to_cpup(reg) + g->intr_target_reg;
> +
> +			qcom_scm_io_readl(addr, &val);
> +			__iormb();

Why do you need this and below barriers?

> +
> +			val &= ~(7 << g->intr_target_bit);
> +			val |= g->intr_target_kpss_val << g->intr_target_bit;
> +
> +			__iowmb();
> +			ret = qcom_scm_io_writel(addr, val);
> +			if (ret)
> +				pr_err("\n Routing interrupts to Apps proc failed");

You have msm_pinctrl->dev, so use dev_err(). And the \n goes at the end
in Linux - and perhaps make it include d->hwirq to make it a little bit
informative?

Regards,
Bjorn

> +		}
> +	}
>  
>  	/* Update configuration for gpio.
>  	 * RAW_STATUS_EN is left on for all gpio irqs. Due to the
> -- 
> 2.25.0
> 
