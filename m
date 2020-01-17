Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55065C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266B62072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ien6EDoN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgAQLkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 06:40:52 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:46450 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgAQLkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 06:40:51 -0500
Received: by mail-wr1-f50.google.com with SMTP id z7so22341184wrl.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 03:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cHQb5eaBdV5Y7L3TXPPVy41eNKPTn60KouNuNMc9msc=;
        b=Ien6EDoNa/m4pUnIPA72MpkL/XJJHXoZrkFTPYxbKxu3voOGYv9kEI8R08V5wAZDus
         lmGUVQxnB2vV6k9b2k4i+TxFin4qLmhgf6FavkKizXOEBhWDt9zHuY+FPICzb17WIabb
         K/bbnFEmybI5GFp3eIAdl3Gnox4Zmg6yaaO4+ymrUchHWVnjfeEP8ORPpLNH2/cpAmHU
         8U5pQ9RA/seCpXDz0fwxzrinxrBblb5hroPwGvwf3C6ZOB5BCQup2LIhujk0qROJH00s
         Sjw44GJoWpGJmIDDwelqN/hWworvvRG5ixRJ9nHrNijZ1dbqO+br7hdnqQ0uDKuwyofj
         0D+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cHQb5eaBdV5Y7L3TXPPVy41eNKPTn60KouNuNMc9msc=;
        b=GSDO3I2LCQj5AswS2k5DHHLPF4vRk0G3F7crNcvRikrLfACOAG6rb+f7t+vAH+VPTq
         tVWkJ0+2UQglBlIUqLyLN6/B19GBiG3LD0ms2s1m4Brqh6PXsmLWPlI9H4Xtm/bNlNvI
         3cu9+FIVUgwC8mgeiyf2gjh/YEZTnDNSMCU5U2pfx3Yt0nedFsLq0wfHnxPM1KCTQHju
         lUJ+V+cVX7eWLIlDFfj6Upw9rpjIFFp6kLQ+Cre8sW52RjYzYrp1/GuHmZf2aEZUD+OS
         HXoqg0OSPar88CwSMsjRLTfp7vcDFCEvIJOWEH8dfqVhyFXQOka3reij3n2VpKEMcKvA
         3xlA==
X-Gm-Message-State: APjAAAU2LHZI7yY+Sc5AeaEZXLnEG9G6XJyStAfAniiGQra7d+Cnr1vX
        CEzapH2U5kR5q+vHrk9YdeYSCA==
X-Google-Smtp-Source: APXvYqx4SDJrFH5PbnjbxtqdBbq22/luSDJ5avGneSLnZUnxk7Pek9UUYfIUD0uJMDR8APZl/pelvA==
X-Received: by 2002:adf:f990:: with SMTP id f16mr2621833wrr.185.1579261249200;
        Fri, 17 Jan 2020 03:40:49 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id s19sm9097445wmj.33.2020.01.17.03.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 03:40:48 -0800 (PST)
Date:   Fri, 17 Jan 2020 11:40:45 +0000
From:   Quentin Perret <qperret@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>, mingo@redhat.com,
        ionela.voinescu@arm.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
        javi.merino@kernel.org, amit.kucheria@verdurent.com,
        kernel-team@android.com
Subject: Re: [Patch v8 4/7] sched/fair: Enable periodic update of average
 thermal pressure
Message-ID: <20200117114045.GA219309@google.com>
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
 <1579031859-18692-5-git-send-email-thara.gopinath@linaro.org>
 <20200116151502.GQ2827@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116151502.GQ2827@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 Jan 2020 at 16:15:02 (+0100), Peter Zijlstra wrote:
> > @@ -10275,6 +10281,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
> >  {
> >  	struct cfs_rq *cfs_rq;
> >  	struct sched_entity *se = &curr->se;
> > +	unsigned long thermal_pressure = arch_cpu_thermal_pressure(cpu_of(rq));
> >  
> >  	for_each_sched_entity(se) {
> >  		cfs_rq = cfs_rq_of(se);
> > @@ -10286,6 +10293,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
> >  
> >  	update_misfit_status(curr, rq);
> >  	update_overutilized_status(task_rq(curr));
> > +	update_thermal_load_avg(rq_clock_task(rq), rq, thermal_pressure);
> >  }
> 
> I'm thinking this is the wrong place; should this not be in
> scheduler_tick(), right before calling sched_class::task_tick() ? Surely
> any execution will affect thermals, not only fair class execution.

Right, but right now only CFS takes action when we overheat. That is,
only CFS uses capacity_of() which is where the thermal signal gets
reflected.

We definitely could (and maybe should) make RT and DL react to thermal
pressure as well when they're both capacity-aware. But perhaps that's
for later ? Thoughts ?

Thanks,
Quentin
