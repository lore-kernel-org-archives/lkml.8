Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 553C7C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B0C52071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bkthCIDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390112AbgAXO63 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:58:29 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38336 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730252AbgAXO62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:58:28 -0500
Received: by mail-wr1-f68.google.com with SMTP id y17so2339123wrh.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 06:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H2kMYwKVMZJJODmSCD9XB1XUy/1Vo4ht1rbsU9Apdvk=;
        b=bkthCIDnMnmz7IMKNGdlKVN9leVC3eeQHCjo7uykoVZG47klS81XDDBrRidkGfyR/7
         mz+/ZCHBzRCgPKMVVHRQLyEPMtyXK8ebtOxJu0hPA4Ej6cC+SUz9h11meJQuamkzmwGa
         /4hzbwju+7guE3O2IFZ3pn5uTfTT2zYW9z+FcA3EXuhHXrfbKfnUnsjP/n8FFaOA982R
         E7Y7viGUZaudicKOMw4T7lXq1JIAiiO0z0u4X6efsTOwbMgsTV2259G899Li1Q/Np+/8
         ulWrL+9Vjt0Ki2qeoeJyDE6QYoT7NRfuo5RPqxPYmeMfHNLJzHSQ0vo3zB6n0lMFri3E
         83MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H2kMYwKVMZJJODmSCD9XB1XUy/1Vo4ht1rbsU9Apdvk=;
        b=Zj9VKJBbjH+98cbWyDzAk49CiEgw/aUximruC46YTI1puGg3Ywxt7R5oQJve68u/XE
         VHjZDDm7tJeoJVmPKcUzKb507StiT47v3WnGlwgAbfovwer1SiDKUqHvPRpSqsoRaiDk
         UaOvAmoZY/YcT3PTI6iKcZsRWshzkKdoDJJZk+dWrQy8X95fvr3FI1IAe8TlkbQzjkkf
         3CUH0F40R5O6m3Bm42d3Z4heAhMJi6eKxnunVl2i9w8R5NRcMASWTB9IewE2Nh8Sb/1a
         DP26tmPsM5PemMhs125rtdPm4xVfwTszMsbEw6+CTvld284rf78qta5jUtIMOtJMpALI
         H2bg==
X-Gm-Message-State: APjAAAVOL+i0GGPcMMGO3J2XtJEFMKYnc2+MH7poLQ9JzsreD0FYHE4P
        QeFJlNz8jmh88Xl8A5jSW4IDciSIqORZeA==
X-Google-Smtp-Source: APXvYqzm6jwWCBsOTsmoHYpWta3NHDV77loe37XCpWXtBF3jbOk4inufxpPJJAfjO7rpqpQTd7DeOQ==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr5067863wrr.226.1579877906269;
        Fri, 24 Jan 2020 06:58:26 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id k8sm7561244wrl.3.2020.01.24.06.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 06:58:25 -0800 (PST)
Date:   Fri, 24 Jan 2020 14:58:22 +0000
From:   Quentin Perret <qperret@google.com>
To:     Douglas Raillard <douglas.raillard@arm.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH v4 3/6] sched/cpufreq: Hook em_pd_get_higher_power()
 into get_next_freq()
Message-ID: <20200124145822.GA221730@google.com>
References: <20200122173538.1142069-1-douglas.raillard@arm.com>
 <20200122173538.1142069-4-douglas.raillard@arm.com>
 <20200123161644.GA144523@google.com>
 <5a2af4e7-f9eb-4f23-908a-fab2c7395a99@arm.com>
 <20200124143704.GA215244@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124143704.GA215244@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 Jan 2020 at 14:37:04 (+0000), Quentin Perret wrote:
> On Thursday 23 Jan 2020 at 17:52:53 (+0000), Douglas Raillard wrote:
> > We can't really move the call to em_pd_get_higher_freq() into
> > cpufreq_driver_resolve_freq() since that's a schedutil-specific feature,
> > and we would loose the !sg_policy->need_freq_update optimization.
> 
> Depends how you do it. You could add a new method to cpufreq_policy that

s/cpufreq_policy/cpufreq_governor

> is defined only for sugov or something along those lines. And you'd call
> that instead of cpufreq_frequency_table_target() when that makes sense.
> 
> > Maybe we can add a flag to cpufreq_driver_resolve_freq() that promises
> > that the frequency is already a valid one. We have to be careful though,
> > since a number of things can make that untrue:
> >  - em_pd_get_higher_freq() will return the passed freq verbatim if it's
> > higher than the max freq, so em_pd_get_higher_freq() will have to set
> > the flag itself in case that logic changes.
> >  - policy limits can change the value
> >  - future things could tinker with the freq and forget to reset the flag.
> > 
> > If you think it's worth it I can make these changes.
> 
> The thing is, not only with the current patch we end up iterating the
> frequencies twice for nothing, but also I think it'd be interesting to
> use the EM for consistency with EAS. It'd be nice to use the same data
> structure for the predictions we do in compute_energy() and for the
> actual request.
> 
> Thoughts ?
> 
> Quentin
