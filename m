Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA13AC2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CC46206F5
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OprSWA3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgDGG0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 02:26:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36772 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgDGG0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 02:26:48 -0400
Received: by mail-pl1-f195.google.com with SMTP id g2so855635plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 23:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ONLftnGsLl++P31s2gjavTkjMaFjGxacNpYiF6aPBEQ=;
        b=OprSWA3K1+DI82/GVLD9pVzmKVKvVfeO4Tz9H3QiOUDtsw81ckghYK6DmWwGFoyB9X
         Ftt1C2XBTnGx5FJ4C3dZaR72V0ZRplOEfo6sldDkl31sFjawtkBr01zebwSXsX1vs2xq
         Jf4YZfmwVGrWaOKs+bev2CeGKwbjQl5bUcBSSP+sPhhCYPi5rgtyPyRcroE5/FHTAaAe
         y4Rfvb8ZIGhtJFvkztdIoQJD3759m2Dq//g5xGG7N3blFCWa/zcUvFaqm78M6g+28EEi
         CF1rPQ4TtLDmvYPusnpFRFLs4itFj8ojJRYgzJZlEA3SeFgTP8WegMwDQZFYMJKLmMSc
         ZQfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ONLftnGsLl++P31s2gjavTkjMaFjGxacNpYiF6aPBEQ=;
        b=aDuIl922vSZoHiI373goY4tFMPZQbmxUb/byo9azOzfCQYgCgsqLqixxgkHGwc53SO
         q2ED6JrJMyjrrAKn+Fm6ROnWcVc8tlyAwa/JWGp+FrN7veuC7AOo0J4FJupyHN71j+W7
         /3kYol4Y1xhHr6guf2sEFpjZF2fTBn/UByY4hGjkkHxyopBLp16hHD9IDTB3gThGEJvr
         rKAZGhSkqPJTy+26oJBQxPqa/JZG/yCnS5MopjJ5E3YBYsq0d6BO7G7HmFXGpINqmCNv
         QXxmbuOrIWEzOGWTo8BbVd/XtZ1oDRgGfapVFGIcnppfxwoy5ZAo+jdKZfemZLALH0nW
         edAQ==
X-Gm-Message-State: AGi0PubWAy+lKckHL734OKqxsrGkXluAGdyH1Bk7SdU+sc/2tHpsjL6Q
        7qkqtNvwPyB8DECvNkKQx6bo
X-Google-Smtp-Source: APiQypI9BlB6ZX2djP+LrPTOJe/2qMnYzGoY4h/zCFG5I5AcCjtUrVcQEj8zGgLQmIIj8cftH5wVGA==
X-Received: by 2002:a17:902:c595:: with SMTP id p21mr1008197plx.17.1586240806501;
        Mon, 06 Apr 2020 23:26:46 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6e86:d03b:80dc:a9ff:fe0a:9bd3])
        by smtp.gmail.com with ESMTPSA id mu15sm716327pjb.30.2020.04.06.23.26.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 23:26:45 -0700 (PDT)
Date:   Tue, 7 Apr 2020 11:56:41 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     hemantk@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] bus: mhi: core: Handle syserr during power_up
Message-ID: <20200407062641.GC2442@Mani-XPS-13-9360>
References: <1586207077-22361-1-git-send-email-jhugo@codeaurora.org>
 <1586207077-22361-2-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586207077-22361-2-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 03:04:35PM -0600, Jeffrey Hugo wrote:
> The MHI device may be in the syserr state when we attempt to init it in
> power_up().  Since we have no local state, the handling is simple -
> reset the device and wait for it to transition out of the reset state.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
>  drivers/bus/mhi/core/pm.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> index 52690cb..cd6ba23 100644
> --- a/drivers/bus/mhi/core/pm.c
> +++ b/drivers/bus/mhi/core/pm.c
> @@ -9,6 +9,7 @@
>  #include <linux/dma-direction.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/interrupt.h>
> +#include <linux/iopoll.h>
>  #include <linux/list.h>
>  #include <linux/mhi.h>
>  #include <linux/module.h>
> @@ -760,6 +761,7 @@ static void mhi_deassert_dev_wake(struct mhi_controller *mhi_cntrl,
>  
>  int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
>  {
> +	enum mhi_state state;
>  	enum mhi_ee_type current_ee;
>  	enum dev_st_transition next_state;
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> @@ -829,6 +831,24 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
>  		goto error_bhi_offset;
>  	}
>  
> +	state = mhi_get_mhi_state(mhi_cntrl);
> +	if (state == MHI_STATE_SYS_ERR) {
> +		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
> +		ret = readl_poll_timeout(mhi_cntrl->regs + MHICTRL, val,
> +					 !(val & MHICTRL_RESET_MASK), 1000,

Hmm. Do we really need a max 1ms delay between each read? I'd prefer to have
100ns to reduce the wait time.

> +					 mhi_cntrl->timeout_ms * 1000);
> +		if (ret) {
> +			dev_info(dev, "Failed to reset syserr\n");

dev_info(dev, "Failed to reset MHI due to syserr state\n"); ?

Thanks,
Mani

> +			goto error_bhi_offset;
> +		}
> +
> +		/*
> +		 * device cleares INTVEC as part of RESET processing,
> +		 * re-program it
> +		 */
> +		mhi_write_reg(mhi_cntrl, mhi_cntrl->bhi, BHI_INTVEC, 0);
> +	}
> +
>  	/* Transition to next state */
>  	next_state = MHI_IN_PBL(current_ee) ?
>  		DEV_ST_TRANSITION_PBL : DEV_ST_TRANSITION_READY;
> -- 
> Qualcomm Technologies, Inc. is a member of the
> Code Aurora Forum, a Linux Foundation Collaborative Project.
