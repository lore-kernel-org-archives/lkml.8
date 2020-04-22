Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE515C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 896B02076C
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 13:29:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nnFtRw/8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgDVN36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 09:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgDVN36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 09:29:58 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5C2C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 06:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ofPUXT9Ajy3OXakbVBD3vabn2HMMLX/q/2RtkTmNqjo=; b=nnFtRw/8r0xI00tvS6Xb+/M4J2
        ZpjX4/LsVHXf2wP1i/J6YUd2gD5Uv637VDakaHxqLq0z8/fXrkGzl1IdFJliPWB14y5fCPevgJ+YK
        DuMvcmZ9Fw5H17+ZXPFPV9n43j5N/4NSYxZp6Kav67k6Tkx+EQ37lnPkM7AOUG0MbhLA7lnzv7t7T
        FdY+kmm5F5mWFbYh7ROxRkAkFrh0zFXe2ZdBzalSE9SjUlSljjAdp4DFfGUVjAUIo3ngVZFhcjIbM
        VBuf+Uoxm8vAx3VQBURZ5AzCtup3H21aNJBt9JKJ5/ncGknf+XFwQRtMghHhKp/eqh59Hc2fDoYHV
        7R+cjWhg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRFRM-00012q-Oi; Wed, 22 Apr 2020 13:29:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E4D43011C6;
        Wed, 22 Apr 2020 15:29:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 430AD25E23BE2; Wed, 22 Apr 2020 15:29:23 +0200 (CEST)
Date:   Wed, 22 Apr 2020 15:29:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 13/23] sched,ion: Convert to sched_set_normal()
Message-ID: <20200422132923.GK20730@hirez.programming.kicks-ass.net>
References: <20200422112719.826676174@infradead.org>
 <20200422112831.988065598@infradead.org>
 <CAKfTPtB8NiKqggZN3v6u=Rdwj4grzRwn1mW31ov0y5ZhDBcvuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtB8NiKqggZN3v6u=Rdwj4grzRwn1mW31ov0y5ZhDBcvuw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 03:21:45PM +0200, Vincent Guittot wrote:
> On Wed, 22 Apr 2020 at 13:29, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > In an attempt to take away sched_setscheduler() from modules, change
> > this into sched_set_normal(.nice = 19).
> >
> > Cc: john.stultz@linaro.org
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Ingo Molnar <mingo@kernel.org>
> > ---
> >  drivers/staging/android/ion/ion_heap.c |    3 ---
> >  1 file changed, 3 deletions(-)
> >
> > --- a/drivers/staging/android/ion/ion_heap.c
> > +++ b/drivers/staging/android/ion/ion_heap.c
> > @@ -244,8 +244,6 @@ static int ion_heap_deferred_free(void *
> >
> >  int ion_heap_init_deferred_free(struct ion_heap *heap)
> >  {
> > -       struct sched_param param = { .sched_priority = 0 };
> > -
> >         INIT_LIST_HEAD(&heap->free_list);
> >         init_waitqueue_head(&heap->waitqueue);
> >         heap->task = kthread_run(ion_heap_deferred_free, heap,
> > @@ -255,7 +253,7 @@ int ion_heap_init_deferred_free(struct i
> >                        __func__);
> >                 return PTR_ERR_OR_ZERO(heap->task);
> >         }
> > -       sched_setscheduler(heap->task, SCHED_IDLE, &param);
> > +       sched_set_normal(heap->task, 19);
> 
> Would it make sense to have a sched_set_idle(task) to enable kernel
> setting SCHED_IDLE task ?
> 
> SCHED_NORMAL w/ nice 19 and SCHED_IDLE tasks are not treated in the
> same way when checking for preemption at  wakeup

Yeah, but does it really matter? I did indeed consider it, but got
lazy. Is there a definite need for IDLE?
