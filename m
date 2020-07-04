Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44977C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 14:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 196AB2158C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 14:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rm9vaEvu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgGDO5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 10:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGDO5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 10:57:03 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2069DC08C5DE
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 07:57:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t15so745297pjq.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 07:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=T5ivJGFMS8l655Uv/RE5CHugIfJFOuIIYbEDilXGXss=;
        b=rm9vaEvuxYykAd3uwe48eVOyoNQaP+YHUjVUtF4riLnU5be9sJT+o4erWOH00v/dGO
         Jf4upm8oiedECEDJ2KGSt+HXAdvHQMP5dCINSHQN7p/cM3o4lw6cyw0v8rfuINFa864X
         z/1t/It7fWOTRRv30MoQ7AOEWunZCK2ks8cmQGKHaqpm4DpkVk90aLN+mqEFwXbVFfRa
         VzWVjsPfm5pIpZTRgidT2sNhCW+bhFDStDCCiEibq0z0Dp/d4OJLeBgx1M9lIVwZEaNo
         EepAxEb/5n7900vJzXMVFUA9E2d/gKgJyhnpXSLz5SADP/EyYf4jopRWF+oniFHbj7vn
         xlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T5ivJGFMS8l655Uv/RE5CHugIfJFOuIIYbEDilXGXss=;
        b=kybJPrk4TGftzAsoAUD11B8FtcFRK2szmV6bGF1n4cCg30JhoMnfrCCMYV+Em3fcUL
         bHE6w1FkHM4muuOfeWyMwd3VSHvUP0JE8ZlSUiv9hgvinNJT6hsRKos1yFYYj+uguTqd
         Ze/rTYiKLaSDDO9IA/FFmbdrf9Unn8aMjTuhSG/ailMRMHjTgE4+o3XQFkUk7sQnWLix
         8pxXrbRF/WF8L6ZofAaqlLoVSKpT1OnciuMhO2giAVEqo3RJHXkL1Yuwdg6ATXjfF1H5
         2ZBUJYb3AZeyik5tSj+y9Bs/g3fCfYqwdI3V0vOzuHB4KZQocHmNG4Y2CQKMNACCqF56
         48aA==
X-Gm-Message-State: AOAM530A9+rmPYmFVxEk7tPVTRfLDcHxM1ELWfqnjYXm7BP5BEE/TDhV
        BtOKIBowRc10mLnMKYCUc20aVVnZqA==
X-Google-Smtp-Source: ABdhPJztNX703knSvL8QCwuvzOGC8mD18J64XhuJv9KJ2a95oXPCL0I0ukJbOGB2y2JUxUagBSuY7w==
X-Received: by 2002:a17:90a:191b:: with SMTP id 27mr45064379pjg.158.1593874622508;
        Sat, 04 Jul 2020 07:57:02 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:680:29c6:d74:dc5c:e13f:c458])
        by smtp.gmail.com with ESMTPSA id f14sm13764448pjq.36.2020.07.04.07.56.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Jul 2020 07:57:01 -0700 (PDT)
Date:   Sat, 4 Jul 2020 20:26:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/9] bus: mhi: core: Trigger a host resume when device
 vote is requested
Message-ID: <20200704145655.GD3066@Mani-XPS-13-9360>
References: <1593448782-8385-1-git-send-email-bbhatt@codeaurora.org>
 <1593448782-8385-5-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593448782-8385-5-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 09:39:37AM -0700, Bhaumik Bhatt wrote:
> It is possible that the host may be suspending or suspended and may
> not allow an outgoing device wake assert immediately if a client has
> requested for it. Ensure that the host wakes up and allows for it so
> the client does not have to wait for an external trigger or an
> outgoing packet to be queued for the host resume to occur.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Remove the term 'vote' from the commit subject, it doesn't seem right. How about
"Trigger host resume if already suspended during mhi_device_get()"? With that
fixed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/pm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> index 5e3994e..74c5cb1 100644
> --- a/drivers/bus/mhi/core/pm.c
> +++ b/drivers/bus/mhi/core/pm.c
> @@ -1115,6 +1115,9 @@ void mhi_device_get(struct mhi_device *mhi_dev)
>  
>  	mhi_dev->dev_wake++;
>  	read_lock_bh(&mhi_cntrl->pm_lock);
> +	if (MHI_PM_IN_SUSPEND_STATE(mhi_cntrl->pm_state))
> +		mhi_trigger_resume(mhi_cntrl, false);
> +
>  	mhi_cntrl->wake_get(mhi_cntrl, true);
>  	read_unlock_bh(&mhi_cntrl->pm_lock);
>  }
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
