Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37216C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 05:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11FE320719
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 05:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hk/CGnSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgHaFvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 01:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgHaFvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 01:51:13 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2679C061575
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 22:51:11 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y6so2516278plt.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 22:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a5XMKt9H7j7vKWkxtVMRuFsLPvpBvOhQyQrdNvfl+qQ=;
        b=Hk/CGnSxUd35Eu4R42iY0zcs7Jt2yYVbImRVunqU5Yz5G99E2NqqaH6I4lM6pKqJfc
         xFUux+JZoIJgcukSwvYjhm0nerIZ3+3kWqPGNqYGQUyhZqY497a0ieI8TlAUZKT3Hbq3
         kjPF3YVL50aOrQJK65/kf7AxsOnWNvPAVLHmoOIcPOsuAck06UhwhM9/feGf5oszOM1J
         NmweVOOdj2Vua0tt1S+BmYwG+QdylfcwVJteVqFV2OH/B72YKQ27ikrr8Bp1QlwPAegd
         EKPmC3Z4Jl80HeLvS8kpZtlHxvGcp+Hyo1cDLVj76Dngr30dNWNDP6E/Z7epYkuHL5Pu
         s2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a5XMKt9H7j7vKWkxtVMRuFsLPvpBvOhQyQrdNvfl+qQ=;
        b=PqiES4phHnk3POWlXBkl/f5JYcajzqTf8wTRwASZElSDDTx1h1svOhFKlevADZDz6i
         Dp7hdzCJbHjARijgi3plQLIfla+IcjiYhfOc2jVr3jfKQIwji4C3wdJhXCpv651ZnX5j
         4wsg9wsTazeUym5fas+pHssqYmhjr0I7qmwlWrm6AsJHkmOIqdiZNWBYv9KPG1tm5R2/
         HwBZZI3g3poi0sNnxTm1CzuHkst9CSnpWzZ98gyqDbs3OYG2VwZFXikwkWr00HZGpdJA
         CZH7KfQRh8tzd9K7ScMWu8mSLalunwOjzZdF7QHXDl2epY1wGqPI+i2mVgIB/ySXH4LS
         U0Pw==
X-Gm-Message-State: AOAM533NK755498H7OHNK/VrzWK7Ms50SD9mQtXdQp/DUmvO2a51PHVT
        eV2wcvBOszgjTcWj7dRapnyqFPah/Uh0EA==
X-Google-Smtp-Source: ABdhPJy7X53S3PKSAw8MINIW0B2yIrCLbI6wtP8X0kcNlFRAhjur/Sl81S9Q7EnozfAlb9Dgsp02DA==
X-Received: by 2002:a17:90a:19c2:: with SMTP id 2mr183390pjj.6.1598853070827;
        Sun, 30 Aug 2020 22:51:10 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id b26sm6551145pfp.177.2020.08.30.22.51.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2020 22:51:10 -0700 (PDT)
Date:   Mon, 31 Aug 2020 11:21:07 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] opp: Drop unnecessary check frmo
 dev_pm_opp_attach_genpd()
Message-ID: <20200831055107.fuyqszsir5ibue2q@vireshk-i7>
References: <88c8522b556d15bd44b8388d47cf25ac6f06b057.1598522635.git.viresh.kumar@linaro.org>
 <20200827121449.GA21147@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827121449.GA21147@gerhold.net>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-08-20, 14:14, Stephan Gerhold wrote:
> Only partially related to this patch, but actually I noticed that
> dev_pm_opp_attach_genpd() does not work correctly if it is called
> multiple times.
> 
> For example, qcom-cpufreq-nvmem calls this for every CPU because it is
> not aware that the OPP table is shared between the CPUs.

It could have called it from cpufreq_driver->init, but yeah I see the
problem here.

> dev_pm_opp_attach_genpd() does not check if opp_table->genpd_virt_devs
> is already set, so when it is called again for other CPUs we will:
> 
>   - Cause a memory leak (opp_table->genpd_virt_devs is just replaced
>     with new memory)
>   - Attach the power domains multiple times
>   - Never detach the power domains from earlier calls
>   - Crash when dev_pm_opp_detach_genpd() is called the second time
> 
> Oh well. :)
> 
> I think the function should just return and do nothing if the power
> domains were already attached, just like dev_pm_opp_set_supported_hw()
> etc. But this is a bit complicated to implement with the "virt_devs"
> parameter, since callers will probably assume that to be valid if we
> return success.

Or maybe at least make it work by returning the OPP table and not
setting the virt_devs.

> Another advantage of my proposal to remove the virt_devs parameter [1] :)

Yes, I do see the advantage there, lets see where that discussion
goes.

-- 
viresh
