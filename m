Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84672C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 572F12076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZrSA1VaW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgGQKnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgGQKnU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 06:43:20 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED63C08C5C0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 03:43:19 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w3so16341929wmi.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 03:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o/b+EmKne5gnDXstxW2uX3pxAh0IsbYMQdhSzdZxQ90=;
        b=ZrSA1VaWOJmimVTByiramfsqR+MhBH7LqpR7K5Hr/k/n8QyMRK7r6tC9igUDitBqvC
         JRzp7+NludnBgMWUF2N6afx/XAYbeuLU1jr6H/m65A5MgmvOdudw5+7gwTzmwwNMD2TG
         JwdmlhTIi/qpnB0pyVNcS+tU3AV6yQOaEAfJrlJu/staUrt+P8gWpwjGo16OEV7+oGha
         YbrGgRwob0UhXAtzH29ybIk34ZJ7F+OFKskSh+0Ob2vtkuuFEF9GadOmIKUa7NZ3A5o7
         Hcjhl6YnO3UUiDmp79cuspio9eSMAtZkUfDzgDbK0QYrVggj2ix7M2OoS+4KkE1Lg1zH
         EEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o/b+EmKne5gnDXstxW2uX3pxAh0IsbYMQdhSzdZxQ90=;
        b=pG7zZ2BpImYMlFQn/MTRsgzsRCHCAO1fvEwCul91Tyb4OcNXmX4ZeNPhhkZh+FEg3u
         ugbDWam8vMvOLhY7cwrAOsGOPoNF6jmBmTbV5sajIfZ0sggqqj/mvcFxq1mX4fpbgZjf
         m/Uz5wbPkCtjjdsjocPr3Y2N/wZRc8SC0O4DsIj3s/VUH1MSu9OPg3I90Oyg6bweLcrg
         qAAYClz91fId/5Gnk0Q6lwhxqdTbNbqnlGPREhAyB6XRyFXmpUfyTluTGr0AYYmgGVFC
         TDIBgiWrzx++O6K/Fsu4/94Yoi8nFBN3oqKJjMZKakRI4kSKkvG8Uydpm91/Yr3KkSqx
         dd/Q==
X-Gm-Message-State: AOAM5334lfiCHT0xa3WKX0wT5YVSJhNbXaXPeHRffr5zIXJYfshuJMin
        CEWK6KQgnTeTLVY/h9znS0oRSQ==
X-Google-Smtp-Source: ABdhPJwdH3QTnBvXg3Z7gVZPAsOOybtbAb4sFkTkT/XqR+Td7VJeZEMZmlbMI1juTQ5o+1GVcwSmpQ==
X-Received: by 2002:a1c:ed05:: with SMTP id l5mr8711628wmh.68.1594982598532;
        Fri, 17 Jul 2020 03:43:18 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:f693:9fff:fef4:a7ef])
        by smtp.gmail.com with ESMTPSA id a4sm15005117wrg.80.2020.07.17.03.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 03:43:17 -0700 (PDT)
Date:   Fri, 17 Jul 2020 11:43:14 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
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
Message-ID: <20200717104314.GB2385870@google.com>
References: <cover.1594707424.git.viresh.kumar@linaro.org>
 <b051b42f0c4f36d7177978e090c6a85df17922c6.1594707424.git.viresh.kumar@linaro.org>
 <20200717101438.GA2366103@google.com>
 <20200717103305.GA2385870@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717103305.GA2385870@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 Jul 2020 at 11:33:05 (+0100), Quentin Perret wrote:
> On Friday 17 Jul 2020 at 11:14:38 (+0100), Quentin Perret wrote:
> > On Tuesday 14 Jul 2020 at 12:06:53 (+0530), Viresh Kumar wrote:
> > >  /**
> > > - * get_load() - get load for a cpu since last updated
> > > + * get_load() - get current load for a cpu
> > >   * @cpufreq_cdev:	&struct cpufreq_cooling_device for this cpu
> > >   * @cpu:	cpu number
> > > - * @cpu_idx:	index of the cpu in time_in_idle*
> > > + * @cpu_idx:	index of the cpu
> > >   *
> > > - * Return: The average load of cpu @cpu in percentage since this
> > > - * function was last called.
> > > + * Return: The current load of cpu @cpu in percentage.
> > >   */
> > >  static u32 get_load(struct cpufreq_cooling_device *cpufreq_cdev, int cpu,
> > >  		    int cpu_idx)
> > >  {
> > > -	u32 load;
> > > -	u64 now, now_idle, delta_time, delta_idle;
> > > -	struct time_in_idle *idle_time = &cpufreq_cdev->idle_time[cpu_idx];
> > > -
> > > -	now_idle = get_cpu_idle_time(cpu, &now, 0);
> > > -	delta_idle = now_idle - idle_time->time;
> > > -	delta_time = now - idle_time->timestamp;
> > > +	unsigned long util = cpu_util_cfs(cpu_rq(cpu));
> > > +	unsigned long max = arch_scale_cpu_capacity(cpu);
> > 
> > Should we subtract the thermal PELT signal from max?
> 
> Actually, that or add it the ENERGY_UTIL case in effective_cpu_util() as
> this appears to be missing for EAS too ...

Scratch that. I do think there is something missing in the EAS path, but
not sure that would fix it. I'll have a think and stop spamming
everybody in the meantime ...

The first question is still valid, though :)

Sorry for the noise,
Quentin
