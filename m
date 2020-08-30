Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D02C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 10:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 786C220714
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 10:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgH3KIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 06:08:55 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:28316 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725869AbgH3KIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 06:08:55 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U7FbYsf_1598782128;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U7FbYsf_1598782128)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 30 Aug 2020 18:08:48 +0800
Subject: Re: [PATCH v2 1/2] mm/pageblock: mitigation cmpxchg false sharing in
 pageblock flags
To:     David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1597816075-61091-1-git-send-email-alex.shi@linux.alibaba.com>
 <8ec2a4b0-9e51-abf9-fa7a-29989d3f1fac@arm.com>
 <0d4c8329-a9ea-e8a9-31e2-c3fe02299152@redhat.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <eeae4eda-272d-f997-9ccf-3f27bb659702@linux.alibaba.com>
Date:   Sun, 30 Aug 2020 18:08:48 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <0d4c8329-a9ea-e8a9-31e2-c3fe02299152@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/8/19 下午4:04, David Hildenbrand 写道:
> On 19.08.20 09:55, Anshuman Khandual wrote:
>>
>>
>> On 08/19/2020 11:17 AM, Alex Shi wrote:
>>> pageblock_flags is used as long, since every pageblock_flags is just 4
>>> bits, 'long' size will include 8(32bit machine) or 16 pageblocks' flags,
>>> that flag setting has to sync in cmpxchg with 7 or 15 other pageblock
>>> flags. It would cause long waiting for sync.
>>>
>>> If we could change the pageblock_flags variable as char, we could use
>>> char size cmpxchg, which just sync up with 2 pageblock flags. it could
>>> relief much false sharing in cmpxchg.
>>
>> Do you have numbers demonstrating claimed performance improvement
>> after this change ?
>>
> 
> I asked for that in v1 and there are no performance numbers to justify
> the change. IMHO, that will be required to consider this for inclusion,
> otherwise it's just code churn resulting in an (although minimal)
> additional memory consumption.
> 

Just got some time to run thpscale on my 4*HT cores machine, here is the data:
I run each of kernel for 3 times, pageblock kernel is the 5.9-rc2 with this 2
patches, the plp1 is the first patch on 5.9-rc2, and rc2 is 5.9-rc2 kernel.
We could found the system and total time is slight less than original kernel.

                   pageblock   pageblock   pageblock        plp1        plp1        plp1         rc2         rc2         rc2   pageblock
                          16        16-2        16-3           1           2           3           a           b           c           a
Duration User          14.81       15.24       14.55       15.28       14.66       14.63       14.76       14.97       14.38       15.07
Duration System        84.44       88.38       90.64       92.65       94.01       90.58      100.43       89.15       88.89       84.04
Duration Elapsed       98.83       99.06       99.81       99.65      100.26       99.90      100.30       99.24       99.14       98.87

And I also add tracing for patchset effect, which show the cmpxchg failure times
get clearly less.



 Performance counter stats for './run-mmtests.sh -c configs/config-workload-thpscale rc2-b':

             6,720      compaction:mm_compaction_isolate_migratepages
            13,526      compaction:mm_compaction_isolate_freepages
             4,052      compaction:mm_compaction_migratepages
            34,199      compaction:mm_compaction_begin
            34,199      compaction:mm_compaction_end
            21,784      compaction:mm_compaction_try_to_compact_pages
            71,606      compaction:mm_compaction_finished
           106,545      compaction:mm_compaction_suitable
                 0      compaction:mm_compaction_deferred
                 0      compaction:mm_compaction_defer_compaction
             2,977      compaction:mm_compaction_defer_reset
                 0      compaction:mm_compaction_kcompactd_sleep
                 0      compaction:mm_compaction_wakeup_kcompactd
                 0      compaction:mm_compaction_kcompactd_wake
             1,046      pageblock:hit_cmpxchg

     114.914303988 seconds time elapsed

      15.754797000 seconds user
      89.712251000 seconds sys





 Performance counter stats for './run-mmtests.sh -c configs/config-workload-thpscale pageblock-a':

               602      compaction:mm_compaction_isolate_migratepages
             3,710      compaction:mm_compaction_isolate_freepages
               402      compaction:mm_compaction_migratepages
            43,116      compaction:mm_compaction_begin
            43,116      compaction:mm_compaction_end
            24,810      compaction:mm_compaction_try_to_compact_pages
            86,527      compaction:mm_compaction_finished
           125,819      compaction:mm_compaction_suitable
                 2      compaction:mm_compaction_deferred
                 0      compaction:mm_compaction_defer_compaction
               271      compaction:mm_compaction_defer_reset
                 0      compaction:mm_compaction_kcompactd_sleep
                 0      compaction:mm_compaction_wakeup_kcompactd
                 0      compaction:mm_compaction_kcompactd_wake
               369      pageblock:hit_cmpxchg

     107.405499745 seconds time elapsed

      15.830967000 seconds user
      84.559767000 seconds sys


commit 36cea76895637c0c18ce8590c0f43a3e453fbf8f
Author: Alex Shi <alex.shi@linux.alibaba.com>
Date:   Wed Aug 19 17:26:26 2020 +0800

    add cmpxchg tracing

    Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>

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

