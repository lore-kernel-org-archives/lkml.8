Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E917C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE89206E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgICIdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:33:08 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:50690 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726025AbgICIdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:33:07 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U7nlKYs_1599121981;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U7nlKYs_1599121981)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Sep 2020 16:33:02 +0800
Subject: Re: [PATCH v4 1/4] mm/pageblock: mitigation cmpxchg false sharing in
 pageblock flags
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1599116482-7410-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200903072447.GB3179@techsingularity.net>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <8275cc70-fd35-25c8-36d4-525a10f05e41@linux.alibaba.com>
Date:   Thu, 3 Sep 2020 16:32:54 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200903072447.GB3179@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/9/3 下午3:24, Mel Gorman 写道:
> On Thu, Sep 03, 2020 at 03:01:20PM +0800, Alex Shi wrote:
>> pageblock_flags is used as long, since every pageblock_flags is just 4
>> bits, 'long' size will include 8(32bit machine) or 16 pageblocks' flags,
>> that flag setting has to sync in cmpxchg with 7 or 15 other pageblock
>> flags. It would cause long waiting for sync.
>>
>> If we could change the pageblock_flags variable as char, we could use
>> char size cmpxchg, which just sync up with 2 pageblock flags. it could
>> relief the false sharing in cmpxchg.
>>
>> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> 
> Page block types were not known to change at high frequency that would
> cause a measurable performance drop. If anything, the performance hit
> from pageblocks is the lookup paths which is a lot more frequent.

Yes, it is not hot path. But it's still a meaningful points to reduce cmpxchg
level false sharing which isn't right on logical.


> 
> What was the workload you were running that altered pageblocks at a high
> enough frequency for collisions to occur when updating adjacent
> pageblocks?
> 

I have run thpscale with 'always' defrag setting of THP. The Amean stddev is much
larger than a very little average run time reducing.

But the left patch 4 could show the cmpxchg retry reduce from thousands to hundreds
or less.

Subject: [PATCH v4 4/4] add cmpxchg tracing

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
---
 include/trace/events/pageblock.h | 30 ++++++++++++++++++++++++++++++
 mm/page_alloc.c                  |  4 ++++
 2 files changed, 34 insertions(+)
 create mode 100644 include/trace/events/pageblock.h

diff --git a/include/trace/events/pageblock.h b/include/trace/events/pageblock.h
new file mode 100644
index 000000000000..003c2d716f82
--- /dev/null
+++ b/include/trace/events/pageblock.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM pageblock
+
+#if !defined(_TRACE_PAGEBLOCK_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PAGEBLOCK_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(hit_cmpxchg,
+
+	TP_PROTO(char byte),
+
+	TP_ARGS(byte),
+
+	TP_STRUCT__entry(
+		__field(char, byte)
+	),
+
+	TP_fast_assign(
+		__entry->byte = byte;
+	),
+
+	TP_printk("%d", __entry->byte)
+);
+
+#endif /* _TRACE_PAGE_ISOLATION_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8b65d83d8be6..a6d7159295bc 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -509,6 +509,9 @@ static __always_inline int get_pfnblock_migratetype(struct page *page, unsigned
  * @pfn: The target page frame number
  * @mask: mask of bits that the caller is interested in
  */
+#define CREATE_TRACE_POINTS
+#include <trace/events/pageblock.h>
+
 void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 					unsigned long pfn,
 					unsigned long mask)
@@ -532,6 +535,7 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 		if (byte == old_byte)
 			break;
 		byte = old_byte;
+		trace_hit_cmpxchg(byte);
 	}
 }

--
1.8.3.1
