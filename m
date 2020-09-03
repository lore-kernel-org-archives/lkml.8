Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65832C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DC712065E
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 08:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgICIkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 04:40:53 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:56252 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726479AbgICIkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 04:40:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0U7nxScg_1599122447;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U7nxScg_1599122447)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Sep 2020 16:40:48 +0800
Subject: Re: [PATCH v4 1/4] mm/pageblock: mitigation cmpxchg false sharing in
 pageblock flags
From:   Alex Shi <alex.shi@linux.alibaba.com>
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
 <8275cc70-fd35-25c8-36d4-525a10f05e41@linux.alibaba.com>
Message-ID: <7813624a-d8af-f09f-d8c3-0d2a01fe5dd3@linux.alibaba.com>
Date:   Thu, 3 Sep 2020 16:40:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8275cc70-fd35-25c8-36d4-525a10f05e41@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/9/3 下午4:32, Alex Shi 写道:
>>
> I have run thpscale with 'always' defrag setting of THP. The Amean stddev is much
> larger than a very little average run time reducing.
> 
> But the left patch 4 could show the cmpxchg retry reduce from thousands to hundreds
> or less.
> 
> Subject: [PATCH v4 4/4] add cmpxchg tracing


It's a typical result with the patchset:

 Performance counter stats for './run-mmtests.sh -c configs/config-workload-thpscale pageblock-c':

             9,564      compaction:mm_compaction_isolate_migratepages
             6,430      compaction:mm_compaction_isolate_freepages
             5,287      compaction:mm_compaction_migratepages
            45,299      compaction:mm_compaction_begin
            45,299      compaction:mm_compaction_end
            30,557      compaction:mm_compaction_try_to_compact_pages
            95,540      compaction:mm_compaction_finished
           149,379      compaction:mm_compaction_suitable
                 0      compaction:mm_compaction_deferred
                 0      compaction:mm_compaction_defer_compaction
             3,949      compaction:mm_compaction_defer_reset
                 0      compaction:mm_compaction_kcompactd_sleep
                 0      compaction:mm_compaction_wakeup_kcompactd
                 0      compaction:mm_compaction_kcompactd_wake
                68      pageblock:hit_cmpxchg

     113.570974583 seconds time elapsed

      14.664451000 seconds user
      96.847116000 seconds sys

It's 5.9-rc2 base kernel result:

 Performance counter stats for './run-mmtests.sh -c configs/config-workload-thpscale rc2-e':

            15,920      compaction:mm_compaction_isolate_migratepages
            20,523      compaction:mm_compaction_isolate_freepages
             9,752      compaction:mm_compaction_migratepages
            27,773      compaction:mm_compaction_begin
            27,773      compaction:mm_compaction_end
            16,391      compaction:mm_compaction_try_to_compact_pages
            62,809      compaction:mm_compaction_finished
            69,821      compaction:mm_compaction_suitable
                 0      compaction:mm_compaction_deferred
                 0      compaction:mm_compaction_defer_compaction
             7,875      compaction:mm_compaction_defer_reset
                 0      compaction:mm_compaction_kcompactd_sleep
                 0      compaction:mm_compaction_wakeup_kcompactd
                 0      compaction:mm_compaction_kcompactd_wake
             1,208      pageblock:hit_cmpxchg

     116.440414591 seconds time elapsed

      15.326913000 seconds user
     103.752758000 seconds sys

