Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E18C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD63E23117
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t+y4Obij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727964AbgHFQ2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbgHFQSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:18:47 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AD3C002168
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 09:06:59 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id h16so16524036oti.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 09:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kRzJPbiSWqPMYf9cXUnubjz9KwLdR0t2PlxbglQqDmQ=;
        b=t+y4ObijkT9CwJCdosVyvo3hNb0ZL2IQqYE+OfodlfDj45ikA05n+fCWNnY5GD4pZ8
         ZnMT0RRGiqj1cgMNTKenHMDNmTSR0lUMYqDGgYq45E9L/SP5axhkyDqluQIuqi8uSEmX
         PGfLd1vme9MOv4ADHA4yxeORytbopb4k9g+NSiKNdn+vkAT5YmfhIO2yIhgVvzTGM+q+
         R2LpxADUnvKlV6epXzLdAiAbZfIw+gx0o2rOwcziRgP13Cpqwth84og51FzOZwqP8hAh
         5G22Wr1oLKPn0gpw0Mg4Iclbh0omDHMj4XcLiz4/3MiUIIXZv6PmXo9I1D+ab/4F4+/C
         QH6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kRzJPbiSWqPMYf9cXUnubjz9KwLdR0t2PlxbglQqDmQ=;
        b=p9W77EOGC9ZpcNjki6Ne08E5rXpKfTMsIFrivnEVg01KlbpG8woJWffhlgTk3cHFd9
         j8I1qdodLJF5bcrvnYUiSvS9htcjrWZkmA/w/6ucHYoapdQy5CO/1QbTkMxIWUhI9yZg
         jFmIbcI4NoPnK5l5bXBnqopVAF2o8X/geRlUKyknMrcnvwgMahaEOkx53s8OsDESjZQv
         YajI649BO+VFXGuynsDWzIDNZzPTqosAAEl0DY1kq5Ypgi5xC8WYSAQHXlFMQOz+ACy2
         OEyoD/WN3zB85+gg3DplXMZqccz0CD6bg5NtOB+t7SwkJ/+AHONqxbD4PdHtTkrSox5C
         zZJA==
X-Gm-Message-State: AOAM531rSmVDDvnVbweFYMqSqy+owbG9GA/pj+7zHmKJ/NBcafJv5XuF
        fFl0xirhRd9M4GLXPdi7r+ngAmhSwTKZzVuoK/XPQA==
X-Google-Smtp-Source: ABdhPJwJIAVQosWtiZxAR5ukKpi9U77jc1CvocrDPXa9RPmKehtYj1ngcb2n5vTsNgDi2+Vf46JBBmJ/ZE4zEtXVcoI=
X-Received: by 2002:a9d:65d3:: with SMTP id z19mr8224587oth.233.1596730016189;
 Thu, 06 Aug 2020 09:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007d3b2d05ac1c303e@google.com> <20200805132629.GA87338@elver.google.com>
 <20200805134232.GR2674@hirez.programming.kicks-ass.net> <20200805135940.GA156343@elver.google.com>
 <20200805141237.GS2674@hirez.programming.kicks-ass.net> <20200805141709.GD35926@hirez.programming.kicks-ass.net>
 <CANpmjNN6FWZ+MsAn3Pj+WEez97diHzqF8hjONtHG15C2gSpSgw@mail.gmail.com>
 <CANpmjNNy3XKQqgrjGPPKKvXhAoF=mae7dk8hmoS4k4oNnnB=KA@mail.gmail.com>
 <20200806074723.GA2364872@elver.google.com> <20200806113236.GZ2674@hirez.programming.kicks-ass.net>
 <20200806131702.GA3029162@elver.google.com>
In-Reply-To: <20200806131702.GA3029162@elver.google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 6 Aug 2020 18:06:43 +0200
Message-ID: <CANpmjNNqt8YrCad4WqgCoXvH47pRXtSLpnTKhD8W8+UpoYJ+jQ@mail.gmail.com>
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*() helpers
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        fenghua.yu@intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>, yu-cheng.yu@intel.com,
        jgross@suse.com, sdeep@vmware.com,
        virtualization@lists.linux-foundation.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 at 15:17, Marco Elver <elver@google.com> wrote:
>
> On Thu, Aug 06, 2020 at 01:32PM +0200, peterz@infradead.org wrote:
> > On Thu, Aug 06, 2020 at 09:47:23AM +0200, Marco Elver wrote:
> > > Testing my hypothesis that raw then nested non-raw
> > > local_irq_save/restore() breaks IRQ state tracking -- see the reproducer
> > > below. This is at least 1 case I can think of that we're bound to hit.
> ...
> >
> > /me goes ponder things...
> >
> > How's something like this then?
> >
> > ---
> >  include/linux/sched.h |  3 ---
> >  kernel/kcsan/core.c   | 62 ++++++++++++++++++++++++++++++++++++---------------
> >  2 files changed, 44 insertions(+), 21 deletions(-)
>
> Thank you! That approach seems to pass syzbot (also with
> CONFIG_PARAVIRT) and kcsan-test tests.
>
> I had to modify it some, so that report.c's use of the restore logic
> works and not mess up the IRQ trace printed on KCSAN reports (with
> CONFIG_KCSAN_VERBOSE).
>
> I still need to fully convince myself all is well now and we don't end
> up with more fixes. :-) If it passes further testing, I'll send it as a
> real patch (I want to add you as Co-developed-by, but would need your
> Signed-off-by for the code you pasted, I think.)

With CONFIG_PARAVIRT=y (without the notrace->noinstr patch), I still
get lockdep DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled()), although
it takes longer for syzbot to hit them. But I think that's expected
because we can still get the recursion that I pointed out, and will
need that patch.

I also get some "BUG: MAX_LOCKDEP_CHAINS too low!" on syzbot (KCSAN is
not in the stacktrace). Although it may be unrelated:
https://lore.kernel.org/lkml/0000000000005613c705aaf88e04@google.com/
-- when are they expected?

Thanks,
-- Marco
