Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D560EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4BC0206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="rUgIUgpg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgHJMol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgHJMok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:44:40 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C84EC061786
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 05:44:40 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id v22so6542184qtq.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 05:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=gAr4D/ePrFPzg5ITCo7F2eiZjjapefZpMToAlkphjvI=;
        b=rUgIUgpgGYUj+dAL7OY+LRW5B1iNfQaizOTu9QModP4rJmLpbj0zM8gSoW2w1gF1gY
         zJV8PNKkE6NtgSi2X3vVTIBw/spdtf7mf7l9OcqJ3uA+1MZ72PhMp3lhE+yX+35/6sKm
         2BXOKptXGfmHSiMh9t93c6NwQX6CX8nkh7+lXAUa2XI8pLhB0IyVbvrXRpeBmlyGd86M
         orq/baff+/CDquuUn8Tt53OsDBxzd8zRTB2ioMuODI0kfd0ZnVPsoFuHJT2QU09M2CEj
         R60Lg3qbqsLE70u2+kBwOqcWgpANqUVqEkqWPi+87reEyhb5ukrem2Y8FB0qlr/gmCwE
         ABqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=gAr4D/ePrFPzg5ITCo7F2eiZjjapefZpMToAlkphjvI=;
        b=QxOUgwhgY/f7lqWo2PDVKKfbGp6I15ovD2l7zMP+IG+iEbTWLZWVmGydXhJ3QJ6DQx
         weqsZHnjri4DvSFa1nTfn+C4sxyg/fDllFLtowMwsFA/gRAtxxtyzvvXIZ2rRdWmeavm
         gvTKS6IMCKi+U/9tVJjkZHHq7f//+NYRKa0jchTNAMh9rQ9dc3SZtH9ZiAw+m9fOKF5H
         /ETpTONs4c5RjHWB9gA9wJoHFr1La1EDE4OMOsN5VABpFJQxhc783CwFhcAkjQEjnBFd
         8gi7+jjVSAiwtCtylwyudJXbkQCVgLHJl+AT8ZvuY+tF9ywpwLt+ItvrSDbRKhXoY3R5
         YknA==
X-Gm-Message-State: AOAM533/fDlJs1gpV2/VOHLGl5ot9mrIONNMq8DF9WUywJFWDJkcYnzR
        Bh0e+FTz8aXlxX804KjInvxvEQ==
X-Google-Smtp-Source: ABdhPJzs2CqjFarg0XkEZgbuZmZNab5q0MHr7iwix6stb9A6MtLvWHu783qEEPSn0NIzKfkEUxh6CA==
X-Received: by 2002:ac8:47c8:: with SMTP id d8mr25413219qtr.32.1597063478706;
        Mon, 10 Aug 2020 05:44:38 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id l1sm15330349qtp.96.2020.08.10.05.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 05:44:38 -0700 (PDT)
Date:   Mon, 10 Aug 2020 08:44:31 -0400
From:   Qian Cai <cai@lca.pw>
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
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 0/5] kasan: add workqueue and timer stack for generic
 KASAN
Message-ID: <20200810124430.GA5307@lca.pw>
References: <20200810072115.429-1-walter-zh.wu@mediatek.com>
 <B873B364-FF03-4819-8F9C-79F3C4EF47CE@lca.pw>
 <1597060257.13160.11.camel@mtksdccf07>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1597060257.13160.11.camel@mtksdccf07>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 07:50:57PM +0800, Walter Wu wrote:
> On Mon, 2020-08-10 at 07:19 -0400, Qian Cai wrote:
> > 
> > > On Aug 10, 2020, at 3:21 AM, Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > > 
> > > ﻿Syzbot reports many UAF issues for workqueue or timer, see [1] and [2].
> > > In some of these access/allocation happened in process_one_work(),
> > > we see the free stack is useless in KASAN report, it doesn't help
> > > programmers to solve UAF on workqueue. The same may stand for times.
> > > 
> > > This patchset improves KASAN reports by making them to have workqueue
> > > queueing stack and timer queueing stack information. It is useful for
> > > programmers to solve use-after-free or double-free memory issue.
> > > 
> > > Generic KASAN will record the last two workqueue and timer stacks,
> > > print them in KASAN report. It is only suitable for generic KASAN.
> > > 
> > > In order to print the last two workqueue and timer stacks, so that
> > > we add new members in struct kasan_alloc_meta.
> > > - two workqueue queueing work stacks, total size is 8 bytes.
> > > - two timer queueing stacks, total size is 8 bytes.
> > > 
> > > Orignial struct kasan_alloc_meta size is 16 bytes. After add new
> > > members, then the struct kasan_alloc_meta total size is 32 bytes,
> > > It is a good number of alignment. Let it get better memory consumption.
> > 
> > Getting debugging tools complicated surely is the best way to kill it. I would argue that it only make sense to complicate it if it is useful most of the time which I never feel or hear that is the case. This reminds me your recent call_rcu() stacks that most of time just makes parsing the report cumbersome. Thus, I urge this exercise to over-engineer on special cases need to stop entirely.
> > 
> 
> A good debug tool is to have complete information in order to solve
> issue. We should focus on if KASAN reports always show this debug
> information or create a option to decide if show it. Because this
> feature is Dimitry's suggestion. see [1]. So I think it need to be
> implemented. Maybe we can wait his response. 
> 
> [1]https://lkml.org/lkml/2020/6/23/256

I don't know if it is Dmitry's pipe-dream which every KASAN report would enable
developers to fix it without reproducing it. It is always an ongoing struggling
between to make kernel easier to debug and the things less cumbersome.

On the other hand, Dmitry's suggestion makes sense only if the price we are
going to pay is fair. With the current diffstat and the recent experience of
call_rcu() stacks "waste" screen spaces as a heavy KASAN user myself, I can't
really get that exciting for pushing the limit again at all.

> 
> Thanks.
> 
> > > 
> > > [1]https://groups.google.com/g/syzkaller-bugs/search?q=%22use-after-free%22+process_one_work
> > > [2]https://groups.google.com/g/syzkaller-bugs/search?q=%22use-after-free%22%20expire_timers
> > > [3]https://bugzilla.kernel.org/show_bug.cgi?id=198437
> > > 
> > > Walter Wu (5):
> > > timer: kasan: record and print timer stack
> > > workqueue: kasan: record and print workqueue stack
> > > lib/test_kasan.c: add timer test case
> > > lib/test_kasan.c: add workqueue test case
> > > kasan: update documentation for generic kasan
> > > 
> > > Documentation/dev-tools/kasan.rst |  4 ++--
> > > include/linux/kasan.h             |  4 ++++
> > > kernel/time/timer.c               |  2 ++
> > > kernel/workqueue.c                |  3 +++
> > > lib/test_kasan.c                  | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > mm/kasan/generic.c                | 42 ++++++++++++++++++++++++++++++++++++++++++
> > > mm/kasan/kasan.h                  |  6 +++++-
> > > mm/kasan/report.c                 | 22 ++++++++++++++++++++++
> > > 8 files changed, 134 insertions(+), 3 deletions(-)
> > > 
> > > -- 
> > > You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> > > To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200810072115.429-1-walter-zh.wu%40mediatek.com.
> 
