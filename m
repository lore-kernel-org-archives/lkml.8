Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F692C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB84F20758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OhMuhXoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgHQHKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgHQHKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:10:47 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E311EC061388
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 00:10:46 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id l204so13974899oib.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 00:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yjoi260yivvP8E6VWrtmP+N5ypeCnjjZyP0aQQnqe/M=;
        b=OhMuhXoTQ8sDuP2VzfqpdbjlOHEj2dXmR8dEiSEBWTL2GfPjIGBRLuFtA1Z5CbwOfz
         xxSi5QjyDz1zuz+NVO7M3hLBjTlUn7N47KbczSAr3HzvR5uP5adz/5tTPt1djhfj7bGa
         URyv+LzO/KA/mihbRAWKJz76MzcNODlK/X1BN0OkxdhCEwN02P5ygU/ARzs73bFr9VpV
         mqI6aCS7HVyb6X9LKY+NAU7sTUl0nL1viANnYejE4Z/qQzv3n/i2KhuJQCgXG6oMQH7X
         uppDOlFl/krlzy4jVxU2TZaTcfv6d5EkkMqus9kw6WyPURbzhEIvHqM+JMz+gx5RC0tk
         J14g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yjoi260yivvP8E6VWrtmP+N5ypeCnjjZyP0aQQnqe/M=;
        b=Kbbhv6rE9PQrPAfBbzI1eQ1LmyEgYWgUpJNZeEaiSaR0j2pdrdHdSXB61sVCqIecXj
         /Gu0MotrTV4OH3+pDvV2re0kNknfAN/ATmEwW/VzMYY7D4c8CjauFdHm9Quyb4ImNFPl
         +MdTO5rFYgJ5qf0iz6EL67pbL7Mv9DHvIHCQtfxfefQCSxsNHi/iJ12SX7mfWLgufbfg
         z9JJBfbYYixeEdZxzmHGPik4uKDggPOO9cFGm8IT+gfGe+NDK/HaLLlc1JnJKjgq/JEY
         fQB4g1qjZ9bCZKeUq8PV6XvFT8d4WC7D4xIyZdCe5SdT/AQ1hybzqiF534ucbOa/bRG2
         0TwQ==
X-Gm-Message-State: AOAM532ngS8al3F6q9YA0HpQzKepvQdUrLWirdTZGcHuA0kZwO5rRLAp
        wLwwukadp8JSStbcoJ8EtfsJw0+6MXgJ1W7ZQZU6cQ==
X-Google-Smtp-Source: ABdhPJwlVHo4MS+1XuXNymGW9ImwwYnBx/t4+c4KCEPyzFY62JhauWBY8c3AEs7t4tsTfyxaH8c0LTxMtrMpsk3pqIU=
X-Received: by 2002:aca:aa8c:: with SMTP id t134mr8082078oie.121.1597648243722;
 Mon, 17 Aug 2020 00:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200807090031.3506555-1-elver@google.com> <87pn7yxnjc.fsf@nanos> <CANpmjNPz8vZLGWUzO_8xxtxdXC7cODUL1zVyZf-rBKDBd9LOpA@mail.gmail.com>
In-Reply-To: <CANpmjNPz8vZLGWUzO_8xxtxdXC7cODUL1zVyZf-rBKDBd9LOpA@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 17 Aug 2020 09:10:32 +0200
Message-ID: <CANpmjNM7kyBLpvcL7wqAUpMnQhPv8zc=aCnE2eQO248b9-2CNQ@mail.gmail.com>
Subject: Re: [PATCH] kcsan: Treat runtime as NMI-like with interrupt tracing
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Aug 2020 at 08:56, Marco Elver <elver@google.com> wrote:
> On Mon, 10 Aug 2020 at 22:18, Thomas Gleixner <tglx@linutronix.de> wrote:
> > Marco Elver <elver@google.com> writes:
> > > Since KCSAN instrumentation is everywhere, we need to treat the hooks
> > > NMI-like for interrupt tracing. In order to present an as 'normal' as
> > > possible context to the code called by KCSAN when reporting errors, we
> > > need to update the IRQ-tracing state.
> > >
> > > Tested: Several runs through kcsan-test with different configuration
> > > (PROVE_LOCKING on/off), as well as hours of syzbot testing with the
> > > original config that caught the problem (without CONFIG_PARAVIRT=y,
> > > which appears to cause IRQ state tracking inconsistencies even when
> > > KCSAN remains off, see Link).
> > >
> > > Link: https://lkml.kernel.org/r/0000000000007d3b2d05ac1c303e@google.com
> > > Fixes: 248591f5d257 ("kcsan: Make KCSAN compatible with new IRQ state tracking")
> > > Reported-by: syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com
> > > Co-developed-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > ---
> > > Patch Note: This patch applies to latest mainline. While current
> > > mainline suffers from the above problem, the configs required to hit the
> > > issue are likely not enabled too often (of course with PROVE_LOCKING on;
> > > we hit it on syzbot though). It'll probably be wise to queue this as
> > > normal on -rcu, just in case something is still off, given the
> > > non-trivial nature of the issue. (If it should instead go to mainline
> > > right now as a fix, I'd like some more test time on syzbot.)
> >
> > I'd rather stick it into mainline before -rc1.
> >
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
>
> Thank you, sounds good.
>
> FWIW I let it run on syzkaller over night once more, rebased against
> Sunday's mainline, and found no DEBUG_LOCKDEP issues. (It still found
> the known issue in irqentry_exit(), but is not specific to KCSAN:
> https://lore.kernel.org/lkml/000000000000e3068105ac405407@google.com/)

I lost track of what's happening with the IRQ state tracking patches.
Do we still need this?

Or would Peter's new approach (to make raw->non-raw work) supersede this patch?
    https://lkml.kernel.org/r/20200811201755.GI35926@hirez.programming.kicks-ass.net

Which would appear to be the nicer solution.

Thanks,
-- Marco
