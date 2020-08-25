Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5EBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 388D32067C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 08:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mE7Ydj/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgHYI0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 04:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgHYI0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 04:26:42 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6074DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 01:26:42 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id u24so10896683oic.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 01:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FC5Hg6COXCLaWmmWNTz40PS96oTnHUqlyjZL5YEDjmI=;
        b=mE7Ydj/tIvyII6lomwmN1NR0MhMKAfEoekSi7y1J/k3ZNS2dnD6AhDjL5WPSSwIQhm
         2Q0JrJSi23rD3J5faSQlxhqF+ng5SP2GoY1jmrM9ck4FQNHYVtYw5Xf9DtY3k+SyszJ0
         uuXE7w7FrYLEXnDuOEPQx1wFVWbq40auNwZI2K+5sQsOdeUllOFcORseNaiXyghzY8Fz
         zTncDRbkjQoLPYoEXGJhL8nVkDUwA2XLDskzTyh7KR1ULBHzjN+sdbf3m8I9nksHQLrj
         PL+6W5Xb9f2gylfIg2mMFkN2yhST1Xw0vv/Cenk0s0RPc9aixJEPovw86FBtXCDVSMDv
         o98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FC5Hg6COXCLaWmmWNTz40PS96oTnHUqlyjZL5YEDjmI=;
        b=Hp5HlBk4GJAJtm74IS85mbbRCZWeYaCecWrx52BCHfA6sbj5F9sWYwlMciyUS4cOz1
         SrXJF9kRilR4K3Q4vVIY5H3U2sU2PVfEr3l1F+pwWJ6At4QNaXNcjdPbfAMbnUrlCJmP
         mw6gokvBAGMUSHGR69yeWMOL6ozGXNI9y6UEf82LP29K+s1DoJmWNR+txjQ/TQshnzpS
         wFmKxdYmCply5vOAKhsQVDp/c8cYdH1PZl8P1N/vLVndVNGFQT0Gz8N/RIhvNk860pzc
         nXkfSYZH3+94mj6pAZNnQK3xeVwTEHLT8BREgZAIxpLZj3BrJn4zBd2Z63CvStSXs8Im
         3OqA==
X-Gm-Message-State: AOAM531FaPlZR/UyQlKk33okpMa+UuLHVnRHHJiyWaRPOKnZRNQt6xEd
        jydtGWjNl8eCMizcOJngf+abBpaANMnesIggzxPWng==
X-Google-Smtp-Source: ABdhPJxD71P1F4ZzbI6iFZEZrr1MZD1sm9wMnlc4GSnJlk+0Zk7Erabn/fwXngbccV76Y6VS7e44EThTikvb+R3DQfs=
X-Received: by 2002:aca:aa8c:: with SMTP id t134mr407296oie.121.1598344001584;
 Tue, 25 Aug 2020 01:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200825015654.27781-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20200825015654.27781-1-walter-zh.wu@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 25 Aug 2020 10:26:30 +0200
Message-ID: <CANpmjNOvj+=v7VDVDXpsUNZ9o0+KoJVJs0MjLhwr0XpYcYQZ5g@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] kasan: add workqueue and timer stack for generic KASAN
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
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

On Tue, 25 Aug 2020 at 03:57, Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> Syzbot reports many UAF issues for workqueue or timer, see [1] and [2].
> In some of these access/allocation happened in process_one_work(),
> we see the free stack is useless in KASAN report, it doesn't help
> programmers to solve UAF on workqueue. The same may stand for times.
>
> This patchset improves KASAN reports by making them to have workqueue
> queueing stack and timer stack information. It is useful for programmers
> to solve use-after-free or double-free memory issue.
>
> Generic KASAN also records the last two workqueue and timer stacks and
> prints them in KASAN report. It is only suitable for generic KASAN.
>
> [1]https://groups.google.com/g/syzkaller-bugs/search?q=%22use-after-free%22+process_one_work
> [2]https://groups.google.com/g/syzkaller-bugs/search?q=%22use-after-free%22%20expire_timers
> [3]https://bugzilla.kernel.org/show_bug.cgi?id=198437
>
> Walter Wu (6):
> timer: kasan: record timer stack
> workqueue: kasan: record workqueue stack
> kasan: print timer and workqueue stack
> lib/test_kasan.c: add timer test case
> lib/test_kasan.c: add workqueue test case
> kasan: update documentation for generic kasan

Acked-by: Marco Elver <elver@google.com>



> ---
>
> Changes since v2:
> - modify kasan document to be more readable.
>   Thanks for Marco suggestion.
>
> Changes since v1:
> - Thanks for Marco and Thomas suggestion.
> - Remove unnecessary code and fix commit log
> - reuse kasan_record_aux_stack() and aux_stack
>   to record timer and workqueue stack.
> - change the aux stack title for common name.
>
> ---
>
> Documentation/dev-tools/kasan.rst |  4 ++--
> kernel/time/timer.c               |  3 +++
> kernel/workqueue.c                |  3 +++
> lib/test_kasan.c                  | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> mm/kasan/report.c                 |  4 ++--
> 5 files changed, 64 insertions(+), 4 deletions(-)
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200825015654.27781-1-walter-zh.wu%40mediatek.com.
