Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A35EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E55A1206D7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B2pFBFVV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgEDPAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:00:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50374 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgEDPAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:00:09 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044Elbbx116456;
        Mon, 4 May 2020 14:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=gOU60KEGCpd90jFwTgBCZEZdFNyJRNJA9GfZLpt6zw8=;
 b=B2pFBFVVIkkc3kRYz76iRL1urniEgMM+pcMfb/sfNQ+kqocoURz+DfnjrDyBw0q84WPk
 rRFnStr5d0TiPQz8dTQe+RC1kIowLLuiJ+4pjuS0XEOdsqYJWbhuJkBu0+AZw3jdkIuE
 PrhMsEQ9QI3/CFfdW6JKLoHoGFaBkqE+RWrVGE7xrXPmvhbwJgrItDIl+Zc3WI8PxpZt
 FLN4bRgMWADYqsEx9LVm8MDmbon8NIMUHC1uUDb2M/SzYVSDH/EzkvBo7YFpVewBEJ1w
 tXRJyqnM3Lz4qCXl5BpTCj7x2of9DtyXiLgkTejBTo1+4YQQ+j4iZaEmIbZftiywvRQc LA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 30s09qyfpj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:59:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044ElK3e033673;
        Mon, 4 May 2020 14:59:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 30sjnaw0r4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:59:38 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044Exaia022105;
        Mon, 4 May 2020 14:59:36 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 07:59:36 -0700
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        x86@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC v4][PATCH part-2 01/13] mm/x86: Introduce decorated page-table (dpt)
Date:   Mon,  4 May 2020 16:57:58 +0200
Message-Id: <20200504145810.11882-2-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504145810.11882-1-alexandre.chartre@oracle.com>
References: <20200504145810.11882-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=2
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015 suspectscore=2
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A decorated page-table (dpt) encapsulates a native page-table (e.g.
a PGD) and maintain additional attributes related to this page-table.
It aims to be the base structure for providing useful functions to
manage a page-table, such as tracking VA range mapped in a page-table
or safely handling references to another page-table.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/dpt.h | 23 +++++++++++++
 arch/x86/mm/Makefile       |  2 +-
 arch/x86/mm/dpt.c          | 67 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/include/asm/dpt.h
 create mode 100644 arch/x86/mm/dpt.c

diff --git a/arch/x86/include/asm/dpt.h b/arch/x86/include/asm/dpt.h
new file mode 100644
index 000000000000..1da4d43d5e94
--- /dev/null
+++ b/arch/x86/include/asm/dpt.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ARCH_X86_MM_DPT_H
+#define ARCH_X86_MM_DPT_H
+
+#include <linux/spinlock.h>
+
+#include <asm/pgtable.h>
+
+/*
+ * A decorated page-table (dpt) encapsulates a native page-table (e.g.
+ * a PGD) and maintain additional attributes related to this page-table.
+ */
+struct dpt {
+	spinlock_t		lock;		/* protect all attributes */
+	pgd_t			*pagetable;	/* the actual page-table */
+	unsigned int		alignment;	/* page-table alignment */
+
+};
+
+extern struct dpt *dpt_create(unsigned int pgt_alignment);
+extern void dpt_destroy(struct dpt *dpt);
+
+#endif
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index e57af263e870..5b52d854a030 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -48,7 +48,7 @@ obj-$(CONFIG_NUMA_EMU)		+= numa_emulation.o
 obj-$(CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS)	+= pkeys.o
 obj-$(CONFIG_RANDOMIZE_MEMORY)			+= kaslr.o
 obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
-obj-$(CONFIG_ADDRESS_SPACE_ISOLATION)		+= asi.o
+obj-$(CONFIG_ADDRESS_SPACE_ISOLATION)		+= asi.o dpt.o
 
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
diff --git a/arch/x86/mm/dpt.c b/arch/x86/mm/dpt.c
new file mode 100644
index 000000000000..333e259c5b7f
--- /dev/null
+++ b/arch/x86/mm/dpt.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, 2020, Oracle and/or its affiliates.
+ *
+ */
+
+#include <linux/slab.h>
+
+#include <asm/dpt.h>
+
+/*
+ * dpt_create - allocate a page-table and create a corresponding
+ * decorated page-table. The page-table is allocated and aligned
+ * at the specified alignment (pgt_alignment) which should be a
+ * multiple of PAGE_SIZE.
+ */
+struct dpt *dpt_create(unsigned int pgt_alignment)
+{
+	unsigned int alloc_order;
+	unsigned long pagetable;
+	struct dpt *dpt;
+
+	if (!IS_ALIGNED(pgt_alignment, PAGE_SIZE))
+		return NULL;
+
+	alloc_order = round_up(PAGE_SIZE + pgt_alignment,
+			       PAGE_SIZE) >> PAGE_SHIFT;
+
+	dpt = kzalloc(sizeof(*dpt), GFP_KERNEL);
+	if (!dpt)
+		return NULL;
+
+	pagetable = (unsigned long)__get_free_pages(GFP_KERNEL_ACCOUNT |
+						    __GFP_ZERO,
+						    alloc_order);
+	if (!pagetable) {
+		kfree(dpt);
+		return NULL;
+	}
+	dpt->pagetable = (pgd_t *)(pagetable + pgt_alignment);
+	dpt->alignment = pgt_alignment;
+
+	spin_lock_init(&dpt->lock);
+
+	return dpt;
+}
+EXPORT_SYMBOL(dpt_create);
+
+void dpt_destroy(struct dpt *dpt)
+{
+	unsigned int pgt_alignment;
+	unsigned int alloc_order;
+
+	if (!dpt)
+		return;
+
+	if (dpt->pagetable) {
+		pgt_alignment = dpt->alignment;
+		alloc_order = round_up(PAGE_SIZE + pgt_alignment,
+				       PAGE_SIZE) >> PAGE_SHIFT;
+		free_pages((unsigned long)(dpt->pagetable) - pgt_alignment,
+			   alloc_order);
+	}
+
+	kfree(dpt);
+}
+EXPORT_SYMBOL(dpt_destroy);
-- 
2.18.2

