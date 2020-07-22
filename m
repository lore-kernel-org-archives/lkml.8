Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5ADC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C5520729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+Tn1IXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731470AbgGVJNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgGVJNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:13:43 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3021DC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:13:43 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id s26so859566pfm.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 02:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VSSYQnDcAEo6XODOg0weBZ1js78HVuMbUH/1YUmj6qE=;
        b=T+Tn1IXdYkqpqQCs0GCtVcpQo/ltUqYpf13AFLjIAwdH1oAXZ/3yJu0ycOJbd2aE9v
         4v/rBr9OXxul+D2kr+iPEZkqZrM0+0UFTQkRc6Dit3vxdw7GvNEcsXqIoE8asCCg19XF
         CdUiX0E29iqPrxpxcGteGSYitGaZ3k1lT6mRoFsCtmeO+RzOCGdHZf8bRudQmkGCEJiQ
         oxJkOl9olO/fiVr0GUEOPzU/N2ELnH306UDLnyeFPlgP6O5ElMD4JWgiKyOjtaD/KF2F
         U3q+VbDKiSngEvKGhfUPsWGuKWQ/lnHZobi3yTUWaekS4ydNi2CdbnlLDxnrRO7mDGrG
         0qMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VSSYQnDcAEo6XODOg0weBZ1js78HVuMbUH/1YUmj6qE=;
        b=URomX1zoo41QkkDOlvGAr9n5BacDoKgsdWYUIfpfMp5ZbMRa/Il/zBO8UOl4erL0Zf
         hsDwRwNNBS2tUE7SpPvGsgLx2d2a/rQWEUD2EWTa5N64EHzmNVsFuqLwt2T6Kj0dOlfc
         eQYY6hRTjk2dvhpxCTSuoUKxlKaCdw++EuQ6A47stI4szFPQfZgPAF6j9Npw/W6f+kor
         /gMpZeDX6/5kZHkia2WzLanc9sOKNiFXLd78BYMpgXbncsFQcaVF+JOfLp43NN1Y+NJe
         edqpMO9Wf7aK9KbPUJ8PNDFFtDc2fcNy9RSpcOVx3IwNHBCo7Efujx/WYsQlsdqpdKlf
         60UA==
X-Gm-Message-State: AOAM533nlaH4WcjG+yxokk4QcvBz1wUB9G/XIXvHEdur2/EHmQ8k5LCF
        0/Vh7Ncewxz3G0+W0A+79qiD4Q==
X-Google-Smtp-Source: ABdhPJz339nnnOnrsTS8ufVI4oWdieVsnoOIzIxcaYOFG9esYsmXqGZpy37dcy7CdcxUrrXCVPClRQ==
X-Received: by 2002:aa7:9f8f:: with SMTP id z15mr27355816pfr.73.1595409222708;
        Wed, 22 Jul 2020 02:13:42 -0700 (PDT)
Received: from localhost ([182.77.116.224])
        by smtp.gmail.com with ESMTPSA id y1sm5024878pfg.86.2020.07.22.02.13.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Jul 2020 02:13:41 -0700 (PDT)
Date:   Wed, 22 Jul 2020 14:43:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
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
Message-ID: <20200722091338.syymxwgk6znnasvt@vireshk-mac-ubuntu>
References: <cover.1594707424.git.viresh.kumar@linaro.org>
 <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
 <20200717101438.GA2366103@google.com>
 <20200717103305.GA2385870@google.com>
 <20200717104314.GB2385870@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717104314.GB2385870@google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-07-20, 11:43, Quentin Perret wrote:
> On Friday 17 Jul 2020 at 11:33:05 (+0100), Quentin Perret wrote:
> > On Friday 17 Jul 2020 at 11:14:38 (+0100), Quentin Perret wrote:
> > > On Tuesday 14 Jul 2020 at 12:06:53 (+0530), Viresh Kumar wrote:
> > > >  /**
> > > > - * get_load() - get load for a cpu since last updated
> > > > + * get_load() - get current load for a cpu
> > > >   * @cpufreq_cdev:	&struct cpufreq_cooling_device for this cpu
> > > >   * @cpu:	cpu number
> > > > - * @cpu_idx:	index of the cpu in time_in_idle*
> > > > + * @cpu_idx:	index of the cpu
> > > >   *
> > > > - * Return: The average load of cpu @cpu in percentage since this
> > > > - * function was last called.
> > > > + * Return: The current load of cpu @cpu in percentage.
> > > >   */
> > > >  static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
> > > >  		    int cpu_idx)
> > > >  {
> > > > -	u32 load;
> > > > -	u64 now, now_idle, delta_time, delta_idle;
> > > > -	struct time_in_idle *idle_time = &cpufreq_cdev->idle_time[cpu_idx];
> > > > -
> > > > -	now_idle = get_cpu_idle_time(cpu, &now, 0);
> > > > -	delta_idle = now_idle - idle_time->time;
> > > > -	delta_time = now - idle_time->timestamp;
> > > > +	unsigned long util = cpu_util_cfs(cpu_rq(cpu));
> > > > +	unsigned long max = arch_scale_cpu_capacity(cpu);
> > > 
> > > Should we subtract the thermal PELT signal from max?

Makes sense to me, but I am not really good with this util and load
stuff and so would leave that to you guys to decide :)

-- 
viresh
