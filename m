Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2FCBC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 06:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C91CA20716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 06:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgICGmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 02:42:45 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:54591 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725919AbgICGmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 02:42:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04392;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U7nIIjA_1599115360;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U7nIIjA_1599115360)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Sep 2020 14:42:40 +0800
Subject: Re: [PATCH v3 1/3] mm/pageblock: mitigation cmpxchg false sharing in
 pageblock flags
To:     Vlastimil Babka <vbabka@suse.cz>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1598928612-68996-1-git-send-email-alex.shi@linux.alibaba.com>
 <fab9e78e-5635-5d0a-9aa7-227178684044@suse.cz>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <81d1feb1-2373-de9b-f788-adcce9647b41@linux.alibaba.com>
Date:   Thu, 3 Sep 2020 14:42:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <fab9e78e-5635-5d0a-9aa7-227178684044@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/9/2 上午1:06, Vlastimil Babka 写道:
>>
>>                    pageblock   pageblock   pageblock        rc2         rc2         rc2
>>                           16        16-2        16-3          a           b           c
>> Duration User          14.81       15.24       14.55      14.76       14.97       14.38
>> Duration System        84.44       88.38       90.64     100.43       89.15       88.89
>> Duration Elapsed       98.83       99.06       99.81     100.30       99.24       99.14
> The large variance in these numbers suggest that 3 iterations are not enough to
> conclude a statistically significant difference. You'd need more iterations and
> calculate at least mean+variance.
> 

on the machine I did seeing much variation more on Amean. but the trace event would
be more straight. It could reduce the hit_cmpxchg from thousand time to hundreds or less.

Thanks
Alex

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
+       TP_PROTO(char byte),
+
+       TP_ARGS(byte),
+
+       TP_STRUCT__entry(
+               __field(char, byte)
+       ),
+
+       TP_fast_assign(
+               __entry->byte = byte;
+       ),
+
+       TP_printk("%d", __entry->byte)
+);
+
+#endif /* _TRACE_PAGE_ISOLATION_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 60342e764090..2422dec00484 100644
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
@@ -536,6 +539,7 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
                if (byte == old_byte)
                        break;
                byte = old_byte;
+               trace_hit_cmpxchg(byte);
        }
 }
