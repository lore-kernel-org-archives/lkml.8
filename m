Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE63C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C63206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 16:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WUkPN4Wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgCMQKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 12:10:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42672 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgCMQKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 12:10:09 -0400
Received: by mail-lj1-f193.google.com with SMTP id q19so11095101ljp.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 09:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lc+TP9X/BI4s1ZOmMJJExFGcSgfoK31/UWMx2IREy7U=;
        b=WUkPN4Wxp/NqTBgJtvLPZHaL5YWWT4h6el7l/K39lgDGtaleAy/V3UhoGaGubxN3SP
         1G278PShBfkS38pzHUgZdQZ2LNEeV+MZPVck/R5NKf4R1mhAa8xiO0bbCXZvUDBqcsK7
         VaXxJPfbe2lQ+9AfTj/6yY8KJGGSI0sgy6kDbm8BO6Nn5STWEUuW9z9wo0nmLFQsWmZr
         g0+62Db3M8tl5V5/+OBAgUub0X/27PAd+Fb/9kV38l7rr4N4pUODqlWSo5lsls/B8zKL
         SZ1a9QPc0dWzC7I4ilLGpkqaBwF+DTUvVk4fFoa5k/VC9IbfJZrjWsup7TVNl2yU6Y4N
         XTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lc+TP9X/BI4s1ZOmMJJExFGcSgfoK31/UWMx2IREy7U=;
        b=p0ddYCp4zl0qMDrTKGTi/0RguYGsr23TuRs3jNpV2xY0TmM7gxUvFRunCENEWndGFg
         caHYPN+o6WX4nGTKlXVr9pL3j1nCkLV62U05vlVgtUZaON4PGlTEZA1a9/QD/ZVfrdv2
         ApzViu2/3k3WMiLedgUAh56vpZlUtwTxB1vIVSOQumTE+2i4btJ7PfFAq7kz34MvjMyF
         CnBOHTsUfBruqebXwHPRPmAWOgRQP0bq4HFPiX8RoRGgbJgaXfKGSC+zdZ+e0d45tJTG
         eaqw8/FPxgSYzlaPxE3Z2MxxbK8kGt4iNwgwfaDL9/tUquFCsMdQ3uOdY5UplYT2uEYt
         B3hw==
X-Gm-Message-State: ANhLgQ3/fYc5nIJvTVsf+Cvl+h8hzbuNH1UjICQIaFhuuZfi91Z3tqmq
        Iwzzp9S7Lk+2Io3AKe5yp+xAIh/esuEjnJW8m5ynsw==
X-Google-Smtp-Source: ADFU+vsRYQgGwBmyIdQpBHKqIX+xC/FgAeHQZpOpC1IxZt1Zj2kLuD4UfuVbCwMBCq2tDzsoed+Qq/szOEBf8JCPQEA=
X-Received: by 2002:a2e:8112:: with SMTP id d18mr8498758ljg.137.1584115806555;
 Fri, 13 Mar 2020 09:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200312165429.990-1-vincent.guittot@linaro.org>
 <jhjr1xwjz96.mognet@arm.com> <CAKfTPtCQZMOz9HzdiWg5g9O+W=hC5E-fiG8YVHWCcODjFRfefQ@mail.gmail.com>
 <jhjpndgjxxk.mognet@arm.com> <jhj4kuspgse.mognet@arm.com> <CAKfTPtD67EKA46i12FHpJQT4gTzaH=ASAyb2dhv4=owPHBRSdQ@mail.gmail.com>
 <CAKfTPtBZgvTBYR+kYjj9dHq8_25mG19CZmYzY5s33ijSHdLGyQ@mail.gmail.com> <jhj36acp88q.mognet@arm.com>
In-Reply-To: <jhj36acp88q.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 13 Mar 2020 17:09:55 +0100
Message-ID: <CAKfTPtAMmYONX+qxp1Awj+XpqkWU3ootcyv7iar7e6z5nSczpw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: improve spreading of utilization
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020 at 16:47, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
>
> On Fri, Mar 13 2020, Vincent Guittot wrote:
> >> > And with more coffee that's another Doh, ASYM_PACKING would end up as
> >> > migrate_task. So this only affects the reduced capacity migration, which
> >>
> >> yes  ASYM_PACKING uses migrate_task and the case of reduced capacity
> >> would use it too and would not be impacted by this patch. I say
> >> "would" because the original rework of load balance got rid of this
> >> case. I'm going to prepare a separate fix  for this
> >
> > After more thought, I think that we are safe for reduced capacity too
> > because this is handled in the migrate_load case. In my previous
> > reply, I was thinking of  the case where rq is not overloaded but cpu
> > has reduced capacity which is not handled. But in such case, we don't
> > have to force the migration of the task because there is still enough
> > capacity otherwise rq would be overloaded and we are back to the case
> > already handled
> >
>
> Good point on the capacity reduction vs group_is_overloaded.
>
> That said, can't we also reach this with migrate_task? Say the local

The test has only been added for migrate_util so migrate_task is not impacted

> group is entirely idle, and the busiest group has a few non-idle CPUs
> but they all have at most 1 running task. AFAICT we would still go to
> calculate_imbalance(), and try to balance out the number of idle CPUs.

such case is handled by migrate_task when we try to even the number of
tasks between groups

>
> If the migration_type is migrate_util, that can't happen because of this
> change. Since we have this progressive balancing strategy (tasks -> util
> -> load), it's a bit odd to have this "gap" in the middle where we get
> one less possibility to trigger active balance, don't you think? That
> is, providing I didn't say nonsense again :)

Right now, I can't think of a use case that could trigger such
situation because we use migrate_util when source is overloaded which
means that there is at least one waiting task and we favor this task
in priority

>
> It's not a super big deal, but I think it's nice if we can maintain a
> consistent / gradual migration policy.
>
> >>
> >> > might be hard to notice in benchmarks.
