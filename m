Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B748C11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E2020659
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 02:08:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729523AbgBUCIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 21:08:00 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60196 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727845AbgBUCIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 21:08:00 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C9E913A4B175E03AC2E3;
        Fri, 21 Feb 2020 10:07:58 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.173.222.27) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Fri, 21 Feb 2020 10:07:50 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <maz@kernel.org>, <tglx@linutronix.de>,
        <wanghaibin.wang@huawei.com>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] genirq/irqdomain: Make sure all irq domain flags are distinct
Date:   Fri, 21 Feb 2020 10:07:25 +0800
Message-ID: <20200221020725.2038-1-yuzenghui@huawei.com>
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

This was noticed when printing debugfs for MSIs on my ARM64 server.
The new dstate IRQD_MSI_NOMASK_QUIRK came out surprisingly while it
should only be the x86 stuff for the time being...

It's the overlap in irqdomain flags which leads to this confusion.
(1 << 1) might be a good choice for old IRQ_DOMAIN_NAME_ALLOCATED,
use it to avoid this overlap.

Fixes: 6f1a4891a592 ("x86/apic/msi: Plug non-maskable MSI affinity race")
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 include/linux/irqdomain.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index b2d47571ab67..8d062e86d954 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -192,7 +192,7 @@ enum {
 	IRQ_DOMAIN_FLAG_HIERARCHY	= (1 << 0),
 
 	/* Irq domain name was allocated in __irq_domain_add() */
-	IRQ_DOMAIN_NAME_ALLOCATED	= (1 << 6),
+	IRQ_DOMAIN_NAME_ALLOCATED	= (1 << 1),
 
 	/* Irq domain is an IPI domain with virq per cpu */
 	IRQ_DOMAIN_FLAG_IPI_PER_CPU	= (1 << 2),
-- 
2.19.1


