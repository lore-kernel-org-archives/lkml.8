Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE45C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 15:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BCBE2072E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 15:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RLQMtHCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbgAKPEl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 10:04:41 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:43316 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729696AbgAKPEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 10:04:41 -0500
Received: by mail-qk1-f173.google.com with SMTP id t129so4691191qke.10
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 07:04:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=e3u7855YGTuTS0G9vUP2P2YyQn90Lt0/N4vk5NW5nI8=;
        b=RLQMtHCLn4iD0P2FZ5WC9N2RjIJt8BXb55XP64ezkM7jWglt42N6v5ydLKd0VNxm/j
         hIsgxc9YgVWrl19K+HezdGZzpzGDjvK9yOT/GFX4HM+nPgJ8qcaWo4QEWcI7goLvQ4t3
         jzyspzEHQukpPACzg48lt4BHgqj0u7Z8nhFn80GQUlFuH0mcVs9XDl048NzI00EXeWkw
         ZJ1GRW1tvn1JB6a6BOlxFXImBTOnyZSN2+EUiSTVaDftgSgixkAaTGLFsMsgiUs0eqCF
         vdDbnk3UZUFJ/72BeicjaZA4DkJPjF9IEjFQ0gvQE/6UI6uwblLbIvzrwTAf4EHB4hwB
         p1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=e3u7855YGTuTS0G9vUP2P2YyQn90Lt0/N4vk5NW5nI8=;
        b=YA7xwRzuiGeueIQ7+JjX6yNvTK1fLQAO8ocFK06NExfTf6TrvIEmZZ5504aKKdw2uW
         AqqBSUsFGOvuo092Td/Lvtia9gjbmqRkI32YAVeLGOn52/4sKeqBZbH8vq+gVayzD3pr
         it4GTk4QQIBS+n5lyiZ2gaTtCM/Q5Hj9BCi82BB04kl4X5lm4fam7j9bwvvLQ4ZawDjs
         Qu8WKB7rXBX41CtIVo0qeg9PMGFtieG8hw7Gnwb55Yr7HN1WWRSnpHsYZ2eU06nOuTpW
         fPJt4cDUEI08ExmCsi8M0g9eyAv4fA5LWZUYWw1tSq5HnWlU1/eCJyZUQyixzjlbAjbe
         m9uQ==
X-Gm-Message-State: APjAAAU3Qh0UtvmwKEgfRrEAx5ZXp9PIvnTcJiwcZk+umxp1LZDwfoLY
        l2AO3ekxP2mqdrMp+WKGG8dpkw==
X-Google-Smtp-Source: APXvYqxSy16KDNpJnuF6E0AMVMCXjrKMKMn7b/ZnU/Ka0xredmDk0lEip+L7BnMbzrAcw+H5mJXN4A==
X-Received: by 2002:a05:620a:2013:: with SMTP id c19mr3686805qka.496.1578755078568;
        Sat, 11 Jan 2020 07:04:38 -0800 (PST)
Received: from [192.168.1.169] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id x6sm2391010qkh.20.2020.01.11.07.04.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Jan 2020 07:04:37 -0800 (PST)
Subject: Re: [Patch v6 0/7] Introduce Thermal Pressure
To:     Peter Zijlstra <peterz@infradead.org>
References: <1576123908-12105-1-git-send-email-thara.gopinath@linaro.org>
 <20191216145624.GU2844@hirez.programming.kicks-ass.net>
Cc:     mingo@redhat.com, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, rui.zhang@intel.com,
        qperret@google.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        amit.kucheria@verdurent.com
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5E19E404.1020601@linaro.org>
Date:   Sat, 11 Jan 2020 10:04:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <20191216145624.GU2844@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16/2019 09:56 AM, Peter Zijlstra wrote:
> On Wed, Dec 11, 2019 at 11:11:41PM -0500, Thara Gopinath wrote:
>> Test Results
>>
>> Hackbench: 1 group , 30000 loops, 10 runs
>>                                                Result         SD
>>                                                (Secs)     (% of mean)
>>  No Thermal Pressure                            14.03       2.69%
>>  Thermal Pressure PELT Algo. Decay : 32 ms      13.29       0.56%
>>  Thermal Pressure PELT Algo. Decay : 64 ms      12.57       1.56%
>>  Thermal Pressure PELT Algo. Decay : 128 ms     12.71       1.04%
>>  Thermal Pressure PELT Algo. Decay : 256 ms     12.29       1.42%
>>  Thermal Pressure PELT Algo. Decay : 512 ms     12.42       1.15%
>>
>> Dhrystone Run Time  : 20 threads, 3000 MLOOPS
>>                                                  Result      SD
>>                                                  (Secs)    (% of mean)
>>  No Thermal Pressure                              9.452      4.49%
>>  Thermal Pressure PELT Algo. Decay : 32 ms        8.793      5.30%
>>  Thermal Pressure PELT Algo. Decay : 64 ms        8.981      5.29%
>>  Thermal Pressure PELT Algo. Decay : 128 ms       8.647      6.62%
>>  Thermal Pressure PELT Algo. Decay : 256 ms       8.774      6.45%
>>  Thermal Pressure PELT Algo. Decay : 512 ms       8.603      5.41%
> 
> What is the conclusion, if any from these results? Clearly thermal
> pressuse seems to help, but what window? ISTR we default to 32ms, which
> is a wash for drystone, but sub-optimal for hackbench.
Hi Peter,

Thanks for the reviews. IMHO, the conclusion is that thermal pressure is
beneficial but the decay period to be used depends on the architecture
and/or use-cases. Sticking to 32ms should give some improvement but it
can be tuned depending on the system.

> 
> 
> Anyway, the patches look more or less acceptible, just a bunch of nits,
> the biggest being the fact that even if an architecture does not support
> this there is still the code and runtime overhead.

I am fixing this and sending out a v7.

> 


-- 
Warm Regards
Thara
