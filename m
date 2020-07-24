Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAC9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A01206E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 05:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NDO0TW1N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgGXFYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 01:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGXFYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 01:24:45 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC02C0619E4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 22:24:43 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so4654337pgf.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 22:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bG5kNzTRUe2ISI1cNtIgna1XqT+GgCV0bBepvmFfMDM=;
        b=NDO0TW1NrTksFUPwBY0dAXFynV3sNPbEBxcLWo5US91+b+pW2JxXNIyjcG1DiQcR8O
         dGyiYwFswmY8rM5Kr+HaJZljSN98MISK1yP1Nx79+s7ezZ3Dpz8FIDgt5rKVHQWNO6Wm
         GZnhYJYr/aXKWJnMzyVZkD3lyIaJdeaq9DhCjBEsDYi1vWGI+icd0krY+2JJngX3uZFb
         TuaNzAHV5tHSaCNbemLOewqIMeuw2J1CGckq/eRRysVZEVWJH9VXDi7y0tDJMo+dygZz
         k86QZJi2l9WatawOtE/LBA0+7tbR1HIGT7RexhDHch7wzBx6MpeyzUTmgk2CJUYotN0Q
         I3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bG5kNzTRUe2ISI1cNtIgna1XqT+GgCV0bBepvmFfMDM=;
        b=CnDJZ6khXI/Yat7M6exNv3M5e3qcAJMHwKy2Y7tq+3X0tP1UhQXXjaHDUwteQAGo4p
         HjvAXxWiQkEH4lMumtbZnvhcg/AZQC0KmBR04GLpnSfQiFE+SuuN8+HjoxKtblGp5NeT
         XL4Hy+j4T7/cw4575qeJv7z70ajV8O3TlaAz7g+Cn541iw62raEhQS2ssfSvj7Ohn3sD
         KDbteZaw6vdPb9+w5IX2D1YJ51PdiP4LT0imXP8sA0vVCeIPW0sGmyCjnXKdTsTvM5Vk
         89ei4ct32EdTFC8QYK8c6uvfWYLNnUg3jqzbq4TMfmE2VxbX9XX6VX6mZjNuQE68fIP+
         lc0g==
X-Gm-Message-State: AOAM530MBp+UCyHsHHjwr6wKm314lJtCdG92tjgnhScwwM6NqH/dRsdC
        0WIr4zyGhnUgJR8oQ2ghOaA1ckkrrg==
X-Google-Smtp-Source: ABdhPJzYKCfZqe523a59d0HSpXjvmQRQ+e0FZ+vv3P8TrAgXgMzIgWc83b49W3dq3UeFShKEXHgoVg==
X-Received: by 2002:aa7:97a1:: with SMTP id d1mr7378437pfq.190.1595568282985;
        Thu, 23 Jul 2020 22:24:42 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6c9b:7816:d54:f58c:a790:e57b])
        by smtp.gmail.com with ESMTPSA id g10sm4734079pfr.164.2020.07.23.22.24.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jul 2020 22:24:42 -0700 (PDT)
Date:   Fri, 24 Jul 2020 10:54:34 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/10] bus: mhi: core: Use counters to track MHI
 device state transitions
Message-ID: <20200724052434.GB17957@Mani-XPS-13-9360>
References: <1595543802-17859-1-git-send-email-bbhatt@codeaurora.org>
 <1595543802-17859-9-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595543802-17859-9-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 03:36:40PM -0700, Bhaumik Bhatt wrote:
> Use counters to track MHI device state transitions such as those
> to M0, M2, or M3 states. This helps in better debug by allowing
> the user to see the number of transitions to a certain state when
> queried using the states debugfs entry.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

This patch should come before the debugfs patch. Also the header addition
should be here.

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/pm.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> index 27bb471..ce4d969 100644
> --- a/drivers/bus/mhi/core/pm.c
> +++ b/drivers/bus/mhi/core/pm.c
> @@ -256,6 +256,7 @@ int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl)
>  		dev_err(dev, "Unable to transition to M0 state\n");
>  		return -EIO;
>  	}
> +	mhi_cntrl->M0++;
>  
>  	/* Wake up the device */
>  	read_lock_bh(&mhi_cntrl->pm_lock);
> @@ -326,6 +327,8 @@ void mhi_pm_m1_transition(struct mhi_controller *mhi_cntrl)
>  		mhi_cntrl->dev_state = MHI_STATE_M2;
>  
>  		write_unlock_irq(&mhi_cntrl->pm_lock);
> +
> +		mhi_cntrl->M2++;
>  		wake_up_all(&mhi_cntrl->state_event);
>  
>  		/* If there are any pending resources, exit M2 immediately */
> @@ -362,6 +365,7 @@ int mhi_pm_m3_transition(struct mhi_controller *mhi_cntrl)
>  		return -EIO;
>  	}
>  
> +	mhi_cntrl->M3++;
>  	wake_up_all(&mhi_cntrl->state_event);
>  
>  	return 0;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
