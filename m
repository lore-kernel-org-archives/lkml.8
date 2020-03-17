Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A42C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7488D20714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCQLzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:55:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725794AbgCQLzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:55:12 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 63265C7A635DEAC5073C;
        Tue, 17 Mar 2020 19:55:04 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Tue, 17 Mar 2020 19:54:56 +0800
From:   Hongbo Yao <yaohongbo@huawei.com>
To:     <will@kernel.org>, <broonie@kernel.org>
CC:     <yaohongbo@huawei.com>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] arm64: fix the missing ktpi= cmdline check in arm64_kernel_unmapped_at_el0()
Date:   Tue, 17 Mar 2020 19:47:08 +0800
Message-ID: <20200317114708.109283-1-yaohongbo@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kpti cannot be disabled from the kernel cmdline after the commit
09e3c22a("arm64: Use a variable to store non-global mappings decision").

Bring back the missing check of kpti= command-line option to fix the
case where the SPE driver complains the missing "kpti-off" even it has
already been set.

Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
---
 arch/arm64/include/asm/mmu.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
index 3c9533322558..ebbc0d3ac2f7 100644
--- a/arch/arm64/include/asm/mmu.h
+++ b/arch/arm64/include/asm/mmu.h
@@ -34,7 +34,8 @@ extern bool arm64_use_ng_mappings;
 
 static inline bool arm64_kernel_unmapped_at_el0(void)
 {
-	return arm64_use_ng_mappings;
+	return arm64_use_ng_mappings &&
+		cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0);
 }
 
 typedef void (*bp_hardening_cb_t)(void);
-- 
2.20.1

