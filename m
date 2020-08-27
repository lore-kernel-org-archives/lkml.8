Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF11C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1384F20738
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:22:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Z+ACVrFc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgH0IWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgH0IWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 04:22:39 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCCDC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:22:39 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g33so2826644pgb.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 01:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6vAnmwYo3lbxQQn+hV6anOdZ6zB32DMmJPar8gJX3cQ=;
        b=Z+ACVrFc2VZNV4dVWmWQBJz6B834/kqQ6ZDCnr+m9LssTFPDHa8MHa+PNY6EssrxB/
         2DHsXXcwwUS8NWa31JpYNeuKjmNBH3RYiH+tFxqtgR/itgmHOEFkFLBLO/TaCAH3W6XK
         ZCPzPOEqwrcfC3ey8Hki5A+pcS2IJcRf2/iqHXnFPVQ1c/TpgAgTEzJbdZuYbDGP1seb
         a92+zkkIO3bHl3pOSU4QguqYjOdk+ELZjVy5df+vB2Xk+3yF+VFeCZOF84VphlEpHrlI
         b6Dw9bxHhaEOUUYjVKEJZfcdBOeHhT579wCEeNRhKv3HLg8BRVtrV5Ebe75025By4R47
         EeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6vAnmwYo3lbxQQn+hV6anOdZ6zB32DMmJPar8gJX3cQ=;
        b=oBrAK/vO0PltiCggg6rijxDYNhnGk50PrPq6SsB+spL4MNpcKe4eVUoT3+iqgySo5f
         fFUsTU0pqXzs35ADi6HKVjZjZOENK8I03fWEUFLfa+Lv7lqnx5MqAfzyH9Iqb91jWYfD
         Xbioxr9axY7ABhbV7RkIfPZaEnpk1VQqq5TWreW2TiC+OJw/0SY+8ejvCHog9EndW+hO
         UBnDJqjgrJph29xinzhhIT1Z1pZVTCOWCgc+PNQp8/WKnKhXW+mTgkkBfLbDzyPFV0nJ
         rJzgbFd/M1Wxryoe02ToFs4jtVNUAvlMiIOEm7Bn5EXBJzS2ZntjMWk/TFSy2nRRCYf0
         fE+g==
X-Gm-Message-State: AOAM532hhcPyAnrs7/okzvVWHVGSh7kz3hhvJ3qrMvYPQKotgGEDSaYD
        a5vArTDl5DZSUItH6qimQo5dtg==
X-Google-Smtp-Source: ABdhPJyqHS11CnZPYSmTIq+sVPZiXhXgOld3KmNt53wRASpby4W8aElwOnBHaLJka79ZJz0GaqOMww==
X-Received: by 2002:a63:205e:: with SMTP id r30mr13218978pgm.56.1598516558566;
        Thu, 27 Aug 2020 01:22:38 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id 124sm1828351pfb.19.2020.08.27.01.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 01:22:38 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        david.abdurachmanov@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v2 3/3] riscv: Add cache information in AUX vector
Date:   Thu, 27 Aug 2020 16:22:28 +0800
Message-Id: <f9199795d6e9bae73f49583c494505e0a4983c61.1598515355.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598515355.git.zong.li@sifive.com>
References: <cover.1598515355.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are no standard CSR registers to provide cache information, the
way for RISC-V is to get this information from DT. Currently, AT_L1I_X,
AT_L1D_X and AT_L2_X are present in glibc header, and sysconf syscall
could use them to get information of cache through AUX vector.

The result of 'getconf -a' as follows:
LEVEL1_ICACHE_SIZE                 32768
LEVEL1_ICACHE_ASSOC                8
LEVEL1_ICACHE_LINESIZE             64
LEVEL1_DCACHE_SIZE                 32768
LEVEL1_DCACHE_ASSOC                8
LEVEL1_DCACHE_LINESIZE             64
LEVEL2_CACHE_SIZE                  2097152
LEVEL2_CACHE_ASSOC                 32
LEVEL2_CACHE_LINESIZE              64

Signed-off-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/cacheinfo.h   |  5 +++++
 arch/riscv/include/asm/elf.h         | 13 +++++++++++
 arch/riscv/include/uapi/asm/auxvec.h | 23 +++++++++++++++++++-
 arch/riscv/kernel/cacheinfo.c        | 32 +++++++++++++++++++++++++++-
 4 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/cacheinfo.h b/arch/riscv/include/asm/cacheinfo.h
index 5d9662e9aba8..d1a365215ec0 100644
--- a/arch/riscv/include/asm/cacheinfo.h
+++ b/arch/riscv/include/asm/cacheinfo.h
@@ -1,4 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 SiFive
+ */
 
 #ifndef _ASM_RISCV_CACHEINFO_H
 #define _ASM_RISCV_CACHEINFO_H
@@ -11,5 +14,7 @@ struct riscv_cacheinfo_ops {
 };
 
 void riscv_set_cacheinfo_ops(struct riscv_cacheinfo_ops *ops);
+uintptr_t get_cache_size(u32 level, enum cache_type type);
+uintptr_t get_cache_geometry(u32 level, enum cache_type type);
 
 #endif /* _ASM_RISCV_CACHEINFO_H */
diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index d83a4efd052b..5c725e1df58b 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -11,6 +11,7 @@
 #include <uapi/asm/elf.h>
 #include <asm/auxvec.h>
 #include <asm/byteorder.h>
+#include <asm/cacheinfo.h>
 
 /*
  * These are used to set parameters in the core dumps.
@@ -61,6 +62,18 @@ extern unsigned long elf_hwcap;
 do {								\
 	NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
 		(elf_addr_t)current->mm->context.vdso);		\
+	NEW_AUX_ENT(AT_L1I_CACHESIZE,				\
+		get_cache_size(1, CACHE_TYPE_INST));		\
+	NEW_AUX_ENT(AT_L1I_CACHEGEOMETRY,			\
+		get_cache_geometry(1, CACHE_TYPE_INST));	\
+	NEW_AUX_ENT(AT_L1D_CACHESIZE,				\
+		get_cache_size(1, CACHE_TYPE_DATA));		\
+	NEW_AUX_ENT(AT_L1D_CACHEGEOMETRY,			\
+		get_cache_geometry(1, CACHE_TYPE_DATA));	\
+	NEW_AUX_ENT(AT_L2_CACHESIZE,				\
+		get_cache_size(2, CACHE_TYPE_UNIFIED));		\
+	NEW_AUX_ENT(AT_L2_CACHEGEOMETRY,			\
+		get_cache_geometry(2, CACHE_TYPE_UNIFIED));	\
 } while (0)
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES
 struct linux_binprm;
diff --git a/arch/riscv/include/uapi/asm/auxvec.h b/arch/riscv/include/uapi/asm/auxvec.h
index 22e0ae888406..32c73ba1d531 100644
--- a/arch/riscv/include/uapi/asm/auxvec.h
+++ b/arch/riscv/include/uapi/asm/auxvec.h
@@ -10,7 +10,28 @@
 /* vDSO location */
 #define AT_SYSINFO_EHDR 33
 
+/*
+ * The set of entries below represent more extensive information
+ * about the caches, in the form of two entry per cache type,
+ * one entry containing the cache size in bytes, and the other
+ * containing the cache line size in bytes in the bottom 16 bits
+ * and the cache associativity in the next 16 bits.
+ *
+ * The associativity is such that if N is the 16-bit value, the
+ * cache is N way set associative. A value if 0xffff means fully
+ * associative, a value of 1 means directly mapped.
+ *
+ * For all these fields, a value of 0 means that the information
+ * is not known.
+ */
+#define AT_L1I_CACHESIZE	40
+#define AT_L1I_CACHEGEOMETRY	41
+#define AT_L1D_CACHESIZE	42
+#define AT_L1D_CACHEGEOMETRY	43
+#define AT_L2_CACHESIZE		44
+#define AT_L2_CACHEGEOMETRY	45
+
 /* entries in ARCH_DLINFO */
-#define AT_VECTOR_SIZE_ARCH	1
+#define AT_VECTOR_SIZE_ARCH	7
 
 #endif /* _UAPI_ASM_RISCV_AUXVEC_H */
diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
index 8b85abfbd77a..13cd23cb8548 100644
--- a/arch/riscv/kernel/cacheinfo.c
+++ b/arch/riscv/kernel/cacheinfo.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2017 SiFive
  */
 
-#include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -25,6 +24,37 @@ cache_get_priv_group(struct cacheinfo *this_leaf)
 	return NULL;
 }
 
+static struct cacheinfo *get_cacheinfo(u32 level, enum cache_type type)
+{
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(smp_processor_id());
+	struct cacheinfo *this_leaf;
+	int index;
+
+	for (index = 0; index < this_cpu_ci->num_leaves; index++) {
+		this_leaf = this_cpu_ci->info_list + index;
+		if (this_leaf->level == level && this_leaf->type == type)
+			return this_leaf;
+	}
+
+	return 0;
+}
+
+uintptr_t get_cache_size(u32 level, enum cache_type type)
+{
+	struct cacheinfo *this_leaf = get_cacheinfo(level, type);
+
+	return this_leaf ? this_leaf->size : 0;
+}
+
+uintptr_t get_cache_geometry(u32 level, enum cache_type type)
+{
+	struct cacheinfo *this_leaf = get_cacheinfo(level, type);
+	uintptr_t ret = (this_leaf->ways_of_associativity << 16 |
+			 this_leaf->coherency_line_size);
+
+	return this_leaf ? ret : 0;
+}
+
 static void ci_leaf_init(struct cacheinfo *this_leaf, enum cache_type type,
 			 unsigned int level, unsigned int size,
 			 unsigned int sets, unsigned int line_size)
-- 
2.28.0

