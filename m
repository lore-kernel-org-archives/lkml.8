Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBF6C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A438E20684
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tw9yqbDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgGQMUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 08:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgGQMUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 08:20:49 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A925C061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 05:20:49 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id e8so12383219ljb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 05:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DwfCGqbD5lQwmf4fC3hEbDFXt8ko4ZIjvd0waQjMN0E=;
        b=tw9yqbDfxO6k80jAMzVf4SXetGvar2AQm2QGYgMDDMa0ng10Iac/kF3HaAqHda8LJn
         BiJS50vsPZC/BfAWKeVBtcruLzEwHcXWVn8qMA6OZPE0ImWA7iwdlkUvJXiRf5KLZRHd
         rO10gQfbNh4SEVrjiQyJ1txgwco+pyI4hlEb2BtM4izaWVr4tvAiJPiHrtwMR9bTVqwf
         ez1W45RmZ54ieDpPC1Sa4l0jMIStngH/QCcMKzk6kCMEV6uakn8bjVBbjZ8AzYGZKakk
         KCXRKb+vetRpiUhJMcJ0ESOtuvTRRVccNyjosvPzzwhmemXnUHkmXOMOZS/v7Vs6LmJJ
         5xdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DwfCGqbD5lQwmf4fC3hEbDFXt8ko4ZIjvd0waQjMN0E=;
        b=SuglOTWADFThzjpSwsIQAJvyoj5DRRkKrcvDC5Q153o32l5OzvaZ9MUwSJ+xiNMkRM
         u7wj4tUWWrxr3upaONfQT5uM97HEXVsWvdBo3uiQxslutWmUGCIQGr/AdHTdjXllB1Uw
         e24rggvJpNYI9clc68PumrOUvLtVetTxQc3jqE/cRYSeQ6ZgU8E2/BjAUKG169FnaI0O
         1oW/JLlpL+F1g6CpYZlKrhjHZ9VmvSKJXNQbYNeMV4JmqPmgcER3LCYsOyaCVjg4y1kj
         C9AW6BnDOWuu05x63813F710yMCUFofTgYSRbU9mwpUOtndMCDeQojyPf1X3xXA8AgA6
         n+EQ==
X-Gm-Message-State: AOAM533Mav8Ct1O7lApPF6Lyz6mwxZ4SjuAVwwHUygR1GavD8b+LVNDo
        MsogPpS8rrQoQdTUKadYCV548PGO+n2GCRPZ9YIVvQ==
X-Google-Smtp-Source: ABdhPJwrxgNiUP7dqmGOGUxqcollpyKLdIrMdeMpHVVZweZ3BzhB7ioNqx66hciqpinEs2DE2Jo1KdFdozlwQF/CyUo=
X-Received: by 2002:a05:651c:512:: with SMTP id o18mr4683481ljp.226.1594988447944;
 Fri, 17 Jul 2020 05:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <87v9kv2545.derkling@matbug.com> <87h7wd15v2.derkling@matbug.net>
 <87imgrlrqi.derkling@matbug.net> <87mu5sqwkt.derkling@matbug.net>
 <87eer42clt.derkling@matbug.net> <87imfi2qbk.derkling@matbug.net>
 <87blla2pdt.derkling@matbug.net> <CAKfTPtBHmP6BOrx6XGqZ7UpCFxWCZz23KWf4DXtAhRGUPfjebA@mail.gmail.com>
 <878sfrywd8.derkling@matbug.net> <CAKfTPtAWgWZMx4GA_N0j1jxXRtDDdo9yix7mOBZ_zdsRrqJA8Q@mail.gmail.com>
 <46c7f966-6679-bb9e-dabe-bb385298d19b@arm.com>
In-Reply-To: <46c7f966-6679-bb9e-dabe-bb385298d19b@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 17 Jul 2020 14:20:36 +0200
Message-ID: <CAKfTPtAQE_n6gtH_DiDb_xQtdX=iA=jGWacf0b+=Ab6mYDg1kQ@mail.gmail.com>
Subject: Re: [SchedulerWakeupLatency] Per-task vruntime wakeup bonus
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Patrick Bellasi <patrick.bellasi@matbug.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Josef Bacik <jbacik@fb.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Parth Shah <parth@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020 at 18:48, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>
> On 13/07/2020 14:59, Vincent Guittot wrote:
> > On Fri, 10 Jul 2020 at 21:59, Patrick Bellasi
> > <patrick.bellasi@matbug.net> wrote:
> >>
> >>
> >> On Fri, Jul 10, 2020 at 15:21:48 +0200, Vincent Guittot <vincent.guittot@linaro.org> wrote...
>
> [...]
>
> >>> Instead, it should weight the decision in wakeup_preempt_entity() and
> >>> wakeup_gran()
> >>
> >> In those functions we already take the task prio into consideration
> >> (ref details at the end of this message).
> >>
> >> Lower nice value tasks have more chances to preempt current since they
> >> will have a smaller wakeup_gran, indeed:
> >
> > yes, and this is there to ensure a fair distribution of running time
> > and prevent a task to increase significantly its vruntime compare to
> > others
> >
> > -1 min that se already got more runtime than current
> > 0 that se's vruntime will go above current's vruntime after a runtime
> > duration of  sched_min_granularity
> > and 1 means that se got less runtime than current and its vruntime
> > will still be lower than current ones even after a runtime duration of
> > sched_min_granularity
> >
> > IMHO, latency_nice should impact the decision only for case 0 but not
> > the case -1 and 1.
> > That being said, we can extend the case 0 a bit to include the
> > situation where current's vruntime will become greater than se's
> > vruntimes after a runtime duration of  sched_min_granularity like
> > below:
> >
> >                                                            curr->vruntime
> >                                           |<-- wakeup_gran(se) -->|<--
> > wakeupgran(curr) -->|
> > current range: se->vruntime          +1   |        0              |    -1
> > new range:     se->vruntime          +1   |                       0
> >                     |   -1
> >
>
> I assume this got messed up by line break somehow:

yes

>
>                                                    curr->vruntime
>                                  |<-- wakeup_gran(se) -->|<-- wakeup_gran(curr) -->|
> current range: se->vruntime  +1  |        0              |    -1
> new range:     se->vruntime  +1  |                       0                         | -1
>
> IMHO, with the current use of wakeup_preempt_entity() I don't see what
> will change with that.
> We check 'wakeup_preempt_entity() == 1' in check_preempt_wakeup() and
> 'wakeup_preempt_entity() < 1' in pick_next_entity().
>
> How should the mapping between se's latency_nice value to the consideration of
> wakeup_gran(curr) look like?

IMO, the latency_nice can be used to move the +1|0 boundary on the
right  and the 0|-1 on the left with a formula that need to be defined
And we also need to review where and how wakeup_preempt_entity is used

>
> [...]
