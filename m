Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E926C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 05:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E0E206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 05:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SafJSNqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgHDFZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 01:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgHDFZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 01:25:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C94C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 22:25:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m8so12698806pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 22:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VyvJTV65QYrZba9SIfzf3Qah/NqVWDrTLrkNojuqHV0=;
        b=SafJSNqu2HzopBQNzSMzXgtQyoN95IoHlxuM48onRYrNr0jx5X5Yx4nbz7n1qxZTaz
         BBLmwCHy6ILOfFAj4CVMMmylSVMacwrWKkcJQHwIk7vN5K3c9K4FBhLNWH2UDK0qjPuR
         YGUpqI6YFRmyyfYhhfJDeZht6Y+jZjY7iT5DkLaaNJe5xOHeoArcGLnKyrwUVYgWgrzO
         j1kh4lVdzME9oNVocVV+RTxxFppvbtEuHgVfDLkCKZT8qhtbHe7/vfLu2r0h/KLji4uj
         RI5P+HSeGJFYjBdWLInTEPaOTXwpLsJZ2dkncuYuY/PF5XAQYjUlZEzY0oCevMx0Arni
         uAoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VyvJTV65QYrZba9SIfzf3Qah/NqVWDrTLrkNojuqHV0=;
        b=sm+pveNm/3mpfe3fW2KmQkGwxOcYtq1OQQdjK01INUgj8nogeLR3J2ZM5kAVuhXGJS
         PWUbnErkR0Y2FKDMQpSWJfvsj/3AxLxML8Q/X1zWNkLGUvPzcliYJvkCzOFEsJ8E03sr
         KZ7TeuSUWQISkybFHGmP1Lpt82F3d6COXfjSlqBw3zHEBj897gznIBoFybIqU3vePXjR
         1sBKMKMGP3HGu5tU2mpkwfz/hkYL0RywgkhmeBpSTJqheD2wJLJM6JgzrpqN1mPLldgX
         SIJk9iBqVGvXa4TZ40Ouj6Fji72HZEz+7eNtx2mfyQ98omA7KVwd0/YD4hkq8ncNYBwm
         5mFA==
X-Gm-Message-State: AOAM533f8Ed19OCCdkmNg7qnIeAD+dpQmdX+Wih2ISli5rcouG4vtLWP
        kY5vpStn2Eh51UyWhYuAIwL/YQ==
X-Google-Smtp-Source: ABdhPJzQBa7GAz/BaRtEtdELU/h9ZsuAAyasELfzNQnsQprm5zGlYxyfDe3Uz3t1K1kJ/+YPjsWlhg==
X-Received: by 2002:a63:5d11:: with SMTP id r17mr17546649pgb.146.1596518713836;
        Mon, 03 Aug 2020 22:25:13 -0700 (PDT)
Received: from localhost ([122.162.244.227])
        by smtp.gmail.com with ESMTPSA id v11sm19518479pgs.22.2020.08.03.22.25.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Aug 2020 22:25:12 -0700 (PDT)
Date:   Tue, 4 Aug 2020 10:55:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: tegra186: Fix initial frequency
Message-ID: <20200804052509.24en7voy2bg6vdbc@vireshk-mac-ubuntu>
References: <20200712100645.13927-1-jonathanh@nvidia.com>
 <20200713032554.cykywnygxln6ukrl@vireshk-i7>
 <3d6091f2-6b04-185f-6c23-e39a34b87877@nvidia.com>
 <20200714034635.2zdv3wzmftjg2t4a@vireshk-i7>
 <8c6d3c32-c142-3981-3a52-6560e885f4c9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c6d3c32-c142-3981-3a52-6560e885f4c9@nvidia.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-07-20, 13:14, Jon Hunter wrote:
> I have been doing some more testing on Tegra, I noticed that when
> reading the current CPU frequency via the sysfs scaling_cur_freq entry,
> this always returns the cached value (at least for Tegra). Looking at
> the implementation of scaling_cur_freq I see ...
> 
> static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
> {
>         ssize_t ret; 
>         unsigned int freq;
> 
>         freq = arch_freq_get_on_cpu(policy->cpu);
>         if (freq)
>                 ret = sprintf(buf, "%u\n", freq);
>         else if (cpufreq_driver && cpufreq_driver->setpolicy &&
>                         cpufreq_driver->get)
>                 ret = sprintf(buf, "%u\n", cpufreq_driver->get(policy->cpu));
>         else
>                 ret = sprintf(buf, "%u\n", policy->cur);
>         return ret; 
> }
> 
> The various Tegra CPU frequency drivers do not implement the
> set_policy callback and hence why we always get the cached value. I
> see the following commit added this and before it simply return the
> cached value ...
> 
> commit c034b02e213d271b98c45c4a7b54af8f69aaac1e
> Author: Dirk Brandewie <dirk.j.brandewie@intel.com>
> Date:   Mon Oct 13 08:37:40 2014 -0700
> 
>     cpufreq: expose scaling_cur_freq sysfs file for set_policy() drivers
> 
> Is this intentional? 

Yes, it is.

There are two sysfs files to read the current frequency.

- scaling_cur_freq: as you noticed it returns cached value unless it is for
  setpolicy drivers in whose case cpufreq core doesn't control the frequency and
  so doesn't cache any values.

- cpuinfo_cur_freq: This will return the value as read from hardware using
  ->get() callback.

-- 
viresh
