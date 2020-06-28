Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E03C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 08:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0023208C7
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 08:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgF1Iao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 04:30:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6845 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726038AbgF1Ian (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 04:30:43 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 087E1ECADE2ACC3F6BB8;
        Sun, 28 Jun 2020 16:30:40 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Sun, 28 Jun 2020 16:30:34 +0800
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
Subject: [PATCH v9 2/5] arm64: kdump: reserve crashkenel above 4G for crash dump kernel
Date:   Sun, 28 Jun 2020 16:34:55 +0800
Message-ID: <20200628083458.40066-3-chenzhou10@huawei.com>
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

Crashkernel=X tries to reserve memory for the crash dump kernel under
4G. If crashkernel=X,low is specified simultaneously, reserve spcified
size low memory for crash kdump kernel devices firstly and then reserve
memory above 4G.

Suggested by James, just introduced crashkernel=X,low to arm64. As memtioned
above, if crashkernel=X,low is specified simultaneously, reserve spcified
size low memory for crash kdump kernel devices firstly and then reserve
memory above 4G, which is much simpler.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
Tested-by: John Donnelly <John.p.donnelly@oracle.com>
Tested-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
---
 arch/arm64/kernel/setup.c |  8 +++++++-
 arch/arm64/mm/init.c      | 31 +++++++++++++++++++++++++++++--
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 93b3844cf442..4dc51a2ac012 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -238,7 +238,13 @@ static void __init request_standard_resources(void)
 		    kernel_data.end <= res->end)
 			request_resource(res, &kernel_data);
 #ifdef CONFIG_KEXEC_CORE
-		/* Userspace will find "Crash kernel" region in /proc/iomem. */
+		/*
+		 * Userspace will find "Crash kernel" region in /proc/iomem.
+		 * Note: the low region is renamed as Crash kernel (low).
+		 */
+		if (crashk_low_res.end && crashk_low_res.start >= res->start &&
+				crashk_low_res.end <= res->end)
+			request_resource(res, &crashk_low_res);
 		if (crashk_res.end && crashk_res.start >= res->start &&
 		    crashk_res.end <= res->end)
 			request_resource(res, &crashk_res);
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 1e93cfc7c47a..ce7ced85f5fb 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -81,6 +81,7 @@ static void __init reserve_crashkernel(void)
 {
 	unsigned long long crash_base, crash_size;
 	int ret;
+	phys_addr_t crash_max = arm64_dma32_phys_limit;
 
 	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
 				&crash_size, &crash_base);
@@ -88,12 +89,38 @@ static void __init reserve_crashkernel(void)
 	if (ret || !crash_size)
 		return;
 
+	ret = reserve_crashkernel_low();
+	if (!ret && crashk_low_res.end) {
+		/*
+		 * If crashkernel=X,low specified, there may be two regions,
+		 * we need to make some changes as follows:
+		 *
+		 * 1. rename the low region as "Crash kernel (low)"
+		 * In order to distinct from the high region and make no effect
+		 * to the use of existing kexec-tools, rename the low region as
+		 * "Crash kernel (low)".
+		 *
+		 * 2. change the upper bound for crash memory
+		 * Set MEMBLOCK_ALLOC_ACCESSIBLE upper bound for crash memory.
+		 *
+		 * 3. mark the low region as "nomap"
+		 * The low region is intended to be used for crash dump kernel
+		 * devices, just mark the low region as "nomap" simply.
+		 */
+		const char *rename = "Crash kernel (low)";
+
+		crashk_low_res.name = rename;
+		crash_max = MEMBLOCK_ALLOC_ACCESSIBLE;
+		memblock_mark_nomap(crashk_low_res.start,
+				    resource_size(&crashk_low_res));
+	}
+
 	crash_size = PAGE_ALIGN(crash_size);
 
 	if (crash_base == 0) {
 		/* Current arm64 boot protocol requires 2MB alignment */
-		crash_base = memblock_find_in_range(0, arm64_dma32_phys_limit,
-				crash_size, SZ_2M);
+		crash_base = memblock_find_in_range(0, crash_max, crash_size,
+				SZ_2M);
 		if (crash_base == 0) {
 			pr_warn("cannot allocate crashkernel (size:0x%llx)\n",
 				crash_size);
-- 
2.20.1

