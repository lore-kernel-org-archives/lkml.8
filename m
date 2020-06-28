Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE58C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 08:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C361A20724
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 08:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgF1Ia6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 04:30:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59044 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726129AbgF1Ias (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 04:30:48 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 303A83761374F50AAB1F;
        Sun, 28 Jun 2020 16:30:45 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Sun, 28 Jun 2020 16:30:36 +0800
From:   Chen Zhou <chenzhou10@huawei.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <dyoung@redhat.com>,
        <bhe@redhat.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <John.P.donnelly@oracle.com>, <prabhakar.pkin@gmail.com>,
        <nsaenzjulienne@suse.de>, <corbet@lwn.net>, <bhsharma@redhat.com>,
        <horms@verge.net.au>
CC:     <guohanjun@huawei.com>, <xiexiuqi@huawei.com>,
        <huawei.libin@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <chenzhou10@huawei.com>
Subject: [PATCH v9 4/5] arm64: kdump: fix kdump broken with ZONE_DMA reintroduced
Date:   Sun, 28 Jun 2020 16:34:57 +0800
Message-ID: <20200628083458.40066-5-chenzhou10@huawei.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200628083458.40066-1-chenzhou10@huawei.com>
References: <20200628083458.40066-1-chenzhou10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 1a8e1cef7603 ("arm64: use both ZONE_DMA and ZONE_DMA32")
broken the arm64 kdump. If the memory reserved for crash dump kernel
falled in ZONE_DMA32, the devices in crash dump kernel need to use
ZONE_DMA will alloc fail.

This patch addressed the above issue based on "reserving crashkernel
above 4G". Originally, we reserve low memory below 4G, and now just need
to adjust memory limit to arm64_dma_phys_limit in reserve_crashkernel_low
if ZONE_DMA is enabled. That is, if there are devices need to use ZONE_DMA
in crash dump kernel, it is a good choice to use parameters
"crashkernel=X crashkernel=Y,low".

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 kernel/crash_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index a7580d291c37..e8ecbbc761a3 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -320,6 +320,7 @@ int __init reserve_crashkernel_low(void)
 	unsigned long long base, low_base = 0, low_size = 0;
 	unsigned long total_low_mem;
 	int ret;
+	phys_addr_t crash_max = 1ULL << 32;
 
 	total_low_mem = memblock_mem_size(1UL << (32 - PAGE_SHIFT));
 
@@ -352,7 +353,11 @@ int __init reserve_crashkernel_low(void)
 			return 0;
 	}
 
-	low_base = memblock_find_in_range(0, 1ULL << 32, low_size, CRASH_ALIGN);
+#ifdef CONFIG_ARM64
+	if (IS_ENABLED(CONFIG_ZONE_DMA))
+		crash_max = arm64_dma_phys_limit;
+#endif
+	low_base = memblock_find_in_range(0, crash_max, low_size, CRASH_ALIGN);
 	if (!low_base) {
 		pr_err("Cannot reserve %ldMB crashkernel low memory, please try smaller size.\n",
 		       (unsigned long)(low_size >> 20));
-- 
2.20.1

