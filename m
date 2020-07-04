Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDB96C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 14:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99FCE207CD
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 14:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N5/Aht5E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgGDOc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 10:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgGDOc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 10:32:56 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF347C08C5DE
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 07:32:55 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id k27so267862pgm.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 07:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dwRxPald58nx4ffEkNOIWW3yDBwtaY7nd/6LogjPLvc=;
        b=N5/Aht5EPbV5L6OuYfj7F/TwKeRhLN3oRgC2qkJlu/Az8UK03d0mD7sZ/33p+06QYy
         M805o1BBvTr2qhGOP6kHrihUDxvOTDgg7tn4zJ5u57dcoDIWA5HvI6czR1LFRgN6eahD
         W6SBbDoOXUFA5XFSatcmtFP8zSAYRXHa0w6fx5iVEYusdySVj77xAQ9uqsU0VtSWpCWO
         1ylk3GK0HVCnaqqGMqywTksSvBuolVBD9a5QllxT5T2oJoMVC08onvqWbpoJ0yeXLqB/
         oznOyrhJcCu8V1xOBpdUZOlFkn8zLX/Nl5IFCaDtGhC6L99igWzhtTsQL7uspOtqG5hx
         YRXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dwRxPald58nx4ffEkNOIWW3yDBwtaY7nd/6LogjPLvc=;
        b=kQFspCKzyfpM0UGlyyZeYJc5Cu60CfRTgeU1OS+EDgjOnpGypZpRy3VyBWIWTQ/ZSw
         KN8sPZHsihh4EMiCOfgllviXthlIO2UUEqUvuDOpZDqyrfCtykn06RoW0m/Bz+Y13C5H
         5Lssh5qFrLMwHcNujfAInUNOSmLZ+ACuCyULoLzZ0NdGeEj6SB9WJJQ5XhcI1r8MMoGJ
         Sn1Kc62CsBj5fgPeIrXmQok67IRfiGbbQWMFPdJ7Xy0eFXopJoUyY5ce9O8rnBECtBtp
         zBrT1k6MWkR7aISTk6cV5qtzhSihxME0FO+ZZbmsPeVjDZGLX85E1QHmgBcTNsLNGLX/
         Yijw==
X-Gm-Message-State: AOAM532/vbPVF5hT730WtNl5ZybkFQZyxpwN0qvtLW3A0cINzD2xOjMX
        1EapUEUCyFDxraGa3Pb5ypBM
X-Google-Smtp-Source: ABdhPJzQ/74flMlii4Qahc6MIL7lIpHrTU+9u7KeQp81lBgDnAH7OsuF8vb49/itg5eWN4gpFOFnYg==
X-Received: by 2002:a63:4f05:: with SMTP id d5mr17951555pgb.298.1593873175331;
        Sat, 04 Jul 2020 07:32:55 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:680:29c6:d74:dc5c:e13f:c458])
        by smtp.gmail.com with ESMTPSA id i13sm13727495pjd.33.2020.07.04.07.32.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Jul 2020 07:32:54 -0700 (PDT)
Date:   Sat, 4 Jul 2020 20:02:47 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/9] bus: mhi: core: Remove double occurrence for
 mhi_ctrl_ev_task() declaration
Message-ID: <20200704143247.GA3066@Mani-XPS-13-9360>
References: <1593448782-8385-1-git-send-email-bbhatt@codeaurora.org>
 <1593448782-8385-2-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593448782-8385-2-git-send-email-bbhatt@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 09:39:34AM -0700, Bhaumik Bhatt wrote:
> mhi_ctrl_ev_task() in the internal header file occurred twice.
> Remove one of the occurrences for clean-up.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/internal.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
> index b1f640b..bcfa7b6 100644
> --- a/drivers/bus/mhi/core/internal.h
> +++ b/drivers/bus/mhi/core/internal.h
> @@ -592,7 +592,6 @@ int mhi_queue_state_transition(struct mhi_controller *mhi_cntrl,
>  void mhi_pm_sys_err_handler(struct mhi_controller *mhi_cntrl);
>  void mhi_fw_load_worker(struct work_struct *work);
>  int mhi_ready_state_transition(struct mhi_controller *mhi_cntrl);
> -void mhi_ctrl_ev_task(unsigned long data);
>  int mhi_pm_m0_transition(struct mhi_controller *mhi_cntrl);
>  void mhi_pm_m1_transition(struct mhi_controller *mhi_cntrl);
>  int mhi_pm_m3_transition(struct mhi_controller *mhi_cntrl);
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
