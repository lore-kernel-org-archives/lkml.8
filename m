Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB50C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 05:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17644207ED
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 05:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgFEFYE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 01:24:04 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55712 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725280AbgFEFYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 01:24:03 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 440F65EA5DFB85F80713;
        Fri,  5 Jun 2020 13:24:01 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Fri, 5 Jun 2020 13:23:51 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>
CC:     <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <wanghaibin.wang@huawei.com>, <wangjingyi11@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] irqchip/gic-v4.1: Use readx_poll_timeout_atomic() to fix sleep in atomic
Date:   Fri, 5 Jun 2020 13:23:45 +0800
Message-ID: <20200605052345.1494-1-yuzenghui@huawei.com>
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

readx_poll_timeout() can sleep if @sleep_us is specified by the caller,
and is therefore unsafe to be used inside the atomic context, which is
this case when we use it to poll the GICR_VPENDBASER.Dirty bit in
irq_set_vcpu_affinity() callback.

Let's convert to its atomic version instead which helps to get the v4.1
board back to life!

Fixes: 96806229ca03 ("irqchip/gic-v4.1: Add support for VPENDBASER's Dirty+Valid signaling")
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index cd685f521c77..6a5a87fc4601 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3797,10 +3797,10 @@ static void its_wait_vpt_parse_complete(void)
 	if (!gic_rdists->has_vpend_valid_dirty)
 		return;
 
-	WARN_ON_ONCE(readq_relaxed_poll_timeout(vlpi_base + GICR_VPENDBASER,
-						val,
-						!(val & GICR_VPENDBASER_Dirty),
-						10, 500));
+	WARN_ON_ONCE(readq_relaxed_poll_timeout_atomic(vlpi_base + GICR_VPENDBASER,
+						       val,
+						       !(val & GICR_VPENDBASER_Dirty),
+						       10, 500));
 }
 
 static void its_vpe_schedule(struct its_vpe *vpe)
-- 
2.19.1

