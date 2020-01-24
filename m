Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD059C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E7282075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 09:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VhEnEoJB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387845AbgAXJvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 04:51:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46153 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388018AbgAXJvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 04:51:32 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so1166913wrl.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 01:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RzNBHiBM5DbXxFUCQ9dlJFviC6ZX759dmrnjTXv765A=;
        b=VhEnEoJB5kqvQztDtZ1+sgqXwqrwEslLahHlElBF3lpg5qQvZfcZnM7vGeVvzMRaqx
         sdx4UD1JsYKtnoJ3HCjp52IkgqyLeVeIwbSKpbt7DegjPfmfH14KbUGl2rbEF3uGtFpQ
         IzYmaBW9kYrFVZnO88Bpp/6fVD4sKiQeC5j0gsWjIZQCuoxg6+Ay8mLsF9y4TZD8qYbk
         Qd0Ud6omR3y4tooLG6NwEpfBS4R6utxM9TxLG/rfy0t0vKxH+SnxQmTeSK9urLTqu+KN
         Zorhxq/SV+jJbAs9OODxdldv+TtTD0+ukPqqwUowCJlMnkyqHcPTIkgekKECsyGu6jyL
         iUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RzNBHiBM5DbXxFUCQ9dlJFviC6ZX759dmrnjTXv765A=;
        b=MAP5+Inn21ldyrAEo4u/0SfKDxnY11AQQv9ZuL1JWoQdMhP0gaEkSvHoQVD6BQh9FX
         uO1AUZKRuziSJBEKLLVS/tIlINlKUeIPaVDcC+GVAXaqF5bL5X4Dysyc87rV3AAHMOXU
         LHP4l+3n5XiO9/E5Pi/m3eVzl39v9UlJ7h2L1TMR7O2X/z6RgyIYE6Ztaog7olofLEZR
         QS+JvsjEofoNxfnDRSxm7KBA+hbFoRqTc4xx+kxGDlwNWHtlv96SqB7p9jIaDL4oLkLx
         CgOQpPkjsbfHBht0M21oXZuxPrAGUdS+hybQVhS8yUED646vRwQNbEXhyMg2j9biP38G
         k3IQ==
X-Gm-Message-State: APjAAAXWGTsQKInLZ7+dEJPqkdUinQcXIJa8AdKFQ4atOQvhYSy2JKTa
        w/KndFw3Nqqdawwnpkfc+L7v+A==
X-Google-Smtp-Source: APXvYqwqC9cGnHGiTVfZGEQ9XEABof4G9y74dllDLrLAebt1sPpbX2gB5tjK4zRY6rHIpUPi5FvR6g==
X-Received: by 2002:adf:ca07:: with SMTP id o7mr3195324wrh.49.1579859489752;
        Fri, 24 Jan 2020 01:51:29 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id n16sm6761700wro.88.2020.01.24.01.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 01:51:29 -0800 (PST)
Date:   Fri, 24 Jan 2020 09:51:25 +0000
From:   Quentin Perret <qperret@google.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Wei Wang <wvw@google.com>, wei.vince.wang@gmail.com,
        dietmar.eggemann@arm.com, valentin.schneider@arm.com,
        chris.redpath@arm.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] sched: restrict iowait boost for boosted task only
Message-ID: <20200124095125.GA121494@google.com>
References: <20200124002811.228334-1-wvw@google.com>
 <20200124025238.jsf36n6w4rrn2ehc@e107158-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124025238.jsf36n6w4rrn2ehc@e107158-lin>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 Jan 2020 at 02:52:39 (+0000), Qais Yousef wrote:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index ba749f579714..221c0fbcea0e 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -5220,8 +5220,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
> >  	 * If in_iowait is set, the code below may not trigger any cpufreq
> >  	 * utilization updates, so do it here explicitly with the IOWAIT flag
> >  	 * passed.
> > +	 * If CONFIG_ENERGY_MODEL and CONFIG_UCLAMP_TASK are both configured,
> > +	 * only boost for tasks set with non-null min-clamp.
> >  	 */
> > -	if (p->in_iowait)
> > +	if (iowait_boosted(p))
> >  		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
> >  
> >  	for_each_sched_entity(se) {
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 280a3c735935..a13d49d835ed 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -2341,6 +2341,18 @@ static inline unsigned int uclamp_util(struct rq *rq, unsigned int util)
> >  }
> >  #endif /* CONFIG_UCLAMP_TASK */
> >  
> > +#if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_UCLAMP_TASK)
> 
> Why depend on CONFIG_ENERGY_MODEL? Laptops are battery powered and might not
> have this option enabled. Do we really need energy model here?

+1

> > +static inline bool iowait_boosted(struct task_struct *p)
> > +{
> > +	return p->in_iowait && uclamp_eff_value(p, UCLAMP_MIN) > 0;
> 
> I think this is overloading the usage of util clamp. You're basically using
> cpu.uclamp.min to temporarily switch iowait boost on/off.
> 
> Isn't it better to add a new cgroup attribute to toggle this feature?
> 
> The problem does seem generic enough and could benefit other battery-powered
> devices outside of the Android world. I don't think the dependency on uclamp &&
> energy model are necessary to solve this.

I think using uclamp is not a bad idea here, but perhaps we could do
things differently. As of today the iowait boost escapes the clamping
mechanism, so one option would be to change that. That would let us set
a low max clamp in the 'background' cgroup, which in turns would limit
the frequency request for those tasks even if they're IO-intensive.

That'll have to be done at the RQ level, but figuring out what's the
current max clamp on the rq should be doable from sugov I think.

Wei: would that work for your use case ?

Also, the iowait boost really should be per-task and not per-cpu, so it
can be taken into account during wake-up balance on big.LITTLE. That
might also help on SMP if a task doing a lot of IO migrates, as the
boost would migrate with it. But that's perhaps for later ...

Thanks,
Quentin
