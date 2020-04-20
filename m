Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8854C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B699220B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHg1vdpc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgDTRhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726450AbgDTRhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:37:06 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1714CC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:37:06 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o185so4878742pgo.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 10:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wp8Xrp59QlTq458T5KjDUO1tXKy+Khd8hcR7eA6qRkQ=;
        b=KHg1vdpcCjXP5/p5qTGrllYsV+lzuJriI2RLw+S4S3xki9OB0wEpeAVLdEce/vnvpd
         4Qj6qZY0OyB9S7P/fnTkWiPaLK2/IznodQKVslWtLWtqgVAYK5tvJ3ygHrcAETIAWCoA
         Ar0DzMHJ+Pcx1+Ztf0WF25JcRGXnJn2Cc419R8/tYnCMw3sjphihMiP39h92kuvvgv7F
         3upXSFD1DQPO8WG8vG+04fku98v0LbVxnBm0SNbeycDqzB71S/afMQamSfxE/MHjnUZD
         ux5z/woSc8UPoNeLMZVeBHX/E3+YcUJVVw7pnNoDjxiMJUaDbRGu8hUVHsD/eobbc1NY
         qN/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wp8Xrp59QlTq458T5KjDUO1tXKy+Khd8hcR7eA6qRkQ=;
        b=qWISfP2TEVXwEb0Z9aGgnFgEG5jTDLcPLJDSor+Le9SDn1tElfGGb/ZwH7Vbun/Uhl
         WojTBy5f5gS2e5HkPTmtL5BGgaokmnGhyy2zq9wqgL5ra0pXb49RcWQ6kodKDzYS0MH/
         IK+q51FB3NPo7x88UVg1mZR8bNrUo7pHahcs4KCxzmMG6LRZzbHVStzSMkTiLDOhqt0a
         jUO+vKkz4fmZlZ/7NhmswR7LPPjvSOhxH5Lh2BPyYMf/8fRbAiaZu2HWbaY0wgJ5b0KF
         ktk37wZwxvYD0JTKLELHFSW81nnE+IXFDxemGunMW+gq0G+YhxArsb97kzuLc1iKufxh
         ofPA==
X-Gm-Message-State: AGi0PuZFAKTLhtC3+V/GomjmiBceokwgSqO1llqSbkffJHvtehpFQGxH
        2p0LABgHcqxSVhdnVpXlake1Mw==
X-Google-Smtp-Source: APiQypI+fpzS9tvyIqAt1Qokh+WJel+RnWJGf1A4F99fII+mmjgwfsHSOcutEHEXBR/XlFLHD+fUGA==
X-Received: by 2002:a62:cf81:: with SMTP id b123mr17223856pfg.84.1587404225615;
        Mon, 20 Apr 2020 10:37:05 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id d2sm103669pfc.7.2020.04.20.10.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 10:37:04 -0700 (PDT)
Date:   Mon, 20 Apr 2020 11:37:03 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>, mike.leach@linaro.org,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCHv2] coresight: tmc: Fix TMC mode read in
 tmc_read_prepare_etb()
Message-ID: <20200420173703.GA25885@xps15>
References: <20200416161459.29855-1-saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416161459.29855-1-saiprakash.ranjan@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 09:44:59PM +0530, Sai Prakash Ranjan wrote:
> On some QCOM platforms like SC7180, SDM845 and SM8150,
> reading TMC mode register without proper coresight power
> management can lead to async exceptions like the one in
> the call trace below in tmc_read_prepare_etb(). This can
> happen if the user tries to read the TMC etf data via
> device node without setting up source and the sink first.
> Fix this by having a check for coresight sysfs mode
> before reading TMC mode management register.
> 
>  Kernel panic - not syncing: Asynchronous SError Interrupt
>  CPU: 7 PID: 2605 Comm: hexdump Tainted: G S                5.4.30 #122
>  Call trace:
>   dump_backtrace+0x0/0x188
>   show_stack+0x20/0x2c
>   dump_stack+0xdc/0x144
>   panic+0x168/0x36c
>   panic+0x0/0x36c
>   arm64_serror_panic+0x78/0x84
>   do_serror+0x130/0x138
>   el1_error+0x84/0xf8
>   tmc_read_prepare_etb+0x88/0xb8
>   tmc_open+0x40/0xd8
>   misc_open+0x120/0x158
>   chrdev_open+0xb8/0x1a4
>   do_dentry_open+0x268/0x3a0
>   vfs_open+0x34/0x40
>   path_openat+0x39c/0xdf4
>   do_filp_open+0x90/0x10c
>   do_sys_open+0x150/0x3e8
>   __arm64_compat_sys_openat+0x28/0x34
>   el0_svc_common+0xa8/0x160
>   el0_svc_compat_handler+0x2c/0x38
>   el0_svc_compat+0x8/0x10
> 
> Fixes: 4525412a5046 ("coresight: tmc: making prepare/unprepare functions generic")
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Suggested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Applied - thanks,
Mathieu

> ---
> v2:
>  * Move the TMC mode read under CS_MODE_SYSFS as per Mathieu
> ---
>  drivers/hwtracing/coresight/coresight-tmc-etf.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> index d0cc3985b72a..36cce2bfb744 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> @@ -596,13 +596,6 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
>  		goto out;
>  	}
>  
> -	/* There is no point in reading a TMC in HW FIFO mode */
> -	mode = readl_relaxed(drvdata->base + TMC_MODE);
> -	if (mode != TMC_MODE_CIRCULAR_BUFFER) {
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
>  	/* Don't interfere if operated from Perf */
>  	if (drvdata->mode == CS_MODE_PERF) {
>  		ret = -EINVAL;
> @@ -616,8 +609,15 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
>  	}
>  
>  	/* Disable the TMC if need be */
> -	if (drvdata->mode == CS_MODE_SYSFS)
> +	if (drvdata->mode == CS_MODE_SYSFS) {
> +		/* There is no point in reading a TMC in HW FIFO mode */
> +		mode = readl_relaxed(drvdata->base + TMC_MODE);
> +		if (mode != TMC_MODE_CIRCULAR_BUFFER) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
>  		__tmc_etb_disable_hw(drvdata);
> +	}
>  
>  	drvdata->reading = true;
>  out:
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
