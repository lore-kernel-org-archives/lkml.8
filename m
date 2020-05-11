Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F676C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 551702080C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fc1FlTQb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgEKKB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 06:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725983AbgEKKB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 06:01:28 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F96C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 03:01:27 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id x13so2296350qvr.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 03:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dEBQw3076mBvIY7CBwoK5uqpgbduOcTYtDKSbai7h/o=;
        b=Fc1FlTQbTssxu2TxqBIzl+6Xlu+t3hasOFsdn49nv21GLo9Z8aBGG/ltllQ5Mqv3vs
         /cS1DoIzzoA0etpn9Wb1dNWhoo4a7PnSU9gFA/dVQZkuny77X/CNk7hdQFyQxT8H3DVE
         EoV6Ku67L0CdgauG4BIN5MwiXPgC4FyhVfqLLtuUmawjRwNgqWpzTu0V3aeonSzSRMtL
         8R9P8SURGv9c8w0VL0TDSiPfiUAE1V/xB68UPSMA7ViHFp2ND2ft3yukF1C5a44SZ8PL
         nkAwzrc+hrrENogaw8HqC+e+2No138vdOykTEcUxjE1xBWU0GiZOAnz+kfac1whzdwd7
         J8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dEBQw3076mBvIY7CBwoK5uqpgbduOcTYtDKSbai7h/o=;
        b=q0eEpGVbJPSfxZMtPM2YTjrsHyM75i0Pdootz2hTbS6XLxJ51+G84lI+J0cqMgoIW2
         qLXTl3o0RMMEGbXqjuH+i43lQFuqi2J739jgdtGoxZ+y9RaYWineJdGI2Tr6YNwgYeCw
         fBjbroqd8+HdLw3zTuKEScdOsS6zQCYMRthcOeMw/CIeITRoqWFvEoF67vF6M78CKsuy
         vbWPZ4FtS16rhhB++mmg55XOD9v6my8q188LJFbkmKBbeFUXLPWLwx7UOUeHR7UxtWJy
         FBBW3kgfTU7NkjjBBKDScjafit7nQkiWEziqr4aFqtoEmiJvYL+MuldSJW+2ej1NOJFH
         CliA==
X-Gm-Message-State: AGi0PubBN4tj5tIYQ7VJXTYh/hWjLjCTsgujsUruWVGg88GKDHRCOi6f
        VjVF0OX02PDleS4WTS1yCEd3549fXoHsJhrQSeHi2A==
X-Google-Smtp-Source: APiQypK3J4Uss9hZs4ShXGbm1QYq+YrrdMGKWDeQyyrRLVZFWF+P7Ohh0VDwlQa19CWjtVyUyFUBSpLqPPKQVLzi6XA=
X-Received: by 2002:ad4:5a48:: with SMTP id ej8mr15299087qvb.122.1589191286510;
 Mon, 11 May 2020 03:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200511022359.15063-1-walter-zh.wu@mediatek.com>
In-Reply-To: <20200511022359.15063-1-walter-zh.wu@mediatek.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 11 May 2020 12:01:14 +0200
Message-ID: <CACT4Y+aC4i8cAVFu2-s82RczWCjYMpPVJLwS0OBLELR9qF8SYg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] kasan: memorize and print call_rcu stack
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 4:24 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> This patchset improves KASAN reports by making them to have
> call_rcu() call stack information. It is useful for programmers
> to solve use-after-free or double-free memory issue.

Hi Walter,

I am looking at this now.

I've upload the change to gerrit [1]
https://linux-review.googlesource.com/c/linux/kernel/git/torvalds/linux/+/2458

I am not capable enough to meaningfully review such changes in this format...

[1] https://linux.googlesource.com/Documentation


> The KASAN report was as follows(cleaned up slightly):
>
> BUG: KASAN: use-after-free in kasan_rcu_reclaim+0x58/0x60
>
> Freed by task 0:
>  save_stack+0x24/0x50
>  __kasan_slab_free+0x110/0x178
>  kasan_slab_free+0x10/0x18
>  kfree+0x98/0x270
>  kasan_rcu_reclaim+0x1c/0x60
>  rcu_core+0x8b4/0x10f8
>  rcu_core_si+0xc/0x18
>  efi_header_end+0x238/0xa6c
>
> First call_rcu() call stack:
>  save_stack+0x24/0x50
>  kasan_record_callrcu+0xc8/0xd8
>  call_rcu+0x190/0x580
>  kasan_rcu_uaf+0x1d8/0x278
>
> Last call_rcu() call stack:
> (stack is not available)
>
> Generic KASAN will record first and last call_rcu() call stack
> and print two call_rcu() call stack in KASAN report.
>
> This feature doesn't increase the cost of memory consumption. It is
> only suitable for generic KASAN.
>
> [1]https://bugzilla.kernel.org/show_bug.cgi?id=198437
> [2]https://groups.google.com/forum/#!searchin/kasan-dev/better$20stack$20traces$20for$20rcu%7Csort:date/kasan-dev/KQsjT_88hDE/7rNUZprRBgAJ
>
> Changes since v2:
> - remove new config option, default enable it in generic KASAN
> - test this feature in SLAB/SLUB, it is pass.
> - modify macro to be more clearly
> - modify documentation
>
> Walter Wu (3):
> rcu/kasan: record and print call_rcu() call stack
> kasan: record and print the free track
> kasan: update documentation for generic kasan
>
> Documentation/dev-tools/kasan.rst |  6 ++++++
> include/linux/kasan.h             |  2 ++
> kernel/rcu/tree.c                 |  4 ++++
> lib/Kconfig.kasan                 |  2 ++
> mm/kasan/common.c                 | 26 ++++----------------------
> mm/kasan/generic.c                | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
> mm/kasan/kasan.h                  | 23 +++++++++++++++++++++++
> mm/kasan/report.c                 | 47 +++++++++++++++++++++--------------------------
> mm/kasan/tags.c                   | 37 +++++++++++++++++++++++++++++++++++++
> 9 files changed, 149 insertions(+), 48 deletions(-)
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200511022359.15063-1-walter-zh.wu%40mediatek.com.
