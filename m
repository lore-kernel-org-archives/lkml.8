Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDC0C4BA18
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5141324670
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m+IJVP5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgBZQXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:23:02 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:54412 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgBZQXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:23:01 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QFwciL094267;
        Wed, 26 Feb 2020 16:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=CUFUM8CWg9Bv0RK05kpxaVdpg6z7n2Fl0mmPBAi4JN8=;
 b=m+IJVP5vCkCfS8iEKwDsGcGMvBOVxmCfgXHO95QNBoo05nAmYW1xJ/ltWvBeh/OR/c1f
 LbL063bIpNNrulPusm38v3rGjhJhKf+7QtXLJdeVQG2w6KvAi8fY/hAjftnkISNlBPRS
 J7urnGSEgWvWuNaRpOME+IvvE4P4BdqmkVAp/zs6sOhTl3cDhpfciw8duoQ33B2p8f36
 hYUe/DKd5kuI7dBv2uy+HdRmKaYNdRXp0s8R9ufwtnIMS0KzONerctW+wVYMihuIZeTf
 rZpadWUljXGKsNPuTI0khr35jemWnGS4g/fRPbctt45i2QcfUWQk1EyXh7j1GxtsnSaq eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 2ydct34r2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 16:22:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QGMJFT016721;
        Wed, 26 Feb 2020 16:22:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2ydcs5dfwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Feb 2020 16:22:20 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01QGMBfl000498;
        Wed, 26 Feb 2020 16:22:11 GMT
Received: from achartre-desktop.us.oracle.com (/10.39.232.60)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Feb 2020 08:22:11 -0800
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
To:     rkrcmar@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, x86@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     pbonzini@redhat.com, konrad.wilk@oracle.com,
        jan.setjeeilers@oracle.com, liran.alon@oracle.com,
        junaids@google.com, graf@amazon.de, rppt@linux.vnet.ibm.com,
        kuzuno@gmail.com, mgross@linux.intel.com,
        alexandre.chartre@oracle.com
Subject: [RFC PATCH v3 1/7] mm/x86: Introduce kernel Address Space Isolation (ASI)
Date:   Wed, 26 Feb 2020 17:21:54 +0100
Message-Id: <1582734120-26757-2-git-send-email-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1582734120-26757-1-git-send-email-alexandre.chartre@oracle.com>
References: <1582734120-26757-1-git-send-email-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260111
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce core functions and structures for implementing Address Space
Isolation (ASI). Kernel address space isolation provides the ability to
run some kernel code with a reduced kernel address space.

An address space isolation is defined with a struct asi structure and
associated with an ASI type and a pagetable.

Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
---
 arch/x86/include/asm/asi.h |   88 ++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/mm/Makefile       |    1 +
 arch/x86/mm/asi.c          |   60 ++++++++++++++++++++++++++++++
 security/Kconfig           |   10 +++++
 4 files changed, 159 insertions(+), 0 deletions(-)
 create mode 100644 arch/x86/include/asm/asi.h
 create mode 100644 arch/x86/mm/asi.c

diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
new file mode 100644
index 0000000..844a81f
--- /dev/null
+++ b/arch/x86/include/asm/asi.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ARCH_X86_MM_ASI_H
+#define ARCH_X86_MM_ASI_H
+
+#ifdef CONFIG_ADDRESS_SPACE_ISOLATION
+
+/*
+ * An Address Space Isolation (ASI) is defined with a struct asi and
+ * associated with an ASI type (struct asi_type). All ASIs of the same
+ * type reference the same ASI type.
+ *
+ * An ASI type has a unique PCID prefix (a value in the range [1, 255])
+ * which is used to define the PCID used for the ASI CR3 value. The
+ * first four bits of the ASI PCID come from the kernel PCID (a value
+ * between 1 and 6, see TLB_NR_DYN_ASIDS). The remaining 8 bits are
+ * filled with the ASI PCID prefix.
+ *
+ *   ASI PCID = (ASI Type PCID Prefix << 4) | Kernel PCID
+ *
+ * The ASI PCID is used to optimize TLB flushing when switching between
+ * the kernel and ASI pagetables. The optimization is valid only when
+ * a task switches between ASI of different types. If a task switches
+ * between different ASIs with the same type then the ASI TLB the task
+ * is switching to will always be flushed.
+ */
+
+#define ASI_PCID_PREFIX_SHIFT	4
+#define ASI_PCID_PREFIX_MASK	0xff0
+#define ASI_KERNEL_PCID_MASK	0x00f
+
+/*
+ * We use bit 12 of a pagetable pointer (and so of the CR3 value) as
+ * a way to know if a pointer/CR3 is referencing a full kernel page
+ * table or an ASI page table.
+ *
+ * A full kernel pagetable is always located on the first half of an
+ * 8K buffer, while an ASI pagetable is always located on the second
+ * half of an 8K buffer.
+ */
+#define ASI_PGTABLE_BIT		PAGE_SHIFT
+#define ASI_PGTABLE_MASK	(1 << ASI_PGTABLE_BIT)
+
+#ifndef __ASSEMBLY__
+
+#include <linux/export.h>
+
+struct asi_type {
+	int			pcid_prefix;	/* PCID prefix */
+};
+
+/*
+ * Macro to define and declare an ASI type.
+ *
+ * Declaring an ASI type will also define an inline function
+ * (asi_create_<typename>()) to easily create an ASI of the
+ * specified type.
+ */
+#define DEFINE_ASI_TYPE(name, pcid_prefix)			\
+	struct asi_type asi_type_ ## name = {			\
+		pcid_prefix,					\
+	};							\
+	EXPORT_SYMBOL(asi_type_ ## name)
+
+#define DECLARE_ASI_TYPE(name)				\
+	extern struct asi_type asi_type_ ## name;	\
+	DECLARE_ASI_CREATE(name)
+
+#define DECLARE_ASI_CREATE(name)			\
+static inline struct asi *asi_create_ ## name(void)	\
+{							\
+	return asi_create(&asi_type_ ## name);		\
+}
+
+struct asi {
+	struct asi_type		*type;		/* ASI type */
+	pgd_t			*pagetable;	/* ASI pagetable */
+	unsigned long		base_cr3;	/* base ASI CR3 */
+};
+
+extern struct asi *asi_create(struct asi_type *type);
+extern void asi_destroy(struct asi *asi);
+extern void asi_set_pagetable(struct asi *asi, pgd_t *pagetable);
+
+#endif	/* __ASSEMBLY__ */
+
+#endif	/* CONFIG_ADDRESS_SPACE_ISOLATION */
+
+#endif
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index 3b89c20..99c56ed 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -49,6 +49,7 @@ obj-$(CONFIG_X86_INTEL_MPX)			+= mpx.o
 obj-$(CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS)	+= pkeys.o
 obj-$(CONFIG_RANDOMIZE_MEMORY)			+= kaslr.o
 obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
+obj-$(CONFIG_ADDRESS_SPACE_ISOLATION)		+= asi.o
 
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
new file mode 100644
index 0000000..0a0ac9d
--- /dev/null
+++ b/arch/x86/mm/asi.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019, 2020, Oracle and/or its affiliates.
+ *
+ * Kernel Address Space Isolation (ASI)
+ */
+
+#include <linux/mm.h>
+#include <linux/slab.h>
+
+#include <asm/asi.h>
+#include <asm/bug.h>
+
+struct asi *asi_create(struct asi_type *type)
+{
+	struct asi *asi;
+
+	if (!type)
+		return NULL;
+
+	asi = kzalloc(sizeof(*asi), GFP_KERNEL);
+	if (!asi)
+		return NULL;
+
+	asi->type = type;
+
+	return asi;
+}
+EXPORT_SYMBOL(asi_create);
+
+void asi_destroy(struct asi *asi)
+{
+	kfree(asi);
+}
+EXPORT_SYMBOL(asi_destroy);
+
+void asi_set_pagetable(struct asi *asi, pgd_t *pagetable)
+{
+	/*
+	 * Check that the specified pagetable is properly aligned to be
+	 * used as an ASI pagetable. If not, the pagetable is ignored
+	 * and entering/exiting ASI will do nothing.
+	 */
+	if (!(((unsigned long)pagetable) & ASI_PGTABLE_MASK)) {
+		WARN(1, "ASI %p: invalid ASI pagetable", asi);
+		asi->pagetable = NULL;
+		return;
+	}
+	asi->pagetable = pagetable;
+
+	/*
+	 * Initialize the invariant part of the ASI CR3 value. We will
+	 * just have to complete the PCID with the kernel PCID before
+	 * using it.
+	 */
+	asi->base_cr3 = __sme_pa(asi->pagetable) |
+		(asi->type->pcid_prefix << ASI_PCID_PREFIX_SHIFT);
+
+}
+EXPORT_SYMBOL(asi_set_pagetable);
diff --git a/security/Kconfig b/security/Kconfig
index 2a1a2d3..fe0515a 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -65,6 +65,16 @@ config PAGE_TABLE_ISOLATION
 
 	  See Documentation/x86/pti.rst for more details.
 
+config ADDRESS_SPACE_ISOLATION
+	bool "Allow code to run with a reduced kernel address space"
+	default y
+	depends on (X86_64 || X86_PAE) && !UML
+	help
+	   This feature provides the ability to run some kernel code
+	   with a reduced kernel address space. This can be used to
+	   mitigate speculative execution attacks which are able to
+	   leak data between sibling CPU hyper-threads.
+
 config SECURITY_INFINIBAND
 	bool "Infiniband Security Hooks"
 	depends on SECURITY && INFINIBAND
-- 
1.7.1

