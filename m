Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE77C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 03:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8258C20707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 03:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgHZDym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 23:54:42 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50626 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726682AbgHZDym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 23:54:42 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 776A076F4CE524E1FDCB;
        Wed, 26 Aug 2020 11:54:40 +0800 (CST)
Received: from localhost (10.174.179.108) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Wed, 26 Aug 2020
 11:54:34 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <nm@ti.com>, <t-kristo@ti.com>, <ssantosh@kernel.org>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>, <maz@kernel.org>,
        <lokeshvutla@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] irqchip/ti-sci-inta: Fix unsigned comparison to zero
Date:   Wed, 26 Aug 2020 11:54:30 +0800
Message-ID: <20200826035430.21060-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.108]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ti_sci_inta_xlate_irq() return -ENOENT on fail, p_hwirq
should be int type.

Fixes: 5c4b585d2910 ("irqchip/ti-sci-inta: Add support for INTA directly connecting to GIC")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/irqchip/irq-ti-sci-inta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index d4e97605456b..05bf94b87b93 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -175,8 +175,8 @@ static struct ti_sci_inta_vint_desc *ti_sci_inta_alloc_parent_irq(struct irq_dom
 	struct irq_fwspec parent_fwspec;
 	struct device_node *parent_node;
 	unsigned int parent_virq;
-	u16 vint_id, p_hwirq;
-	int ret;
+	int p_hwirq, ret;
+	u16 vint_id;
 
 	vint_id = ti_sci_get_free_resource(inta->vint);
 	if (vint_id == TI_SCI_RESOURCE_NULL)
-- 
2.20.1


