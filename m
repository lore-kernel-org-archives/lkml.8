Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2373FC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5E20206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SeJRcOMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgBUPnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:43:24 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35675 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgBUPnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:43:24 -0500
Received: by mail-wr1-f65.google.com with SMTP id w12so2577466wrt.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TdgQZoYzFfHTGZzoJ00i9pnvONpQW5SeDrs/ilsmT00=;
        b=SeJRcOMNQfp1YCK33Vxody1eFQHvooFc3aOxbrhnjIylgD+1EasJ36ecMI30d4lvXJ
         tFbOsgjuMMH1upUe7MG9/b93+Xu8uHTGEm1D5gsDmwkmRmkNAeOIoLKcwBxPuSV8aJ7h
         Ms3hnu6dnqi1cSACFPr3bhE+qvz3NmVD92i9eVka12Hu/z3PvxTkEMltJ7o4GgJvHK80
         vz86CRyz/atoOBtJG018gxPiZFjvniehVkLHbe0raVqjgbA2CvMllU6O80ZIkuV/FFAb
         fMIDelRJeH3fHbnEbfV/vZGh1lJv9Efe8Sz6wVsmA8X8EZfJBj+PZ1r3pwj+zmidHdYO
         a8Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=TdgQZoYzFfHTGZzoJ00i9pnvONpQW5SeDrs/ilsmT00=;
        b=ucCwScvlzC6lwNCZwE1K0LZFlVguJIf8EVPdchhpuBcYBbSwPyP8kFrNc6Gfj3l0YG
         fgYv5W7+1jXBgKWINeLxF6oD7cAZIjANMmYrCJCE6nHdScs4DIsEDX0odUy9u3Ac2Di3
         sG6UCYUqo28hq571TmOPDIinAvaN3edft0YIbLgoJHlPLdFdB+9tV83PHceA8cGqna+J
         0WUhSPCbjumZEMt9LCcoT99XsOI5VECdt/NLnMuVMx9sTDmBVTg7+4jO0aOL1Kdal3ls
         G49W/EzKUE8dCEB64YhjqE0UhAHB/qz64zxU8qYjNEmPNbDEKUIHW7c0DvnBxeAv4IjP
         a+Pg==
X-Gm-Message-State: APjAAAUetQ1nypVFlPJHawyhqyWzMEXMAkh5TQs+Jvu8NHG91Lq8unAC
        EDD9Qa7BOkrfNol/iPJkuBU4SA==
X-Google-Smtp-Source: APXvYqwaokzBdL5Sy902QAplCeDWKw29jbJ4njjIRsN8Wt1MCzTD3diqBlzSjsr/TGqqT9voteJxTg==
X-Received: by 2002:a5d:5452:: with SMTP id w18mr47054218wrv.333.1582299801751;
        Fri, 21 Feb 2020 07:43:21 -0800 (PST)
Received: from linaro.org ([2a01:e34:ed2f:f020:903b:a048:f296:e3ae])
        by smtp.gmail.com with ESMTPSA id v15sm4646081wrf.7.2020.02.21.07.43.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Feb 2020 07:43:20 -0800 (PST)
Date:   Fri, 21 Feb 2020 16:43:18 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Jasper Korten <jja2000@gmail.com>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 09/17] arm: tegra20: cpuidle: Handle case where
 secondary CPU hangs on entering LP2
Message-ID: <20200221154318.GO10516@linaro.org>
References: <20200212235134.12638-1-digetx@gmail.com>
 <20200212235134.12638-10-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200212235134.12638-10-digetx@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 02:51:26AM +0300, Dmitry Osipenko wrote:
> It is possible that something may go wrong with the secondary CPU, in that
> case it is much nicer to get a dump of the flow-controller state before
> hanging machine.
> 
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Tested-by: Peter Geis <pgwipeout@gmail.com>
> Tested-by: Jasper Korten <jja2000@gmail.com>
> Tested-by: David Heidelberg <david@ixit.cz>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  arch/arm/mach-tegra/cpuidle-tegra20.c | 47 +++++++++++++++++++++++++--
>  1 file changed, 45 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/cpuidle-tegra20.c b/arch/arm/mach-tegra/cpuidle-tegra20.c
> index 9672c619f4bc..bcc158b72e67 100644
> --- a/arch/arm/mach-tegra/cpuidle-tegra20.c
> +++ b/arch/arm/mach-tegra/cpuidle-tegra20.c
> @@ -83,14 +83,57 @@ static inline void tegra20_wake_cpu1_from_reset(void)
>  }
>  #endif
>  
> +static void tegra20_report_cpus_state(void)
> +{
> +	unsigned long cpu, lcpu, csr;
> +
> +	for_each_cpu(lcpu, cpu_possible_mask) {
> +		cpu = cpu_logical_map(lcpu);
> +		csr = flowctrl_read_cpu_csr(cpu);
> +
> +		pr_err("cpu%lu: online=%d flowctrl_csr=0x%08lx\n",
> +		       cpu, cpu_online(lcpu), csr);
> +	}
> +}
> +
> +static int tegra20_wait_for_secondary_cpu_parking(void)
> +{
> +	unsigned int retries = 3;
> +
> +	while (retries--) {
> +		ktime_t timeout = ktime_add_ms(ktime_get(), 500);

Oops I missed this one. Do not use ktime_get() in this code path, use jiffies.

> +
> +		/*
> +		 * The primary CPU0 core shall wait for the secondaries
> +		 * shutdown in order to power-off CPU's cluster safely.
> +		 * The timeout value depends on the current CPU frequency,
> +		 * it takes about 40-150us  in average and over 1000us in
> +		 * a worst case scenario.
> +		 */
> +		do {
> +			if (tegra_cpu_rail_off_ready())
> +				return 0;
> +
> +		} while (ktime_before(ktime_get(), timeout));

So this loop will aggresively call tegra_cpu_rail_off_ready() and retry 3
times. The tegra_cpu_rail_off_ready() function can be called thoushand of times
here but the function will hang 1.5s :/

I suggest something like:

	while (retries--i && !tegra_cpu_rail_off_ready()) 
		udelay(100);

So <retries> calls to tegra_cpu_rail_off_ready() and 100us x <retries> maximum
impact.

> +		pr_err("secondary CPU taking too long to park\n");
> +
> +		tegra20_report_cpus_state();
> +	}
> +
> +	pr_err("timed out waiting secondaries to park\n");
> +
> +	return -ETIMEDOUT;
> +}
> +
>  static bool tegra20_cpu_cluster_power_down(struct cpuidle_device *dev,
>  					   struct cpuidle_driver *drv,
>  					   int index)
>  {
>  	bool ret;
>  
> -	while (!tegra_cpu_rail_off_ready())
> -		cpu_relax();
> +	if (tegra20_wait_for_secondary_cpu_parking())
> +		return false;
>  
>  	ret = !tegra_pm_enter_lp2();
>  
> -- 
> 2.24.0
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
