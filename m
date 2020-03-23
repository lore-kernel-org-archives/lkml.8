Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2CFC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 03:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B5F206F8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 03:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oy7AW0C4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgCWDRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 23:17:38 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41660 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727145AbgCWDRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 23:17:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id b1so6462259pgm.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 20:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S4TZKS6d2y1eHYS1jppzyvKAfOVpYJMMu/Ehs0CdOMQ=;
        b=oy7AW0C4+1A9gMD6L/aMJGFCcFb+ub8nHaXwstcdSZj5UK6Y9WQ+dSQInkxvWPGAPd
         atYUGcC2fqdoRJ5YsVK179OZ8nyM4/echB2BWEutHssW5MMyq+XlnYsUpmOhpLTqfDe0
         nZdhu3YAprzsDcw9cwUm4ew/BH48l3O8LeP5Z98f/MBoKh9wzaJAVlX81QDORw+nHcly
         oD8AtOmIWuqEKOsIQjTVUuvkn8DmmB9MmBjHGq26desmsW8C2XiUVKTM9o8W2INzwbNI
         9ywlGUZukQU4tME2lDsrM9IwxRuRXqyaj/L/y08Dom3IA9VSqBYnFVfekVnEPpbR4srm
         wnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S4TZKS6d2y1eHYS1jppzyvKAfOVpYJMMu/Ehs0CdOMQ=;
        b=IYn2WEjJG4SfC7+CF7I+kFkLLqZR1ILyC5YWa+z7mKEUpSEnWeVt2qxDYttk9WT2dS
         kqFJMDSyAplrJnluIQXu06VDOvxvRJjEm8br3B5k6YlZZIWwNLaGGuPtqDSmwYfmgB+S
         DB3xoCHSeK2+asvbHSPpFc8jc7cq9yP6sFGTiyiWsatzW1VfMX8sVVv5Zu+whCGBJRPm
         8w/DP6vv73W/b2/r3EKv3en7FHH+W6uhJDUHrR/0aJitLPBOr0xCidEZk6k/nEY9+ME4
         OKU09YrWuAjak63e/w/SlEZsJSIukh6Xrrq2aZRK4yHO4LjgmS6m7/a+Rnyope74bnKv
         ifsw==
X-Gm-Message-State: ANhLgQ0vO5/VM5pafkDUhoHSgdp8VxdCEFyF4DrETYzgY92BoXISRd8I
        s2ax5AJ+Z+7I4iTnoH/I2Gvwqw==
X-Google-Smtp-Source: ADFU+vves3/aQr7oLsJhGchZWXzKMdM3mh+P/th94kW7rLjU1R6jxUU6OV6sQnzpH/J+h5YTyQdu4g==
X-Received: by 2002:aa7:988f:: with SMTP id r15mr22672571pfl.252.1584933455399;
        Sun, 22 Mar 2020 20:17:35 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id i4sm2741719pjg.4.2020.03.22.20.17.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Mar 2020 20:17:34 -0700 (PDT)
Date:   Mon, 23 Mar 2020 08:47:24 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Willy Wolff <willy.mh.wolff.ml@gmail.com>
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J.Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] thermal/drivers/cpufreq_cooling: Fix return of
 cpufreq_set_cur_state
Message-ID: <20200323031724.xnbr6wmbzwpwutn4@vireshk-i7>
References: <20200321092740.7vvwfxsebcrznydh@macmini.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321092740.7vvwfxsebcrznydh@macmini.local>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-20, 09:27, Willy Wolff wrote:
> The function freq_qos_update_request returns 0 or 1 describing update
> effectiveness, and a negative error code on failure. However,
> cpufreq_set_cur_state returns 0 on success or an error code otherwise.
> 
> Signed-off-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
> ---
>  drivers/thermal/cpufreq_cooling.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index fe83d7a210d4..af55ac08e1bd 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -431,6 +431,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>  				 unsigned long state)
>  {
>  	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
> +	int ret;
>  
>  	/* Request state should be less than max_level */
>  	if (WARN_ON(state > cpufreq_cdev->max_level))
> @@ -442,8 +443,9 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>  
>  	cpufreq_cdev->cpufreq_state = state;
>  
> -	return freq_qos_update_request(&cpufreq_cdev->qos_req,
> -				get_state_freq(cpufreq_cdev, state));
> +	ret = freq_qos_update_request(&cpufreq_cdev->qos_req,
> +				      get_state_freq(cpufreq_cdev, state));
> +	return ret < 0 ? ret : 0;
>  }
>  
>  /* Bind cpufreq callbacks to thermal cooling device ops */

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
