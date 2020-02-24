Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8DBC35673
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6937D20637
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 02:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbgBXCvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 21:51:03 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:43792 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727156AbgBXCvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 21:51:03 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 08295B1E631B9B876FB6;
        Mon, 24 Feb 2020 10:51:01 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Mon, 24 Feb 2020 10:50:52 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <kvmarm@lists.cs.columbia.edu>, <maz@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Yanlei Jia <jiayanlei@huawei.com>
Subject: [PATCH] irqchip/gic-v3-its: Clear Valid before writing any bits else in VPENDBASER
Date:   Mon, 24 Feb 2020 10:50:29 +0800
Message-ID: <20200224025029.92-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Valid bit must be cleared before changing anything else when writing
GICR_VPENDBASER to avoid the UNPREDICTABLE behavior. This is exactly what
we've done on 32bit arm, but not on arm64.

This works fine on GICv4 where we only clear Valid for a vPE deschedule.
With the introduction of GICv4.1, we might also need to talk something else
(e.g., PendingLast, Doorbell) to the redistributor when clearing the Valid.
Let's port the 32bit gicr_write_vpendbaser() to arm64 so that hardware can
do the right thing after descheduling the vPE.

Cc: Yanlei Jia <jiayanlei@huawei.com>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 arch/arm64/include/asm/arch_gicv3.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index 25fec4bde43a..effe66e1ca58 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -143,7 +143,18 @@ static inline u32 gic_read_rpr(void)
 #define gicr_write_vpropbaser(v, c)	writeq_relaxed(v, c)
 #define gicr_read_vpropbaser(c)		readq_relaxed(c)
 
-#define gicr_write_vpendbaser(v, c)	writeq_relaxed(v, c)
+#define gicr_write_vpendbaser(v, c) do {		\
+	u64 tmp = readq_relaxed(c);			\
+							\
+	/* Clear Valid before writing any bits else. */	\
+	if (tmp & GICR_VPENDBASER_Valid) {		\
+		tmp &= ~GICR_VPENDBASER_Valid;		\
+		writeq_relaxed(tmp, c);			\
+	}						\
+							\
+	writeq_relaxed(v, c);				\
+} while (0)
+
 #define gicr_read_vpendbaser(c)		readq_relaxed(c)
 
 static inline bool gic_prio_masking_enabled(void)
-- 
2.19.1


