Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51466C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B2CB207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 07:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XEsclj/A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgERHxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 03:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbgERHxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 03:53:13 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B1FAC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:53:13 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b12so3883741plz.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 00:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H+nmyXbDTXJaw998d7ykbBQgRq7RD9hlm9DkRAd6Oi8=;
        b=XEsclj/ATCKjjChaY7dp1vWB6dOCospxZ+RYHwj7BOG9gu2C8VLYpFsj/b9Yh60abK
         Sh2tEsX9dA/ucWzJ1AEqUpUuFS06DoMcCQaZ+NJsR+/Wq2NLdJxOOa+PvtKJFNGFCTYi
         ZS3HHLfN5UFx21uBY5KCKabCzkfJTlmoKqSgeIlCaoweaZcJ89GHRuQWRFqhrqLiw6VE
         kcw0PQgMgo33VUislPbGaCOoCW0Hm8cSUEnePkBRdO+zUfOpbpn0swg2oSt61Oxx3nj5
         MXtXVmMH3GXeFsn0n7gmZDfnNZA8JM0cCGhoraOfJu4b3UTrKdUG13K3I8E/LA7fqTWy
         8W1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H+nmyXbDTXJaw998d7ykbBQgRq7RD9hlm9DkRAd6Oi8=;
        b=GZ4uZENTSkl8bJUUsulLH3xgeoh9zKs72RNsBJ85uqvzI8miyDRtIMyYMUSpw7kLkO
         kYs/7SEtQ1AidWVwdqpt6allERCDTl7nKZnkByPqcMO4v2RqC+EJU7KJ+FJ6OYpRklwT
         8mLnz+mex2LSNw4MiNnsvRzhfkWm/xRUbEX3lfN3vWW19g7E7rm18nlTWVTFLP6gYYEe
         gpiu5OP01nLkfnvVhsTO4N9TR4Kmb1BQDHvESLlgl5zB8+V4F4r0qqM5e4+68Fmy37fC
         qYsaWTujUB1rVeiad8b+rEjcXGs6r2+NuMytdHbzWeoemqt6ciq2NA1njqNDMwoVTtPr
         7EGQ==
X-Gm-Message-State: AOAM530MgEnZBLCgLtFboT0C9GcqosV+6+BiTd8u7Khckt/Bzuqy9vZn
        YkwPxfPKC9IF50kQ3/qPDzM9rw==
X-Google-Smtp-Source: ABdhPJzZsQBojStaYWOlvkhb83DhqJGkkOJWtVW7yvxly47MohiSAENvpRiIsgnA+if2xPLVqJgcwg==
X-Received: by 2002:a17:90a:7309:: with SMTP id m9mr17795943pjk.235.1589788392533;
        Mon, 18 May 2020 00:53:12 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id y8sm8234037pfg.216.2020.05.18.00.53.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 00:53:11 -0700 (PDT)
Date:   Mon, 18 May 2020 13:23:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Souvik.Chakravarty@arm.com, Thanu.Rangarajan@arm.com,
        Sudeep.Holla@arm.com, guohanjun@huawei.com, john.garry@huawei.com,
        jonathan.cameron@huawei.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] cpufreq: Add SW BOOST support for drivers
 without frequency table
Message-ID: <20200518075309.xoon4vyfjywmteww@vireshk-i7>
References: <1588929064-30270-1-git-send-email-wangxiongfeng2@huawei.com>
 <1588929064-30270-3-git-send-email-wangxiongfeng2@huawei.com>
 <5858421.kfVlu25t0p@kreacher>
 <7325b64c-85f7-21fe-3860-faa10ab1cf21@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7325b64c-85f7-21fe-3860-faa10ab1cf21@huawei.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay from my side in replying to this thread.

On 15-05-20, 09:49, Xiongfeng Wang wrote:
> On 2020/5/14 22:16, Rafael J. Wysocki wrote:
> > On Friday, May 8, 2020 11:11:03 AM CEST Xiongfeng Wang wrote:
> >> Software-managed BOOST get the boost frequency by check the flag
> >> CPUFREQ_BOOST_FREQ at driver's frequency table. But some cpufreq driver
> >> don't have frequency table and use other methods to get the frequency
> >> range, such CPPC cpufreq driver.
> >>
> >> To add SW BOOST support for drivers without frequency table, we add
> >> members in 'cpufreq_policy.cpufreq_cpuinfo' to record the max frequency
> >> of boost mode and non-boost mode. The cpufreq driver initialize these two
> >> members when probing.
> >>
> >> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> >> ---
> >>  drivers/cpufreq/cpufreq.c | 23 +++++++++++++++--------
> >>  include/linux/cpufreq.h   |  2 ++
> >>  2 files changed, 17 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >> index 475fb1b..a299426 100644
> >> --- a/drivers/cpufreq/cpufreq.c
> >> +++ b/drivers/cpufreq/cpufreq.c
> >> @@ -2508,15 +2508,22 @@ static int cpufreq_boost_set_sw(int state)
> >>  	int ret = -EINVAL;
> >>  
> >>  	for_each_active_policy(policy) {
> >> -		if (!policy->freq_table)
> >> -			continue;
> >> -
> >> -		ret = cpufreq_frequency_table_cpuinfo(policy,
> >> +		if (policy->freq_table) {
> >> +			ret = cpufreq_frequency_table_cpuinfo(policy,
> >>  						      policy->freq_table);
> >> -		if (ret) {
> >> -			pr_err("%s: Policy frequency update failed\n",
> >> -			       __func__);
> >> -			break;
> >> +			if (ret) {
> >> +				pr_err("%s: Policy frequency update failed\n",
> >> +				       __func__);
> >> +				break;
> >> +			}
> >> +		} else if (policy->cpuinfo.boost_max_freq) {
> >> +			if (state)
> >> +				policy->max = policy->cpuinfo.boost_max_freq;
> >> +			else
> >> +				policy->max = policy->cpuinfo.nonboost_max_freq;
> >> +			policy->cpuinfo.max_freq = policy->max;
> >> +		} else {
> >> +			continue;
> >>  		}
> > 
> > Why do you need to update this function?
> 
> My original thought is to reuse the current SW BOOST code as possible, but this
> seems to change the cpufreq core too much.
> 
> Thanks for your advice. This is better. I will provide a '->set_boost' callback
> for CPPC driver. But I will need to export 'cpufreq_policy_list' and make the
> macro 'for_each_active_policy' public.

This can and should be avoided, I will rather move the for-each-policy
loop in cpufreq_boost_trigger_state() and call ->set_boost() for each
policy and pass policy as argument as well. You would be required to
update existing users of sw boost.

-- 
viresh
