Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9F7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70953206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbgF3Nlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:41:50 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:57252 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726248AbgF3Nlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:41:50 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 09CA1F219864EDC93449;
        Tue, 30 Jun 2020 21:41:49 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.226) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Tue, 30 Jun 2020 21:41:38 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] irqchip/gic-v3: Remove the unused register definition
Date:   Tue, 30 Jun 2020 21:41:26 +0800
Message-ID: <20200630134126.880-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.185.226]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per the GICv3 specification, GIC{D,R}_SEIR are not assigned and the
locations (0x0068) are actually Reserved. GICR_MOV{LPI,ALL}R are two IMP
DEF registers and might be defined by some specific micro-architecture,
Linux doesn't use them.

As they're not used anywhere in the kernel, just drop all of them.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---

Compile tested on top of mainline.

 include/linux/irqchip/arm-gic-v3.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/irqchip/arm-gic-v3.h b/include/linux/irqchip/arm-gic-v3.h
index 6c36b6cc3edf..f6d092fdb93d 100644
--- a/include/linux/irqchip/arm-gic-v3.h
+++ b/include/linux/irqchip/arm-gic-v3.h
@@ -19,7 +19,6 @@
 #define GICD_CLRSPI_NSR			0x0048
 #define GICD_SETSPI_SR			0x0050
 #define GICD_CLRSPI_SR			0x0058
-#define GICD_SEIR			0x0068
 #define GICD_IGROUPR			0x0080
 #define GICD_ISENABLER			0x0100
 #define GICD_ICENABLER			0x0180
@@ -119,14 +118,11 @@
 #define GICR_WAKER			0x0014
 #define GICR_SETLPIR			0x0040
 #define GICR_CLRLPIR			0x0048
-#define GICR_SEIR			GICD_SEIR
 #define GICR_PROPBASER			0x0070
 #define GICR_PENDBASER			0x0078
 #define GICR_INVLPIR			0x00A0
 #define GICR_INVALLR			0x00B0
 #define GICR_SYNCR			0x00C0
-#define GICR_MOVLPIR			0x0100
-#define GICR_MOVALLR			0x0110
 #define GICR_IDREGS			GICD_IDREGS
 #define GICR_PIDR2			GICD_PIDR2
 
-- 
2.19.1

