Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F43C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 06:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A64F720772
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 06:34:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgHSGeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 02:34:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:58280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgHSGeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 02:34:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5DA20ADFE;
        Wed, 19 Aug 2020 06:34:48 +0000 (UTC)
Date:   Wed, 19 Aug 2020 08:34:21 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     syzbot <syzbot+b305848212deec86eabe@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-free Write in page_counter_uncharge
Message-ID: <20200819063421.GA5422@dhcp22.suse.cz>
References: <00000000000014822b05ad2802a7@google.com>
 <20200818161856.d18df24b5d10fc727ead846f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818161856.d18df24b5d10fc727ead846f@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18-08-20 16:18:56, Andrew Morton wrote:
> On Tue, 18 Aug 2020 07:50:28 -0700 syzbot <syzbot+b305848212deec86eabe@syzkaller.appspotmail.com> wrote:
> 
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    a1d21081 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=17ceb0ce900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=21f0d1d2df6d5fc
> > dashboard link: https://syzkaller.appspot.com/bug?extid=b305848212deec86eabe
> > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> 
> Presumably this is the same as
> http://lkml.kernel.org/r/00000000000011710f05ad27fe8a@google.com.

Very likely.

> > Unfortunately, I don't have any reproducer for this issue yet.
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+b305848212deec86eabe@syzkaller.appspotmail.com
> > 
> > ==================================================================
> > BUG: KASAN: use-after-free in instrument_atomic_write include/linux/instrumented.h:71 [inline]
> > BUG: KASAN: use-after-free in atomic64_sub_return include/asm-generic/atomic-instrumented.h:970 [inline]
> > BUG: KASAN: use-after-free in atomic_long_sub_return include/asm-generic/atomic-long.h:113 [inline]
> > BUG: KASAN: use-after-free in page_counter_cancel mm/page_counter.c:54 [inline]
> > BUG: KASAN: use-after-free in page_counter_uncharge+0x3d/0xc0 mm/page_counter.c:155
> > Write of size 8 at addr ffff8880371c0148 by task syz-executor.0/9304
> > 
> > CPU: 0 PID: 9304 Comm: syz-executor.0 Not tainted 5.8.0-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x1f0/0x31e lib/dump_stack.c:118
> >  print_address_description+0x66/0x620 mm/kasan/report.c:383
> >  __kasan_report mm/kasan/report.c:513 [inline]
> >  kasan_report+0x132/0x1d0 mm/kasan/report.c:530
> >  check_memory_region_inline mm/kasan/generic.c:183 [inline]
> >  check_memory_region+0x2b5/0x2f0 mm/kasan/generic.c:192
> >  instrument_atomic_write include/linux/instrumented.h:71 [inline]
> >  atomic64_sub_return include/asm-generic/atomic-instrumented.h:970 [inline]
> >  atomic_long_sub_return include/asm-generic/atomic-long.h:113 [inline]
> >  page_counter_cancel mm/page_counter.c:54 [inline]
> >  page_counter_uncharge+0x3d/0xc0 mm/page_counter.c:155
> >  uncharge_batch+0x6c/0x350 mm/memcontrol.c:6764
> >  uncharge_page+0x115/0x430 mm/memcontrol.c:6796
> >  uncharge_list mm/memcontrol.c:6835 [inline]
> >  mem_cgroup_uncharge_list+0x70/0xe0 mm/memcontrol.c:6877
> >  release_pages+0x13a2/0x1550 mm/swap.c:911

This looks like a reference count unbalance when memcg is released
early. My first guess would be 1a3e1f40962c ("mm: memcontrol: decouple
reference counting from page accounting").

Unless I am missing something nothing really prevents the memcg for the
current batch to go away. uncharge_page collects all the charges for the
same memcg but it later drops the reference for the current page. Later
on when the memcg changes or when the final clean up is done in uncharge_list
uncharge_batch needs to access memcg but this might be after the last
page dropped the reference and memcg went away. The whole process of
tear down is quite complex and takes some time with all the RCU/WQ
involvement so this is quite unlikely to hit.

That being said the below should cure the reference count but I am not
sure this is a complete fix. If this looks reasonable I will post the
full patch. Johannes?

--- 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index b807952b4d43..11b6dd1c4f64 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6753,6 +6753,7 @@ struct uncharge_gather {
 
 static inline void uncharge_gather_clear(struct uncharge_gather *ug)
 {
+	css_put(&ug->memcg->css);
 	memset(ug, 0, sizeof(*ug));
 }
 
@@ -6797,6 +6798,7 @@ static void uncharge_page(struct page *page, struct uncharge_gather *ug)
 			uncharge_gather_clear(ug);
 		}
 		ug->memcg = page->mem_cgroup;
+		css_get(&ug->memcg->css);
 	}
 
 	nr_pages = compound_nr(page);
-- 
Michal Hocko
SUSE Labs
