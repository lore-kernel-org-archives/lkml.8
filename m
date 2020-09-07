Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CEEC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E17921532
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgIGRVG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:21:06 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729675AbgIGNri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 09:47:38 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 20D5B788E7EE530AA00F;
        Mon,  7 Sep 2020 21:47:04 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Mon, 7 Sep 2020 21:46:53 +0800
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
Subject: [PATCH v12 7/9] kdump: add threshold for the required memory
Date:   Mon, 7 Sep 2020 21:47:43 +0800
Message-ID: <20200907134745.25732-8-chenzhou10@huawei.com>
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

For crashkernel=X, if required size X is too large and leads to very
little free low memory after low allocation, the system may not work
normally.
So add a threshold and go for high allocation directly if the required
size is too large. The value of threshold is set as the half of the
low memory.

Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
---
 kernel/crash_core.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 3f735cb37ace..d11d597a470d 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -378,6 +378,15 @@ int __init reserve_crashkernel_low(void)
 }
 
 #if defined(CONFIG_X86) || defined(CONFIG_ARM64)
+
+/*
+ * Add a threshold for required memory size of crashkernel. If required memory
+ * size is greater than threshold, just go for high allocation directly. The
+ * value of threshold is set as half of the total low memory.
+ */
+#define REQUIRED_MEMORY_THRESHOLD	(memblock_mem_size(CRASH_ADDR_LOW_MAX >> \
+			PAGE_SHIFT) >> 1)
+
 #ifdef CONFIG_KEXEC_CORE
 /*
  * reserve_crashkernel() - reserves memory for crash kernel
@@ -422,7 +431,7 @@ void __init reserve_crashkernel(void)
 		 * So try low memory first and fall back to high memory
 		 * unless "crashkernel=size[KMG],high" is specified.
 		 */
-		if (!high)
+		if (!high && crash_size <= REQUIRED_MEMORY_THRESHOLD)
 			crash_base = memblock_find_in_range(CRASH_ALIGN,
 						CRASH_ADDR_LOW_MAX,
 						crash_size, CRASH_ALIGN);
-- 
2.20.1

