Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF26C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 03:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC3220812
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 03:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W4hMfPJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgEVDzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 23:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgEVDzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 23:55:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0264BC05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 20:55:02 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id n15so4581939pfd.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 20:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PSjZv6hMwQjMojNQQS4MHSvgmHUyEQAFuzP+PCP7cnc=;
        b=W4hMfPJGCUl0d8jXGTcwwrAShMZXxwEccV2lgEyOsuCK5AmEMMgnIimLUgHgk8cgZ7
         lsff+nI0UY4maKlGBKDN75w1WBoPMRVqh1Sf5mBa9vOSQMICvx2f/5Mh0AZjOid1EeNa
         dNfQ1z6/MvLcin/aWO51Lp6huScSjp2jjESfqiwvMy+ts5rm372z3yYkjSiu89SNCkv1
         AlOjZ6dVooX0IS65DYvQpUxq6dDkRdet7NR0dcpr4mh45kTNhrKVTzRRU1Aglf22H7qu
         MZ0JZHQPOEWvE1Z68VL1hGBb1IhE6frk6+Q8nLulinbvHZvW33/1eqaky90h9C77QUNd
         /UxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PSjZv6hMwQjMojNQQS4MHSvgmHUyEQAFuzP+PCP7cnc=;
        b=RUOpVCCyDrfZYRm7VC2LN3PGcudedV9B9VGKf2bIC3/+PQEYRt66mm6Tswxjm7Ktbd
         /ZpwD0sfnLmS+Gsm7aUUVjRTIc3pl9NnyBgLznA/l+zxtZ+dVyyA367acSWcZAEGwRd3
         ONgDBHwSx3+1h9L50i8Fe+7f8/0t8rLMHc7LAjx/BIwfdAIUl7Ivbz0UnxCHpVgslJG+
         PAPbz610RGNnVl8wTt4IND5soNHJ+hDpWEdRXbMDw48D1QPFYrW2xYQXR0PcgziotVn7
         T9TOundBBThpR1XTKkA9n9MvbK/9k99/JzJf7ZFFYkd9XORT9F5p8F0sUBT9hl/SB7/w
         JmhA==
X-Gm-Message-State: AOAM532KjACDrXViRrKflYVn2EtxTmfklvXMytXEoRiKzPsKiBQngJVC
        uk25p6Q8EYFif1zDYwPby9dJpmQ8//w=
X-Google-Smtp-Source: ABdhPJzvoI8fipE/2LLkGIWv6z+dDxSCcscu17AFF749PdM6mLlVTjAPrySKvm7P37hKgW1z4g+qpQ==
X-Received: by 2002:a17:90a:ba18:: with SMTP id s24mr2224111pjr.192.1590119701457;
        Thu, 21 May 2020 20:55:01 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id s16sm653599pfd.84.2020.05.21.20.55.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 May 2020 20:55:00 -0700 (PDT)
Date:   Fri, 22 May 2020 09:24:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     rjw@rjwysocki.net, Souvik.Chakravarty@arm.com,
        Thanu.Rangarajan@arm.com, Sudeep.Holla@arm.com,
        guohanjun@huawei.com, john.garry@huawei.com,
        jonathan.cameron@huawei.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] add SW BOOST support for CPPC
Message-ID: <20200522035455.ahyajbv2taryqnj4@vireshk-i7>
References: <1590118476-28742-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590118476-28742-1-git-send-email-wangxiongfeng2@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-05-20, 11:34, Xiongfeng Wang wrote:
> ACPI spec 6.2 section 8.4.7.1 provide the following two CPC registers.
> 
> "Highest performance is the absolute maximum performance an individual
> processor may reach, assuming ideal conditions. This performance level
> may not be sustainable for long durations, and may only be achievable if
> other platform components are in a specific state; for example, it may
> require other processors be in an idle state.
> 
> Nominal Performance is the maximum sustained performance level of the
> processor, assuming ideal operating conditions. In absence of an
> external constraint (power, thermal, etc.) this is the performance level
> the platform is expected to be able to maintain continuously. All
> processors are expected to be able to sustain their nominal performance
> state simultaneously."
> 
> We can use Highest Performance as the max performance in boost mode and
> Nomial Performance as the max performance in non-boost mode. If the
> Highest Performance is greater than the Nominal Performance, we assume
> SW BOOST is supported.
> 
> v3->v4:
> 	run 'boost_set_msr_each' for each CPU in the policy rather than
> 	each CPU in the system for 'acpi-cpufreq'
> 	add 'Suggested-by'

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
