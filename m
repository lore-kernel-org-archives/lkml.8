Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6C8C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C0A20870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fzqeEciF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgCEWIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:08:16 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:40548 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726209AbgCEWIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:08:16 -0500
Received: by mail-io1-f65.google.com with SMTP id d8so111254ion.7
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 14:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGS8rnXzHLbpXsJJAH3jh30eyIA7p3nGgcBVwa0A2w8=;
        b=fzqeEciFPF22o5uyQb5nHvkhVF8jr5xf2Wo5iKCh1x0QlRNspF7nqIhsmjI6R0JPN3
         tEi8EvQg+inlv/MZY/54d5x7ow47ExRcP9TN/GAsrIS1QseaOW3dXjAgAuotTHd1SuqV
         ap65h9Hkwnl1INBV+i9n2vvRw9p/S2xfuN7/ilfX8B2CIGzQ1/2M+qxLydAVK46c2LRS
         WDYy39RorrBeZYlr+8liVxg6aCqJj6o6vxBtEgPtYT8GgiTuN0cG7NYJPqe+vjD5yxW+
         5udG5txKOInbYOZbpMrrUpx2jq6Vcgl4vcCnIXy7A1eK5Npk0zFKcuDVPHxzAQlYoeox
         ZAfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGS8rnXzHLbpXsJJAH3jh30eyIA7p3nGgcBVwa0A2w8=;
        b=SPb3C6kcBV6/iskoZzGJqc1nlYUqZoG6WK4xGKM0NeG//ppgPAoiY189AYg1bd9vQR
         LsDaiE/Wg2sI5Yn4Fg3nzhCJVQG8kCYbB4C/u/SgaKICi/WduH/ZJHbTy8eqJ4/KXrvz
         0mHCl+lmwqS1arSytiGpMc9ELWgR2C3SHGFXUUPaM1pCh56Jb3xD37rTT1Q4jHgcRSck
         E9vc/STd2/uGIFS3xO8dv7NN8aV4ph078DQqucAtJNNriACZQE5VauK2RmulHQzxVSM1
         0Yjunyi84xsuoP7+e8lWXrbaJrsliTYvoukUyWd+tPP1ObGEHY16SMbLDv1Kf0rGFxwJ
         WdEg==
X-Gm-Message-State: ANhLgQ3cCJLgqcblfz/8F5jr6AYYcF31tzIOXOdf7C4H4UhkxTYgpr4X
        nktgOgNmWJrG0CXRI574yVSabTYN7p1zAFzHzT3X8A==
X-Google-Smtp-Source: ADFU+vveEQCvuJ7btQNldSOgXGFAeDpBOkfuEX1g8TVAtm4CcqZ0jqP7fo30nSwwhYYivnaHCnk+9qqz5ORdkzcvwIk=
X-Received: by 2002:a02:3093:: with SMTP id q141mr650220jaq.121.1583446094877;
 Thu, 05 Mar 2020 14:08:14 -0800 (PST)
MIME-Version: 1.0
References: <20200304213941.112303-1-xii@google.com> <20200305075742.GR2596@hirez.programming.kicks-ass.net>
 <87blpad6b2.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87blpad6b2.fsf@nanos.tec.linutronix.de>
From:   Paul Turner <pjt@google.com>
Date:   Thu, 5 Mar 2020 14:07:37 -0800
Message-ID: <CAPM31RKR4w75Y8oNxS-cZ77AauvCFFXRzH=hhWXfr6LLQt2Myw@mail.gmail.com>
Subject: Re: [PATCH] sched: watchdog: Touch kernel watchdog in sched code
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, Xi Wang <xii@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Don <joshdon@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

The knob can obviously be removed, it's vestigial and reflects caution
from when we were implementing / rolling things over to it.  We have
default values that we know work at scale. I don't think this actually
needs or wants to be tunable beyond on or off (and even that could be
strictly compile or boot time only).
