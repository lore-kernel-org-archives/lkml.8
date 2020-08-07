Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7335AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4521D2177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 09:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQCDtvOe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgHGJBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgHGJBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 05:01:42 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8DBC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 02:01:42 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id k4so1317759oik.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 02:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AmcYU/Cqf1PQgYD//8cKRjZoT/V5udiPWhn6Gby65YU=;
        b=QQCDtvOeoTY0rYVjRZjOt/pUwuseOsUWN9lTjEfyJDHLW0q/8EgTE964fS5CQC7v7m
         +dXtZ2q3QOZRX/6QKFxF0doMAR56OAKKYBHcWbHW8+ejPSQBc4uV1VIr1gOgzJteRbk9
         ZHf+GnLNGaclcrkZ2EBmtpPUV+DFQVFe0ysPV4J7nEOf542F6LvRUN9jy+aW9kXkpG2A
         vN4vuDlK9ILvjl7NsHqAVj8gxNInVi4BfdIggDJuNwHjdANG1WwPU6oXhyGFMT7c/Mf3
         bwVLpnYOP1PQSyqqiZjJRXilUMYB7SQY5FAhNf+yR9h4aTcPn3WyAt2lITsuUY6lC7ky
         jyMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AmcYU/Cqf1PQgYD//8cKRjZoT/V5udiPWhn6Gby65YU=;
        b=AXPF0SwawFHSL6yqjTMJIt7GYE1x9NrZY8BhDBe8HVTUY3a2dxgfJ7bf4FBiMmrtJL
         oci0B7Kz/3WngTD2ghGrDKBnujp68Dm1PJQw//+/TUFMgyD6i3ifLfBSv5zT7OqGGZbv
         B0YNr4N3KEZntjVW5FYfJLJjfCnaAS+kNvjn4eaji9D7WuzJIf+Vt+agYsEvYGeil9ho
         8VQAOkkL8Qt3m8+yqnx+KQJ8LHBE2AkL0jwrvs0WfbZHB0RqPQ3T16pzLGTZgxFPCItf
         ks/QtMsD0Z4UkCu0zcKrAnmX6L9//qkqUqKYVqTqGCEtU7B9qtI8Qz8dyZptASo3rbD9
         ZZBg==
X-Gm-Message-State: AOAM532fMnrdMbOy81CzoqMQFnDJayiegYARMOjBWUv2HwAKiiCL17dj
        0JvY/+j19YnT33YFdQjR22SRmLa+TuXRXPpXtXQ7JA==
X-Google-Smtp-Source: ABdhPJxTkiSUMGnt6tL7lC7OlOAnE4HlDH1/uGuK8zcTcArkHT+JrOqvlNyMJPNHDF/ECEb8Y2ltcXS0+py4aUn3oVw=
X-Received: by 2002:aca:b8c4:: with SMTP id i187mr10655594oif.121.1596790901265;
 Fri, 07 Aug 2020 02:01:41 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000007d3b2d05ac1c303e@google.com> <20200805132629.GA87338@elver.google.com>
 <20200805134232.GR2674@hirez.programming.kicks-ass.net> <20200805135940.GA156343@elver.google.com>
 <20200805141237.GS2674@hirez.programming.kicks-ass.net> <20200805141709.GD35926@hirez.programming.kicks-ass.net>
 <CANpmjNN6FWZ+MsAn3Pj+WEez97diHzqF8hjONtHG15C2gSpSgw@mail.gmail.com>
 <CANpmjNNy3XKQqgrjGPPKKvXhAoF=mae7dk8hmoS4k4oNnnB=KA@mail.gmail.com>
 <20200806074723.GA2364872@elver.google.com> <20200806113236.GZ2674@hirez.programming.kicks-ass.net>
 <20200806131702.GA3029162@elver.google.com> <CANpmjNNqt8YrCad4WqgCoXvH47pRXtSLpnTKhD8W8+UpoYJ+jQ@mail.gmail.com>
In-Reply-To: <CANpmjNNqt8YrCad4WqgCoXvH47pRXtSLpnTKhD8W8+UpoYJ+jQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 7 Aug 2020 11:01:29 +0200
Message-ID: <CANpmjNO860SHpNve+vaoAOgarU1SWy8o--tUWCqNhn82OLCiew@mail.gmail.com>
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
        syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 at 18:06, Marco Elver <elver@google.com> wrote:
> On Thu, 6 Aug 2020 at 15:17, Marco Elver <elver@google.com> wrote:
> > On Thu, Aug 06, 2020 at 01:32PM +0200, peterz@infradead.org wrote:
> > > On Thu, Aug 06, 2020 at 09:47:23AM +0200, Marco Elver wrote:
> > > > Testing my hypothesis that raw then nested non-raw
> > > > local_irq_save/restore() breaks IRQ state tracking -- see the reproducer
> > > > below. This is at least 1 case I can think of that we're bound to hit.
> > ...
> > >
> > > /me goes ponder things...
> > >
> > > How's something like this then?
> > >
> > > ---
> > >  include/linux/sched.h |  3 ---
> > >  kernel/kcsan/core.c   | 62 ++++++++++++++++++++++++++++++++++++---------------
> > >  2 files changed, 44 insertions(+), 21 deletions(-)
> >
> > Thank you! That approach seems to pass syzbot (also with
> > CONFIG_PARAVIRT) and kcsan-test tests.
> >
> > I had to modify it some, so that report.c's use of the restore logic
> > works and not mess up the IRQ trace printed on KCSAN reports (with
> > CONFIG_KCSAN_VERBOSE).
> >
> > I still need to fully convince myself all is well now and we don't end
> > up with more fixes. :-) If it passes further testing, I'll send it as a
> > real patch (I want to add you as Co-developed-by, but would need your
> > Signed-off-by for the code you pasted, I think.)

I let it run on syzbot through the night, and it's fine without
PARAVIRT (see below). I have sent the patch (need your Signed-off-by
as it's based on your code, thank you!):
https://lkml.kernel.org/r/20200807090031.3506555-1-elver@google.com

> With CONFIG_PARAVIRT=y (without the notrace->noinstr patch), I still
> get lockdep DEBUG_LOCKS_WARN_ON(!lockdep_hardirqs_enabled()), although
> it takes longer for syzbot to hit them. But I think that's expected
> because we can still get the recursion that I pointed out, and will
> need that patch.

Never mind, I get these warnings even if I don't turn on KCSAN
(CONFIG_KCSAN=n). Something else is going on with PARAVIRT=y that
throws off IRQ state tracking. :-/

Thanks,
-- Marco
