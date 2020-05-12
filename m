Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924D8C54E8F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CB5D20752
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TpxuWsEB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgELGsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 02:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725889AbgELGsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:48:01 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AF4C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 23:47:59 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 9so174699pgr.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 23:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xStF/LvgirIKlsQkZu5T5XjT/8+nmfTv4uL0HxiDbUg=;
        b=TpxuWsEBxYJVZ6z1OiykUfvfvt2F8hshe2JE8BF2NMN7ZSwR5WDiMle2Ym6wnIo0Av
         0Fehon1Ff6cS4G0Yj5jr9dVcdHFs5P7mYru9FjjMhoOBbfqm3kaH3EyeYvx6/kGtuytg
         l+AuAMI8TMb+vb2rVHYGFvL7QOiSCJ31pWWgJReKy5BAO6euEZzLxl9Zx++Pt5gjEuM0
         l/ehikOu2Ic8YTX1yo+ljGQlr8BycPqnPgYCYvPx7ybj8WZKqth265hwPaDdt55+4Z1L
         QJpFumikb7y+mGGsAefzLEH0KSqX7UONONBQJGj3DH7VsWo2qlp6OXBa3GIr+ZmaP0r4
         7+mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xStF/LvgirIKlsQkZu5T5XjT/8+nmfTv4uL0HxiDbUg=;
        b=lBs8RGgTg/rumBa9oSeEEKOy3UNlTMSLOSotFHn5PRWaisrs2KM/XT4zUrK1N6cCxb
         UwVLSVjizcRloteYPTck91DMp9nb5N9lrztBxp5cJRGvH8Q9IuiZJG1gccu2dGCwIezW
         1azetnF9kNgpUWjpO99NK1GRJmY9YCfht5oRN4DnHQQMALlbjnq4KLWXvge/F9HShPss
         Og1UohDfRGE3d07vMZvLhCkw6+sHFRyupG6dBE3iCdJJ6wXVO8HkOnVuKA6DIY3Xq1Ek
         T522ngw0U/8pLgHbdlnPmsKulRA2fS66dNK1gGq9lzcXymRBKIvNS2J2RIc6ZVjoqRx/
         eg7g==
X-Gm-Message-State: AOAM530DIqvq1h7PWl9hD373ruBVacqyIv4+ILSFX5qlyfr/iSLzUTWx
        rtEEiN3OlJBFJ1G/F+zbcGQS
X-Google-Smtp-Source: ABdhPJyvA/QCz/3nwd9RhJfuGISeb+4IzqsUvXUDJavBywVLWxQ2L4Ke5f0zGkqBy8CZZVKkxxmqew==
X-Received: by 2002:a63:5812:: with SMTP id m18mr3060403pgb.407.1589266079225;
        Mon, 11 May 2020 23:47:59 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6007:2f23:5151:5dd:ea86:4678])
        by smtp.gmail.com with ESMTPSA id a136sm11269599pfa.99.2020.05.11.23.47.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 May 2020 23:47:58 -0700 (PDT)
Date:   Tue, 12 May 2020 12:17:52 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Hemant Kumar <hemantk@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhugo@codeaurora.org, bbhatt@codeaurora.org
Subject: Re: [PATCH v1 2/5] bus: mhi: core: Handle disable transitions in
 state worker
Message-ID: <20200512064752.GD4928@Mani-XPS-13-9360>
References: <1589248989-23824-1-git-send-email-hemantk@codeaurora.org>
 <1589248989-23824-3-git-send-email-hemantk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589248989-23824-3-git-send-email-hemantk@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 07:03:06PM -0700, Hemant Kumar wrote:
> Mission mode transition is handled by state worker thread but
> power off is not. There is a possibility while mission mode
> transition is in progress which calls MHI client driver probe,
> power off is issued by MHI controller. This results into client
> driver probe and remove running in parallel and causes use after
> free situation. By queuing disable transition work when mission
> mode is in progress prevents the race condition.
> 
> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
> Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/init.c     |  1 +
>  drivers/bus/mhi/core/internal.h |  1 +
>  drivers/bus/mhi/core/pm.c       | 11 ++++++++++-
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index 3a853c5..12207cc 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -35,6 +35,7 @@
>  	[DEV_ST_TRANSITION_SBL] = "SBL",
>  	[DEV_ST_TRANSITION_MISSION_MODE] = "MISSION_MODE",
>  	[DEV_ST_TRANSITION_SYS_ERR] = "SYS_ERR",
> +	[DEV_ST_TRANSITION_DISABLE] = "DISABLE",
>  };
>  
>  const char * const mhi_state_str[MHI_STATE_MAX] = {
> diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
> index f01283b..b1f640b 100644
> --- a/drivers/bus/mhi/core/internal.h
> +++ b/drivers/bus/mhi/core/internal.h
> @@ -387,6 +387,7 @@ enum dev_st_transition {
>  	DEV_ST_TRANSITION_SBL,
>  	DEV_ST_TRANSITION_MISSION_MODE,
>  	DEV_ST_TRANSITION_SYS_ERR,
> +	DEV_ST_TRANSITION_DISABLE,
>  	DEV_ST_TRANSITION_MAX,
>  };
>  
> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> index d9964d4..345f197 100644
> --- a/drivers/bus/mhi/core/pm.c
> +++ b/drivers/bus/mhi/core/pm.c
> @@ -657,6 +657,10 @@ void mhi_pm_st_worker(struct work_struct *work)
>  			mhi_pm_disable_transition
>  				(mhi_cntrl, MHI_PM_SYS_ERR_PROCESS);
>  			break;
> +		case DEV_ST_TRANSITION_DISABLE:
> +			mhi_pm_disable_transition
> +				(mhi_cntrl, MHI_PM_SHUTDOWN_PROCESS);
> +			break;
>  		default:
>  			break;
>  		}
> @@ -1011,7 +1015,12 @@ void mhi_power_down(struct mhi_controller *mhi_cntrl, bool graceful)
>  				to_mhi_pm_state_str(MHI_PM_LD_ERR_FATAL_DETECT),
>  				to_mhi_pm_state_str(mhi_cntrl->pm_state));
>  	}
> -	mhi_pm_disable_transition(mhi_cntrl, MHI_PM_SHUTDOWN_PROCESS);
> +
> +	mhi_queue_state_transition(mhi_cntrl, DEV_ST_TRANSITION_DISABLE);
> +
> +	/* Wait for shutdown to complete */
> +	flush_work(&mhi_cntrl->st_worker);
> +
>  	mhi_deinit_free_irq(mhi_cntrl);
>  
>  	if (!mhi_cntrl->pre_init) {
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
