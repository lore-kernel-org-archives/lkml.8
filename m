Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B73D1C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E9D621841
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kKs5ycMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgEDOxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 10:53:30 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39692 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgEDOxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 10:53:30 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044EnCHY024811;
        Mon, 4 May 2020 14:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=aTvo3LOy6ZsSCX7rN8bz6bGi2mzArjNplhSWG2j/8T4=;
 b=kKs5ycMXibypAaFfXJGlmHPuQPQAejWwXHc+K3dNpt4MN/F/gF/k7/AoXcEzh+X3qXos
 3AzkG9SQ+GKii+7TCX5tCmtDXOlJarpRbwYu9FmQf7Y9Q+8G6n4CcaOSe0zDhPQxBvVr
 XDlLRRtMIxpeRYldNbZV/5xVzYW7h0U5uaNsIHeiJvpeqGCRKbhw96ZCr2ZOeHwlKtgk
 3R5Wmt+mJKnzRNa6PBN/FM7aidz+X0aRCdx/Ef8V7Ne/+6cvmbxqOdiIYyfKpzv/YxaY
 59LVOCvVZNIE0udsdMJdJD8KUwlAcmqYO7rCFXEug6eTIokHgvXrjPTd1KFjmD5w9STQ Kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30s0tm7byn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:53:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 044Elap1053358;
        Mon, 4 May 2020 14:51:07 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 30t1r2e0t8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 May 2020 14:51:07 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 044Ep4HN027354;
        Mon, 4 May 2020 14:51:04 GMT
Received: from linux-1.home.com (/10.175.9.166)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 04 May 2020 07:51:04 -0700
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
Subject: [RFC v4][PATCH part-1 1/7] mm/x86: Introduce kernel Address Space Isolation (ASI)
Date:   Mon,  4 May 2020 16:49:33 +0200
Message-Id: <20200504144939.11318-2-alexandre.chartre@oracle.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200504144939.11318-1-alexandre.chartre@oracle.com>
References: <20200504144939.11318-1-alexandre.chartre@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005040123
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9610 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 phishscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005040123
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
 arch/x86/include/asm/asi.h | 88 ++++++++++++++++++++++++++++++++++++++
 arch/x86/mm/Makefile       |  1 +
 arch/x86/mm/asi.c          | 60 ++++++++++++++++++++++++++
 security/Kconfig           | 10 +++++
 4 files changed, 159 insertions(+)
 create mode 100644 arch/x86/include/asm/asi.h
 create mode 100644 arch/x86/mm/asi.c

diff --git a/arch/x86/include/asm/asi.h b/arch/x86/include/asm/asi.h
new file mode 100644
index 000000000000..844a81fb84d2
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
index 98f7c6fa2eaa..e57af263e870 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -48,6 +48,7 @@ obj-$(CONFIG_NUMA_EMU)		+= numa_emulation.o
 obj-$(CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS)	+= pkeys.o
 obj-$(CONFIG_RANDOMIZE_MEMORY)			+= kaslr.o
 obj-$(CONFIG_PAGE_TABLE_ISOLATION)		+= pti.o
+obj-$(CONFIG_ADDRESS_SPACE_ISOLATION)		+= asi.o
 
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt.o
 obj-$(CONFIG_AMD_MEM_ENCRYPT)	+= mem_encrypt_identity.o
diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
new file mode 100644
index 000000000000..0a0ac9d6d078
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
index cd3cc7da3a55..d98197eb260c 100644
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
2.18.2

