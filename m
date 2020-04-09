Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF021C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802D82072F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 21:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eOnlc6ti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgDIVrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 17:47:35 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40541 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726676AbgDIVrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 17:47:35 -0400
Received: by mail-pj1-f68.google.com with SMTP id kx8so25919pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 14:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lPCa+kwYaSTiQed9UmMr59x22XsKDt6YMkuWg/hzKmw=;
        b=eOnlc6tiiPSQvYszeyVQ4n4SzBfHcYu40t0qYtRtDrBWYFlUZg6bbIAYR/nQkPMaYK
         MSQ8kj1bixUBOJMQH92dTYMfKBBQkHlBEKI4pSbEMGXWjcLfeIiS/5m0y/t4fKzl0n69
         1Wwe4LAlIXVamGBdfe4LeI0IlNRhEx1XLjdDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lPCa+kwYaSTiQed9UmMr59x22XsKDt6YMkuWg/hzKmw=;
        b=lI6v5mtkrnIjAF4cVr2ojLeoOjfwdZBAU3w/L+pNxRxZ9pJS0O/cPUeN2SS63Tozmc
         MYhbW+O8lnLD07HeGk2dNAJUywBK/nX0Lhiyrw0JZg/6ngtamyrLYpC1DXyS3ZDf97lE
         J1MtnrQFJT+UqopDZ1vFGyAiN8V0NNrkyoYzzihs+K6fnIfbFGpPO3eP9POOYZiJVHm4
         ngbPGFtYXMpiRPO8IqiIFTZ1koIVgou3EgVCaRHkbCOzoMRgxTA9KNnSLTE5Nehkzvqv
         8yxrQlkDb63MoJLu0L8ld1AeuMyF3WBNYlsrWh5JbA0E9mXLbB931ZfGLS3d26VVDD1p
         k9bw==
X-Gm-Message-State: AGi0PuZmSemKFObmKOv1KTXYIfRqCanF+fkp0vuxfDQ2QLzVANqUjWwR
        tNkGHLEh0kgQAGCaDH5s58618w==
X-Google-Smtp-Source: APiQypLlzrkprPFi5xjYKzsE8uROImMIRdIrgjfjkMD9eE0dGcKdBuaRZ1ScOKTSsUVHyNQD+ecxPQ==
X-Received: by 2002:a17:90a:9742:: with SMTP id i2mr1744697pjw.194.1586468855475;
        Thu, 09 Apr 2020 14:47:35 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id a1sm46284pfl.188.2020.04.09.14.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 14:47:34 -0700 (PDT)
Date:   Thu, 9 Apr 2020 14:47:34 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
Subject: Re: [PATCH 1/7] venus: core: Add missing mutex destroy
Message-ID: <20200409214734.GV199755@google.com>
References: <20200408213330.27665-1-stanimir.varbanov@linaro.org>
 <20200408213330.27665-2-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200408213330.27665-2-stanimir.varbanov@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanimir,

On Thu, Apr 09, 2020 at 12:33:24AM +0300, Stanimir Varbanov wrote:
> This adds missing mutex_destroy in remove method of venus core driver.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 4395cb96fb04..f8b9a732bc65 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -335,6 +335,7 @@ static int venus_remove(struct platform_device *pdev)
>  
>  	v4l2_device_unregister(&core->v4l2_dev);
>  	mutex_destroy(&core->pm_lock);
> +	mutex_destroy(&core->lock);
>  
>  	return ret;
>  }

On which tree is this series based? From the context it seems that the
tree includes the patch "venus: vdec: Use pmruntime autosuspend"
(https://lore.kernel.org/patchwork/patch/1187829/), however I can not
find this patch in any of the branches of your git tree
(https://git.linuxtv.org/svarbanov/media_tree.git/)

Am I looking in the wrong place?
