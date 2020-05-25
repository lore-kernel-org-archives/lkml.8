Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54424C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 17:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3773D207D8
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 17:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vrKxB8Ua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391347AbgEYRgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 13:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388230AbgEYRgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 13:36:39 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E029C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 10:36:39 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q24so206179pjd.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 10:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IJjU5AD78PQmMgIoxlhUE3XdqOGH2pnJ5GvxPy/ZWeA=;
        b=vrKxB8Ua+XZv4ykKGQgav6FhXKVJzsqZQi6l56ji2rRpxEXy+U0uFSAqqvLXB59YM0
         2msyq81bVTgHfqK1FdOumNDJOpeqzHcN+anyUyzdYd1b44EJu0EE+KyyQGK2cmGJCoIG
         ctxMlfJr9abZC4SFziuymzvUKKJ3ffJQ51PZUNeRBB084rim2V8/Aiq2ro76qwYi4XMO
         eHmtL/MBn5MCH5n6wnNm607QikhtfJzzD/tQLjCxlPOyYb9rfABOUj02gOqim7FQMVPb
         xd9nqr3CPh4Zc2mpGJTmD1gG6o+DuyFWZxpTMcTd86jxAvYgrndO34XI5WQhegqcftN7
         iV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IJjU5AD78PQmMgIoxlhUE3XdqOGH2pnJ5GvxPy/ZWeA=;
        b=fNwcQASp07Xj0Jon1B75BjiKCdZRmDfONv2ns32zcbXHzRM7Y2UHu9L3bOuVfDaosf
         CLJlM/7osUp+tdxdL6kW6paHbUpBvjs3fHOY7mgfoYZvGFH02o6eTEtdaMyjA69XNQHj
         hHfBo0C/wlfHbpnxIU+mHTNbGlQOIq5ghsctCfYRtzgAAYBwyk7jSfNO7OObKc2sZiMh
         MCgbicZ5ahLfVfc/GE6z1CM+F2KaeNHpy661x9fanxVdja+wmHez9xWRckcgmzLKx5sw
         P+wiaOosl+4Gp90sMuNMt9qTaa0p2PFErzf6uRS+j4X593vfuly7TEAuM30bhOeYOWPV
         vlXA==
X-Gm-Message-State: AOAM533Y4i+2hecyYcE8aHht2btNTEnxXOvGpbyPIHW382oE1Rhwy8bZ
        zBCwXK9JD6PTUN4dw3KWMCcWxE3dahGiHaBY1wCObg==
X-Google-Smtp-Source: ABdhPJz0kSa4s6ANDBb+YqExevdOdc33aV3eoTivjXP7z1lS4l97h5suRM2uOi232ee0BDQo2/+CwFWu+Jw4ExRID7M=
X-Received: by 2002:a17:90b:1994:: with SMTP id mv20mr21281595pjb.41.1590428198538;
 Mon, 25 May 2020 10:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200522015757.22267-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20200522015757.22267-1-walter-zh.wu@mediatek.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 25 May 2020 19:36:27 +0200
Message-ID: <CAAeHK+y9qz5P-WCWEGwUx__XVzPXTddcOXsFDnFvh_1-k4Opxw@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] kasan: memorize and print call_rcu stack
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Fri, May 22, 2020 at 3:58 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> This patchset improves KASAN reports by making them to have
> call_rcu() call stack information. It is useful for programmers
> to solve use-after-free or double-free memory issue.
>
> The KASAN report was as follows(cleaned up slightly):
>
> BUG: KASAN: use-after-free in kasan_rcu_reclaim+0x58/0x60
>
> Freed by task 0:
>  kasan_save_stack+0x24/0x50
>  kasan_set_track+0x24/0x38
>  kasan_set_free_info+0x18/0x20
>  __kasan_slab_free+0x10c/0x170
>  kasan_slab_free+0x10/0x18
>  kfree+0x98/0x270
>  kasan_rcu_reclaim+0x1c/0x60
>
> Last call_rcu():
>  kasan_save_stack+0x24/0x50
>  kasan_record_aux_stack+0xbc/0xd0
>  call_rcu+0x8c/0x580
>  kasan_rcu_uaf+0xf4/0xf8
>
> Generic KASAN will record the last two call_rcu() call stacks and
> print up to 2 call_rcu() call stacks in KASAN report. it is only
> suitable for generic KASAN.
>
> This feature considers the size of struct kasan_alloc_meta and
> kasan_free_meta, we try to optimize the structure layout and size
> , let it get better memory consumption.
>
> [1]https://bugzilla.kernel.org/show_bug.cgi?id=198437
> [2]https://groups.google.com/forum/#!searchin/kasan-dev/better$20stack$20traces$20for$20rcu%7Csort:date/kasan-dev/KQsjT_88hDE/7rNUZprRBgAJ

Reviewed-by: Andrey Konovalov <andreyknvl@google.com>

for the series.

Thanks!

>
> Changes since v2:
> - remove new config option, default enable it in generic KASAN
> - test this feature in SLAB/SLUB, it is pass.
> - modify macro to be more clearly
> - modify documentation
>
> Changes since v3:
> - change recording from first/last to the last two call stacks
> - move free track into kasan free meta
> - init slab_free_meta on object slot creation
> - modify documentation
>
> Changes since v4:
> - change variable name to be more clearly
> - remove the redundant condition
> - remove init free meta-data and increasing object condition
>
> Changes since v5:
> - add a macro KASAN_KMALLOC_FREETRACK in order to check whether
>   print free stack
> - change printing message
> - remove descriptions in Kocong.kasan
>
> Changes since v6:
> - reuse print_stack() in print_track()
>
> Walter Wu (4):
> rcu/kasan: record and print call_rcu() call stack
> kasan: record and print the free track
> kasan: add tests for call_rcu stack recording
> kasan: update documentation for generic kasan
>
> Documentation/dev-tools/kasan.rst |  3 +++
> include/linux/kasan.h             |  2 ++
> kernel/rcu/tree.c                 |  2 ++
> lib/test_kasan.c                  | 30 ++++++++++++++++++++++++++++++
> mm/kasan/common.c                 | 26 ++++----------------------
> mm/kasan/generic.c                | 43 +++++++++++++++++++++++++++++++++++++++++++
> mm/kasan/generic_report.c         |  1 +
> mm/kasan/kasan.h                  | 23 +++++++++++++++++++++--
> mm/kasan/quarantine.c             |  1 +
> mm/kasan/report.c                 | 54 +++++++++++++++++++++++++++---------------------------
> mm/kasan/tags.c                   | 37 +++++++++++++++++++++++++++++++++++++
> 11 files changed, 171 insertions(+), 51 deletions(-)
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200522015757.22267-1-walter-zh.wu%40mediatek.com.
