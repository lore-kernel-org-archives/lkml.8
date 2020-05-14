Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5493DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3795B20575
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KACcbMcy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgENFXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725876AbgENFXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:23:12 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B7DC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 22:23:12 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b12so719257plz.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 22:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/9E3MjDhSnLeEr9EWAO9eILQyqFL+6FFvSw8g6uxZN4=;
        b=KACcbMcyELxmf5M1Fs+/YWbUPDvl2Xf75/e2yVd2JT86mNQgbfhn3D4Ig75idPUpsS
         pa9a1tZ0ilC0jg+W4WRZ7HkQZc06O1yL39akTek6M3V6HBnHoiEGyANMl53eXmSsnxRi
         d/O1xTDQ6rXhbcRMKw4cj0/LkhaDv96kpx+7Fw7snyO0u6oqreTsLa2XBounpTJXBWrL
         K4/v6YBb4Zxurt5i36q1tcQQxZOmjSbTy6/uVRBzea7k4wp8s0mbZ1zNZcDNuexTT9av
         CZAMA+oIvBCxXHjFcW0b1vtlxXZtXZxbx05vCMbpZNHyY2ksLNjlufChtvj7c2Jy3ZlW
         E+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/9E3MjDhSnLeEr9EWAO9eILQyqFL+6FFvSw8g6uxZN4=;
        b=Bxs7iP3/0DxwFlvv31X5LFquWGcEs758SL8XaH2GVQJ3ELanFmq8LBfBi+WyPzPeFb
         gd40dVsgnBDoQHfO9UNASdc4LYtYe/bTIcH6ecgB/YgMwHoYKglLMETm0zhuVA6thpaX
         l/JfX78rljTyjc49/fJOxpdrp5wzeo2LNX2Zs8l49DRR27sIJuaZwXDXQ1NrAfjYYbjN
         Gr8OfSXpbC737R3h+dRLRB4NT/FwNOjqWOR0BeeVyGSH5WXZ9aSPiavslJi4sxE3rVUq
         32nd/IIdRjvSbB8My02cZVFX5OQMMtYitbqdkHUOBfDD7PynWkmgWh8GtQTjmawZ+Oze
         YzAQ==
X-Gm-Message-State: AOAM531t5oS6euSIqEpaR7F05klw0sUCR3w4ee/7T+LM1uRL2j2In4Wi
        ub1CEPpSP31k+VsMRESR1sQk
X-Google-Smtp-Source: ABdhPJx/3pYCS1QwD7RsrwPeLuu2J8iRzjREmibNHcDFwcT4oGeDanK458HNXfu1VMrJMX/Ql0xpvw==
X-Received: by 2002:a17:90a:154b:: with SMTP id y11mr1889668pja.158.1589433791435;
        Wed, 13 May 2020 22:23:11 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:406:efde:ac17:556c:1ce3:639f])
        by smtp.gmail.com with ESMTPSA id o21sm16694785pjr.37.2020.05.13.22.23.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 May 2020 22:23:10 -0700 (PDT)
Date:   Thu, 14 May 2020 10:53:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] bus: mhi: core: Handle syserr during power_up
Message-ID: <20200514052305.GC2877@Mani-XPS-13-9360>
References: <1588868371-8365-1-git-send-email-jhugo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588868371-8365-1-git-send-email-jhugo@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 10:19:31AM -0600, Jeffrey Hugo wrote:
> The MHI device may be in the syserr state when we attempt to init it in
> power_up().  Since we have no local state, the handling is simple -
> reset the device and wait for it to transition out of the reset state.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Will apply this patch to mhi-next and include in the 5.8 series.

Thanks,
Mani

> ---
> 
> v4:
> -Implemented Hemant's suggested solution from v2.  The spec will be amended
> to indicate the intvec interrupt will be triggered for the reset state change
> which matches the current implementations and enables Hemant's solution to
> be used, which is cleaner.
> 
>  drivers/bus/mhi/core/pm.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> index dc83d65..ddef693 100644
> --- a/drivers/bus/mhi/core/pm.c
> +++ b/drivers/bus/mhi/core/pm.c
> @@ -760,6 +760,7 @@ static void mhi_deassert_dev_wake(struct mhi_controller *mhi_cntrl,
>  
>  int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
>  {
> +	enum mhi_state state;
>  	enum mhi_ee_type current_ee;
>  	enum dev_st_transition next_state;
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
> @@ -829,6 +830,32 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
>  		goto error_bhi_offset;
>  	}
>  
> +	state = mhi_get_mhi_state(mhi_cntrl);
> +	if (state == MHI_STATE_SYS_ERR) {
> +		mhi_set_mhi_state(mhi_cntrl, MHI_STATE_RESET);
> +		ret = wait_event_timeout(mhi_cntrl->state_event,
> +				MHI_PM_IN_FATAL_STATE(mhi_cntrl->pm_state) ||
> +					mhi_read_reg_field(mhi_cntrl,
> +							   mhi_cntrl->regs,
> +							   MHICTRL,
> +							   MHICTRL_RESET_MASK,
> +							   MHICTRL_RESET_SHIFT,
> +							   &val) ||
> +					!val,
> +				msecs_to_jiffies(mhi_cntrl->timeout_ms));
> +		if (ret) {
> +			ret = -EIO;
> +			dev_info(dev, "Failed to reset MHI due to syserr state\n");
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
