Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB069C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90083206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730940AbgIGRUw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:20:52 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11236 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729673AbgIGNri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:47:38 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DFEB22355186AC059AD1;
        Mon,  7 Sep 2020 21:46:58 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Sep 2020 21:46:49 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <dyoung@redhat.com>, <bhe@redhat.com>, <corbet@lwn.net>,
        <John.P.donnelly@oracle.com>, <prabhakar.pkin@gmail.com>,
        <bhsharma@redhat.com>
CC:     <horms@verge.net.au>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <nsaenzjulienne@suse.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <wangkefeng.wang@huawei.com>, <chenzhou10@huawei.com>
Subject: [PATCH v12 3/9] x86: kdump: use macro CRASH_ADDR_LOW_MAX in functions reserve_crashkernel[_low]()
Date:   Mon, 7 Sep 2020 21:47:39 +0800
Message-ID: <20200907134745.25732-4-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200907134745.25732-1-chenzhou10@huawei.com>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make the functions reserve_crashkernel[_low]() as generic,
replace some hard-coded numbers with macro CRASH_ADDR_LOW_MAX.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 arch/x86/kernel/setup.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index d7fd90c52dae..71a6a6e7ca5b 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -430,7 +430,7 @@ static int __init reserve_crashkernel_low(void)
 	unsigned long total_low_mem;
 	int ret;
 
-	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
+	total_low_mem = memblock_mem_size(CRASH_ADDR_LOW_MAX >> PAGE_SHIFT);
 
 	/* crashkernel=Y,low */
 	ret = parse_crashkernel_low(boot_command_line, total_low_mem, &low_size, &base);
@@ -451,7 +451,7 @@ static int __init reserve_crashkernel_low(void)
 			return 0;
 	}
 
-	low_base = memblock_find_in_range(CRASH_ALIGN, 1ULL << 32, low_size, CRASH_ALIGN);
+	low_base = memblock_find_in_range(CRASH_ALIGN, CRASH_ADDR_LOW_MAX, low_size, CRASH_ALIGN);
 	if (!low_base) {
 		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
 		       (unsigned long)(low_size >> 20));
@@ -504,8 +504,9 @@ static void __init reserve_crashkernel(void)
 	if (!crash_base) {
 		/*
 		 * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
-		 * crashkernel=x,high reserves memory over 4G, also allocates
-		 * 256M extra low memory for DMA buffers and swiotlb.
+		 * crashkernel=x,high reserves memory over CRASH_ADDR_LOW_MAX,
+		 * also allocates 256M extra low memory for DMA buffers
+		 * and swiotlb.
 		 * But the extra memory is not required for all machines.
 		 * So try low memory first and fall back to high memory
 		 * unless "crashkernel=size[KMG],high" is specified.
@@ -539,7 +540,7 @@ static void __init reserve_crashkernel(void)
 		return;
 	}
 
-	if (crash_base >= (1ULL << 32) && reserve_crashkernel_low()) {
+	if (crash_base >= CRASH_ADDR_LOW_MAX && reserve_crashkernel_low()) {
 		memblock_free(crash_base, crash_size);
 		return;
 	}
-- 
2.20.1

