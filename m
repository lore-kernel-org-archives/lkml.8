Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93FFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6C52253D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgAVI4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 03:56:46 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9234 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbgAVI4q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 03:56:46 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5AA0BFA352067B42F98D;
        Wed, 22 Jan 2020 16:56:44 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Wed, 22 Jan 2020 16:56:35 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <maz@kernel.org>
CC:     <kvmarm@lists.cs.columbia.edu>, <linux-kernel@vger.kernel.org>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] irqchip/gic-v3-its: Don't confuse get_vlpi_map() by writing DB config
Date:   Wed, 22 Jan 2020 16:56:09 +0800
Message-ID: <20200122085609.658-1-yuzenghui@huawei.com>
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

When we're writing config for the doorbell interrupt, get_vlpi_map() will
get confused by doorbell's d->parent_data hack and find the wrong its_dev
as chip data and the wrong event.

Fix this issue by making sure no doorbells will be involved before invoking
get_vlpi_map(), which restore some of the logic in lpi_write_config().

Fixes: c1d4d5cd203c ("irqchip/gic-v3-its: Add its_vlpi_map helpers")
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---

This is based on mainline and can't be directly applied to the current
irqchip-next.

 drivers/irqchip/irq-gic-v3-its.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e05673bcd52b..cc8a4fcbd6d6 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1181,12 +1181,13 @@ static struct its_vlpi_map *get_vlpi_map(struct irq_data *d)
 
 static void lpi_write_config(struct irq_data *d, u8 clr, u8 set)
 {
-	struct its_vlpi_map *map = get_vlpi_map(d);
 	irq_hw_number_t hwirq;
 	void *va;
 	u8 *cfg;
 
-	if (map) {
+	if (irqd_is_forwarded_to_vcpu(d)) {
+		struct its_vlpi_map *map = get_vlpi_map(d);
+
 		va = page_address(map->vm->vprop_page);
 		hwirq = map->vintid;
 
-- 
2.19.1


