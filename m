Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837B2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69C442078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:03:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgHTJDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:03:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:37168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgHTJDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:03:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C984DADBB;
        Thu, 20 Aug 2020 09:04:09 +0000 (UTC)
Date:   Thu, 20 Aug 2020 11:03:41 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     syzbot <syzbot+b305848212deec86eabe@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com, Roman Gushchin <guro@fb.com>,
        Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: KASAN: use-after-free Write in page_counter_uncharge
Message-ID: <20200820090341.GC5033@dhcp22.suse.cz>
References: <00000000000014822b05ad2802a7@google.com>
 <20200818161856.d18df24b5d10fc727ead846f@linux-foundation.org>
 <20200819063421.GA5422@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819063421.GA5422@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 19-08-20 08:34:22, Michal Hocko wrote:
[...]
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b807952b4d43..11b6dd1c4f64 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6753,6 +6753,7 @@ struct uncharge_gather {
>  
>  static inline void uncharge_gather_clear(struct uncharge_gather *ug)
>  {
> +	css_put(&ug->memcg->css);
>  	memset(ug, 0, sizeof(*ug));
>  }
>  
> @@ -6797,6 +6798,7 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
>  			uncharge_gather_clear(ug);
>  		}
>  		ug->memcg = page->mem_cgroup;
> +		css_get(&ug->memcg->css);
>  	}
>  
>  	nr_pages = compound_nr(page);

This is not a proper fix because uncharge_gather_clear is called also to
initialize the initial state so ug->memcg would be a garbage from the
stack. The proper fix with the full changelog should be. Let's add more
people involved in the original commit to the CC. The initial report is
http://lkml.kernel.org/r/00000000000014822b05ad2802a7@google.com resp.
http://lkml.kernel.org/r/00000000000011710f05ad27fe8a@google.com

From 73a40589cab12122170fb9f90222982e81d41423 Mon Sep 17 00:00:00 2001
From: Michal Hocko <mhocko@suse.com>
Date: Thu, 20 Aug 2020 10:44:58 +0200
Subject: [PATCH] memcg: fix use-after-free in uncharge_batch

syzbot has reported an use-after-free in the uncharge_batch path
BUG: KASAN: use-after-free in instrument_atomic_write include/linux/instrumented.h:71 [inline]
BUG: KASAN: use-after-free in atomic64_sub_return include/asm-generic/atomic-instrumented.h:970 [inline]
BUG: KASAN: use-after-free in atomic_long_sub_return include/asm-generic/atomic-long.h:113 [inline]
BUG: KASAN: use-after-free in page_counter_cancel mm/page_counter.c:54 [inline]
BUG: KASAN: use-after-free in page_counter_uncharge+0x3d/0xc0 mm/page_counter.c:155
Write of size 8 at addr ffff8880371c0148 by task syz-executor.0/9304

CPU: 0 PID: 9304 Comm: syz-executor.0 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 print_address_description+0x66/0x620 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report+0x132/0x1d0 mm/kasan/report.c:530
 check_memory_region_inline mm/kasan/generic.c:183 [inline]
 check_memory_region+0x2b5/0x2f0 mm/kasan/generic.c:192
 instrument_atomic_write include/linux/instrumented.h:71 [inline]
 atomic64_sub_return include/asm-generic/atomic-instrumented.h:970 [inline]
 atomic_long_sub_return include/asm-generic/atomic-long.h:113 [inline]
 page_counter_cancel mm/page_counter.c:54 [inline]
 page_counter_uncharge+0x3d/0xc0 mm/page_counter.c:155
 uncharge_batch+0x6c/0x350 mm/memcontrol.c:6764
 uncharge_page+0x115/0x430 mm/memcontrol.c:6796
 uncharge_list mm/memcontrol.c:6835 [inline]
 mem_cgroup_uncharge_list+0x70/0xe0 mm/memcontrol.c:6877
 release_pages+0x13a2/0x1550 mm/swap.c:911
 tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
 tlb_flush_mmu+0x780/0x910 mm/mmu_gather.c:249
 tlb_finish_mmu+0xcb/0x200 mm/mmu_gather.c:328
 exit_mmap+0x296/0x550 mm/mmap.c:3185
 __mmput+0x113/0x370 kernel/fork.c:1076
 exit_mm+0x4cd/0x550 kernel/exit.c:483
 do_exit+0x576/0x1f20 kernel/exit.c:793
 do_group_exit+0x161/0x2d0 kernel/exit.c:903
 get_signal+0x139b/0x1d30 kernel/signal.c:2743
 arch_do_signal+0x33/0x610 arch/x86/kernel/signal.c:811
 exit_to_user_mode_loop kernel/entry/common.c:135 [inline]
 exit_to_user_mode_prepare+0x8d/0x1b0 kernel/entry/common.c:166
 syscall_exit_to_user_mode+0x5e/0x1a0 kernel/entry/common.c:241
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

1a3e1f40962c ("mm: memcontrol: decouple reference counting from page
accounting") has reworked the memcg lifetime to be bound the the struct
page rather than charges. It has also removed the css_put_many from
uncharge_batch and that is causing the above splat. uncharge_batch is
supposed to uncharge accumulated charges for all pages freed from the
same memcg. The queuing is done by uncharge_page which however drops the
memcg reference after it adds charges to the batch. If the current page
happens to be the last one holding the reference for its memcg then the
memcg is OK to go and the next page to be freed will trigger batched
uncharge which needs to access the memcg which is gone already.

Fix the issue by taking a reference for the memcg in the current batch.

Fixes: 1a3e1f40962c ("mm: memcontrol: decouple reference counting from page accounting")
Reported-by: syzbot+b305848212deec86eabe@syzkaller.appspotmail.com
Reported-by: syzbot+b5ea6fb6f139c8b9482b@syzkaller.appspotmail.com
Signed-off-by: Michal Hocko <mhocko@suse.com>
---
 mm/memcontrol.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b807952b4d43..cfa6cbad21d5 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6774,6 +6774,9 @@ static void uncharge_batch(const struct uncharge_gather *ug)
 	__this_cpu_add(ug->memcg->vmstats_percpu->nr_page_events, ug->nr_pages);
 	memcg_check_events(ug->memcg, ug->dummy_page);
 	local_irq_restore(flags);
+
+	/* drop reference from uncharge_page */
+	css_put(&ug->memcg->css);
 }
 
 static void uncharge_page(struct page *page, struct uncharge_gather *ug)
@@ -6797,6 +6800,9 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 			uncharge_gather_clear(ug);
 		}
 		ug->memcg = page->mem_cgroup;
+
+		/* pairs with css_put in uncharge_batch */
+		css_get(&ug->memcg->css);
 	}
 
 	nr_pages = compound_nr(page);
-- 
2.28.0

-- 
Michal Hocko
SUSE Labs
