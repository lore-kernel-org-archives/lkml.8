Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6D3C4332D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 12:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9CD120722
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 12:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgCUMRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 08:17:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58736 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727405AbgCUMRG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 08:17:06 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4F697CC732300DE34742;
        Sat, 21 Mar 2020 20:16:42 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.173.220.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Sat, 21 Mar 2020 20:16:31 +0800
From:   Zhenyu Ye <yezhenyu2@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <aneesh.kumar@linux.ibm.com>,
        <maz@kernel.org>, <steven.price@arm.com>, <broonie@kernel.org>,
        <guohanjun@huawei.com>
CC:     <yezhenyu2@huawei.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>
Subject: [RFC PATCH v3 2/4] mm: Add page table level flags to vm_flags
Date:   Sat, 21 Mar 2020 20:16:19 +0800
Message-ID: <20200321121621.1600-3-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
In-Reply-To: <20200321121621.1600-1-yezhenyu2@huawei.com>
References: <20200321121621.1600-1-yezhenyu2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add VM_LEVEL_[PUD|PMD|PTE] to vm_flags to indicate which level of
the page tables the vma is in. Those flags can be used to reduce
the cost of TLB invalidation.

These should be common flags for all architectures, however, those
flags are only available in 64-bits system currently, because the
lower-order flags are fully used.

These flags are only used by ARM64 architecture now. See in next
patch.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 include/linux/mm.h             | 10 ++++++++++
 include/trace/events/mmflags.h | 15 ++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52269e56c514..63a04e02a221 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -313,6 +313,16 @@ extern unsigned int kobjsize(const void *objp);
 #endif
 #endif /* CONFIG_ARCH_HAS_PKEYS */
 
+#ifdef CONFIG_64BIT
+# define VM_LEVEL_PUD	BIT(37)		/* vma is in pud-level of page table */
+# define VM_LEVEL_PMD	BIT(38)		/* vma is in pmd-level of page table */
+# define VM_LEVEL_PTE	BIT(39)		/* vma is in pte-level of page table */
+#else
+# define VM_LEVEL_PUD	0
+# define VM_LEVEL_PMD	0
+# define VM_LEVEL_PTE	0
+#endif /* CONFIG_64BIT */
+
 #if defined(CONFIG_X86)
 # define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
 #elif defined(CONFIG_PPC)
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index a1675d43777e..9f13cfa96f9f 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -130,6 +130,16 @@ IF_HAVE_PG_IDLE(PG_idle,		"idle"		)
 #define IF_HAVE_VM_SOFTDIRTY(flag,name)
 #endif
 
+#ifdef CONFIG_64BIT
+#define IF_HAVE_VM_LEVEL_PUD(flag,name)	{flag, name}
+#define IF_HAVE_VM_LEVEL_PMD(flag,name)	{flag, name}
+#define IF_HAVE_VM_LEVEL_PTE(flag,name)	{flag, name}
+#else
+#define IF_HAVE_VM_LEVEL_PUD(flag,name)
+#define IF_HAVE_VM_LEVEL_PMD(flag,name)
+#define IF_HAVE_VM_LEVEL_PTE(flag,name)
+#endif
+
 #define __def_vmaflag_names						\
 	{VM_READ,			"read"		},		\
 	{VM_WRITE,			"write"		},		\
@@ -161,7 +171,10 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
 	{VM_MIXEDMAP,			"mixedmap"	},		\
 	{VM_HUGEPAGE,			"hugepage"	},		\
 	{VM_NOHUGEPAGE,			"nohugepage"	},		\
-	{VM_MERGEABLE,			"mergeable"	}		\
+	{VM_MERGEABLE,			"mergeable"	},		\
+IF_HAVE_VM_LEVEL_PUD(VM_LEVEL_PUD,	"pud-level"	),		\
+IF_HAVE_VM_LEVEL_PMD(VM_LEVEL_PMD,	"pmd-level"	),		\
+IF_HAVE_VM_LEVEL_PTE(VM_LEVEL_PTE,	"pte-level"	)		\
 
 #define show_vma_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
-- 
2.19.1


