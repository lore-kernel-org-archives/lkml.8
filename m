Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47863C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 02:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BAC820774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 02:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o/GCCrxJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgFIC5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 22:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgFIC5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 22:57:01 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0340C03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 19:57:01 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id t132so10809165vst.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 19:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n021Bv2sm3YRmta3I91RDU4sLE2ElfUH8G8nw2qo8eU=;
        b=o/GCCrxJ8LOZxQY0gEjPerQWKZdD4HYbN3kq002PwZu3hVxjsei57KMYIpCbuAHgNA
         h/EGBq+NhW4vSjZg4ssUVQIWgyu0JrB5sd2XjhRfrHSCrb22BhXxWxv8EscX2zdasIrB
         kssEyyaX8ZgAynZqTsvlCbD1vcFYyai6Wkj7V3DlKgkGeDCp5D/HOK/p6jkaV2YDvr/g
         4TJNIDRjm1DNPjBQ5+wuQ9wjxdNRzvKovLd7SNTOqX4g3YlQPFPJ/zBNenOfY7S+aTAI
         hZs9wgUaaSXsnII+sYJtL05lrfkefJDDqLADA+GENrNK5wCCsP15Ud2Hp+oRAlxmYGcb
         /QMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n021Bv2sm3YRmta3I91RDU4sLE2ElfUH8G8nw2qo8eU=;
        b=QZOyGQ2RonIfK64WaXVbt1rvaS+Y6pxiUVgsW9XetlEIYb3QdHEgECTuxXA8I9Emud
         JUtJTSVqNXKa1Oo7wsNc44Nc3k1S3s8IiyD8uQO0dOOt6xmryoNoBlRnNqY5cSSVqvmb
         o4dZADKcCAq78ggTyx8BR+whtiDIC4iTkc9nmNu8Pqyun/MeN1GmP7xnV8G+B/lnpviJ
         KrTliYwHssGo8haWXmbMwfyQpFyPVpUL0B6CDyRiTuubjNHISxceUCK4G6cD7nE5BrDC
         pYXcf7OMPK4qkR1gAYhwY2QhISGhhLhd2LtCPkJUwHCL3G/4yPuWZNgRLkhrxXwEXFiN
         uOMw==
X-Gm-Message-State: AOAM531qQZ8MyCgl3x5CF1sbFcCddar8Fe6W4fqFoTJo/tmxUrJndayb
        47YW7jYl7sytb/ZNMfEwOpg2RpRDj+/NGaDqw6049w==
X-Google-Smtp-Source: ABdhPJxoZ8B15Wtzm0OsHQ/N3REdS7lJEraKx3KX9bE9C++I4vi5BwHLo9Mbo7ScmMvdlg6uB6bVU1KqFELFetzxrys=
X-Received: by 2002:a67:1d06:: with SMTP id d6mr1259880vsd.119.1591671420266;
 Mon, 08 Jun 2020 19:57:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200528195442.190116-1-surenb@google.com> <20200604131215.GB4117@hirez.programming.kicks-ass.net>
 <CAJuCfpHNfOCRks_Ftbk7tEXsXs7AjPVUuxevKOtQWp9DCE4+8A@mail.gmail.com>
In-Reply-To: <CAJuCfpHNfOCRks_Ftbk7tEXsXs7AjPVUuxevKOtQWp9DCE4+8A@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 8 Jun 2020 19:56:49 -0700
Message-ID: <CAJuCfpGKsAs44AsRUF71E=Q-QyFbdH+05358BxhbQ-dAoz59YQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] psi: eliminate kthread_worker from psi trigger
 scheduling mechanism
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>, mgorman@suse.de,
        Shakeel Butt <shakeelb@google.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 4, 2020 at 12:20 PM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Thu, Jun 4, 2020 at 6:12 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, May 28, 2020 at 12:54:42PM -0700, Suren Baghdasaryan wrote:
> > > Each psi group requires a dedicated kthread_delayed_work and
> > > kthread_worker. Since no other work can be performed using psi_group's
> > > kthread_worker, the same result can be obtained using a task_struct and
> > > a timer directly. This makes psi triggering simpler by removing lists
> > > and locks involved with kthread_worker usage and eliminates the need for
> > > poll_scheduled atomic use in the hot path.
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > > This patch is meant to address Peter's request in [1] to pull
> > > kthread_queue_delayed_work() out from under rq->lock. This should also address
> > > the lockdep warning about possibility of a circular dependency described in [2]
> >
> > I think you could've just fixed kthread_queue_delayed_work(), that code
> > is sub-optimal.

After some more staring into kthread code I think I understand what
Peter's comment meant about delayed_work_list.
worker->delayed_work_list seems to be unnecessary because each
kthread_delayed_work has its own timer which will add the work into
worker->work_list when the time comes. So there is no need to store
the delayed work in an intermediate worker->delayed_work_list.
However I think kthread_destroy_worker() has an issue if it's called
while worker->delayed_work_list is non-empty. The issue is that
kthread_destroy_worker() does not stop all the
kthread_delayed_work->timers scheduled on the
worker->delayed_work_list. So if such a timer fires after a call to
kthread_destroy_worker(), timer's handler will dereference the already
destroyed worker.

If I'm right and this is indeed an issue then I think we do need
worker->delayed_work_list to cancel all the scheduled timers. The
issue can be avoided if we assume that the caller will alway call
kthread_cancel_delayed_work_sync() for each delayed_work scheduled on
worker->delayed_work_list before calling kthread_destroy_worker(). If
that's what we expect I think this expectation should be reflected in
the comments and a WARN_ON(!list_empty(&worker->delayed_work_list)) be
added in kthread_destroy_worker(). WDYT?

>
> Ok, let me look into it some more. My understanding was that the
> worker->lock in kthread_queue_delayed_work() was needed to synchronize
> worker->delayed_work_list access. But maybe I'm missing something... I
> assume you are talking about optimizing this beyond what
> https://lkml.org/lkml/2020/5/4/1148 was doing?
>
> BTW, any objections against taking https://lkml.org/lkml/2020/5/4/1148
> ? It's not the ultimate fix but it is an improvement since it gets
> some of the operations that were unnecessarily under worker->lock out
> of it.
>
> >
> > But I suppose this works too.
>
> In PSI's case there is always one work for each worker, so the
> delayed_work_list and work_list are not needed and therefore I can
> replace kthread_worker machinery with a task and a timer.
> I think I can simplify this a bit further. For example
> group->poll_wakeup doesn't have to be an atomic. Originally I wanted
> to avoid a possibility of a race when poll_timer_fn sets it and
> psi_poll_worker resets it and as a result misses a wakeup, however if
> psi_poll_worker resets it before calling psi_poll_work then there is
> no harm in missing a wakeup because we called psi_poll_work and did
> the required work anyway.
>
> One question about this patch I'm not sure about and wanted to ask you
> Peter is whether it's ok to call mod_timer from within a hotpath
> (while holding rq->lock). As I described in the additional comment,
> there is a possibility of a race between when I check timer_pending
> and the call to mod_timer, so it's possible that mod_timer might be
> called both from psi_poll_work (psi poll work handler) and from
> psi_task_change (hotpath under rq->lock). I see that mod_timer takes
> base->lock spinlock, and IIUC such a race might block the hotpath and
> therefore is unacceptable. If this is true I'll need to revive the
> poll_scheduled atomic to close this race and then I can change
> mod_timer into add_timer.
> WDYT? And sorry for my ignorance if this is a trivial question. I'm
> not sure about the rules when it comes to rq->locks.
>
> Thanks,
> Suren.
>
> >
> > --
> > To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >
