Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F121AC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 10:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9DE1207DA
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 10:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgH3KOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 06:14:39 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:39051 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726264AbgH3KOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 06:14:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04392;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0U7FapVA_1598782473;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U7FapVA_1598782473)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 30 Aug 2020 18:14:34 +0800
Subject: Re: [PATCH v2 1/2] mm/pageblock: mitigation cmpxchg false sharing in
 pageblock flags
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1597816075-61091-1-git-send-email-alex.shi@linux.alibaba.com>
 <8ec2a4b0-9e51-abf9-fa7a-29989d3f1fac@arm.com>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <01c846d4-2fe4-eeef-6c79-e71fda1f9a39@linux.alibaba.com>
Date:   Sun, 30 Aug 2020 18:14:33 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8ec2a4b0-9e51-abf9-fa7a-29989d3f1fac@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2020/8/19 下午3:55, Anshuman Khandual 写道:
> 
> 
> On 08/19/2020 11:17 AM, Alex Shi wrote:
>> pageblock_flags is used as long, since every pageblock_flags is just 4
>> bits, 'long' size will include 8(32bit machine) or 16 pageblocks' flags,
>> that flag setting has to sync in cmpxchg with 7 or 15 other pageblock
>> flags. It would cause long waiting for sync.
>>
>> If we could change the pageblock_flags variable as char, we could use
>> char size cmpxchg, which just sync up with 2 pageblock flags. it could
>> relief much false sharing in cmpxchg.
> 
> Do you have numbers demonstrating claimed performance improvement
> after this change ?
> 

the performance data show in another email.

LKP reported the arm6 has a bug on this patchset, since it has no cmpxchgb
solution, so maybe let's fallback to cmpxchg on it.

From db3d97ba8cc5e206b440bd40a92ef6955ad86bc0 Mon Sep 17 00:00:00 2001
From: Alex Shi <alex.shi@linux.alibaba.com>
Date: Tue, 18 Aug 2020 15:51:18 +0800
Subject: [PATCH v2 3/3] armv6: fix armv6 build issue

Arm v6 can not simulate cmpxchg1 func, so we have to use cmpxchg4 on it.

   arm-linux-gnueabi-ld: mm/page_alloc.o: in function `set_pfnblock_flags_mask':
   (.text+0x32b4): undefined reference to `__bad_cmpxchg'
   arm-linux-gnueabi-ld: (.text+0x32e0): undefined reference to `__bad_cmpxchg'
   arm-linux-gnueabi-ld: drivers/net/ethernet/aquantia/atlantic/hw_atl/hw_atl_b0.o: in function `hw_atl_b0_get_mac_temp':
   hw_atl_b0.c:(.text+0x30fc): undefined reference to `__bad_udelay'

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 mm/page_alloc.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7da09d66233b..c09146a8946c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -517,7 +517,11 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 {
 	unsigned char *bitmap;
 	unsigned long bitidx, byte_bitidx;
+#ifdef	CONFIG_CPU_V6
+	unsigned long old_byte, byte;
+#else
 	unsigned char old_byte, byte;
+#endif
 
 	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != BITS_PER_BYTE);
 	BUILD_BUG_ON(MIGRATE_TYPES > (1 << PB_migratetype_bits));
@@ -532,9 +536,18 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 	mask <<= bitidx;
 	flags <<= bitidx;
 
+#ifdef	CONFIG_CPU_V6
+	byte = (unsigned long)READ_ONCE(bitmap[byte_bitidx]);
+#else
 	byte = READ_ONCE(bitmap[byte_bitidx]);
+#endif
 	for (;;) {
+#ifdef	CONFIG_CPU_V6
+		/* arm v6 has no cmpxchgb function, so still false sharing long word */
+		old_byte = cmpxchg((unsigned long*)&bitmap[byte_bitidx], byte, (byte & ~mask) | flags);
+#else
 		old_byte = cmpxchg(&bitmap[byte_bitidx], byte, (byte & ~mask) | flags);
+#endif
 		if (byte == old_byte)
 			break;
 		byte = old_byte;
-- 
1.8.3.1

