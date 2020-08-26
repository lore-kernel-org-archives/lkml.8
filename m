Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A13F8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD7020707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:30:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QakGTVbn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgHZMau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbgHZMaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:30:46 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A254C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 05:30:46 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id v16so818507plo.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 05:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lKGfppbU0E9vUo/Yy4y4n653KjJPK3r8SJn5wAvVr+w=;
        b=QakGTVbnXji0yIrLxFbJeBQ4Wf27OXuadMyAl+bRhLmub3MVtzX2wowojkT9zFhudo
         4ecf/bj36eiq5t7/Xlbi1OBjE9CSJ7lTTQASsQMdjzAM31kZSMAdmbDPkmsDq62jIWLm
         4EPiv8fBPc0g7CfEV5HS/ESM5rtS1YmNgyo2FrY7BWcOfbcCTHN6Ub1BNh5nv7MvTo2f
         NgNHpBVzB+w4EAVGzWptlpbZqkUVaejmuPBIF8xTNSRptmsxR3s7Pbv+rkmxNVC4irOT
         TNt184ss1jrFY2Ino4qBMzI6FBff3MO38MvnQxyQ/EKBCU/t3uQH9iZ3kPgbQ/KIzYzM
         HEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lKGfppbU0E9vUo/Yy4y4n653KjJPK3r8SJn5wAvVr+w=;
        b=OcTMiam7PgB4wvG8sShFRPoW8do7exjufrE48h1q+azyy7ursgWVDIqcCCQJrKIqav
         nm2pSlZsCxLjt843xp8GtA+mWg+ee/cPpYcX//IGRVzYe3eViMr2I3VYZyclKetJbsrD
         THo4vzIpCstO+QNHqWeATVzRiaG3YJJsKr9YrufEdjox5cYY+wdXm8i3BQpQBa2zn/HL
         8qYFjXpQnd7ZYEcPZlEY5xXwfVMvIR0N8VsUzf5B8Lh7n21aCdTQ6h5/o/lZ4pVBnau4
         tCGPthTFsxIOuh3TgHW42wTIqM3Q/gqq0AwCgZqneriNZAjp6yicie6DrImr4jzUQnQ8
         ZA9Q==
X-Gm-Message-State: AOAM533a6pK8U1SL8lsGsbxbBDqa9IaKbsJW7pqQKhyenlys1r1qsBz1
        GD1pdEb2nwm5P23Qfl1gnMcKGE3rnoB52KdATeoj2w==
X-Google-Smtp-Source: ABdhPJzfN5W9BaSlDLOyQZ1bH05/BwCHKG7L/Q3MInfwi5CE5Y8xF3ppMa98+Luw2xoB+7F0FyfkJUjO7daLVC4QNBI=
X-Received: by 2002:a17:90a:2d82:: with SMTP id p2mr5048424pjd.166.1598445045375;
 Wed, 26 Aug 2020 05:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200825015654.27781-1-walter-zh.wu@mediatek.com> <CANpmjNOvj+=v7VDVDXpsUNZ9o0+KoJVJs0MjLhwr0XpYcYQZ5g@mail.gmail.com>
In-Reply-To: <CANpmjNOvj+=v7VDVDXpsUNZ9o0+KoJVJs0MjLhwr0XpYcYQZ5g@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Wed, 26 Aug 2020 14:30:34 +0200
Message-ID: <CAAeHK+yVShDPCxVKDsO_5SwoM2ZG7x7byUJ74PtB7ekY61L2YQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] kasan: add workqueue and timer stack for generic KASAN
To:     Marco Elver <elver@google.com>
Cc:     Walter Wu <walter-zh.wu@mediatek.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 10:26 AM 'Marco Elver' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On Tue, 25 Aug 2020 at 03:57, Walter Wu <walter-zh.wu@mediatek.com> wrote:
> >
> > Syzbot reports many UAF issues for workqueue or timer, see [1] and [2].
> > In some of these access/allocation happened in process_one_work(),
> > we see the free stack is useless in KASAN report, it doesn't help
> > programmers to solve UAF on workqueue. The same may stand for times.
> >
> > This patchset improves KASAN reports by making them to have workqueue
> > queueing stack and timer stack information. It is useful for programmers
> > to solve use-after-free or double-free memory issue.
> >
> > Generic KASAN also records the last two workqueue and timer stacks and
> > prints them in KASAN report. It is only suitable for generic KASAN.
> >
> > [1]https://groups.google.com/g/syzkaller-bugs/search?q=%22use-after-free%22+process_one_work
> > [2]https://groups.google.com/g/syzkaller-bugs/search?q=%22use-after-free%22%20expire_timers
> > [3]https://bugzilla.kernel.org/show_bug.cgi?id=198437
> >
> > Walter Wu (6):
> > timer: kasan: record timer stack
> > workqueue: kasan: record workqueue stack
> > kasan: print timer and workqueue stack
> > lib/test_kasan.c: add timer test case
> > lib/test_kasan.c: add workqueue test case
> > kasan: update documentation for generic kasan
>
> Acked-by: Marco Elver <elver@google.com>

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

>
>
>
> > ---
> >
> > Changes since v2:
> > - modify kasan document to be more readable.
> >   Thanks for Marco suggestion.
> >
> > Changes since v1:
> > - Thanks for Marco and Thomas suggestion.
> > - Remove unnecessary code and fix commit log
> > - reuse kasan_record_aux_stack() and aux_stack
> >   to record timer and workqueue stack.
> > - change the aux stack title for common name.
> >
> > ---
> >
> > Documentation/dev-tools/kasan.rst |  4 ++--
> > kernel/time/timer.c               |  3 +++
> > kernel/workqueue.c                |  3 +++
> > lib/test_kasan.c                  | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > mm/kasan/report.c                 |  4 ++--
> > 5 files changed, 64 insertions(+), 4 deletions(-)
> >
> > --
> > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200825015654.27781-1-walter-zh.wu%40mediatek.com.
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/CANpmjNOvj%2B%3Dv7VDVDXpsUNZ9o0%2BKoJVJs0MjLhwr0XpYcYQZ5g%40mail.gmail.com.
