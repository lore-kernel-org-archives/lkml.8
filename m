Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E3BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB7F320775
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JYERXkm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgGQKOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgGQKOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 06:14:44 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FCAC061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 03:14:43 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so10415906wrw.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 03:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Xh3Vxkdsr0MyJ/eAAV4ggDyTqQu6gdpUTSt74caMCHs=;
        b=JYERXkm4Qw/HVt3Pj/KgAUwtyADNyEsXB/PW5FtfA/vr6iy9YbEY1vAbfC+fT+5KRb
         HrvgEhhawP1lxPJO7x17+2Qc/FKuJ46iDrD3RxIi28/MpdLTzkbsgFXFTWevtm5WDN19
         GqAgAeGvSoOEFQrWRMVplSCvZwJXkdr9r2XiJ+TsF/qHEZRiUP34l9QjZIUSSzpSG7G8
         iqtwF0s6vrpdXp4PBJAjS2HI2ch0Mw/hs9xEd8Hs7JaEc9bKp1QsRBP4PFqg+IRLB54h
         Br03Mpm7QWiXgPNXUuZ/0wTHeeh7o8n/YJQfM9oTFbnkojDu4MsSpVNUx+h2bF33S1Dp
         4VWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xh3Vxkdsr0MyJ/eAAV4ggDyTqQu6gdpUTSt74caMCHs=;
        b=i4HKycUlIsrLnAgNJ57hMDWT80EeG45F/Jre1kS6bTIiaz77FuahaWeGachr6TNiMk
         61Xa6RW5jSfQquobQhiX9g5yzB0K7QT3Y/1CzFTM4we1lBg4zRHlwwjXQQYQDIP1w7vA
         23YECyIE37zh9KxqHWZpJF8gQuZPT0H3EPYL7pl56Ny/KHumdunOLgfcpHt5q6g6BEbg
         V9S23YoD+BZsB8dQSNVHK2vop/ieM2ahfxu9a+PIMvqhXlPcIOQWiZmjjQtIrcj4bbjM
         oS+UUDWmOhEWuWAmxwssGbr2BLMAT1ImHnmLSQZf8en2ggOuhY2Mhc/T34jiXH5jEHqn
         qFYQ==
X-Gm-Message-State: AOAM533+DHAkycNGL6/HxWU1ruOsvniPXYDTAwA2dfbys/9tjO/zbH61
        cWlZ7i5zSzauCL2Y3QgZqVS9Cw==
X-Google-Smtp-Source: ABdhPJz6FzNIPoIfukBqgWC7eOcb/Ay4WFWUuo+opSOW8RW7fY0peptEpWNkrYiQHZICrW22gyIn+g==
X-Received: by 2002:adf:ef4d:: with SMTP id c13mr9310959wrp.315.1594980882326;
        Fri, 17 Jul 2020 03:14:42 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id l67sm14870048wml.13.2020.07.17.03.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 03:14:41 -0700 (PDT)
Date:   Fri, 17 Jul 2020 11:14:38 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        linux-kernel@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/2] thermal: cpufreq_cooling: Reuse effective_cpu_util()
Message-ID: <20200717101438.GA2366103@google.com>
References: <cover.1594707424.git.viresh.kumar@linaro.org>
 <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 Jul 2020 at 12:06:53 (+0530), Viresh Kumar wrote:
>  /**
> - * get_load() - get load for a cpu since last updated
> + * get_load() - get current load for a cpu
>   * @cpufreq_cdev:	&struct cpufreq_cooling_device for this cpu
>   * @cpu:	cpu number
> - * @cpu_idx:	index of the cpu in time_in_idle*
> + * @cpu_idx:	index of the cpu
>   *
> - * Return: The average load of cpu @cpu in percentage since this
> - * function was last called.
> + * Return: The current load of cpu @cpu in percentage.
>   */
>  static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
>  		    int cpu_idx)
>  {
> -	u32 load;
> -	u64 now, now_idle, delta_time, delta_idle;
> -	struct time_in_idle *idle_time = &cpufreq_cdev->idle_time[cpu_idx];
> -
> -	now_idle = get_cpu_idle_time(cpu, &now, 0);
> -	delta_idle = now_idle - idle_time->time;
> -	delta_time = now - idle_time->timestamp;
> +	unsigned long util = cpu_util_cfs(cpu_rq(cpu));
> +	unsigned long max = arch_scale_cpu_capacity(cpu);

Should we subtract the thermal PELT signal from max? I'm worried that
if we don't do that, the load computed in this function will look
artificially small when IPA is capping the max freq, and that we'll
enter a weird oscillating state due to the cyclic dependency here.

Thoughts?

>  
> -	if (delta_time <= delta_idle)
> -		load = 0;
> -	else
> -		load = div64_u64(100 * (delta_time - delta_idle), delta_time);
> -
> -	idle_time->time = now_idle;
> -	idle_time->timestamp = now;
> -
> -	return load;
> +	util = effective_cpu_util(cpu, util, max, ENERGY_UTIL, NULL);
> +	return (util * 100) / max;
>  }


Thanks,
Quentin
