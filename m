Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA52FC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5A22080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 07:47:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgAJHr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 02:47:57 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60672 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726549AbgAJHr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 02:47:57 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 40D871CBDB19189F9994;
        Fri, 10 Jan 2020 15:47:52 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.31) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Fri, 10 Jan 2020
 15:47:43 +0800
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <anshuman.khandual@arm.com>, <akpm@linux-foundation.org>,
        <willy@infradead.org>, <yeyunfeng@huawei.com>,
        <ard.biesheuvel@arm.com>, <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <hushiyuan@huawei.com>, <linfeilong@huawei.com>
From:   yeyunfeng <yeyunfeng@huawei.com>
Subject: [PATCH] arm64: mm: support setting page attributes for debug
 situation
Message-ID: <5a3ab728-b895-0930-9540-5e9c586e8858@huawei.com>
Date:   Fri, 10 Jan 2020 15:47:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.31]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When rodata_full is set or pagealloc debug is enabled, block mappings or
contiguou hints are no longer used for linear address area. Therefore,
support setting page attributes in this case is useful for debugging
memory corruption problems.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
---
 arch/arm64/mm/pageattr.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 9ce7bd9d4d9c..823143534a93 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -65,6 +65,9 @@ static int change_memory_common(unsigned long addr, int numpages,
 		WARN_ON_ONCE(1);
 	}

+	if (!numpages)
+		return 0;
+
 	/*
 	 * Kernel VA mappings are always live, and splitting live section
 	 * mappings into page mappings may cause TLB conflicts. This means
@@ -81,11 +84,18 @@ static int change_memory_common(unsigned long addr, int numpages,
 	area = find_vm_area((void *)addr);
 	if (!area ||
 	    end > (unsigned long)area->addr + area->size ||
-	    !(area->flags & VM_ALLOC))
+	    !(area->flags & VM_ALLOC)) {
+
+		/*
+		 * When rodata_full is set, or pagealloc debug is enabled,
+		 * the linear address is mapped with NO_BLOCK_MAPPINGS or
+		 * NO_CONT_MAPPINGS flags, so splitting is never needed.
+		 */
+		if (rodata_full || debug_pagealloc_enabled())
+			return __change_memory_common(start, size, set_mask,
+							clear_mask);
 		return -EINVAL;
-
-	if (!numpages)
-		return 0;
+	}

 	/*
 	 * If we are manipulating read-only permissions, apply the same
-- 
2.7.4

