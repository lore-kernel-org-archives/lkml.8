Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69E1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95719206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 11:50:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oLyJ6GRK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgHXLuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 07:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgHXLuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 07:50:20 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4D0C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 04:50:20 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id o8so4277496otp.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 04:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yJXg3YmJV9VmBBuMxTtghIxF3sII7GvdsrK6BwX4Nus=;
        b=oLyJ6GRKHTm1t7mgGpDwN4erpee2C2K8InRMviIFM7ItOZjfGHwrLx5AqYVOyiaj2H
         Sut0+dlkdVXZjAi7t6gZDvKzPxSlKEVjXEXukWfDse9h4cuaBBoHnh8nLCJnowemg/gp
         OBPAHWMwTO2x0X0nGFhP1VkCLuv2QlfwmAOgXeKwSFhOB1mhlIHVv9tX3val2OmziOqL
         KPTYLiXiQBhJxzN5Qip06U+Xx/adZQ8VHy13CgZ7WTjW3CJfkqFD3cc/vMOMqxFDP2d/
         ci8FSMbFgXLLI+sGzo1XDEnZB+xvTYLArHLLB9OJ+Ku8Yj8EkrGjlqkkGP0s7pdstJok
         DJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yJXg3YmJV9VmBBuMxTtghIxF3sII7GvdsrK6BwX4Nus=;
        b=UzvvEYhUU7k6Zk98ezHVRKaUZ+GQnr8ag1K6eMhTHbJntoXWOVPwth4sHxaXCYtkG6
         WBA9O3VZVDMC5N/JUJO/XB9//GCp6dl8o/51x86/Dr+IUbnAX8tmwA71/rrsBjCqnv6b
         j4DDFvril9+uPfUpRU2PeWcFJy3+nSW1QFNHKCmU7g94nDnvFK/RapmrpZV6WVd7QQWf
         5fbcO8DshFas/g8ti3S9rn9uVYuXXTi92EDO5SJOPlcS1vvQhoTS/xngkwa1RbWPqfUC
         MVQ65r+APCzllUDaM1BJESFlZLfyCrxony9KnMMjwyBH6eBaAFYkFm0NKrq/w5z9wjp4
         foIA==
X-Gm-Message-State: AOAM531ObG0CYYcBSQDu2Gg030DXva7PfW1L4W9QwJcsSGeIQTcoR0+e
        aDyZD42vN6lwpfMQC7FX9ZR94oU/GgMzOhYZ8NwoXQ==
X-Google-Smtp-Source: ABdhPJxY6ICnrMzo1mNkyVVmig6kmZLJrD1Ga0fs2iobFX/jQG+jCprR22w/YZrmq6KdxX46yuF7HEXTXgAX+iTF6Ik=
X-Received: by 2002:a9d:739a:: with SMTP id j26mr3480830otk.17.1598269819856;
 Mon, 24 Aug 2020 04:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200824080706.24704-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20200824080706.24704-1-walter-zh.wu@mediatek.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 24 Aug 2020 13:50:08 +0200
Message-ID: <CANpmjNNYhYwyzT3pBzJdb=XCGyLj7X+Fhqui-6JAZJWGys25Rg@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] kasan: add workqueue and timer stack for generic KASAN
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

On Mon, 24 Aug 2020 at 10:07, Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> Syzbot reports many UAF issues for workqueue or timer, see [1] and [2].
> In some of these access/allocation happened in process_one_work(),
> we see the free stack is useless in KASAN report, it doesn't help
> programmers to solve UAF on workqueue. The same may stand for times.
>
> This patchset improves KASAN reports by making them to have workqueue
> queueing stack and timer queueing stack information. It is useful for
> programmers to solve use-after-free or double-free memory issue.
>
> Generic KASAN will record the last two workqueue and timer stacks,
> print them in KASAN report. It is only suitable for generic KASAN.
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
>
> ---
>
> Changes since v1:
> - Thanks for Marco and Thomas suggestion.
> - Remove unnecessary code and fix commit log
> - reuse kasan_record_aux_stack() and aux_stack
>   to record timer and workqueue stack.
> - change the aux stack title for common name.

Much cleaner.

In general,

Acked-by: Marco Elver <elver@google.com>

but I left some more comments. I'm a bit worried about the tests,
because of KASAN-test KUnit rework, but probably not much we can do
until these are added to -mm tree.

Thanks,
-- Marco
