Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12F7C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC5F620738
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L5LYC4MY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgDVPJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgDVPJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:09:29 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA417C03C1AC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:09:28 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id l11so1971908lfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 08:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqD1DdKFaLwmkcbGRvBOw+gGxJHG2rMwpj+QEoNWLYk=;
        b=L5LYC4MYPzU3miuwOzUQoLPSVqC0ES4G5kE/4AWaR1CAJeKBY6KPyU6QUicky/XAFE
         /1PmafW+vwOnnUygtw57rCgtCMf4/SyG62UJ6PdH4GbNbwDzKM9YL1jDAbLvYJUqYKVk
         qQQ9ym3z2IE1sSb7aFpScIOtdHD7765PMtBSpqfTMOaVGHQIS2uBJC8bd/T+nCMyMLy7
         ry7jxxUnqLpaTRqYBHdRqSAPuNXyZG7+d1PqW+lphihypfM+JhKoS6ZryBVlUM5nwITP
         VXczeTfrZVufcvkVQNco1LrRjN8PfTuptBb3ctpuBFUCC7kWEbN3Tse8+wtkwv5F0rpu
         S+dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqD1DdKFaLwmkcbGRvBOw+gGxJHG2rMwpj+QEoNWLYk=;
        b=VpTwpcbkUZFkVUTm5sP5FOEW2ywe+1+7J/OAfcM6nClN6C4K4pqxxNSWdfVHGcxbKW
         2Gxp5+jySemEUjptmtgr1HlA8jtxzU3iAsqNVbvtyBMpkFiJlv2JZ4bMZS8n0j8UM/ql
         emk7pwc+N09ImV05bhRiYBq+nNhs8so8VYYgpkOh19Fdlu1Vu59bdq4wKJy9BYO/ycx9
         XduuMrU8KG5FjspZnFS//59RTqi0p+kfcVs5zr4cwXpaW8g6dbDXdlak3U+A+RJw0pGI
         dp+PdnyqONO1iAl/1GqfP6rTTxaePdC9rMSmYf9ZAajLbrc03wzNTLkRRtSOGuJOdoUx
         jOMw==
X-Gm-Message-State: AGi0PuajRtBsEre8If8k2VOo1qOCj1KJW8wphfon235Z20UaIiEUxEKo
        B1QFCmzsUXKqm+ydkc7JFZa52dd8XpL2ZDlSYWiloA==
X-Google-Smtp-Source: APiQypJ7Oy6nELcLEYUlmkGdg4fUIFXPut+OUjguHI+4R6WK+FY46uXtvJxmrDdMyVItHkHgwDO30tmGKQxPC01VMQ8=
X-Received: by 2002:a19:c7d8:: with SMTP id x207mr16947210lff.190.1587568166866;
 Wed, 22 Apr 2020 08:09:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200422112719.826676174@infradead.org> <20200422112831.988065598@infradead.org>
 <CAKfTPtB8NiKqggZN3v6u=Rdwj4grzRwn1mW31ov0y5ZhDBcvuw@mail.gmail.com>
 <20200422132923.GK20730@hirez.programming.kicks-ass.net> <CAKfTPtBsFDt8JyxjD39B2YP+kCN9nXWZxnaJys9sz2CjWzd1Zw@mail.gmail.com>
 <20200422135921.GL20730@hirez.programming.kicks-ass.net>
In-Reply-To: <20200422135921.GL20730@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 22 Apr 2020 17:09:15 +0200
Message-ID: <CAKfTPtDa2JPtc2qPSe=d187u8pp7AdvV4wKJiUJsDiAvUTE9hg@mail.gmail.com>
Subject: Re: [PATCH 13/23] sched,ion: Convert to sched_set_normal()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        John Stultz <john.stultz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Apr 2020 at 15:59, Peter Zijlstra <peterz@infradead.org> wrote:
>
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

Yes one must be careful when using it
>
> It's not unbounded, like a true idle-time scheduler would be, but it can
> still be pretty horrible. nice19 has some of that too of course, but
> idle has it worse, esp. also because it begs others to preempt it.

Yeah... you have to pay the benefit of letting other tasks to preempt
faster. But both sched_idle and nice19 have the same weight and as a
result they will have the same amount of running time.  So I'm not
sure that sched-idle will have bigger problems than nice 19 but may be
more often

>
> I should get back to proxy execution I suppose...
