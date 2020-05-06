Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C48DC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2926206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TemheLuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgEFMhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 08:37:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36360 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727067AbgEFMhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588768665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s1MktsIoJtjuCK1LIHvBtwFHwePnfE+EvLWoNj84r9o=;
        b=TemheLuScOS/0GLmlAwKqCZccXkeRQanV9t61T+tU5U+Yi/32PEcesUit3bG2FWQEVUkx1
        WKIbgbu0FZLvjEbWC/nK1HovZAQHITt4Qib+WEHucDKt17LJc8MHTsKs1y6XlEdNvHjLz+
        w6XVeDA5TbijsqGCFXioMCkvGVTPnVA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-NoBxukqMP_iuMvZq34wtQA-1; Wed, 06 May 2020 08:37:43 -0400
X-MC-Unique: NoBxukqMP_iuMvZq34wtQA-1
Received: by mail-wm1-f70.google.com with SMTP id o26so813436wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 05:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s1MktsIoJtjuCK1LIHvBtwFHwePnfE+EvLWoNj84r9o=;
        b=MwsG0XjQq16RvAjMSG6feWwI/sICYU6g/FS3wJuKfDQCw1Vm9zum/PRoqsPtZUTS+1
         A7iW2e3cfncaVLfTTqRJibhwI5chNExzACAQC9UFJLfXWemYs9r2nfcx5wAnSyvSfyUS
         BRK4sLxWtnvNFJE/yrf7NDDD2v/LMh4rCeUwcnOHDODVp3cnCgvOjSd5tMnLI4aZDkfp
         hIsObo0bA1q/sxjKUj4OlL61K69i8LTDyPYvX/UnDe0lHx3G8CjgsW/ppXNByzbuyGRQ
         YU3BU1oCjglZF49PQ4oNXFI5feF95L31RRXo+rjlf4L4bwnztM/Nbzk4YAYav7uaQPgY
         doog==
X-Gm-Message-State: AGi0PuYNJgYH8VdtMdItAW8eo9kqFozvdH/uQDItZQdw7MzI2lSYllhO
        fcqI+WggCerCTiBRsR5KegF+DVmQLfUSA61FauefS9VGBsMRtIrUdqNIJwbbrubxAwXCOblkgJA
        bOFH0c6mNnOh4STWN5CBolCl3
X-Received: by 2002:adf:c7c3:: with SMTP id y3mr9163128wrg.196.1588768662158;
        Wed, 06 May 2020 05:37:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypJfUIWJzOGHjxR7ZkM0uW5dIfQKZeIuCzQQj1rRLmusBGoAtRKo0sKNGPghmxkMEb2uokVfnQ==
X-Received: by 2002:adf:c7c3:: with SMTP id y3mr9163084wrg.196.1588768661793;
        Wed, 06 May 2020 05:37:41 -0700 (PDT)
Received: from localhost.localdomain ([151.29.188.60])
        by smtp.gmail.com with ESMTPSA id z1sm2871826wmf.15.2020.05.06.05.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 05:37:41 -0700 (PDT)
Date:   Wed, 6 May 2020 14:37:38 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] sched/deadline: Add dl_bw_capacity()
Message-ID: <20200506123738.GJ17381@localhost.localdomain>
References: <20200427083709.30262-1-dietmar.eggemann@arm.com>
 <20200427083709.30262-4-dietmar.eggemann@arm.com>
 <23bde551-0d91-4bfe-ce65-40af9fbfdef9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23bde551-0d91-4bfe-ce65-40af9fbfdef9@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/20 12:54, Dietmar Eggemann wrote:
> On 27/04/2020 10:37, Dietmar Eggemann wrote:
> 
> [...]
> 
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 4ae22bfc37ae..eb23e6921d94 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -69,6 +69,25 @@ static inline int dl_bw_cpus(int i)
> >  
> >  	return cpus;
> >  }
> > +
> > +static inline unsigned long dl_bw_capacity(int i)
> > +{
> > +	struct root_domain *rd = cpu_rq(i)->rd;
> > +	unsigned long cap;
> > +
> > +	RCU_LOCKDEP_WARN(!rcu_read_lock_sched_held(),
> > +			 "sched RCU must be held");
> > +
> > +	if (cpumask_subset(rd->span, cpu_active_mask))
> > +		return rd->sum_cpu_capacity;
> > +
> > +	cap = 0;
> > +
> > +	for_each_cpu_and(i, rd->span, cpu_active_mask)
> > +		cap += capacity_orig_of(i);
> > +
> > +	return cap;
> > +}
> 
> There is an issue w/ excl. cpusets and cpuset.sched_load_balance=0. The
> latter is needed to demonstrate the problem since DL task affinity can't
> be altered.
> 
> A CPU in such a cpuset has its rq attached to def_root_domain which does
> not have its 'sum_cpu_capacity' properly set.

Hummm, but if sched_load_balance is disabled it means that we've now got
a subset of CPUs which (from a DL AC pow) are partitioned. So, I'd tend
to say that we actually want to check new tasks bw requirement against
the available bandwidth of the particular CPU they happen to be running
(and will continue to run) when setscheduler is called.

If then load balance is enabled again, AC check we did above should
still be valid for all tasks admitted in the meantime, no?

