Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ABBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 19:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A489206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 19:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R+Yz0Foz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgFDTU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 15:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgFDTUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 15:20:25 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E590C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 12:20:24 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l26so6299308wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 12:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ouAgXFl2oDrnxvULrGgv6WgEdc2JkyMXoReqxIRdap0=;
        b=R+Yz0FozPBPFPWc9NPwI1q5KqS9DoWZ/gt2LO6RAy54U7fhmfoVIQx4iJFexNJvfwh
         o2w8wi/pvxVgDgw+7urh6y2tN4oEuicJLi65AOGp58A1yEiCZjPGole59Qj9LfFL5m0u
         okppwEX3a7ZzsWzYHtsiE6A9XfOw6cmaOBdT8jPp3vd12VzXvCPVukPWaXuMLrHFJWWR
         tvs3N0hTMVfY4Ykwrq3C82U0R3yCNN5T1ioQqvuD1ERevyIa5MFgw9DFQc73DIfMWHvI
         WDbPuDBFGWZcG7w/LmJyW/1A64WcKkyCWXrMukydp5ce4Cfeq9nsXl1kiXNT6zLS/Tks
         wZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ouAgXFl2oDrnxvULrGgv6WgEdc2JkyMXoReqxIRdap0=;
        b=gB7P4hkEEuOmihMZa+C4xiJX6/VJJXKz3VYwqUmG9MgDwLuZbr7d1Fx052aHk85DoC
         yZYH2ZbdtHvRM+KpHSp5pz98KCjbq3RVLQh2o4pWXRstXp4zVYQ21NrvDY0OefbEtNVF
         Q21bARt/H277+A5fW0tyYAYmdMnN1pPf30KXVDbjTRm1Qkt+87PfdLTAkBBvV+drTAab
         lb8+rPLU3rQL+5KQb4QxPj12tnW7xnnog/+zZ7YIvZcT29+E92YsfBsT4lxB/oVQJS98
         ZLItQ6BaSxu8ZFqtpB6r3QkvWGFvXh62Vo9fgv3eqh0WaBBv3veCED49QkehImiwI2Eq
         wUAA==
X-Gm-Message-State: AOAM531U6TYxLcyvVxbYudA9AqXXRhK8F7Qc63pza3MvKpSzjgI+cXgc
        GbIi5GV72PpQp8DSACYF8wjcW66881T9m+yf/8VY7Q==
X-Google-Smtp-Source: ABdhPJw23Qj+XqKUo8d9Yi8zLVFZDmhHc9ZyRZ5y8DYBKe3GyWRTZppjy7dTb8VyjV1fNr9PaqujNnTfPtIXywE5Tec=
X-Received: by 2002:a1c:6884:: with SMTP id d126mr5337742wmc.121.1591298422679;
 Thu, 04 Jun 2020 12:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200528195442.190116-1-surenb@google.com> <20200604131215.GB4117@hirez.programming.kicks-ass.net>
In-Reply-To: <20200604131215.GB4117@hirez.programming.kicks-ass.net>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 4 Jun 2020 12:20:10 -0700
Message-ID: <CAJuCfpHNfOCRks_Ftbk7tEXsXs7AjPVUuxevKOtQWp9DCE4+8A@mail.gmail.com>
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

On Thu, Jun 4, 2020 at 6:12 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, May 28, 2020 at 12:54:42PM -0700, Suren Baghdasaryan wrote:
> > Each psi group requires a dedicated kthread_delayed_work and
> > kthread_worker. Since no other work can be performed using psi_group's
> > kthread_worker, the same result can be obtained using a task_struct and
> > a timer directly. This makes psi triggering simpler by removing lists
> > and locks involved with kthread_worker usage and eliminates the need for
> > poll_scheduled atomic use in the hot path.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> > This patch is meant to address Peter's request in [1] to pull
> > kthread_queue_delayed_work() out from under rq->lock. This should also address
> > the lockdep warning about possibility of a circular dependency described in [2]
>
> I think you could've just fixed kthread_queue_delayed_work(), that code
> is sub-optimal.

Ok, let me look into it some more. My understanding was that the
worker->lock in kthread_queue_delayed_work() was needed to synchronize
worker->delayed_work_list access. But maybe I'm missing something... I
assume you are talking about optimizing this beyond what
https://lkml.org/lkml/2020/5/4/1148 was doing?

BTW, any objections against taking https://lkml.org/lkml/2020/5/4/1148
? It's not the ultimate fix but it is an improvement since it gets
some of the operations that were unnecessarily under worker->lock out
of it.

>
> But I suppose this works too.

In PSI's case there is always one work for each worker, so the
delayed_work_list and work_list are not needed and therefore I can
replace kthread_worker machinery with a task and a timer.
I think I can simplify this a bit further. For example
group->poll_wakeup doesn't have to be an atomic. Originally I wanted
to avoid a possibility of a race when poll_timer_fn sets it and
psi_poll_worker resets it and as a result misses a wakeup, however if
psi_poll_worker resets it before calling psi_poll_work then there is
no harm in missing a wakeup because we called psi_poll_work and did
the required work anyway.

One question about this patch I'm not sure about and wanted to ask you
Peter is whether it's ok to call mod_timer from within a hotpath
(while holding rq->lock). As I described in the additional comment,
there is a possibility of a race between when I check timer_pending
and the call to mod_timer, so it's possible that mod_timer might be
called both from psi_poll_work (psi poll work handler) and from
psi_task_change (hotpath under rq->lock). I see that mod_timer takes
base->lock spinlock, and IIUC such a race might block the hotpath and
therefore is unacceptable. If this is true I'll need to revive the
poll_scheduled atomic to close this race and then I can change
mod_timer into add_timer.
WDYT? And sorry for my ignorance if this is a trivial question. I'm
not sure about the rules when it comes to rq->locks.

Thanks,
Suren.

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
