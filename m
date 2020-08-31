Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3850C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BECBF207BB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 07:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="mACKkyQQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgHaHeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 03:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgHaHd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 03:33:59 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45473C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 00:33:59 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d22so133134pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 00:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D2/zDTHvWlr1Ly8bFpcj2KiwYie4rAzDW76UW7C3FiQ=;
        b=mACKkyQQ3E/8JXYbwFUTlc1csMGhgn1EiPhe/kKRn4KBtyQaNIy996S4oVaTWzlCIu
         tLDEfA8yVJcq6YAC8VOuPDhIpk5u1jVuz/u47YDYMr/nNi+XKiwzI12UZaFZFS4JrbhR
         hy4GxpGFrtcl1cjCIm/lGKk1tcow2uDZjBkrqyUE4U1ltLvNXsk0eOS+/LmFw3HRZx/w
         HowbdOqEENDRs0P/AnZ33dv/PMMJPbYUq+HUdnFEDaH24O5y+Mv1IDklM62ZeVlX4sbJ
         FbdXCOTDyrPR6CzWnoVt0VVJ6rxCZwpgfwZJz+KwWqgmbTFaxJBygSyPPwdS7a3bo/+S
         Bpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D2/zDTHvWlr1Ly8bFpcj2KiwYie4rAzDW76UW7C3FiQ=;
        b=dGQVD49j+FitnwUG1NYfjwSEy3ckFFMLNoQ4BQFAMBOthESHBzMxhgwYNl3OohI6qe
         aWCpzZ3ZRpWnl183AS8OvGDHdN4+cVh9hC/2SbJ1GQSbmQgpZ6GX3mf0Lcpb7g8+mdLm
         5rWNNXCIAsBbApj8d9vgSIUvqFTerNvcot7FQ+2ALQEz2FkjPpYW1/nIHDWwTFy3usC5
         xkVdeRFcVGVga8v/FaJZ5X5mR3WCRFotL2VeIj5ZCDAtxQpQBk84dsX+ux9GTbRXlWaz
         a8X0arE/lo09f0tFtwcDC0uUxWRS7VCaAAL6NKd3Nz35MYtc5EAFmKoyBXuJ+9bsEh3k
         cbmw==
X-Gm-Message-State: AOAM5313E8DeJrMyIJ2WXAbOMMi3GslkB/RDd7wr/gWO+qSwcQpsSFh+
        84OtSTtuUcuyEAnAhNxiqX2uRw==
X-Google-Smtp-Source: ABdhPJwDzdqwO+6c2A0n956bc0Kzwtr46Zq0Wj5zhNMlJWmnjRsDKjYooyKfh0ZE52LII3vg+9b+xQ==
X-Received: by 2002:a65:6286:: with SMTP id f6mr336781pgv.0.1598859238809;
        Mon, 31 Aug 2020 00:33:58 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id m3sm6065979pjn.28.2020.08.31.00.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 00:33:58 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        david.abdurachmanov@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [PATCH v4 3/3] riscv: Add cache information in AUX vector
Date:   Mon, 31 Aug 2020 15:33:50 +0800
Message-Id: <b6fed9b4c2a3eacb2a9c353c2570d9dc1d0c1c88.1598859038.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <cover.1598859038.git.zong.li@sifive.com>
References: <cover.1598859038.git.zong.li@sifive.com>
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
index 291d7d8f748b..de59dd457b41 100644
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
+	return NULL;
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
+
+	return this_leaf ? (this_leaf->ways_of_associativity << 16 |
+			    this_leaf->coherency_line_size) :
+			   0;
+}
+
 static void ci_leaf_init(struct cacheinfo *this_leaf, enum cache_type type,
 			 unsigned int level, unsigned int size,
 			 unsigned int sets, unsigned int line_size)
-- 
2.28.0

