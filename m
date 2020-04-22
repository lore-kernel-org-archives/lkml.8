Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4C3C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B41C82076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZgLK8Xx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgDVPi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:38:29 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49269 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725980AbgDVPi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587569906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PiL92fiIbjBpTLQbW35VIRjphDmosDAbmsy/SBxdj8A=;
        b=HZgLK8Xx5NHID5zfIcza5rOJeBwSgoNM0mCDLW4fGJpj3bdOZo1HuIidwQgcMpp0FuslW3
        hdNOfL83EqA45pAZCuHsk78zO5slqLuAi0p0VIS0o6OEPNTzRZyfr8NHLr/KeTTmSK6a0G
        wNQWenk4whzyCQZVFUK1nJtWK1qq49g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-MdBGRk-rOB-aKXo9L2SMEQ-1; Wed, 22 Apr 2020 11:38:25 -0400
X-MC-Unique: MdBGRk-rOB-aKXo9L2SMEQ-1
Received: by mail-wm1-f70.google.com with SMTP id 14so975967wmo.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:38:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PiL92fiIbjBpTLQbW35VIRjphDmosDAbmsy/SBxdj8A=;
        b=CbIeG/Q1BSWc7nWcuSA+CbbSj/wGuiuEL/Ch5jQkTkHGuXAb2rz76qbnvfvxOuxXPY
         tmykCshCR959/wwsPxfaifE2M+vIH6YlmFmLHQR2o55h0dyKBVzzjjDyEVbmgVnu4Cmh
         Tweyex0hxTuKAJrcAZL+k9SHoZGIpCl1S2EsdjNiqSok7EgcwznQLM2PTFwoHKq3k1Ke
         m+qTAwNFj73MpC+hSvT50OwOKsfVxKt61TWijGrFHWAHtJwJYp3/lq9XEt4Q0Htxy+LV
         tqwvgk15DGQdS/91M82eMVb05BfnyX7MaRdGWMQ6NsEAW3gStEKyQgGRlrnuDIA8jiWg
         qlig==
X-Gm-Message-State: AGi0PubJYKaqqLbAKx81dBhXFDrXm0TrE+CgpUD+jiGkK0xVoUm4ljWC
        pSjuyHLYr2xDfPlACS1Lw+3vewEH84z+o34tgcgoRFK7cldvh+ENlU/8TwRctLmYMIUpWh9rviM
        dRAs5yVvTjbEJNPXgL9h+s7ST
X-Received: by 2002:adf:f9c6:: with SMTP id w6mr30700034wrr.341.1587569904125;
        Wed, 22 Apr 2020 08:38:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypIgvlNy/lUcsVNmg22dI5WnAMBscXbX3xC6BqCySaQ8n8D9ijTO+vFgaI+M5olv1FwvT8HS0g==
X-Received: by 2002:adf:f9c6:: with SMTP id w6mr30700009wrr.341.1587569903876;
        Wed, 22 Apr 2020 08:38:23 -0700 (PDT)
Received: from localhost.localdomain ([151.29.194.179])
        by smtp.gmail.com with ESMTPSA id c1sm9125790wrc.4.2020.04.22.08.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 08:38:22 -0700 (PDT)
Date:   Wed, 22 Apr 2020 17:38:20 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 13/23] sched,ion: Convert to sched_set_normal()
Message-ID: <20200422153820.GK9767@localhost.localdomain>
References: <20200422112719.826676174@infradead.org>
 <20200422112831.988065598@infradead.org>
 <CAKfTPtB8NiKqggZN3v6u=Rdwj4grzRwn1mW31ov0y5ZhDBcvuw@mail.gmail.com>
 <20200422132923.GK20730@hirez.programming.kicks-ass.net>
 <CAKfTPtBsFDt8JyxjD39B2YP+kCN9nXWZxnaJys9sz2CjWzd1Zw@mail.gmail.com>
 <20200422135921.GL20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422135921.GL20730@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/20 15:59, Peter Zijlstra wrote:
> On Wed, Apr 22, 2020 at 03:36:22PM +0200, Vincent Guittot wrote:
> > On Wed, 22 Apr 2020 at 15:29, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Wed, Apr 22, 2020 at 03:21:45PM +0200, Vincent Guittot wrote:
> > > > On Wed, 22 Apr 2020 at 13:29, Peter Zijlstra <peterz@infradead.org> wrote:
> > > > >
> > > > > In an attempt to take away sched_setscheduler() from modules, change
> > > > > this into sched_set_normal(.nice = 19).
> > > > >
> > > > > Cc: john.stultz@linaro.org
> > > > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > > > Reviewed-by: Ingo Molnar <mingo@kernel.org>
> > > > > ---
> > > > >  drivers/staging/android/ion/ion_heap.c |    3 ---
> > > > >  1 file changed, 3 deletions(-)
> > > > >
> > > > > --- a/drivers/staging/android/ion/ion_heap.c
> > > > > +++ b/drivers/staging/android/ion/ion_heap.c
> > > > > @@ -244,8 +244,6 @@ static int ion_heap_deferred_free(void *
> > > > >
> > > > >  int ion_heap_init_deferred_free(struct ion_heap *heap)
> > > > >  {
> > > > > -       struct sched_param param = { .sched_priority = 0 };
> > > > > -
> > > > >         INIT_LIST_HEAD(&heap->free_list);
> > > > >         init_waitqueue_head(&heap->waitqueue);
> > > > >         heap->task = kthread_run(ion_heap_deferred_free, heap,
> > > > > @@ -255,7 +253,7 @@ int ion_heap_init_deferred_free(struct i
> > > > >                        __func__);
> > > > >                 return PTR_ERR_OR_ZERO(heap->task);
> > > > >         }
> > > > > -       sched_setscheduler(heap->task, SCHED_IDLE, &param);
> > > > > +       sched_set_normal(heap->task, 19);
> > > >
> > > > Would it make sense to have a sched_set_idle(task) to enable kernel
> > > > setting SCHED_IDLE task ?
> > > >
> > > > SCHED_NORMAL w/ nice 19 and SCHED_IDLE tasks are not treated in the
> > > > same way when checking for preemption at  wakeup
> > >
> > > Yeah, but does it really matter? I did indeed consider it, but got
> > > lazy. Is there a definite need for IDLE?
> > 
> > John is the best to answer this for this driver but SCHED_IDLE will
> > let other tasks which might be involved in end user interaction like
> > on Android to run first
> 
> So I don't much like SCHED_IDLE because it introduces some pretty
> horrible tail latencies. Consider the IDLE task holding a lock, then the
> lock waiter will have to wait until the task gets around to running.
> 
> It's not unbounded, like a true idle-time scheduler would be, but it can
> still be pretty horrible. nice19 has some of that too of course, but
> idle has it worse, esp. also because it begs others to preempt it.
> 
> I should get back to proxy execution I suppose...

Huh, so you really think proxy exec should be default on for kernel
mutexes...

