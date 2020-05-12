Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A877C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 101E623126
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 22:24:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kNEV5mI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731961AbgELWYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 18:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731594AbgELWY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 18:24:27 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC63FC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:24:27 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id v63so7064593pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 15:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NG6we4EVElAPQUK0aN618c7gFt1x3MHwQbr2/Svw2vI=;
        b=kNEV5mI0LwUaQw+DbWntL8ZgPqqlUBdufqDPVeVaEhZANnwVoh0chDp/Uo97YcBtRh
         223QYDNVBusXaAIEKFWART+4E5rHM+7cdyocVpyOKLwXxztGya4gLbJPe6p08mf7yhxd
         zcFUWbivJqKcQBSbJJo4RRYbSd76fM4r6z1VlOXHn26I9l6HOnZ/ytcP0I+hXggiTJqj
         N4kH5qY5YythLgLQ5fPBn+6mdRncEaP6pFehPaISXvUd7oGYr/mUISfpaFk49C+TMhE4
         R2KO92/B2yrY288FYdxfaXUa7nb8emvCf+jRHFDz1wIwe4zFUlmsX7N39kUjuoHrnxmo
         aRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NG6we4EVElAPQUK0aN618c7gFt1x3MHwQbr2/Svw2vI=;
        b=p7LcexU/E1aFiRoZ2H/9dBBIsupv9obVATEnDxPA81r199LYmbFwqfzE1AKhsA6zvU
         nTNkQ33IhffS8pVVvL4MYBwAgMh565VnZ29YHfsLmjkBwl2VmZqvvhEe5F3wm8RHl8Dv
         OaGOR5An0bBCp37Lknge9yduOHVaTzlpezqGYPI8+ssq3XlAWj5mLnfJA07jlgnBh6hA
         4DcLKcS6spY2t8FJbIEvMHzGF4Fn6Q2bgcC6DYEoKSH7FXbEfsO2nOGwVx+/uuISrEQ2
         JeCPdbQf1r5WNuT7qlJROGFCxYJMl59QeskoaDped2Z2IRgwvvvTdfq1vNlmWBglhVQW
         dh1Q==
X-Gm-Message-State: AGi0PuY7oMy9yaSmZSFMdOGebSmSlAfRag/U2hPfY1xs8zBCRSkOGzqJ
        wE8F5SQAwOcFpbRPjIZZhu7gJA==
X-Google-Smtp-Source: APiQypL5T85pumwim3gF1owmE1/fjwAzTQXH9mCqeOjfPWv4HgPerDsfZK4XURMNbgXNQJIG9mHhSA==
X-Received: by 2002:aa7:9690:: with SMTP id f16mr24507424pfk.20.1589322267141;
        Tue, 12 May 2020 15:24:27 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k4sm10971599pgg.88.2020.05.12.15.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 15:24:26 -0700 (PDT)
Date:   Tue, 12 May 2020 15:22:53 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     andy.gross@linaro.org, linus.walleij@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, dianders@chromium.org,
        swboyd@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org,
        Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
Subject: Re: [PATCH] pinctrl: qcom: Add affinity callbacks to msmgpio IRQ chip
Message-ID: <20200512222253.GP2165@builder.lan>
References: <1588314617-4556-1-git-send-email-mkshah@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588314617-4556-1-git-send-email-mkshah@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30 Apr 23:30 PDT 2020, Maulik Shah wrote:

> From: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> 
> Wakeup capable GPIO IRQs routed via PDC are not being migrated when a CPU
> is hotplugged. Add affinity callbacks to msmgpio IRQ chip to update the
> affinity of wakeup capable IRQs.
> 
> Fixes: e35a6ae0eb3a ("pinctrl/msm: Setup GPIO chip in hierarchy")
> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> [mkshah: updated commit text and minor code fixes]
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 29259fe..83b7d64 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -1033,6 +1033,29 @@ static void msm_gpio_irq_relres(struct irq_data *d)
>  	module_put(gc->owner);
>  }
>  
> +static int msm_gpio_irq_set_affinity(struct irq_data *d,
> +				const struct cpumask *dest, bool force)
> +{
> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
> +
> +	if (d->parent_data && test_bit(d->hwirq, pctrl->skip_wake_irqs))
> +		return irq_chip_set_affinity_parent(d, dest, force);
> +
> +	return 0;
> +}
> +
> +static int msm_gpio_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
> +{
> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +	struct msm_pinctrl *pctrl = gpiochip_get_data(gc);
> +
> +	if (d->parent_data && test_bit(d->hwirq, pctrl->skip_wake_irqs))
> +		return irq_chip_set_vcpu_affinity_parent(d, vcpu_info);
> +
> +	return 0;
> +}
> +
>  static void msm_gpio_irq_handler(struct irq_desc *desc)
>  {
>  	struct gpio_chip *gc = irq_desc_get_handler_data(desc);
> @@ -1131,6 +1154,8 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>  	pctrl->irq_chip.irq_set_wake = msm_gpio_irq_set_wake;
>  	pctrl->irq_chip.irq_request_resources = msm_gpio_irq_reqres;
>  	pctrl->irq_chip.irq_release_resources = msm_gpio_irq_relres;
> +	pctrl->irq_chip.irq_set_affinity = msm_gpio_irq_set_affinity;
> +	pctrl->irq_chip.irq_set_vcpu_affinity = msm_gpio_irq_set_vcpu_affinity;
>  
>  	np = of_parse_phandle(pctrl->dev->of_node, "wakeup-parent", 0);
>  	if (np) {
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
