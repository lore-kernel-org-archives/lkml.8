Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C7AC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C9E2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727563AbgBJJFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:05:42 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:41921 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727029AbgBJJFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:05:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=zhabin@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TpbD1jB_1581325533;
Received: from localhost(mailfrom:zhabin@linux.alibaba.com fp:SMTPD_---0TpbD1jB_1581325533)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 Feb 2020 17:05:33 +0800
From:   Zha Bin <zhabin@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     mst@redhat.com, jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
        gerry@linux.alibaba.com, zhabin@linux.alibaba.com,
        jing2.liu@linux.intel.com, chao.p.peng@linux.intel.com
Subject: [PATCH v2 5/5] x86: virtio-mmio: support virtio-mmio with MSI for x86
Date:   Mon, 10 Feb 2020 17:05:21 +0800
Message-Id: <946b71e77a34666a9b8c419c5a467d1628b50fa0.1581305609.git.zhabin@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1581305609.git.zhabin@linux.alibaba.com>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
In-Reply-To: <cover.1581305609.git.zhabin@linux.alibaba.com>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Jiang <gerry@linux.alibaba.com>

virtio-mmio supports a generic MSI irq domain for all archs. This
patch adds the x86 architecture support.

Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
Co-developed-by: Jing Liu <jing2.liu@linux.intel.com>
Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
---
 arch/x86/kernel/apic/msi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 159bd0c..2fcd602 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -45,7 +45,11 @@ static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg)
 		MSI_DATA_VECTOR(cfg->vector);
 }
 
-static void irq_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
+/*
+ * x86 PCI-MSI/HPET/DMAR related method.
+ * Also can be used as arch specific method for virtio-mmio MSI.
+ */
+void irq_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
 {
 	__irq_msi_compose_msg(irqd_cfg(data), msg);
 }
@@ -166,6 +170,11 @@ static void irq_msi_update_msg(struct irq_data *irqd, struct irq_cfg *cfg)
 	return ret;
 }
 
+struct irq_domain *arch_msi_root_irq_domain(void)
+{
+	return x86_vector_domain;
+}
+
 /*
  * IRQ Chip for MSI PCI/PCI-X/PCI-Express Devices,
  * which implement the MSI or MSI-X Capability Structure.
-- 
1.8.3.1

