Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C2DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF645207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SeqgTILR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgFSF5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 01:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgFSF5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 01:57:22 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A5CC0613EE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 22:57:20 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x207so3961334pfc.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 22:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vcoQU27veVgPOWd/0ckYZko/pX3wgLDFO82QmujnsUA=;
        b=SeqgTILRIJeeuWL+GE8nzrMopFxDyt/JNfmF486iyq/55jNuqxsAccNrdbdv5opOMj
         Cw3qYunXuIDd2VY5NGlEYPyiPM5XwZWEw+5l3uJLNtxvWG1elDUCcYsOPc2UxKlRwYrw
         drbAtdpy+YOPGGvUXO82Awgd2CBAexIBU9UcOB/8//phJB+1c75Y1uTodsEU8C7K+xUI
         an2BavnQWXoR/ffmARliRtdQvl1tPNNi/FcyC+2jopBNGa3IQqAbRHsryYEzw+Cj1k9G
         i1kVlE4RhUlf/I1Y+/7pWnhZpu7snhTdgbAlx9LJVQFuD2oToJygoSduU/Q8mlkfL1Fx
         55bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vcoQU27veVgPOWd/0ckYZko/pX3wgLDFO82QmujnsUA=;
        b=JatiWiQj4VSGpW+V5+N7LZbLQBVzwTxMLIFTCwZzEJ2nPE8STc/+U1jT9DyAnsuRQc
         FrwNdl+pndoM95v3bgv+fnxzvbt30ZJbcP9TnIMkhXB8vw8i/AbEuny4QeMmrgEBOw23
         R7jsbLBLyxpO86h5V9uWIhoenbbHfhDPOTr46ODFQAwG6/mMrQVkNzYxccWtnStOOnIS
         j9M4pqDNEbp5Okm4H0AeiEKv0QgnQsPF2LwXWE3x+t21XccojXt34Nrl0Q7JICJOte+8
         ei4xtLm/uJ7CGeRwexWnI26bjqmEHBPIcnvVStQs7QB10+eSj5HMeVVfXGPe+JxtOt3n
         ckIw==
X-Gm-Message-State: AOAM532qajmCNmnUnTG08vbE0p3G5DHyqQA44NeMdrTezsFXhdE8kJPK
        23y1yzUI1r5pAOFps9WNkXZMfw==
X-Google-Smtp-Source: ABdhPJz4MRK3ifLZfCXFaqSI4lm/LqkedTNZlXh7gAgSS7T865nY3qUJX8dSsfHTyUTvLewIMd3iRA==
X-Received: by 2002:a63:1f0e:: with SMTP id f14mr1559154pgf.405.1592546240182;
        Thu, 18 Jun 2020 22:57:20 -0700 (PDT)
Received: from localhost ([122.172.119.132])
        by smtp.gmail.com with ESMTPSA id j130sm3859861pgc.75.2020.06.18.22.57.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 22:57:19 -0700 (PDT)
Date:   Fri, 19 Jun 2020 11:27:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Finley Xiao <finley.xiao@rock-chips.com>
Cc:     xf@rock-chips.com, heiko@sntech.de, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, javi.merino@kernel.org,
        rui.zhang@intel.com, amit.kucheria@verdurent.com,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, huangtao@rock-chips.com,
        tony.xie@rock-chips.com, cl@rock-chips.com
Subject: Re: [PATCH] thermal/drivers/cpufreq_cooling: Fix wrong frequency
 converted from power
Message-ID: <20200619055717.egfs23qywj4kmjok@vireshk-i7>
References: <20200619015126.15002-1-finley.xiao@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619015126.15002-1-finley.xiao@rock-chips.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-20, 09:51, Finley Xiao wrote:
> The function cpu_power_to_freq is used to find a frequency and set the
> cooling device to consume at most the power to be converted. For example,
> if the power to be converted is 80mW, and the em table is as follow.
> struct em_cap_state table[] = {
> 	/* KHz     mW */
> 	{ 1008000, 36, 0 },
> 	{ 1200000, 49, 0 },
> 	{ 1296000, 59, 0 },
> 	{ 1416000, 72, 0 },
> 	{ 1512000, 86, 0 },
> };
> The target frequency should be 1416000KHz, not 1512000KHz.
> 

Cc: v4.13+ <stable@vger.kernel.org> # v4.13+

> Fixes: 349d39dc5739 ("thermal: cpu_cooling: merge frequency and power tables")
> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
> ---
>  drivers/thermal/cpufreq_cooling.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index 9e124020519f..6c0e1b053126 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -123,12 +123,12 @@ static u32 cpu_power_to_freq(struct cpufreq_cooling_device *cpufreq_cdev,
>  {
>  	int i;
>  
> -	for (i = cpufreq_cdev->max_level - 1; i >= 0; i--) {
> -		if (power > cpufreq_cdev->em->table[i].power)
> +	for (i = cpufreq_cdev->max_level; i >= 0; i--) {
> +		if (power >= cpufreq_cdev->em->table[i].power)
>  			break;
>  	}
>  
> -	return cpufreq_cdev->em->table[i + 1].frequency;
> +	return cpufreq_cdev->em->table[i].frequency;
>  }

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
