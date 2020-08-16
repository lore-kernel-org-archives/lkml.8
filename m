Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1371C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 14:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C111420735
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 14:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgHPOPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 10:15:17 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:60651 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729449AbgHPOPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 10:15:11 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U5uJ-GC_1597587304;
Received: from IT-FVFX43SYHV2H.lan(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U5uJ-GC_1597587304)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 16 Aug 2020 22:15:05 +0800
Subject: Re: [PATCH 1/2] mm/pageblock: mitigation cmpxchg false sharing in
 pageblock flags
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1597549677-7480-1-git-send-email-alex.shi@linux.alibaba.com>
 <eeb80957-96f7-661c-1510-0e6247570bd3@redhat.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <89b42892-8257-e3fc-34c9-27d9a470ed79@linux.alibaba.com>
Date:   Sun, 16 Aug 2020 22:14:08 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <eeb80957-96f7-661c-1510-0e6247570bd3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/8/16 下午8:16, David Hildenbrand 写道:
> On 16.08.20 05:47, Alex Shi wrote:
>> pageblock_flags is used as long, since every pageblock_flags is just 4
>> bits, 'long' size will include 8(32bit machine) or 16 pageblocks' flags,
>> that flag setting has to sync in cmpxchg with 7 or 15 other pageblock
>> flags. It would cause long waiting for sync.
>>
>> If we could change the pageblock_flags variable as char, we could use
>> char size cmpxchg, which just sync up with 2 pageblock flags. it could
>> relief much false sharing in cmpxchg.
> 
> Do you have any performance numbers to back your claims? IOW, do we care
> at all?
> 
> 

Hi David,

Thanks for comments!

Not yet, I trace the following commit here, with this commit this hot path
looks be resolved.

Thanks
Alex

e380bebe4771548  mm, compaction: keep migration source private to a single compaction instance
                if (!locked) {
                        locked = compact_trylock_irqsave(zone_lru_lock(zone),
                                                                &flags, cc);
-                       if (!locked)
+
+                       /* Allow future scanning if the lock is contended */
+                       if (!locked) {
+                               clear_pageblock_skip(page);
                                break;
+                       }
+
+                       /* Try get exclusive access under lock */
+                       if (!skip_updated) {
+                               skip_updated = true;
+                               if (test_and_set_skip(cc, page, low_pfn))
+                                       goto isolate_abort;
+                       }

