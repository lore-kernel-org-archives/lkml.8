Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569ADC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F42B2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eA/Llucr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCEVls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 16:41:48 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39782 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgCEVls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:41:48 -0500
Received: by mail-ot1-f66.google.com with SMTP id x97so407732ota.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 13:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=zTMkBqRXWtuag7VWknouHi7tC0angRdQ/CUfF///Ayk=;
        b=eA/Llucrfq6/R2bMv5UhSMiYGd+gfzDkRFfX5g4+2rcLY7U37DCNU5nY4guXfC0tvb
         gG5ySIDiNSzzx7DdhKLvQAM/bdqRKUbo11GYW4LMPNmItNEIZNOSgPQj7BSCeK3/fFVs
         3AZgJxVPgDXjlf8rKJ2nsewjfa9OavSRyg+cRPfoDsTjNiBhfjDZlfsL4CMwMOD6Kfrh
         DiLGZj2SS4BfC8G3XfH+ZrNwtzH5L7513jWInfFAafSTksVWMqnhcae+hpR01BO0ndiJ
         DaWeWQpN+SLQipoOUYaBoUJAGWTgDhHEh8cx8hMPJShUqAUtkfwEsWzklgBz+ufwkXGH
         UFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=zTMkBqRXWtuag7VWknouHi7tC0angRdQ/CUfF///Ayk=;
        b=iY1IvTQOJgKBFOn6UNH7pCOLZwPS1SiNQw3jZMfxcEWpwjpRPnggtCogXer/Uh+mvy
         f1O7WakO/WGoIvnSozffewgm9fJcSiulQ4MxSe2DMXKtXuFajPbdzoW3DjSeiyluwqSz
         a5eYdrjrk+b8KK62Bi25SHJKicemC8wYR8YbHN3AZHm5kjHzK6vb0lraJOeKWHoLbIhA
         NIeD5eqZfiY1KbNadAGyGztjFIL8eJdNbdndhk7fErmRjK48C4+2zC4GlUYdaNQyMcUi
         Nw2Bs0pX8YnNaZTH5b+pbrv41Qur/5Mqy70bXSztp3EqbCVqEYN6nOE1ZihnfCOfA90g
         2EuQ==
X-Gm-Message-State: ANhLgQ3HzY/s/i8jfUQiY22tGCfL0lr8ai9zHaiZ4zpzWEQDBh0IUIvd
        sKMEvzuOn4a/gh5wAZPkvOWNXlmJgxSPDB7bxpZl+Epiql8=
X-Received: by 2002:a9d:7c85:: with SMTP id q5mt438830otn.341.1583444507323;
 Thu, 05 Mar 2020 13:41:47 -0800 (PST)
MIME-Version: 1.0
References: <20200304213941.112303-1-xii@google.com> <20200305075742.GR2596@hirez.programming.kicks-ass.net>
 <87blpad6b2.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87blpad6b2.fsf@nanos.tec.linutronix.de>
From:   Xi Wang <xii@google.com>
Date:   Thu, 5 Mar 2020 13:41:36 -0800
Message-ID: <CAOBoifgTZ_h4MJv7-yJwrQ4jAYQtHfajxBCyZNJkerKko+e9nQ@mail.gmail.com>
Subject: Re: [PATCH] sched: watchdog: Touch kernel watchdog in sched code
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Measuring jitter from a userspace busy loop showed a 4us peak was
flattened in the histogram (cascadelake). So the effect is likely
reducing overhead/jitter by 4us.

Code in resched_for_watchdog should be ok since it is always called
from the watchdog hrtimer function?

Why supporting the option to alternate between thread context and
touch in sched: Might be a little risky to completely switch to the
touch in sched method. Touch in sched for 9 out of 10 times still
captures most of the latency benefit. I can remove it or change it to
on/off if desired.

Advertising the knob on random blogs: Maybe I should create a blog :)

-Xi


On Thu, Mar 5, 2020 at 10:07 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Peter Zijlstra <peterz@infradead.org> writes:
>
> > On Wed, Mar 04, 2020 at 01:39:41PM -0800, Xi Wang wrote:
> >> The main purpose of kernel watchdog is to test whether scheduler can
> >> still schedule tasks on a cpu. In order to reduce latency from
> >> periodically invoking watchdog reset in thread context, we can simply
> >> touch watchdog from pick_next_task in scheduler. Compared to actually
> >> resetting watchdog from cpu stop / migration threads, we lose coverage
> >> on: a migration thread actually get picked and we actually context
> >> switch to the migration thread. Both steps are heavily protected by
> >> kernel locks and unlikely to silently fail. Thus the change would
> >> provide the same level of protection with less overhead.
> >>
> >> The new way vs the old way to touch the watchdogs is configurable
> >> from:
> >>
> >> /proc/sys/kernel/watchdog_touch_in_thread_interval
> >>
> >> The value means:
> >> 0: Always touch watchdog from pick_next_task
> >> 1: Always touch watchdog from migration thread
> >> N (N>0): Touch watchdog from migration thread once in every N
> >>          invocations, and touch watchdog from pick_next_task for
> >>          other invocations.
> >>
> >
> > This is configurable madness. What are we really trying to do here?
>
> Create yet another knob which will be advertised in random web blogs to
> solve all problems of the world and some more. Like the one which got
> silently turned into a NOOP ~10 years ago :)
>
>
