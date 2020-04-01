Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E75C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CDF92078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S3CneriJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731951AbgDAKkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:40:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:32889 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgDAKkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:40:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id d17so11937339pgo.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 03:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HA+H7swzhefkPfk6R1gtpHINU9Ey2LI3psCTRPqaPR0=;
        b=S3CneriJLVSt5R+rdBCFatEshwxsVhUhuAHdGmTBJ7WSS1EL5SCBmF84JBC4+JsGjp
         WgvJB2p53uGo2uTxl8omyZ6lZKT4hivBCEfIdoWXi2q4WpA7x3r70EkBkLGozbU+uMv7
         1Xbw1ywiMnR64mg26HKJmvU97vZOFEq61bvMBwmmcR7uy0XdIRrCEEraog4Mc7nbgTxL
         MrEjo+JN7uJyNdPB+Ahv6sGMc1/IvXIpoGAUaV3aFihi6W/DwHwLAJBnCZwcZ7Iu+6OQ
         JdSqXkNI1a0407mRqt/aqmrat+LiM8HXj35CJjADPUclaAkY9IiXlTQdrafXbYQosNP1
         wU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HA+H7swzhefkPfk6R1gtpHINU9Ey2LI3psCTRPqaPR0=;
        b=BIMNEfQSAcmHqQsMQ5+6Cq3v1TC/rHYF5R/Zi6wXc+bzcFOFnTIli3gOVS9Q1Hkido
         DM/KAlAR/rjW8oa4e32M0IAgO2TuMxr0yHsZ+Yh74a4hWwLzSRLnh94Nvk5AL5P+t9qX
         hNi086nCAvuwohfmpEf8VxyLXsePUbaKjHeBkRYxN1brChpfu10a10ZRY56h6y5pHX36
         N9G62QuDuMhx4+IhumeORHqb7++XNlhNCBhVlk4nB7E8o85GVMr5sB1P4NbMh73UIWX1
         bcd1ECWWh5BFMA55G0KkhoiFnAawVPRuiDhcoIEhrGL8YNnzoqB6EB2zQeY6LohuyjGP
         G1pw==
X-Gm-Message-State: ANhLgQ1S+w3ce9VbiZHmwkfKFt4wmbNDZWuQ+Od4iOErIW/K2QdFPv/Q
        EY739/d6FUOh8MWo0/eEzVHI6w==
X-Google-Smtp-Source: ADFU+vsmg7f+/yXDon1aHVn1vjyaqEQgtyF6ylBpqg7NrT+7Yr8EnfUJhrYGhh8W/xCpSwtIfWo6OA==
X-Received: by 2002:a63:6346:: with SMTP id x67mr21515451pgb.67.1585737650080;
        Wed, 01 Apr 2020 03:40:50 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id o5sm1141432pgm.70.2020.04.01.03.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 03:40:48 -0700 (PDT)
Date:   Wed, 1 Apr 2020 16:10:46 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [sched/fair] 3c29e651e1: hackbench.throughput -15.2% regression
Message-ID: <20200401104046.5f3aou6fvyw4x3ej@vireshk-i7>
References: <20200205122902.GL12867@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205122902.GL12867@shao2-debian>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for getting back to this after a long time :(

On 05-02-20, 20:29, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed a -15.2% regression of hackbench.throughput due to commit:
> 
> 
> commit: 3c29e651e16dd3b3179cfb2d055ee9538e37515c ("sched/fair: Fall back to sched-idle CPU if idle CPU isn't found")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> in testcase: hackbench
> on test machine: 16 threads Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz with 32G memory
> with following parameters:
> 
> 	nr_threads: 100%
> 	mode: threads
> 	ipc: pipe
> 	cpufreq_governor: performance
> 	ucode: 0xca

I tried following command on my x86 box, skylake, 8 CPUs 

"/usr/bin/hackbench" "-g" "8" "--threads" "--pipe" "-l" "30000" "-s" "100"

And hackbench mostly reports values from 29.4 to 30.7, with and without my
patches. I used intel_pstate=passive in command line and chose performance
governor by default.

I don't see any issues here in hackbench numbers because of my patches.

-- 
viresh
