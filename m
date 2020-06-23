Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86466C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EFA4206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cAB5DngA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732981AbgFWRdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732408AbgFWRdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:33:44 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE47C061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 10:33:43 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id f3so109403pgr.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 10:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iraOuU2nAS/k+2VyIidfWI20LZhSMu95WvSW+PLhzDA=;
        b=cAB5DngApas7biJNLKGUGeIVB7awS3HBWEggJGEguHU4d9COs9mhzD/TPXeAJZIpi3
         rFzfPGPaBMtuYwXVbd1pSCnw2zGHnykBm8p1mo/6Z6DcsMlKOsLv4+Ukw1oGI2aFKeEK
         CblL4eBdtq6+Wdo2dto3J4/Csc352cOBivSYnXXIhi5Yik7Tq3f/AanhBl2cq3ymzcjF
         xx5ofMdjrpAUEq0Ci29EVUd0X+51lwLux3bczfcjoOTdCzCxA6owTOUVBDK7rQhlc1Lm
         pdNkVYIjiiFJfv64p3drFJTwDitN8JOEjZmxj//s5ILV3rZz0IuZHj2JN2h/3j62vVKN
         5Wtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iraOuU2nAS/k+2VyIidfWI20LZhSMu95WvSW+PLhzDA=;
        b=BgFg/2nxs+YcojimcVpAHNUcllwtOg0NLapTkWSh3/VsrEum21GRrO/ZS8bvlp8PiE
         ZOKy7ZmqPT510Q7RoNxvs5ZY79gctGVh8Mq4Hdt6NAtiRbO1Sul+3q7AIzwDBGT0XACX
         fEK5/zWO1sqV3TGTJ4JObMzDFGz/Nk//2QJnEK8c4EZqkVsKCb3Nokp5nMUE7Dl7LIsn
         lLnkuUETm/fUDAwfRibfVoKpUnO43aKbB57mdxt5htf70AGLc8lMceVbKwn3YeXwtTyr
         aRfvHMAahMasVm8BWIcYmDDwB0/w4JlCJhUdofTcfEylz0Gcq1WKGuoePN/0h9Ol4RVZ
         eoKQ==
X-Gm-Message-State: AOAM530buUBQlmqTJQ8YHuDqFVfOVSK8TC6MYSXf/Iddjx9Q4MGIVlG5
        YykM6mlBOSNudNzTUasGSCfvRw==
X-Google-Smtp-Source: ABdhPJzYi7yrFd/vQE+EQoy+GKEp0n7xf+yKWXxRg7RK5IvG7FEYUrnoZ+VnxgncruH7e+Po2uxXKQ==
X-Received: by 2002:a62:8454:: with SMTP id k81mr25620819pfd.140.1592933623092;
        Tue, 23 Jun 2020 10:33:43 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id ng12sm3193013pjb.15.2020.06.23.10.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 10:33:42 -0700 (PDT)
Date:   Tue, 23 Jun 2020 11:33:40 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH] coresight: tmc: Fix TMC mode read in
 tmc_read_unprepare_etb()
Message-ID: <20200623173340.GB1843779@xps15>
References: <20200616045441.27483-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616045441.27483-1-saiprakash.ranjan@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 10:24:41AM +0530, Sai Prakash Ranjan wrote:
> Reading TMC mode register without proper coresight power
> management can lead to exceptions like the one in the call
> trace below in tmc_read_unprepare_etb() when the trace data
> is read after the sink is disabled. So fix this by having
> a check for coresight sysfs mode before reading TMC mode
> management register in tmc_read_unprepare_etb() similar to
> tmc_read_prepare_etb().
> 
>   SError Interrupt on CPU6, code 0xbe000411 -- SError
>   pstate: 80400089 (Nzcv daIf +PAN -UAO)
>   pc : tmc_read_unprepare_etb+0x74/0x108
>   lr : tmc_read_unprepare_etb+0x54/0x108
>   sp : ffffff80d9507c30
>   x29: ffffff80d9507c30 x28: ffffff80b3569a0c
>   x27: 0000000000000000 x26: 00000000000a0001
>   x25: ffffff80cbae9550 x24: 0000000000000010
>   x23: ffffffd07296b0f0 x22: ffffffd0109ee028
>   x21: 0000000000000000 x20: ffffff80d19e70e0
>   x19: ffffff80d19e7080 x18: 0000000000000000
>   x17: 0000000000000000 x16: 0000000000000000
>   x15: 0000000000000000 x14: 0000000000000000
>   x13: 0000000000000000 x12: 0000000000000000
>   x11: 0000000000000000 x10: dfffffd000000001
>   x9 : 0000000000000000 x8 : 0000000000000002
>   x7 : ffffffd071d0fe78 x6 : 0000000000000000
>   x5 : 0000000000000080 x4 : 0000000000000001
>   x3 : ffffffd071d0fe98 x2 : 0000000000000000
>   x1 : 0000000000000004 x0 : 0000000000000001
>   Kernel panic - not syncing: Asynchronous SError Interrupt
> 
> Fixes: 4525412a5046 ("coresight: tmc: making prepare/unprepare functions generic")
> Reported-by: Mike Leach <mike.leach@linaro.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etf.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>

And this one too.
 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index 36cce2bfb744..6375504ba8b0 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -639,15 +639,14 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata)
>  
>  	spin_lock_irqsave(&drvdata->spinlock, flags);
>  
> -	/* There is no point in reading a TMC in HW FIFO mode */
> -	mode = readl_relaxed(drvdata->base + TMC_MODE);
> -	if (mode != TMC_MODE_CIRCULAR_BUFFER) {
> -		spin_unlock_irqrestore(&drvdata->spinlock, flags);
> -		return -EINVAL;
> -	}
> -
>  	/* Re-enable the TMC if need be */
>  	if (drvdata->mode == CS_MODE_SYSFS) {
> +		/* There is no point in reading a TMC in HW FIFO mode */
> +		mode = readl_relaxed(drvdata->base + TMC_MODE);
> +		if (mode != TMC_MODE_CIRCULAR_BUFFER) {
> +			spin_unlock_irqrestore(&drvdata->spinlock, flags);
> +			return -EINVAL;
> +		}
>  		/*
>  		 * The trace run will continue with the same allocated trace
>  		 * buffer. As such zero-out the buffer so that we don't end
> 
> base-commit: 3d439a6c349778f129de19595db564a8366c3634
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
