Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515CDC352A5
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0782082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 03:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgBKDlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 22:41:12 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:60918 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727831AbgBKDlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 22:41:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=guoren@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TpeDRM7_1581392468;
Received: from localhost(mailfrom:guoren@linux.alibaba.com fp:SMTPD_---0TpeDRM7_1581392468)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 11 Feb 2020 11:41:09 +0800
From:   Guo Ren <guoren@linux.alibaba.com>
To:     linux-csky@vger.kernel.org, majun258@linux.alibaba.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] csky: Add PCI support
Date:   Tue, 11 Feb 2020 11:41:07 +0800
Message-Id: <20200211034107.11192-1-guoren@linux.alibaba.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: MaJun <majun258@linux.alibaba.com>

Add the pci related code for csky arch to support basic pci virtual
function, such as qemu virt-pci-9pfs.

Signed-off-by: MaJun <majun258@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/Kconfig           |  5 +++++
 arch/csky/include/asm/pci.h | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)
 create mode 100644 arch/csky/include/asm/pci.h

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index bf246b036dee..72b2999a889a 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -58,6 +58,11 @@ config CSKY
 	select TIMER_OF
 	select USB_ARCH_HAS_EHCI
 	select USB_ARCH_HAS_OHCI
+	select GENERIC_PCI_IOMAP
+	select HAVE_PCI
+	select PCI_DOMAINS_GENERIC if PCI
+	select PCI_SYSCALL if PCI
+	select PCI_MSI if PCI
 
 config CPU_HAS_CACHEV2
 	bool
diff --git a/arch/csky/include/asm/pci.h b/arch/csky/include/asm/pci.h
new file mode 100644
index 000000000000..ebc765b1f78b
--- /dev/null
+++ b/arch/csky/include/asm/pci.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __ASM_CSKY_PCI_H
+#define __ASM_CSKY_PCI_H
+
+#include <linux/types.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/io.h>
+
+#define PCIBIOS_MIN_IO		0
+#define PCIBIOS_MIN_MEM		0
+
+/* C-SKY shim does not initialize PCI bus */
+#define pcibios_assign_all_busses() 1
+
+extern int isa_dma_bridge_buggy;
+
+#ifdef CONFIG_PCI
+static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
+{
+	/* no legacy IRQ on csky */
+	return -ENODEV;
+}
+
+static inline int pci_proc_domain(struct pci_bus *bus)
+{
+	/* always show the domain in /proc */
+	return 1;
+}
+#endif  /* CONFIG_PCI */
+
+#endif  /* __ASM_CSKY_PCI_H */
-- 
2.17.0

