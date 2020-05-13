Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82029C2D0F9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6186B23128
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QVrHL5vN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729325AbgEMH6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 03:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbgEMH6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 03:58:20 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA1AC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 00:58:18 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x13so1755975pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 00:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jogA+H3Q6MuCTIAnANEe2TTFuAA4vtSgvVXzDjj5xDY=;
        b=QVrHL5vNgIPaJffcA2KTxVcDRri5H2L4uWqKWXNxONC+eJL7W6snAUI5c9UmIAuO7y
         Hnbi4hmclXUmQqatasQEoVTpYWL1CN9g39BdYJ5FQTcJW8HRPhe0WtK+CjvdJbTL8Fes
         +Ut2X9RW1woOPZ2saaLRW0PKkeMqSld5bO6Dsri/FfwaW6AXqeVthyqg3wAK5H+JyzLH
         8q7UK9WXOn4qAe6GmDwfuQYaXUCw/8G/QPXcOOXJhSGqvUcr30VjJI0W/pqpAhWRe+Hl
         oe5MGO7MC5yy4huRGYF9I8/wWNX4OeGV1FMulrybMiXlzPP8m+5qr6UR+UOLvhkrN4dB
         Ju/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jogA+H3Q6MuCTIAnANEe2TTFuAA4vtSgvVXzDjj5xDY=;
        b=BANgQMaosPBNc1SbnnfGsx2aSGHYCeTT/6tidc7vmjYhjEGHW1p1izzG8LxbLjNEoU
         s3mTDIVl9dmYk/wHpfztUM5Ev5gbjoMpQKHvWw37c/Zg8Wpw6T4YtLCw5gky2FYxJD81
         frlkTszl6yjv7IcJ18V0UUUDBLdsp8DQggKZo4D9GJ8a+D0VjeUmOoD6ktDOY3qv0DLD
         g/7E6O87gaebEgcHrgp4HC4+rPKiBTjhrfRhY9kwY3IjiUZMK8Z2ti7DhaJiRhkOeTWl
         Qqjsi7SDIXgcXluApVakP88lF0X28IIqrkTPjbQT/Ecg4Ok5Uy6Uvu8WxDuOBEyLcdmU
         zF7A==
X-Gm-Message-State: AOAM532Y9emHlT3pa9JRljgBxanS7pI72O5jxTqn4xHlT7SCIxQAFgPj
        w81JThZpM8JDBc32dOrGFtCY
X-Google-Smtp-Source: ABdhPJyZkMAOOmADDSEv1gbvqopLi44rUvDm534stz/n9EjVOSBtd9357N+8f0G6IOypE5aTIFL2hQ==
X-Received: by 2002:a63:1a0b:: with SMTP id a11mr14090313pga.299.1589356698288;
        Wed, 13 May 2020 00:58:18 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:30b:c888:d8ce:4edd:4c38:4a1b])
        by smtp.gmail.com with ESMTPSA id bj6sm10154891pjb.47.2020.05.13.00.58.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 May 2020 00:58:17 -0700 (PDT)
Date:   Wed, 13 May 2020 13:28:11 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Hemant Kumar <hemantk@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhugo@codeaurora.org, bbhatt@codeaurora.org
Subject: Re: [PATCH v1 3/5] bus: mhi: core: Skip handling BHI irq if MHI reg
 access is not allowed
Message-ID: <20200513075811.GA32128@Mani-XPS-13-9360>
References: <1589248989-23824-1-git-send-email-hemantk@codeaurora.org>
 <1589248989-23824-4-git-send-email-hemantk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589248989-23824-4-git-send-email-hemantk@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 07:03:07PM -0700, Hemant Kumar wrote:
> Driver continues handling of BHI interrupt even if MHI register access
> is not allowed. By doing so it calls the status call back and performs
> early notification for the MHI client. This is not needed when MHI
> register access is not allowed. Hence skip the handling in this case and
> return. Also add debug log to print device state, local EE and device EE
> when reg access is valid.
> 
> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
> Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/main.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index 9ec9b36..467c0ba 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -369,22 +369,29 @@ irqreturn_t mhi_irq_handler(int irq_number, void *dev)
>  	return IRQ_HANDLED;
>  }
>  
> -irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *dev)
> +irqreturn_t mhi_intvec_threaded_handler(int irq_number, void *priv)
>  {
> -	struct mhi_controller *mhi_cntrl = dev;
> +	struct mhi_controller *mhi_cntrl = priv;
> +	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>  	enum mhi_state state = MHI_STATE_MAX;
>  	enum mhi_pm_state pm_state = 0;
>  	enum mhi_ee_type ee = 0;
>  
>  	write_lock_irq(&mhi_cntrl->pm_lock);
> -	if (MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
> -		state = mhi_get_mhi_state(mhi_cntrl);
> -		ee = mhi_cntrl->ee;
> -		mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
> +	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
> +		write_unlock_irq(&mhi_cntrl->pm_lock);
> +		goto exit_intvec;
>  	}
>  
> +	state = mhi_get_mhi_state(mhi_cntrl);
> +	ee = mhi_cntrl->ee;
> +	mhi_cntrl->ee = mhi_get_exec_env(mhi_cntrl);
> +	dev_dbg(dev, "local ee:%s device ee:%s dev_state:%s\n",
> +		TO_MHI_EXEC_STR(mhi_cntrl->ee), TO_MHI_EXEC_STR(ee),
> +		TO_MHI_STATE_STR(state));
> +
>  	if (state == MHI_STATE_SYS_ERR) {
> -		dev_dbg(&mhi_cntrl->mhi_dev->dev, "System error detected\n");
> +		dev_dbg(dev, "System error detected\n");
>  		pm_state = mhi_tryset_pm_state(mhi_cntrl,
>  					       MHI_PM_SYS_ERR_DETECT);
>  	}
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
