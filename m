Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBB9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 03:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E162520FC3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 03:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZJ8AcR0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgG3Dlf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 23:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbgG3Dle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 23:41:34 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D890C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 20:41:33 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w19so66129plq.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 20:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rwTsd3u9TKrgBcA6Qz/hEukqNQY4MFVBnr/oej/t/jY=;
        b=ZJ8AcR0wT+TC/a+JqYHcv0gv1nV8vfoW4iv/UpEC/ZTJBVuFOqoHHa7HwpIbs5FnDJ
         iy6pMxHeC4okSPnbrvgsvfpzMURTn6uadjCYqvKB19w8zvHGDTeGDoahVg9A/Yj+wfQ7
         +WgLnaiHd7JLW282RzqxcOU1d/6C+2zSx8m0ci1wdlYkybL/M1jWOrLIg5ZOnZZ3dFAn
         Tgb5HsY5j3j1UkElntS5xp6e7u/f5ShEG7Vm8EBU4/pWU6NpFRwrdD1rnEOpNFcjKkNM
         HA025/k3T+9KoNQXWUgrMa1vXhxdIejoHXYckby2Ib81n2ase0Wh+zC0t9qqKUKzTIq9
         UIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rwTsd3u9TKrgBcA6Qz/hEukqNQY4MFVBnr/oej/t/jY=;
        b=jYjemdW6ZzU3EkreU5LXh29gVT2c7SBLzxvUTJwL9/hr7/mTgfMDXV84Q2LBQvs/MS
         bfNFViiCqjjMDYhstsujXEGCP5HAma17+VYfmAutK/bo6u0U0ChbjWYDCkksZaUAo5re
         9XITuJ//WM8CrB1S5E9jq5CMM5YtcyYqjacT6w/rkFT1rtAHZZNfPdg8jucD5AMZTV9s
         DhOjYvzuuTQtzscAaQj+33q1FYYuQ9L/BmnaJVY/wyhYY7s+CjQl2EQJpgdlu85hnPtV
         6LUKWuMHW20g6mFMtoUzWrahNqQ8ki4QSsO42EjW9yOZH7pEIXd+2RJRLJffpsxK5cvC
         +OrA==
X-Gm-Message-State: AOAM530lEmHc0c6h2dhJhr3+tD7f/f6Ru1zMm5L4Gks051M+/J9y+ds8
        x9MQbO6Be45Zv9bRaONaaVDp2Q==
X-Google-Smtp-Source: ABdhPJxQQF0rlpXk1DGDtLCYG0sOy3hlhmmFVvQz0dYBui/t3MnyfKQhdZVqeLiAv8MS6n38S5pqgQ==
X-Received: by 2002:a17:90b:3685:: with SMTP id mj5mr12980659pjb.123.1596080493101;
        Wed, 29 Jul 2020 20:41:33 -0700 (PDT)
Received: from localhost ([106.201.14.19])
        by smtp.gmail.com with ESMTPSA id y17sm4049374pfe.30.2020.07.29.20.41.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jul 2020 20:41:32 -0700 (PDT)
Date:   Thu, 30 Jul 2020 09:11:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH v2 1/7] cpufreq: move invariance setter calls in cpufreq
 core
Message-ID: <20200730034128.k4fmblfuwjcmqdze@vireshk-mac-ubuntu>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-2-ionela.voinescu@arm.com>
 <CAJZ5v0i5Xrk6oTt81aeXDi1F8gnEspJo9e6nGf10nSvBz-Dbkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i5Xrk6oTt81aeXDi1F8gnEspJo9e6nGf10nSvBz-Dbkw@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-07-20, 15:48, Rafael J. Wysocki wrote:
> On Wed, Jul 22, 2020 at 11:38 AM Ionela Voinescu
> <ionela.voinescu@arm.com> wrote:
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 036f4cc42ede..bac4101546db 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -2058,9 +2058,16 @@ EXPORT_SYMBOL(cpufreq_unregister_notifier);
> >  unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
> >                                         unsigned int target_freq)
> >  {
> > +       unsigned int freq;
> > +
> >         target_freq = clamp_val(target_freq, policy->min, policy->max);
> > +       freq = cpufreq_driver->fast_switch(policy, target_freq);
> > +
> > +       if (freq)
> > +               arch_set_freq_scale(policy->related_cpus, freq,
> > +                                   policy->cpuinfo.max_freq);
> 
> Why can't arch_set_freq_scale() handle freq == 0?

Actually there is no need to. AFAIU the freq returned by fast_switch
can never be 0 (yeah qcom driver does it right now and I am fixing
it). And so we can drop this check altogether.

-- 
viresh
