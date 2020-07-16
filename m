Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83605C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 657572067D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728063AbgGPIjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:39:24 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725921AbgGPIjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:39:23 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 88FF275C51A9C3B9AFA4;
        Thu, 16 Jul 2020 16:39:20 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.185.226) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 16:39:12 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <tglx@linutronix.de>, <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] genirq/irqdomain: Remove redundant NULL pointer check on fwnode
Date:   Thu, 16 Jul 2020 16:39:05 +0800
Message-ID: <20200716083905.287-1-yuzenghui@huawei.com>
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

The is_fwnode_irqchip() helper will check if the fwnode_handle is empty.
There is no need to perform a redundant check outside of it.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 kernel/irq/irqdomain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index a4c2c915511d..155460fc0147 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -142,7 +142,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 	if (!domain)
 		return NULL;
 
-	if (fwnode && is_fwnode_irqchip(fwnode)) {
+	if (is_fwnode_irqchip(fwnode)) {
 		fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
 
 		switch (fwid->type) {
-- 
2.19.1

