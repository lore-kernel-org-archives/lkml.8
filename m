Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44E9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAAD7206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:36:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ScVoohvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgHXRgd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727995AbgHXRgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 13:36:14 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A180BC061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 10:36:13 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 12so4914889lfb.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 10:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=26TUydVqxPxVzujJkDP3ooe0LIcJ+6TaS9e0RGjD9TQ=;
        b=ScVoohvVJ4OdOS/Gp7uTipGqkFwSPZ9/YTmOUlz0G9AbmpJeQYZCv7d3hKj9latwaA
         bA9Mx1atAqp3See+ZC1WOEt+W3MZ4cG+dQmycKllxFlLi+rego7+B0MpzCAZIEQcLj3W
         TMBPC9zZ76ploc/sHdDOZBnHvjfBOdSbR1TtRyWMbV+3WpRx8HPJ7SoyOpPySFQA+PIs
         Jz5ga+N8aNh5aIWtcH2JQP/fAIB4PKIczxnDE+qaP0eT3j2Jyt81fOwovzxj50rPO1SW
         j7iPM0r5999zjD16J1s+Q3xgEIi3yqzyZPORFEIHKwHt+dgkq2BQUg98m+iz44KEdNor
         TYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=26TUydVqxPxVzujJkDP3ooe0LIcJ+6TaS9e0RGjD9TQ=;
        b=VgHywxIEACLku/xF14faWVQR0wq0WuW3H4a4cG6iwdvXoJLxYua2rvfhyNirhvrypa
         PkE9Htsec1rEKeOMuLaKg+AgRdrJgGqHy24Dfb52zZ2B0wGXVPorY6xvLmOKriFg1hU6
         +s6aWoof6T9lSe9wlLzo0K7bT4guKvUnfAe94B4K8lIE7f7eZZfqzz9emvqE7jJaExpb
         JdYw1tzLFtSn78QgQ7tCS+suJTEk5/7ArmT4WGPJJe6XrVRH7hQ2yhIBXNwHBfCRaWhZ
         aoxUZlw2kA1QePsIII17qNxmQrMayVyLrrOk609EOYCH3ucUekZA/MvWeHTh35JzdKGf
         p/Gw==
X-Gm-Message-State: AOAM5311Gh03NxwpVIasebT0aHyr1v453aUF5b7nSd+BgbjT8w4iSTKS
        vKI+Uv9FnwihGDBTNSNhpFGXSXl2p9e1e5bEUM3nnA==
X-Google-Smtp-Source: ABdhPJw50J/imJJZ9ghO0Y9W18RJUd6CUUPfxxSV5TuOaea2qlecDLf1QIF/i3imhz91FMTwDr+goq7S3rB31u7ML9Y=
X-Received: by 2002:ac2:5235:: with SMTP id i21mr3055285lfl.96.1598290571672;
 Mon, 24 Aug 2020 10:36:11 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000014822b05ad2802a7@google.com> <20200818161856.d18df24b5d10fc727ead846f@linux-foundation.org>
 <20200819063421.GA5422@dhcp22.suse.cz> <20200820090341.GC5033@dhcp22.suse.cz>
In-Reply-To: <20200820090341.GC5033@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 24 Aug 2020 10:36:00 -0700
Message-ID: <CALvZod7+y=Ap6sasRakvOjL0DBVtPHV30JEs8hEEKzB+9CjDow@mail.gmail.com>
Subject: Re: KASAN: use-after-free Write in page_counter_uncharge
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        syzbot <syzbot+b305848212deec86eabe@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Roman Gushchin <guro@fb.com>, Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 2:03 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Wed 19-08-20 08:34:22, Michal Hocko wrote:
> [...]
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index b807952b4d43..11b6dd1c4f64 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -6753,6 +6753,7 @@ struct uncharge_gather {
> >
> >  static inline void uncharge_gather_clear(struct uncharge_gather *ug)
> >  {
> > +     css_put(&ug->memcg->css);
> >       memset(ug, 0, sizeof(*ug));
> >  }
> >
> > @@ -6797,6 +6798,7 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
> >                       uncharge_gather_clear(ug);
> >               }
> >               ug->memcg = page->mem_cgroup;
> > +             css_get(&ug->memcg->css);
> >       }
> >
> >       nr_pages = compound_nr(page);
>
> This is not a proper fix because uncharge_gather_clear is called also to
> initialize the initial state so ug->memcg would be a garbage from the
> stack. The proper fix with the full changelog should be. Let's add more
> people involved in the original commit to the CC. The initial report is
> http://lkml.kernel.org/r/00000000000014822b05ad2802a7@google.com resp.
> http://lkml.kernel.org/r/00000000000011710f05ad27fe8a@google.com
>
> From 73a40589cab12122170fb9f90222982e81d41423 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Thu, 20 Aug 2020 10:44:58 +0200
> Subject: [PATCH] memcg: fix use-after-free in uncharge_batch
>
> syzbot has reported an use-after-free in the uncharge_batch path
> BUG: KASAN: use-after-free in instrument_atomic_write include/linux/instrumented.h:71 [inline]
> BUG: KASAN: use-after-free in atomic64_sub_return include/asm-generic/atomic-instrumented.h:970 [inline]
> BUG: KASAN: use-after-free in atomic_long_sub_return include/asm-generic/atomic-long.h:113 [inline]
> BUG: KASAN: use-after-free in page_counter_cancel mm/page_counter.c:54 [inline]
> BUG: KASAN: use-after-free in page_counter_uncharge+0x3d/0xc0 mm/page_counter.c:155
> Write of size 8 at addr ffff8880371c0148 by task syz-executor.0/9304
>
> CPU: 0 PID: 9304 Comm: syz-executor.0 Not tainted 5.8.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1f0/0x31e lib/dump_stack.c:118
>  print_address_description+0x66/0x620 mm/kasan/report.c:383
>  __kasan_report mm/kasan/report.c:513 [inline]
>  kasan_report+0x132/0x1d0 mm/kasan/report.c:530
>  check_memory_region_inline mm/kasan/generic.c:183 [inline]
>  check_memory_region+0x2b5/0x2f0 mm/kasan/generic.c:192
>  instrument_atomic_write include/linux/instrumented.h:71 [inline]
>  atomic64_sub_return include/asm-generic/atomic-instrumented.h:970 [inline]
>  atomic_long_sub_return include/asm-generic/atomic-long.h:113 [inline]
>  page_counter_cancel mm/page_counter.c:54 [inline]
>  page_counter_uncharge+0x3d/0xc0 mm/page_counter.c:155
>  uncharge_batch+0x6c/0x350 mm/memcontrol.c:6764
>  uncharge_page+0x115/0x430 mm/memcontrol.c:6796
>  uncharge_list mm/memcontrol.c:6835 [inline]
>  mem_cgroup_uncharge_list+0x70/0xe0 mm/memcontrol.c:6877
>  release_pages+0x13a2/0x1550 mm/swap.c:911
>  tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
>  tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
>  tlb_flush_mmu+0x780/0x910 mm/mmu_gather.c:249
>  tlb_finish_mmu+0xcb/0x200 mm/mmu_gather.c:328
>  exit_mmap+0x296/0x550 mm/mmap.c:3185
>  __mmput+0x113/0x370 kernel/fork.c:1076
>  exit_mm+0x4cd/0x550 kernel/exit.c:483
>  do_exit+0x576/0x1f20 kernel/exit.c:793
>  do_group_exit+0x161/0x2d0 kernel/exit.c:903
>  get_signal+0x139b/0x1d30 kernel/signal.c:2743
>  arch_do_signal+0x33/0x610 arch/x86/kernel/signal.c:811
>  exit_to_user_mode_loop kernel/entry/common.c:135 [inline]
>  exit_to_user_mode_prepare+0x8d/0x1b0 kernel/entry/common.c:166
>  syscall_exit_to_user_mode+0x5e/0x1a0 kernel/entry/common.c:241
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> 1a3e1f40962c ("mm: memcontrol: decouple reference counting from page
> accounting") has reworked the memcg lifetime to be bound the the struct
> page rather than charges. It has also removed the css_put_many from
> uncharge_batch and that is causing the above splat. uncharge_batch is
> supposed to uncharge accumulated charges for all pages freed from the
> same memcg. The queuing is done by uncharge_page which however drops the
> memcg reference after it adds charges to the batch. If the current page
> happens to be the last one holding the reference for its memcg then the
> memcg is OK to go and the next page to be freed will trigger batched
> uncharge which needs to access the memcg which is gone already.
>
> Fix the issue by taking a reference for the memcg in the current batch.
>
> Fixes: 1a3e1f40962c ("mm: memcontrol: decouple reference counting from page accounting")
> Reported-by: syzbot+b305848212deec86eabe@syzkaller.appspotmail.com
> Reported-by: syzbot+b5ea6fb6f139c8b9482b@syzkaller.appspotmail.com
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Seems correct to me.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
