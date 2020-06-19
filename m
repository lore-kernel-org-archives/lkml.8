Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC7DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2614520786
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NYZ9yPCY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbgFSFeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 01:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbgFSFeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 01:34:01 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDAD3C0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 22:34:00 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k1so3486792pls.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 22:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ab8+1YMk6qjzS4WRHwARDFcpXcgAOo18p41t0NQx6jc=;
        b=NYZ9yPCYhNcCISQU8JivT8GyG4YIK2LHpuB3yOr0WOnekmzKbKXvKnaIathUoNvN1f
         KEqFtz3fL9PjzxXH8TRyQKSczxPuZ3vS8xA5yTgsG7Ik7G39w6E/Q9wLeohO5vkzWILA
         MUj+YO2v3CSj99s5Yhykj3b6Xjqr2eGtpNM/76VsK2baIGvviy3zRVPJvhk6XeCfEWji
         acMqT7fOvAY8TOTMJMAChP8P8X9YBs48yDCUfsVCm4v3p4q52uxbUtop4+wnjNSt3OUO
         /i4hTWVJ6vAZMJ3Ce2VfAC4QaMuYoZmdQ67qBFT5ucbaYsp5YdupvTS6TJZHiteIIz6a
         q9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ab8+1YMk6qjzS4WRHwARDFcpXcgAOo18p41t0NQx6jc=;
        b=WzZIsKgBEq1X0zjMPI4qGbEXvzCQu4k/g9SAdq1LFHf2Xyph51vK2gllN9KzHVJiou
         fy3wJ3kU1jjmsUMKu6z1NtQv16W0ZqUi72f18lzTw+fL3KbIX471O4IVGn7GzJnSIOlM
         JA9yPS5/tbgG1AgIl81TFYfmT6QGLBNacinmtb53tn4AQ1cIRYqMi9h6IgbNbIobZVHX
         fJidlu5/HkmVVZOZTmKQ0m013tI3UhdCrcpV49Qixo3pHX2qVZLNw6QD4AKU+lyzIUUz
         meZz10b6T1rKhR/Ta+A08V0oZ0TzyQwxhMQkbrlMPYfzZjtve+anWhOB175wYA9gAkSc
         uQKA==
X-Gm-Message-State: AOAM532e9IgmPf3K9BC6MeCl1uL28SEGzbB+/02nuNByKMAuDqasDuHw
        wSNjGGOwWqZHxIPQzDcGJ0Pq
X-Google-Smtp-Source: ABdhPJwbqUV4rSkjtmLB7sxVU1E9G9lR6L4110+rxIdkoT+3XVyK3pZE+So8AwwRmjRnOJWVuHor1A==
X-Received: by 2002:a17:902:a50e:: with SMTP id s14mr68845plq.334.1592544839966;
        Thu, 18 Jun 2020 22:33:59 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:59f:c065:651a:bc24:a9bb:ff41])
        by smtp.gmail.com with ESMTPSA id p12sm4566629pfq.69.2020.06.18.22.33.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jun 2020 22:33:59 -0700 (PDT)
Date:   Fri, 19 Jun 2020 11:03:53 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Hemant Kumar <hemantk@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jhugo@codeaurora.org, bbhatt@codeaurora.org
Subject: Re: [PATCH v3 2/4] bus: mhi: core: Move MHI_MAX_MTU to external
 header file
Message-ID: <20200619053353.GB3245@Mani-XPS-13-9360>
References: <1591899224-3403-1-git-send-email-hemantk@codeaurora.org>
 <1591899224-3403-3-git-send-email-hemantk@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591899224-3403-3-git-send-email-hemantk@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 11:13:42AM -0700, Hemant Kumar wrote:
> Currently this macro is defined in internal MHI header as
> a TRE length mask. Moving it to external header allows MHI
> client drivers to set this upper bound for the transmit
> buffer size.
> 

So we have 2 definitions for MHI_MAX_MTU now? Why can't you remove the one
available internally?

Thanks,
Mani

> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
> ---
>  include/linux/mhi.h | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index a39b77d..ce43f74 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -16,6 +16,9 @@
>  #include <linux/wait.h>
>  #include <linux/workqueue.h>
>  
> +/* MHI client drivers to set this upper bound for tx buffer */
> +#define MHI_MAX_MTU 0xffff
> +
>  #define MHI_VOTE_BUS BIT(0) /* do not disable the mhi bus */
>  #define MHI_VOTE_DEVICE BIT(1) /* prevent mhi device from entering lpm */
>  
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
