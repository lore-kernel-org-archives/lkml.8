Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA284C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 06:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B61E920791
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 06:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgHNG2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 02:28:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9803 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726116AbgHNG2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 02:28:07 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 0E26B9E5115403E9F7E9;
        Fri, 14 Aug 2020 14:28:03 +0800 (CST)
Received: from huawei.com (10.44.142.101) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Fri, 14 Aug 2020
 14:27:54 +0800
From:   Sang Yan <sangyan@huawei.com>
To:     <kexec@lists.infradead.org>, <ebiederm@xmission.com>,
        <linux-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>,
        <guohanjun@huawei.com>
CC:     <zhuling8@huawei.com>, <luanjianhai@huawei.com>,
        <luchunhua@huawei.com>
Subject: [PATCH 2/2] arm64: Reserve memory for quick kexec
Date:   Fri, 14 Aug 2020 01:52:39 -0400
Message-ID: <20200814055239.47348-2-sangyan@huawei.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200814055239.47348-1-sangyan@huawei.com>
References: <20200814055239.47348-1-sangyan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.44.142.101]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reserve memory for quick kexec on arm64
with cmdline "quickkexec=".

Signed-off-by: Sang Yan <sangyan@huawei.com>
---
 arch/arm64/kernel/setup.c |  6 ++++++
 arch/arm64/mm/init.c      | 43 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 77c4c9bad1b8..2a5dc032d95e 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -369,6 +369,12 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	 */
 	init_task.thread_info.ttbr0 = __pa_symbol(empty_zero_page);
 #endif
+#ifdef CONFIG_QUICK_KEXEC
+		if (quick_kexec_res.end &&
+		    quick_kexec_res.start >= res->start &&
+		    quick_kexec_res.end <= res->end)
+			request_resource(res, &quick_kexec_res);
+#endif
 
 	if (boot_args[1] || boot_args[2] || boot_args[3]) {
 		pr_err("WARNING: x1-x3 nonzero in violation of boot protocol:\n"
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 481d22c32a2e..579acb93728f 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -130,6 +130,45 @@ static void __init reserve_crashkernel(void)
 }
 #endif /* CONFIG_KEXEC_CORE */
 
+#ifdef CONFIG_QUICK_KEXEC
+static int __init parse_quick_kexec(char *p)
+{
+	if (!p)
+		return 0;
+
+	quick_kexec_res.end = PAGE_ALIGN(memparse(p, NULL));
+
+	return 0;
+}
+early_param("quickkexec", parse_quick_kexec);
+
+static void __init reserve_quick_kexec(void)
+{
+	unsigned long long mem_start, mem_len;
+
+	mem_len = quick_kexec_res.end;
+	if (mem_len == 0)
+		return;
+
+	/* Current arm64 boot protocol requires 2MB alignment */
+	mem_start = memblock_find_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
+			mem_len, CRASH_ALIGN);
+	if (mem_start == 0) {
+		pr_warn("cannot allocate quick kexec mem (size:0x%llx)\n",
+			mem_len);
+		quick_kexec_res.end = 0;
+		return;
+	}
+
+	memblock_reserve(mem_start, mem_len);
+	pr_info("quick kexec mem reserved: 0x%016llx - 0x%016llx (%lld MB)\n",
+		mem_start, mem_start + mem_len,	mem_len >> 20);
+
+	quick_kexec_res.start = mem_start;
+	quick_kexec_res.end = mem_start + mem_len - 1;
+}
+#endif
+
 #ifdef CONFIG_CRASH_DUMP
 static int __init early_init_dt_scan_elfcorehdr(unsigned long node,
 		const char *uname, int depth, void *data)
@@ -399,6 +438,10 @@ void __init arm64_memblock_init(void)
 
 	reserve_crashkernel();
 
+#ifdef CONFIG_QUICK_KEXEC
+	reserve_quick_kexec();
+#endif
+
 	reserve_elfcorehdr();
 
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
-- 
2.19.1

