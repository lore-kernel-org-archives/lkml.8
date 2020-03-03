Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1D7C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1AA021D56
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgCCBsz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 20:48:55 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:48877 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726773AbgCCBsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 20:48:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=zhangliguang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TrVHtRc_1583200126;
Received: from localhost(mailfrom:zhangliguang@linux.alibaba.com fp:SMTPD_---0TrVHtRc_1583200126)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 03 Mar 2020 09:48:52 +0800
From:   luanshi <zhangliguang@linux.alibaba.com>
To:     Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        luanshi <zhangliguang@linux.alibaba.com>
Subject: [PATCH] irqdomain: Fix function documentation of __irq_domain_alloc_fwnode
Date:   Tue,  3 Mar 2020 09:48:45 +0800
Message-Id: <1583200125-58806-1-git-send-email-zhangliguang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function got renamed at some point, but the kernel-doc was not
updated.

Signed-off-by: luanshi <zhangliguang@linux.alibaba.com>
---
 kernel/irq/irqdomain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 7527e5e..fdfc213 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -46,11 +46,11 @@ static inline void debugfs_remove_domain_dir(struct irq_domain *d) { }
 EXPORT_SYMBOL_GPL(irqchip_fwnode_ops);
 
 /**
- * irq_domain_alloc_fwnode - Allocate a fwnode_handle suitable for
+ * __irq_domain_alloc_fwnode - Allocate a fwnode_handle suitable for
  *                           identifying an irq domain
  * @type:	Type of irqchip_fwnode. See linux/irqdomain.h
- * @name:	Optional user provided domain name
  * @id:		Optional user provided id if name != NULL
+ * @name:	Optional user provided domain name
  * @pa:		Optional user-provided physical address
  *
  * Allocate a struct irqchip_fwid, and return a poiner to the embedded
-- 
1.8.3.1

