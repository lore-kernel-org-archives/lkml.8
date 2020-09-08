Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2DFC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EDFF2080C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cHZa1GWK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgIHVGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 17:06:18 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:38424 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728197AbgIHVGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 17:06:11 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 6C6B7C00F7;
        Tue,  8 Sep 2020 21:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1599599168; bh=930T92cKWJypP6yEDkRjZzrcMsFryxkCqGjcWcgPMUY=;
        h=From:To:Cc:Subject:Date:From;
        b=cHZa1GWKhjUroGs2KsPh1HHUxsRXsU+KugqK28wjVOGhulzrAgESsJV2D/IWJWtfJ
         KTBTG6f5TA+FT/+5oxG/biERaIO/w8C6VFwu4xY0go6knob/gvTU12S1h1wKx+2jOQ
         kIG/aSxFtDd5BlfF7VKz/l54Q3hc/JnwAvN0Q8yR+WazoXRf5iz54GEnKhgoyHigON
         qF8I25FGivO6czOtdcvRERoUS+1RwI/vj8F88aiHv7Uyk8hzTk1/UmzTFEGKSqLdIs
         fQwrdPfB0Nlgl82S3fZRekrGw9B5N31KbLinV/gf9AYvZc0ozTuUptJ75eWPGuBy70
         yfWFogy7vonQg==
Received: from vineetg-Latitude-7400.internal.synopsys.com (unknown [10.13.183.89])
        by mailhost.synopsys.com (Postfix) with ESMTP id 8EA6FA006F;
        Tue,  8 Sep 2020 21:06:05 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Ofer Levi <oferle@nvidia.com>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH] ARC: [plat-eznps]: Drop support for EZChip NPS platform
Date:   Tue,  8 Sep 2020 14:06:01 -0700
Message-Id: <20200908210601.1746462-1-vgupta@synopsys.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NPS customers are no longer doing active development, as evident from
rand config build failures reported in recent times, so drop support
for NPS platform.

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 MAINTAINERS                             |   7 -
 arch/arc/Makefile                       |   5 -
 arch/arc/configs/nps_defconfig          |  80 ---------
 arch/arc/include/asm/atomic.h           | 104 ------------
 arch/arc/include/asm/barrier.h          |   9 +-
 arch/arc/include/asm/bitops.h           |  58 +------
 arch/arc/include/asm/cmpxchg.h          |  70 +-------
 arch/arc/include/asm/entry-compact.h    |  27 ---
 arch/arc/include/asm/processor.h        |  37 -----
 arch/arc/include/asm/ptrace.h           |   5 -
 arch/arc/include/asm/setup.h            |   4 -
 arch/arc/include/asm/spinlock.h         |   6 -
 arch/arc/include/asm/switch_to.h        |   9 -
 arch/arc/kernel/ctx_sw.c                |  13 --
 arch/arc/kernel/process.c               |  15 --
 arch/arc/mm/tlbex.S                     |   7 -
 arch/arc/plat-eznps/Kconfig             |  58 -------
 arch/arc/plat-eznps/Makefile            |   8 -
 arch/arc/plat-eznps/ctop.c              |  21 ---
 arch/arc/plat-eznps/entry.S             |  60 -------
 arch/arc/plat-eznps/include/plat/ctop.h | 208 ------------------------
 arch/arc/plat-eznps/include/plat/mtm.h  |  49 ------
 arch/arc/plat-eznps/include/plat/smp.h  |  15 --
 arch/arc/plat-eznps/mtm.c               | 166 -------------------
 arch/arc/plat-eznps/platform.c          |  91 -----------
 arch/arc/plat-eznps/smp.c               | 138 ----------------
 26 files changed, 5 insertions(+), 1265 deletions(-)
 delete mode 100644 arch/arc/configs/nps_defconfig
 delete mode 100644 arch/arc/plat-eznps/Kconfig
 delete mode 100644 arch/arc/plat-eznps/Makefile
 delete mode 100644 arch/arc/plat-eznps/ctop.c
 delete mode 100644 arch/arc/plat-eznps/entry.S
 delete mode 100644 arch/arc/plat-eznps/include/plat/ctop.h
 delete mode 100644 arch/arc/plat-eznps/include/plat/mtm.h
 delete mode 100644 arch/arc/plat-eznps/include/plat/smp.h
 delete mode 100644 arch/arc/plat-eznps/mtm.c
 delete mode 100644 arch/arc/plat-eznps/platform.c
 delete mode 100644 arch/arc/plat-eznps/smp.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b5cfab015bd6..72b4c44ac37b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6614,13 +6614,6 @@ L:	iommu@lists.linux-foundation.org
 S:	Maintained
 F:	drivers/iommu/exynos-iommu.c
 
-EZchip NPS platform support
-M:	Vineet Gupta <vgupta@synopsys.com>
-M:	Ofer Levi <oferle@nvidia.com>
-S:	Supported
-F:	arch/arc/boot/dts/eznps.dts
-F:	arch/arc/plat-eznps
-
 F2FS FILE SYSTEM
 M:	Jaegeuk Kim <jaegeuk@kernel.org>
 M:	Chao Yu <yuchao0@huawei.com>
diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index d00f8b8afd08..0c6bf0d1df7a 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -94,13 +94,8 @@ core-y		+= arch/arc/boot/dts/
 core-y				+= arch/arc/plat-sim/
 core-$(CONFIG_ARC_PLAT_TB10X)	+= arch/arc/plat-tb10x/
 core-$(CONFIG_ARC_PLAT_AXS10X)	+= arch/arc/plat-axs10x/
-core-$(CONFIG_ARC_PLAT_EZNPS)	+= arch/arc/plat-eznps/
 core-$(CONFIG_ARC_SOC_HSDK)	+= arch/arc/plat-hsdk/
 
-ifdef CONFIG_ARC_PLAT_EZNPS
-KBUILD_CPPFLAGS += -I$(srctree)/arch/arc/plat-eznps/include
-endif
-
 drivers-$(CONFIG_OPROFILE)	+= arch/arc/oprofile/
 
 libs-y		+= arch/arc/lib/ $(LIBGCC)
diff --git a/arch/arc/configs/nps_defconfig b/arch/arc/configs/nps_defconfig
deleted file mode 100644
index f7a978dfdf1d..000000000000
--- a/arch/arc/configs/nps_defconfig
+++ /dev/null
@@ -1,80 +0,0 @@
-# CONFIG_LOCALVERSION_AUTO is not set
-# CONFIG_SWAP is not set
-CONFIG_SYSVIPC=y
-CONFIG_NO_HZ_IDLE=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3=y
-# CONFIG_EPOLL is not set
-# CONFIG_SIGNALFD is not set
-# CONFIG_TIMERFD is not set
-# CONFIG_EVENTFD is not set
-# CONFIG_AIO is not set
-CONFIG_EMBEDDED=y
-CONFIG_PERF_EVENTS=y
-# CONFIG_COMPAT_BRK is not set
-CONFIG_ISA_ARCOMPACT=y
-CONFIG_KPROBES=y
-CONFIG_MODULES=y
-CONFIG_MODULE_FORCE_LOAD=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_ARC_PLAT_EZNPS=y
-CONFIG_SMP=y
-CONFIG_NR_CPUS=4096
-CONFIG_ARC_CACHE_LINE_SHIFT=5
-# CONFIG_ARC_CACHE_PAGES is not set
-# CONFIG_ARC_HAS_LLSC is not set
-CONFIG_ARC_KVADDR_SIZE=402
-CONFIG_ARC_EMUL_UNALIGNED=y
-CONFIG_PREEMPT=y
-CONFIG_NET=y
-CONFIG_UNIX=y
-CONFIG_INET=y
-CONFIG_IP_PNP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_DIAG is not set
-# CONFIG_IPV6 is not set
-# CONFIG_WIRELESS is not set
-CONFIG_DEVTMPFS=y
-CONFIG_DEVTMPFS_MOUNT=y
-# CONFIG_PREVENT_FIRMWARE_BUILD is not set
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_COUNT=1
-CONFIG_BLK_DEV_RAM_SIZE=2048
-CONFIG_NETDEVICES=y
-CONFIG_NETCONSOLE=y
-# CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_MICREL is not set
-# CONFIG_NET_VENDOR_STMICRO is not set
-# CONFIG_WLAN is not set
-# CONFIG_INPUT_MOUSEDEV is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
-# CONFIG_LEGACY_PTYS is not set
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=1
-CONFIG_SERIAL_8250_RUNTIME_UARTS=1
-CONFIG_SERIAL_8250_DW=y
-CONFIG_SERIAL_OF_PLATFORM=y
-# CONFIG_HW_RANDOM is not set
-# CONFIG_HWMON is not set
-# CONFIG_USB_SUPPORT is not set
-# CONFIG_DNOTIFY is not set
-CONFIG_PROC_KCORE=y
-CONFIG_TMPFS=y
-# CONFIG_MISC_FILESYSTEMS is not set
-CONFIG_NFS_FS=y
-CONFIG_NFS_V3_ACL=y
-CONFIG_ROOT_NFS=y
-CONFIG_DEBUG_INFO=y
-# CONFIG_ENABLE_MUST_CHECK is not set
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_MEMORY_INIT=y
-CONFIG_ENABLE_DEFAULT_TRACERS=y
diff --git a/arch/arc/include/asm/atomic.h b/arch/arc/include/asm/atomic.h
index c614857eb209..fa679b7396d2 100644
--- a/arch/arc/include/asm/atomic.h
+++ b/arch/arc/include/asm/atomic.h
@@ -14,8 +14,6 @@
 #include <asm/barrier.h>
 #include <asm/smp.h>
 
-#ifndef CONFIG_ARC_PLAT_EZNPS
-
 #define atomic_read(v)  READ_ONCE((v)->counter)
 
 #ifdef CONFIG_ARC_HAS_LLSC
@@ -195,108 +193,6 @@ ATOMIC_OPS(andnot, &= ~, bic)
 ATOMIC_OPS(or, |=, or)
 ATOMIC_OPS(xor, ^=, xor)
 
-#else /* CONFIG_ARC_PLAT_EZNPS */
-
-static inline int atomic_read(const atomic_t *v)
-{
-	int temp;
-
-	__asm__ __volatile__(
-	"	ld.di %0, [%1]"
-	: "=r"(temp)
-	: "r"(&v->counter)
-	: "memory");
-	return temp;
-}
-
-static inline void atomic_set(atomic_t *v, int i)
-{
-	__asm__ __volatile__(
-	"	st.di %0,[%1]"
-	:
-	: "r"(i), "r"(&v->counter)
-	: "memory");
-}
-
-#define ATOMIC_OP(op, c_op, asm_op)					\
-static inline void atomic_##op(int i, atomic_t *v)			\
-{									\
-	__asm__ __volatile__(						\
-	"	mov r2, %0\n"						\
-	"	mov r3, %1\n"						\
-	"       .word %2\n"						\
-	:								\
-	: "r"(i), "r"(&v->counter), "i"(asm_op)				\
-	: "r2", "r3", "memory");					\
-}									\
-
-#define ATOMIC_OP_RETURN(op, c_op, asm_op)				\
-static inline int atomic_##op##_return(int i, atomic_t *v)		\
-{									\
-	unsigned int temp = i;						\
-									\
-	/* Explicit full memory barrier needed before/after */		\
-	smp_mb();							\
-									\
-	__asm__ __volatile__(						\
-	"	mov r2, %0\n"						\
-	"	mov r3, %1\n"						\
-	"       .word %2\n"						\
-	"	mov %0, r2"						\
-	: "+r"(temp)							\
-	: "r"(&v->counter), "i"(asm_op)					\
-	: "r2", "r3", "memory");					\
-									\
-	smp_mb();							\
-									\
-	temp c_op i;							\
-									\
-	return temp;							\
-}
-
-#define ATOMIC_FETCH_OP(op, c_op, asm_op)				\
-static inline int atomic_fetch_##op(int i, atomic_t *v)			\
-{									\
-	unsigned int temp = i;						\
-									\
-	/* Explicit full memory barrier needed before/after */		\
-	smp_mb();							\
-									\
-	__asm__ __volatile__(						\
-	"	mov r2, %0\n"						\
-	"	mov r3, %1\n"						\
-	"       .word %2\n"						\
-	"	mov %0, r2"						\
-	: "+r"(temp)							\
-	: "r"(&v->counter), "i"(asm_op)					\
-	: "r2", "r3", "memory");					\
-									\
-	smp_mb();							\
-									\
-	return temp;							\
-}
-
-#define ATOMIC_OPS(op, c_op, asm_op)					\
-	ATOMIC_OP(op, c_op, asm_op)					\
-	ATOMIC_OP_RETURN(op, c_op, asm_op)				\
-	ATOMIC_FETCH_OP(op, c_op, asm_op)
-
-ATOMIC_OPS(add, +=, CTOP_INST_AADD_DI_R2_R2_R3)
-#define atomic_sub(i, v) atomic_add(-(i), (v))
-#define atomic_sub_return(i, v) atomic_add_return(-(i), (v))
-#define atomic_fetch_sub(i, v) atomic_fetch_add(-(i), (v))
-
-#undef ATOMIC_OPS
-#define ATOMIC_OPS(op, c_op, asm_op)					\
-	ATOMIC_OP(op, c_op, asm_op)					\
-	ATOMIC_FETCH_OP(op, c_op, asm_op)
-
-ATOMIC_OPS(and, &=, CTOP_INST_AAND_DI_R2_R2_R3)
-ATOMIC_OPS(or, |=, CTOP_INST_AOR_DI_R2_R2_R3)
-ATOMIC_OPS(xor, ^=, CTOP_INST_AXOR_DI_R2_R2_R3)
-
-#endif /* CONFIG_ARC_PLAT_EZNPS */
-
 #undef ATOMIC_OPS
 #undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
diff --git a/arch/arc/include/asm/barrier.h b/arch/arc/include/asm/barrier.h
index 7823811e7cf5..4637de9e02fa 100644
--- a/arch/arc/include/asm/barrier.h
+++ b/arch/arc/include/asm/barrier.h
@@ -27,7 +27,7 @@
 #define rmb()	asm volatile("dmb 1\n" : : : "memory")
 #define wmb()	asm volatile("dmb 2\n" : : : "memory")
 
-#elif !defined(CONFIG_ARC_PLAT_EZNPS)  /* CONFIG_ISA_ARCOMPACT */
+#else
 
 /*
  * ARCompact based cores (ARC700) only have SYNC instruction which is super
@@ -37,13 +37,6 @@
 
 #define mb()	asm volatile("sync\n" : : : "memory")
 
-#else	/* CONFIG_ARC_PLAT_EZNPS */
-
-#include <plat/ctop.h>
-
-#define mb()	asm volatile (".word %0" : : "i"(CTOP_INST_SCHD_RW) : "memory")
-#define rmb()	asm volatile (".word %0" : : "i"(CTOP_INST_SCHD_RD) : "memory")
-
 #endif
 
 #include <asm-generic/barrier.h>
diff --git a/arch/arc/include/asm/bitops.h b/arch/arc/include/asm/bitops.h
index 50eb3f64a77c..c6606f4d20d6 100644
--- a/arch/arc/include/asm/bitops.h
+++ b/arch/arc/include/asm/bitops.h
@@ -85,7 +85,7 @@ static inline int test_and_##op##_bit(unsigned long nr, volatile unsigned long *
 	return (old & (1 << nr)) != 0;					\
 }
 
-#elif !defined(CONFIG_ARC_PLAT_EZNPS)
+#else /* !CONFIG_ARC_HAS_LLSC */
 
 /*
  * Non hardware assisted Atomic-R-M-W
@@ -136,55 +136,7 @@ static inline int test_and_##op##_bit(unsigned long nr, volatile unsigned long *
 	return (old & (1UL << (nr & 0x1f))) != 0;			\
 }
 
-#else /* CONFIG_ARC_PLAT_EZNPS */
-
-#define BIT_OP(op, c_op, asm_op)					\
-static inline void op##_bit(unsigned long nr, volatile unsigned long *m)\
-{									\
-	m += nr >> 5;							\
-									\
-	nr = (1UL << (nr & 0x1f));					\
-	if (asm_op == CTOP_INST_AAND_DI_R2_R2_R3)			\
-		nr = ~nr;						\
-									\
-	__asm__ __volatile__(						\
-	"	mov r2, %0\n"						\
-	"	mov r3, %1\n"						\
-	"	.word %2\n"						\
-	:								\
-	: "r"(nr), "r"(m), "i"(asm_op)					\
-	: "r2", "r3", "memory");					\
-}
-
-#define TEST_N_BIT_OP(op, c_op, asm_op)					\
-static inline int test_and_##op##_bit(unsigned long nr, volatile unsigned long *m)\
-{									\
-	unsigned long old;						\
-									\
-	m += nr >> 5;							\
-									\
-	nr = old = (1UL << (nr & 0x1f));				\
-	if (asm_op == CTOP_INST_AAND_DI_R2_R2_R3)			\
-		old = ~old;						\
-									\
-	/* Explicit full memory barrier needed before/after */		\
-	smp_mb();							\
-									\
-	__asm__ __volatile__(						\
-	"	mov r2, %0\n"						\
-	"	mov r3, %1\n"						\
-	"       .word %2\n"						\
-	"	mov %0, r2"						\
-	: "+r"(old)							\
-	: "r"(m), "i"(asm_op)						\
-	: "r2", "r3", "memory");					\
-									\
-	smp_mb();							\
-									\
-	return (old & nr) != 0;					\
-}
-
-#endif /* CONFIG_ARC_PLAT_EZNPS */
+#endif
 
 /***************************************
  * Non atomic variants
@@ -226,15 +178,9 @@ static inline int __test_and_##op##_bit(unsigned long nr, volatile unsigned long
 	/* __test_and_set_bit(), __test_and_clear_bit(), __test_and_change_bit() */\
 	__TEST_N_BIT_OP(op, c_op, asm_op)
 
-#ifndef CONFIG_ARC_PLAT_EZNPS
 BIT_OPS(set, |, bset)
 BIT_OPS(clear, & ~, bclr)
 BIT_OPS(change, ^, bxor)
-#else
-BIT_OPS(set, |, CTOP_INST_AOR_DI_R2_R2_R3)
-BIT_OPS(clear, & ~, CTOP_INST_AAND_DI_R2_R2_R3)
-BIT_OPS(change, ^, CTOP_INST_AXOR_DI_R2_R2_R3)
-#endif
 
 /*
  * This routine doesn't need to be atomic.
diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index c11398160240..cf8233700c00 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -41,7 +41,7 @@ __cmpxchg(volatile void *ptr, unsigned long expected, unsigned long new)
 	return prev;
 }
 
-#elif !defined(CONFIG_ARC_PLAT_EZNPS)
+#else /* !CONFIG_ARC_HAS_LLSC */
 
 static inline unsigned long
 __cmpxchg(volatile void *ptr, unsigned long expected, unsigned long new)
@@ -61,33 +61,7 @@ __cmpxchg(volatile void *ptr, unsigned long expected, unsigned long new)
 	return prev;
 }
 
-#else /* CONFIG_ARC_PLAT_EZNPS */
-
-static inline unsigned long
-__cmpxchg(volatile void *ptr, unsigned long expected, unsigned long new)
-{
-	/*
-	 * Explicit full memory barrier needed before/after
-	 */
-	smp_mb();
-
-	write_aux_reg(CTOP_AUX_GPA1, expected);
-
-	__asm__ __volatile__(
-	"	mov r2, %0\n"
-	"	mov r3, %1\n"
-	"	.word %2\n"
-	"	mov %0, r2"
-	: "+r"(new)
-	: "r"(ptr), "i"(CTOP_INST_EXC_DI_R2_R2_R3)
-	: "r2", "r3", "memory");
-
-	smp_mb();
-
-	return new;
-}
-
-#endif /* CONFIG_ARC_HAS_LLSC */
+#endif
 
 #define cmpxchg(ptr, o, n) ({				\
 	(typeof(*(ptr)))__cmpxchg((ptr),		\
@@ -104,8 +78,6 @@ __cmpxchg(volatile void *ptr, unsigned long expected, unsigned long new)
 #define atomic_cmpxchg(v, o, n) ((int)cmpxchg(&((v)->counter), (o), (n)))
 
 
-#ifndef CONFIG_ARC_PLAT_EZNPS
-
 /*
  * xchg (reg with memory) based on "Native atomic" EX insn
  */
@@ -168,44 +140,6 @@ static inline unsigned long __xchg(unsigned long val, volatile void *ptr,
 
 #endif
 
-#else /* CONFIG_ARC_PLAT_EZNPS */
-
-static inline unsigned long __xchg(unsigned long val, volatile void *ptr,
-				   int size)
-{
-	extern unsigned long __xchg_bad_pointer(void);
-
-	switch (size) {
-	case 4:
-		/*
-		 * Explicit full memory barrier needed before/after
-		 */
-		smp_mb();
-
-		__asm__ __volatile__(
-		"	mov r2, %0\n"
-		"	mov r3, %1\n"
-		"	.word %2\n"
-		"	mov %0, r2\n"
-		: "+r"(val)
-		: "r"(ptr), "i"(CTOP_INST_XEX_DI_R2_R2_R3)
-		: "r2", "r3", "memory");
-
-		smp_mb();
-
-		return val;
-	}
-	return __xchg_bad_pointer();
-}
-
-#define xchg(ptr, with) ({				\
-	(typeof(*(ptr)))__xchg((unsigned long)(with),	\
-			       (ptr),			\
-			       sizeof(*(ptr)));		\
-})
-
-#endif /* CONFIG_ARC_PLAT_EZNPS */
-
 /*
  * "atomic" variant of xchg()
  * REQ: It needs to follow the same serialization rules as other atomic_xxx()
diff --git a/arch/arc/include/asm/entry-compact.h b/arch/arc/include/asm/entry-compact.h
index c3aa775878dc..6dbf5cecc8cc 100644
--- a/arch/arc/include/asm/entry-compact.h
+++ b/arch/arc/include/asm/entry-compact.h
@@ -33,10 +33,6 @@
 #include <asm/irqflags-compact.h>
 #include <asm/thread_info.h>	/* For THREAD_SIZE */
 
-#ifdef CONFIG_ARC_PLAT_EZNPS
-#include <plat/ctop.h>
-#endif
-
 /*--------------------------------------------------------------
  * Switch to Kernel Mode stack if SP points to User Mode stack
  *
@@ -189,12 +185,6 @@
 	PUSHAX	lp_start
 	PUSHAX	erbta
 
-#ifdef CONFIG_ARC_PLAT_EZNPS
-	.word CTOP_INST_SCHD_RW
-	PUSHAX  CTOP_AUX_GPA1
-	PUSHAX  CTOP_AUX_EFLAGS
-#endif
-
 	lr	r10, [ecr]
 	st      r10, [sp, PT_event]    /* EV_Trap expects r10 to have ECR */
 .endm
@@ -211,11 +201,6 @@
  * by hardware and that is not good.
  *-------------------------------------------------------------*/
 .macro EXCEPTION_EPILOGUE
-#ifdef CONFIG_ARC_PLAT_EZNPS
-	.word CTOP_INST_SCHD_RW
-	POPAX   CTOP_AUX_EFLAGS
-	POPAX   CTOP_AUX_GPA1
-#endif
 
 	POPAX	erbta
 	POPAX	lp_start
@@ -278,11 +263,6 @@
 	PUSHAX	lp_start
 	PUSHAX	bta_l\LVL\()
 
-#ifdef CONFIG_ARC_PLAT_EZNPS
-	.word CTOP_INST_SCHD_RW
-	PUSHAX  CTOP_AUX_GPA1
-	PUSHAX  CTOP_AUX_EFLAGS
-#endif
 .endm
 
 /*--------------------------------------------------------------
@@ -295,11 +275,6 @@
  * by hardware and that is not good.
  *-------------------------------------------------------------*/
 .macro INTERRUPT_EPILOGUE  LVL
-#ifdef CONFIG_ARC_PLAT_EZNPS
-	.word CTOP_INST_SCHD_RW
-	POPAX   CTOP_AUX_EFLAGS
-	POPAX   CTOP_AUX_GPA1
-#endif
 
 	POPAX	bta_l\LVL\()
 	POPAX	lp_start
@@ -327,13 +302,11 @@
 	bic \reg, sp, (THREAD_SIZE - 1)
 .endm
 
-#ifndef CONFIG_ARC_PLAT_EZNPS
 /* Get CPU-ID of this core */
 .macro  GET_CPU_ID  reg
 	lr  \reg, [identity]
 	lsr \reg, \reg, 8
 	bmsk \reg, \reg, 7
 .endm
-#endif
 
 #endif  /* __ASM_ARC_ENTRY_COMPACT_H */
diff --git a/arch/arc/include/asm/processor.h b/arch/arc/include/asm/processor.h
index 0fcea5bad343..e4031ecd3c8c 100644
--- a/arch/arc/include/asm/processor.h
+++ b/arch/arc/include/asm/processor.h
@@ -17,13 +17,6 @@
 #include <asm/dsp.h>
 #include <asm/fpu.h>
 
-#ifdef CONFIG_ARC_PLAT_EZNPS
-struct eznps_dp {
-	unsigned int eflags;
-	unsigned int gpa1;
-};
-#endif
-
 /* Arch specific stuff which needs to be saved per task.
  * However these items are not so important so as to earn a place in
  * struct thread_info
@@ -38,9 +31,6 @@ struct thread_struct {
 #ifdef CONFIG_ARC_FPU_SAVE_RESTORE
 	struct arc_fpu fpu;
 #endif
-#ifdef CONFIG_ARC_PLAT_EZNPS
-	struct eznps_dp dp;
-#endif
 };
 
 #define INIT_THREAD  {                          \
@@ -60,17 +50,8 @@ struct task_struct;
  * A lot of busy-wait loops in SMP are based off of non-volatile data otherwise
  * get optimised away by gcc
  */
-#ifndef CONFIG_EZNPS_MTM_EXT
-
 #define cpu_relax()		barrier()
 
-#else
-
-#define cpu_relax()     \
-	__asm__ __volatile__ (".word %0" : : "i"(CTOP_INST_SCHD_RW) : "memory")
-
-#endif
-
 #define KSTK_EIP(tsk)   (task_pt_regs(tsk)->ret)
 #define KSTK_ESP(tsk)   (task_pt_regs(tsk)->sp)
 
@@ -118,25 +99,7 @@ extern unsigned int get_wchan(struct task_struct *p);
 
 #define USER_KERNEL_GUTTER    (VMALLOC_START - TASK_SIZE)
 
-#ifdef CONFIG_ARC_PLAT_EZNPS
-/* NPS architecture defines special window of 129M in user address space for
- * special memory areas, when accessing this window the MMU do not use TLB.
- * Instead MMU direct the access to:
- * 0x57f00000:0x57ffffff -- 1M of closely coupled memory (aka CMEM)
- * 0x58000000:0x5fffffff -- 16 huge pages, 8M each, with fixed map (aka FMTs)
- *
- * CMEM - is the fastest memory we got and its size is 16K.
- * FMT  - is used to map either to internal/external memory.
- * Internal memory is the second fast memory and its size is 16M
- * External memory is the biggest memory (16G) and also the slowest.
- *
- * STACK_TOP need to be PMD align (21bit) that is why we supply 0x57e00000.
- */
-#define STACK_TOP       0x57e00000
-#else
 #define STACK_TOP       TASK_SIZE
-#endif
-
 #define STACK_TOP_MAX   STACK_TOP
 
 /* This decides where the kernel will search for a free chunk of vm
diff --git a/arch/arc/include/asm/ptrace.h b/arch/arc/include/asm/ptrace.h
index 2fdb87addadc..4c3c9be5bd16 100644
--- a/arch/arc/include/asm/ptrace.h
+++ b/arch/arc/include/asm/ptrace.h
@@ -16,11 +16,6 @@
 #ifdef CONFIG_ISA_ARCOMPACT
 struct pt_regs {
 
-#ifdef CONFIG_ARC_PLAT_EZNPS
-	unsigned long eflags;	/* Extended FLAGS */
-	unsigned long gpa1;	/* General Purpose Aux */
-#endif
-
 	/* Real registers */
 	unsigned long bta;	/* bta_l1, bta_l2, erbta */
 
diff --git a/arch/arc/include/asm/setup.h b/arch/arc/include/asm/setup.h
index 61a97fe70b86..01f85478170d 100644
--- a/arch/arc/include/asm/setup.h
+++ b/arch/arc/include/asm/setup.h
@@ -9,11 +9,7 @@
 #include <linux/types.h>
 #include <uapi/asm/setup.h>
 
-#ifdef CONFIG_ARC_PLAT_EZNPS
-#define COMMAND_LINE_SIZE 2048
-#else
 #define COMMAND_LINE_SIZE 256
-#endif
 
 /*
  * Data structure to map a ID to string
diff --git a/arch/arc/include/asm/spinlock.h b/arch/arc/include/asm/spinlock.h
index 94bbed88e3fc..192871608925 100644
--- a/arch/arc/include/asm/spinlock.h
+++ b/arch/arc/include/asm/spinlock.h
@@ -232,15 +232,9 @@ static inline void arch_spin_lock(arch_spinlock_t *lock)
 
 	__asm__ __volatile__(
 	"1:	ex  %0, [%1]		\n"
-#ifdef CONFIG_EZNPS_MTM_EXT
-	"	.word %3		\n"
-#endif
 	"	breq  %0, %2, 1b	\n"
 	: "+&r" (val)
 	: "r"(&(lock->slock)), "ir"(__ARCH_SPIN_LOCK_LOCKED__)
-#ifdef CONFIG_EZNPS_MTM_EXT
-	, "i"(CTOP_INST_SCHD_RW)
-#endif
 	: "memory");
 
 	smp_mb();
diff --git a/arch/arc/include/asm/switch_to.h b/arch/arc/include/asm/switch_to.h
index 4a3d67989d19..1f85de8288b1 100644
--- a/arch/arc/include/asm/switch_to.h
+++ b/arch/arc/include/asm/switch_to.h
@@ -12,19 +12,10 @@
 #include <asm/dsp-impl.h>
 #include <asm/fpu.h>
 
-#ifdef CONFIG_ARC_PLAT_EZNPS
-extern void dp_save_restore(struct task_struct *p, struct task_struct *n);
-#define ARC_EZNPS_DP_PREV(p, n)      dp_save_restore(p, n)
-#else
-#define ARC_EZNPS_DP_PREV(p, n)
-
-#endif /* !CONFIG_ARC_PLAT_EZNPS */
-
 struct task_struct *__switch_to(struct task_struct *p, struct task_struct *n);
 
 #define switch_to(prev, next, last)	\
 do {					\
-	ARC_EZNPS_DP_PREV(prev, next);	\
 	dsp_save_restore(prev, next);	\
 	fpu_save_restore(prev, next);	\
 	last = __switch_to(prev, next);\
diff --git a/arch/arc/kernel/ctx_sw.c b/arch/arc/kernel/ctx_sw.c
index e172c3333a84..1a76f2d6f694 100644
--- a/arch/arc/kernel/ctx_sw.c
+++ b/arch/arc/kernel/ctx_sw.c
@@ -14,9 +14,6 @@
 #include <asm/asm-offsets.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
-#ifdef CONFIG_ARC_PLAT_EZNPS
-#include <plat/ctop.h>
-#endif
 
 #define KSP_WORD_OFF 	((TASK_THREAD + THREAD_KSP) / 4)
 
@@ -67,17 +64,10 @@ __switch_to(struct task_struct *prev_task, struct task_struct *next_task)
 		 */
 #ifndef CONFIG_SMP
 		"st  %2, [@_current_task]	\n\t"
-#else
-#ifdef CONFIG_ARC_PLAT_EZNPS
-		"lr   r24, [%4]		\n\t"
-#ifndef CONFIG_EZNPS_MTM_EXT
-		"lsr  r24, r24, 4		\n\t"
-#endif
 #else
 		"lr   r24, [identity]		\n\t"
 		"lsr  r24, r24, 8		\n\t"
 		"bmsk r24, r24, 7		\n\t"
-#endif
 		"add2 r24, @_current_task, r24	\n\t"
 		"st   %2,  [r24]		\n\t"
 #endif
@@ -115,9 +105,6 @@ __switch_to(struct task_struct *prev_task, struct task_struct *next_task)
 
 		: "=r"(tmp)
 		: "n"(KSP_WORD_OFF), "r"(next), "r"(prev)
-#ifdef CONFIG_ARC_PLAT_EZNPS
-		, "i"(CTOP_AUX_LOGIC_GLOBAL_ID)
-#endif
 		: "blink"
 	);
 
diff --git a/arch/arc/kernel/process.c b/arch/arc/kernel/process.c
index efeba1fe7252..37f724ad5e39 100644
--- a/arch/arc/kernel/process.c
+++ b/arch/arc/kernel/process.c
@@ -116,17 +116,6 @@ void arch_cpu_idle(void)
 		:"I"(arg)); /* can't be "r" has to be embedded const */
 }
 
-#elif defined(CONFIG_EZNPS_MTM_EXT)	/* ARC700 variant in NPS */
-
-void arch_cpu_idle(void)
-{
-	/* only the calling HW thread needs to sleep */
-	__asm__ __volatile__(
-		".word %0	\n"
-		:
-		:"i"(CTOP_INST_HWSCHD_WFT_IE12));
-}
-
 #else	/* ARC700 */
 
 void arch_cpu_idle(void)
@@ -278,10 +267,6 @@ void start_thread(struct pt_regs *regs, unsigned long pc, unsigned long usp)
 	 */
 	regs->status32 = STATUS_U_MASK | STATUS_L_MASK | ISA_INIT_STATUS_BITS;
 
-#ifdef CONFIG_EZNPS_MTM_EXT
-	regs->eflags = 0;
-#endif
-
 	fpu_init_task(regs);
 
 	/* bogus seed values for debugging */
diff --git a/arch/arc/mm/tlbex.S b/arch/arc/mm/tlbex.S
index 31f54bdd95f2..062fae46c3f8 100644
--- a/arch/arc/mm/tlbex.S
+++ b/arch/arc/mm/tlbex.S
@@ -281,13 +281,6 @@ ex_saved_reg1:
 .macro COMMIT_ENTRY_TO_MMU
 #if (CONFIG_ARC_MMU_VER < 4)
 
-#ifdef CONFIG_EZNPS_MTM_EXT
-	/* verify if entry for this vaddr+ASID already exists */
-	sr    TLBProbe, [ARC_REG_TLBCOMMAND]
-	lr    r0, [ARC_REG_TLBINDEX]
-	bbit0 r0, 31, 88f
-#endif
-
 	/* Get free TLB slot: Set = computed from vaddr, way = random */
 	sr  TLBGetIndex, [ARC_REG_TLBCOMMAND]
 
diff --git a/arch/arc/plat-eznps/Kconfig b/arch/arc/plat-eznps/Kconfig
deleted file mode 100644
index a645bca5899a..000000000000
--- a/arch/arc/plat-eznps/Kconfig
+++ /dev/null
@@ -1,58 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# For a description of the syntax of this configuration file,
-# see Documentation/kbuild/kconfig-language.rst.
-#
-
-menuconfig ARC_PLAT_EZNPS
-	bool "\"EZchip\" ARC dev platform"
-	depends on ISA_ARCOMPACT
-	select CPU_BIG_ENDIAN
-	select CLKSRC_NPS if !PHYS_ADDR_T_64BIT
-	select EZNPS_GIC
-	select EZCHIP_NPS_MANAGEMENT_ENET if ETHERNET
-	help
-	  Support for EZchip development platforms,
-	  based on ARC700 cores.
-	  We handle few flavors:
-	    - Hardware Emulator AKA HE which is FPGA based chassis
-	    - Simulator based on MetaWare nSIM
-	    - NPS400 chip based on ASIC
-
-config EZNPS_MTM_EXT
-	bool "ARC-EZchip MTM Extensions"
-	select CPUMASK_OFFSTACK
-	depends on ARC_PLAT_EZNPS && SMP
-	default y
-	help
-	  Here we add new hierarchy for CPUs topology.
-	  We got:
-	    Core
-	    Thread
-	  At the new thread level each CPU represent one HW thread.
-	  At highest hierarchy each core contain 16 threads,
-	  any of them seem like CPU from Linux point of view.
-	  All threads within same core share the execution unit of the
-	  core and HW scheduler round robin between them.
-
-config EZNPS_MEM_ERROR_ALIGN
-	bool "ARC-EZchip Memory error as an exception"
-	depends on EZNPS_MTM_EXT
-	default n
-	help
-	  On the real chip of the NPS, user memory errors are handled
-	  as a machine check exception, which is fatal, whereas on
-	  simulator platform for NPS, is handled as a Level 2 interrupt
-	  (just a stock ARC700) which is recoverable. This option makes
-	  simulator behave like hardware.
-
-config EZNPS_SHARED_AUX_REGS
-	bool "ARC-EZchip Shared Auxiliary Registers Per Core"
-	depends on ARC_PLAT_EZNPS
-	default y
-	help
-	  On the real chip of the NPS, auxiliary registers are shared between
-	  all the cpus of the core, whereas on simulator platform for NPS,
-	  each cpu has a different set of auxiliary registers. Configuration
-	  should be unset if auxiliary registers are not shared between the cpus
-	  of the core, so there will be a need to initialize them per cpu.
diff --git a/arch/arc/plat-eznps/Makefile b/arch/arc/plat-eznps/Makefile
deleted file mode 100644
index ebb9723002cf..000000000000
--- a/arch/arc/plat-eznps/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-#
-# Makefile for the linux kernel.
-#
-
-obj-y := entry.o platform.o ctop.o
-obj-$(CONFIG_SMP) += smp.o
-obj-$(CONFIG_EZNPS_MTM_EXT) += mtm.o
diff --git a/arch/arc/plat-eznps/ctop.c b/arch/arc/plat-eznps/ctop.c
deleted file mode 100644
index b398e6e838a9..000000000000
--- a/arch/arc/plat-eznps/ctop.c
+++ /dev/null
@@ -1,21 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright(c) 2015 EZchip Technologies.
- */
-
-#include <linux/sched.h>
-#include <asm/processor.h>
-#include <plat/ctop.h>
-
-void dp_save_restore(struct task_struct *prev, struct task_struct *next)
-{
-	struct eznps_dp *prev_task_dp = &prev->thread.dp;
-	struct eznps_dp *next_task_dp = &next->thread.dp;
-
-	/* Here we save all Data Plane related auxiliary registers */
-	prev_task_dp->eflags = read_aux_reg(CTOP_AUX_EFLAGS);
-	write_aux_reg(CTOP_AUX_EFLAGS, next_task_dp->eflags);
-
-	prev_task_dp->gpa1 = read_aux_reg(CTOP_AUX_GPA1);
-	write_aux_reg(CTOP_AUX_GPA1, next_task_dp->gpa1);
-}
diff --git a/arch/arc/plat-eznps/entry.S b/arch/arc/plat-eznps/entry.S
deleted file mode 100644
index 3f18c0108e72..000000000000
--- a/arch/arc/plat-eznps/entry.S
+++ /dev/null
@@ -1,60 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*******************************************************************************
-
-  EZNPS CPU startup Code
-  Copyright(c) 2012 EZchip Technologies.
-
-
-*******************************************************************************/
-#include <linux/linkage.h>
-#include <asm/entry.h>
-#include <asm/cache.h>
-#include <plat/ctop.h>
-
-	.cpu A7
-
-	.section .init.text, "ax",@progbits
-	.align 1024	; HW requierment for restart first PC
-
-ENTRY(res_service)
-#if defined(CONFIG_EZNPS_MTM_EXT) && defined(CONFIG_EZNPS_SHARED_AUX_REGS)
-	; There is no work for HW thread id != 0
-	lr	r3, [CTOP_AUX_THREAD_ID]
-	cmp	r3, 0
-	jne	stext
-#endif
-
-#ifdef CONFIG_ARC_HAS_DCACHE
-	; With no cache coherency mechanism D$ need to be used very carefully.
-	; Address space:
-	; 0G-2G: We disable CONFIG_ARC_CACHE_PAGES.
-	; 2G-3G: We disable D$ by setting this bit.
-	; 3G-4G: D$ is disabled by architecture.
-	; FMT are huge pages for user application reside at 0-2G.
-	; Only FMT left as one who can use D$ where each such page got
-	; disable/enable bit for cachability.
-	; Programmer will use FMT pages for private data so cache coherency
-	; would not be a problem.
-	; First thing we invalidate D$
-	sr	1, [ARC_REG_DC_IVDC]
-	sr	HW_COMPLY_KRN_NOT_D_CACHED, [CTOP_AUX_HW_COMPLY]
-#endif
-
-#ifdef CONFIG_SMP
-	; We set logical cpuid to be used by GET_CPUID
-	; We do not use physical cpuid since we want ids to be continious when
-	; it comes to cpus on the same quad cluster.
-	; This is useful for applications that used shared resources of a quad
-	; cluster such SRAMS.
-	lr 	r3, [CTOP_AUX_CORE_ID]
-	sr	r3, [CTOP_AUX_LOGIC_CORE_ID]
-	lr	r3, [CTOP_AUX_CLUSTER_ID]
-	; Set logical is acheived by swap of 2 middle bits of cluster id (4 bit)
-	; r3 is used since we use short instruction and we need q-class reg
-	.short	CTOP_INST_MOV2B_FLIP_R3_B1_B2_INST
-	.word 	CTOP_INST_MOV2B_FLIP_R3_B1_B2_LIMM
-	 sr	r3, [CTOP_AUX_LOGIC_CLUSTER_ID]
-#endif
-
-	j	stext
-END(res_service)
diff --git a/arch/arc/plat-eznps/include/plat/ctop.h b/arch/arc/plat-eznps/include/plat/ctop.h
deleted file mode 100644
index 77712c5ffe84..000000000000
--- a/arch/arc/plat-eznps/include/plat/ctop.h
+++ /dev/null
@@ -1,208 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright(c) 2015 EZchip Technologies.
- */
-
-#ifndef _PLAT_EZNPS_CTOP_H
-#define _PLAT_EZNPS_CTOP_H
-
-#ifndef CONFIG_ARC_PLAT_EZNPS
-#error "Incorrect ctop.h include"
-#endif
-
-#include <linux/bits.h>
-#include <linux/types.h>
-#include <soc/nps/common.h>
-
-/* core auxiliary registers */
-#ifdef __ASSEMBLY__
-#define CTOP_AUX_BASE				(-0x800)
-#else
-#define CTOP_AUX_BASE				0xFFFFF800
-#endif
-
-#define CTOP_AUX_GLOBAL_ID			(CTOP_AUX_BASE + 0x000)
-#define CTOP_AUX_CLUSTER_ID			(CTOP_AUX_BASE + 0x004)
-#define CTOP_AUX_CORE_ID			(CTOP_AUX_BASE + 0x008)
-#define CTOP_AUX_THREAD_ID			(CTOP_AUX_BASE + 0x00C)
-#define CTOP_AUX_LOGIC_GLOBAL_ID		(CTOP_AUX_BASE + 0x010)
-#define CTOP_AUX_LOGIC_CLUSTER_ID		(CTOP_AUX_BASE + 0x014)
-#define CTOP_AUX_LOGIC_CORE_ID			(CTOP_AUX_BASE + 0x018)
-#define CTOP_AUX_MT_CTRL			(CTOP_AUX_BASE + 0x020)
-#define CTOP_AUX_HW_COMPLY			(CTOP_AUX_BASE + 0x024)
-#define CTOP_AUX_DPC				(CTOP_AUX_BASE + 0x02C)
-#define CTOP_AUX_LPC				(CTOP_AUX_BASE + 0x030)
-#define CTOP_AUX_EFLAGS				(CTOP_AUX_BASE + 0x080)
-#define CTOP_AUX_GPA1				(CTOP_AUX_BASE + 0x08C)
-#define CTOP_AUX_UDMC				(CTOP_AUX_BASE + 0x300)
-
-/* EZchip core instructions */
-#define CTOP_INST_HWSCHD_WFT_IE12		0x3E6F7344
-#define CTOP_INST_HWSCHD_OFF_R4			0x3C6F00BF
-#define CTOP_INST_HWSCHD_RESTORE_R4		0x3E6F7103
-#define CTOP_INST_SCHD_RW			0x3E6F7004
-#define CTOP_INST_SCHD_RD			0x3E6F7084
-#define CTOP_INST_ASRI_0_R3			0x3B56003E
-#define CTOP_INST_XEX_DI_R2_R2_R3		0x4A664C00
-#define CTOP_INST_EXC_DI_R2_R2_R3		0x4A664C01
-#define CTOP_INST_AADD_DI_R2_R2_R3		0x4A664C02
-#define CTOP_INST_AAND_DI_R2_R2_R3		0x4A664C04
-#define CTOP_INST_AOR_DI_R2_R2_R3		0x4A664C05
-#define CTOP_INST_AXOR_DI_R2_R2_R3		0x4A664C06
-
-/* Do not use D$ for address in 2G-3G */
-#define HW_COMPLY_KRN_NOT_D_CACHED		BIT(28)
-
-#define NPS_MSU_EN_CFG				0x80
-#define NPS_CRG_BLKID				0x480
-#define NPS_CRG_SYNC_BIT			BIT(0)
-#define NPS_GIM_BLKID				0x5C0
-
-/* GIM registers and fields*/
-#define NPS_GIM_UART_LINE			BIT(7)
-#define NPS_GIM_DBG_LAN_EAST_TX_DONE_LINE	BIT(10)
-#define NPS_GIM_DBG_LAN_EAST_RX_RDY_LINE	BIT(11)
-#define NPS_GIM_DBG_LAN_WEST_TX_DONE_LINE	BIT(25)
-#define NPS_GIM_DBG_LAN_WEST_RX_RDY_LINE	BIT(26)
-
-#ifndef __ASSEMBLY__
-/* Functional registers definition */
-struct nps_host_reg_mtm_cfg {
-	union {
-		struct {
-			u32 gen:1, gdis:1, clk_gate_dis:1, asb:1,
-			__reserved:9, nat:3, ten:16;
-		};
-		u32 value;
-	};
-};
-
-struct nps_host_reg_mtm_cpu_cfg {
-	union {
-		struct {
-			u32 csa:22, dmsid:6, __reserved:3, cs:1;
-		};
-		u32 value;
-	};
-};
-
-struct nps_host_reg_thr_init {
-	union {
-		struct {
-			u32 str:1, __reserved:27, thr_id:4;
-		};
-		u32 value;
-	};
-};
-
-struct nps_host_reg_thr_init_sts {
-	union {
-		struct {
-			u32 bsy:1, err:1, __reserved:26, thr_id:4;
-		};
-		u32 value;
-	};
-};
-
-struct nps_host_reg_msu_en_cfg {
-	union {
-		struct {
-			u32     __reserved1:11,
-			rtc_en:1, ipc_en:1, gim_1_en:1,
-			gim_0_en:1, ipi_en:1, buff_e_rls_bmuw:1,
-			buff_e_alc_bmuw:1, buff_i_rls_bmuw:1, buff_i_alc_bmuw:1,
-			buff_e_rls_bmue:1, buff_e_alc_bmue:1, buff_i_rls_bmue:1,
-			buff_i_alc_bmue:1, __reserved2:1, buff_e_pre_en:1,
-			buff_i_pre_en:1, pmuw_ja_en:1, pmue_ja_en:1,
-			pmuw_nj_en:1, pmue_nj_en:1, msu_en:1;
-		};
-		u32 value;
-	};
-};
-
-struct nps_host_reg_gim_p_int_dst {
-	union {
-		struct {
-			u32 int_out_en:1, __reserved1:4,
-			is:1, intm:2, __reserved2:4,
-			nid:4, __reserved3:4, cid:4,
-			 __reserved4:4, tid:4;
-		};
-		u32 value;
-	};
-};
-
-/* AUX registers definition */
-struct nps_host_reg_aux_dpc {
-	union {
-		struct {
-			u32 ien:1, men:1, hen:1, reserved:29;
-		};
-		u32 value;
-	};
-};
-
-struct nps_host_reg_aux_udmc {
-	union {
-		struct {
-			u32 dcp:1, cme:1, __reserved:19, nat:3,
-			__reserved2:5, dcas:3;
-		};
-		u32 value;
-	};
-};
-
-struct nps_host_reg_aux_mt_ctrl {
-	union {
-		struct {
-			u32 mten:1, hsen:1, scd:1, sten:1,
-			st_cnt:8, __reserved:8,
-			hs_cnt:8, __reserved1:4;
-		};
-		u32 value;
-	};
-};
-
-struct nps_host_reg_aux_hw_comply {
-	union {
-		struct {
-			u32 me:1, le:1, te:1, knc:1, __reserved:28;
-		};
-		u32 value;
-	};
-};
-
-struct nps_host_reg_aux_lpc {
-	union {
-		struct {
-			u32 mep:1, __reserved:31;
-		};
-		u32 value;
-	};
-};
-
-/* CRG registers */
-#define REG_GEN_PURP_0          nps_host_reg_non_cl(NPS_CRG_BLKID, 0x1BF)
-
-/* GIM registers */
-#define REG_GIM_P_INT_EN_0      nps_host_reg_non_cl(NPS_GIM_BLKID, 0x100)
-#define REG_GIM_P_INT_POL_0     nps_host_reg_non_cl(NPS_GIM_BLKID, 0x110)
-#define REG_GIM_P_INT_SENS_0    nps_host_reg_non_cl(NPS_GIM_BLKID, 0x114)
-#define REG_GIM_P_INT_BLK_0     nps_host_reg_non_cl(NPS_GIM_BLKID, 0x118)
-#define REG_GIM_P_INT_DST_10    nps_host_reg_non_cl(NPS_GIM_BLKID, 0x13A)
-#define REG_GIM_P_INT_DST_11    nps_host_reg_non_cl(NPS_GIM_BLKID, 0x13B)
-#define REG_GIM_P_INT_DST_25    nps_host_reg_non_cl(NPS_GIM_BLKID, 0x149)
-#define REG_GIM_P_INT_DST_26    nps_host_reg_non_cl(NPS_GIM_BLKID, 0x14A)
-
-#else
-
-.macro  GET_CPU_ID  reg
-	lr  \reg, [CTOP_AUX_LOGIC_GLOBAL_ID]
-#ifndef CONFIG_EZNPS_MTM_EXT
-	lsr \reg, \reg, 4
-#endif
-.endm
-
-#endif /* __ASSEMBLY__ */
-
-#endif /* _PLAT_EZNPS_CTOP_H */
diff --git a/arch/arc/plat-eznps/include/plat/mtm.h b/arch/arc/plat-eznps/include/plat/mtm.h
deleted file mode 100644
index 7c55becc891b..000000000000
--- a/arch/arc/plat-eznps/include/plat/mtm.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright(c) 2015 EZchip Technologies.
- */
-
-#ifndef _PLAT_EZNPS_MTM_H
-#define _PLAT_EZNPS_MTM_H
-
-#include <plat/ctop.h>
-
-static inline void *nps_mtm_reg_addr(u32 cpu, u32 reg)
-{
-	struct global_id gid;
-	u32 core, blkid;
-
-	gid.value = cpu;
-	core = gid.core;
-	blkid = (((core & 0x0C) << 2) | (core & 0x03));
-
-	return nps_host_reg(cpu, blkid, reg);
-}
-
-#ifdef CONFIG_EZNPS_MTM_EXT
-#define NPS_CPU_TO_THREAD_NUM(cpu) \
-	({ struct global_id gid; gid.value = cpu; gid.thread; })
-
-/* MTM registers */
-#define MTM_CFG(cpu)			nps_mtm_reg_addr(cpu, 0x81)
-#define MTM_THR_INIT(cpu)		nps_mtm_reg_addr(cpu, 0x92)
-#define MTM_THR_INIT_STS(cpu)		nps_mtm_reg_addr(cpu, 0x93)
-
-#define get_thread(map) map.thread
-#define eznps_max_cpus 4096
-#define eznps_cpus_per_cluster	256
-
-void mtm_enable_core(unsigned int cpu);
-int mtm_enable_thread(int cpu);
-#else /* !CONFIG_EZNPS_MTM_EXT */
-
-#define get_thread(map) 0
-#define eznps_max_cpus 256
-#define eznps_cpus_per_cluster	16
-#define mtm_enable_core(cpu)
-#define mtm_enable_thread(cpu) 1
-#define NPS_CPU_TO_THREAD_NUM(cpu) 0
-
-#endif /* CONFIG_EZNPS_MTM_EXT */
-
-#endif /* _PLAT_EZNPS_MTM_H */
diff --git a/arch/arc/plat-eznps/include/plat/smp.h b/arch/arc/plat-eznps/include/plat/smp.h
deleted file mode 100644
index e433f118bdca..000000000000
--- a/arch/arc/plat-eznps/include/plat/smp.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright(c) 2015 EZchip Technologies.
- */
-
-#ifndef __PLAT_EZNPS_SMP_H
-#define __PLAT_EZNPS_SMP_H
-
-#ifdef CONFIG_SMP
-
-extern void res_service(void);
-
-#endif /* CONFIG_SMP */
-
-#endif
diff --git a/arch/arc/plat-eznps/mtm.c b/arch/arc/plat-eznps/mtm.c
deleted file mode 100644
index 3dcf5a9e2976..000000000000
--- a/arch/arc/plat-eznps/mtm.c
+++ /dev/null
@@ -1,166 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright(c) 2015 EZchip Technologies.
- */
-
-#include <linux/smp.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/io.h>
-#include <linux/log2.h>
-#include <asm/arcregs.h>
-#include <plat/mtm.h>
-#include <plat/smp.h>
-
-#define MT_HS_CNT_MIN		0x01
-#define MT_HS_CNT_MAX		0xFF
-#define MT_CTRL_ST_CNT		0xF
-#define NPS_NUM_HW_THREADS	0x10
-
-static int mtm_hs_ctr = MT_HS_CNT_MAX;
-
-#ifdef CONFIG_EZNPS_MEM_ERROR_ALIGN
-int do_memory_error(unsigned long address, struct pt_regs *regs)
-{
-	die("Invalid Mem Access", regs, address);
-
-	return 1;
-}
-#endif
-
-static void mtm_init_nat(int cpu)
-{
-	struct nps_host_reg_mtm_cfg mtm_cfg;
-	struct nps_host_reg_aux_udmc udmc;
-	int log_nat, nat = 0, i, t;
-
-	/* Iterate core threads and update nat */
-	for (i = 0, t = cpu; i < NPS_NUM_HW_THREADS; i++, t++)
-		nat += test_bit(t, cpumask_bits(cpu_possible_mask));
-
-	log_nat = ilog2(nat);
-
-	udmc.value = read_aux_reg(CTOP_AUX_UDMC);
-	udmc.nat = log_nat;
-	write_aux_reg(CTOP_AUX_UDMC, udmc.value);
-
-	mtm_cfg.value = ioread32be(MTM_CFG(cpu));
-	mtm_cfg.nat = log_nat;
-	iowrite32be(mtm_cfg.value, MTM_CFG(cpu));
-}
-
-static void mtm_init_thread(int cpu)
-{
-	int i, tries = 5;
-	struct nps_host_reg_thr_init thr_init;
-	struct nps_host_reg_thr_init_sts thr_init_sts;
-
-	/* Set thread init register */
-	thr_init.value = 0;
-	iowrite32be(thr_init.value, MTM_THR_INIT(cpu));
-	thr_init.thr_id = NPS_CPU_TO_THREAD_NUM(cpu);
-	thr_init.str = 1;
-	iowrite32be(thr_init.value, MTM_THR_INIT(cpu));
-
-	/* Poll till thread init is done */
-	for (i = 0; i < tries; i++) {
-		thr_init_sts.value = ioread32be(MTM_THR_INIT_STS(cpu));
-		if (thr_init_sts.thr_id == thr_init.thr_id) {
-			if (thr_init_sts.bsy)
-				continue;
-			else if (thr_init_sts.err)
-				pr_warn("Failed to thread init cpu %u\n", cpu);
-			break;
-		}
-
-		pr_warn("Wrong thread id in thread init for cpu %u\n", cpu);
-		break;
-	}
-
-	if (i == tries)
-		pr_warn("Got thread init timeout for cpu %u\n", cpu);
-}
-
-int mtm_enable_thread(int cpu)
-{
-	struct nps_host_reg_mtm_cfg mtm_cfg;
-
-	if (NPS_CPU_TO_THREAD_NUM(cpu) == 0)
-		return 1;
-
-	/* Enable thread in mtm */
-	mtm_cfg.value = ioread32be(MTM_CFG(cpu));
-	mtm_cfg.ten |= (1 << (NPS_CPU_TO_THREAD_NUM(cpu)));
-	iowrite32be(mtm_cfg.value, MTM_CFG(cpu));
-
-	return 0;
-}
-
-void mtm_enable_core(unsigned int cpu)
-{
-	int i;
-	struct nps_host_reg_aux_mt_ctrl mt_ctrl;
-	struct nps_host_reg_mtm_cfg mtm_cfg;
-	struct nps_host_reg_aux_dpc dpc;
-
-	/*
-	 * Initializing dpc register in each CPU.
-	 * Overwriting the init value of the DPC
-	 * register so that CMEM and FMT virtual address
-	 * spaces are accessible, and Data Plane HW
-	 * facilities are enabled.
-	 */
-	dpc.ien = 1;
-	dpc.men = 1;
-	write_aux_reg(CTOP_AUX_DPC, dpc.value);
-
-	if (NPS_CPU_TO_THREAD_NUM(cpu) != 0)
-		return;
-
-	/* Initialize Number of Active Threads */
-	mtm_init_nat(cpu);
-
-	/* Initialize mtm_cfg */
-	mtm_cfg.value = ioread32be(MTM_CFG(cpu));
-	mtm_cfg.ten = 1;
-	iowrite32be(mtm_cfg.value, MTM_CFG(cpu));
-
-	/* Initialize all other threads in core */
-	for (i = 1; i < NPS_NUM_HW_THREADS; i++)
-		mtm_init_thread(cpu + i);
-
-
-	/* Enable HW schedule, stall counter, mtm */
-	mt_ctrl.value = 0;
-	mt_ctrl.hsen = 1;
-	mt_ctrl.hs_cnt = mtm_hs_ctr;
-	mt_ctrl.mten = 1;
-	write_aux_reg(CTOP_AUX_MT_CTRL, mt_ctrl.value);
-
-	/*
-	 * HW scheduling mechanism will start working
-	 * Only after call to instruction "schd.rw".
-	 * cpu_relax() calls "schd.rw" instruction.
-	 */
-	cpu_relax();
-}
-
-/* Verify and set the value of the mtm hs counter */
-static int __init set_mtm_hs_ctr(char *ctr_str)
-{
-	int hs_ctr;
-	int ret;
-
-	ret = kstrtoint(ctr_str, 0, &hs_ctr);
-
-	if (ret || hs_ctr > MT_HS_CNT_MAX || hs_ctr < MT_HS_CNT_MIN) {
-		pr_err("** Invalid @nps_mtm_hs_ctr [%d] needs to be [%d:%d] (incl)\n",
-		       hs_ctr, MT_HS_CNT_MIN, MT_HS_CNT_MAX);
-		return -EINVAL;
-	}
-
-	mtm_hs_ctr = hs_ctr;
-
-	return 0;
-}
-early_param("nps_mtm_hs_ctr", set_mtm_hs_ctr);
diff --git a/arch/arc/plat-eznps/platform.c b/arch/arc/plat-eznps/platform.c
deleted file mode 100644
index 6de2fe840043..000000000000
--- a/arch/arc/plat-eznps/platform.c
+++ /dev/null
@@ -1,91 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright(c) 2015 EZchip Technologies.
- */
-
-#include <linux/init.h>
-#include <linux/io.h>
-#include <asm/mach_desc.h>
-#include <plat/mtm.h>
-
-static void __init eznps_configure_msu(void)
-{
-	int cpu;
-	struct nps_host_reg_msu_en_cfg msu_en_cfg = {.value = 0};
-
-	msu_en_cfg.msu_en = 1;
-	msu_en_cfg.ipi_en = 1;
-	msu_en_cfg.gim_0_en = 1;
-	msu_en_cfg.gim_1_en = 1;
-
-	/* enable IPI and GIM messages on all clusters */
-	for (cpu = 0 ; cpu < eznps_max_cpus; cpu += eznps_cpus_per_cluster)
-		iowrite32be(msu_en_cfg.value,
-			    nps_host_reg(cpu, NPS_MSU_BLKID, NPS_MSU_EN_CFG));
-}
-
-static void __init eznps_configure_gim(void)
-{
-	u32 reg_value;
-	u32 gim_int_lines;
-	struct nps_host_reg_gim_p_int_dst gim_p_int_dst = {.value = 0};
-
-	gim_int_lines = NPS_GIM_UART_LINE;
-	gim_int_lines |= NPS_GIM_DBG_LAN_EAST_TX_DONE_LINE;
-	gim_int_lines |= NPS_GIM_DBG_LAN_EAST_RX_RDY_LINE;
-	gim_int_lines |= NPS_GIM_DBG_LAN_WEST_TX_DONE_LINE;
-	gim_int_lines |= NPS_GIM_DBG_LAN_WEST_RX_RDY_LINE;
-
-	/*
-	 * IRQ polarity
-	 * low or high level
-	 * negative or positive edge
-	 */
-	reg_value = ioread32be(REG_GIM_P_INT_POL_0);
-	reg_value &= ~gim_int_lines;
-	iowrite32be(reg_value, REG_GIM_P_INT_POL_0);
-
-	/* IRQ type level or edge */
-	reg_value = ioread32be(REG_GIM_P_INT_SENS_0);
-	reg_value |= NPS_GIM_DBG_LAN_EAST_TX_DONE_LINE;
-	reg_value |= NPS_GIM_DBG_LAN_WEST_TX_DONE_LINE;
-	iowrite32be(reg_value, REG_GIM_P_INT_SENS_0);
-
-	/*
-	 * GIM interrupt select type for
-	 * dbg_lan TX and RX interrupts
-	 * should be type 1
-	 * type 0 = IRQ line 6
-	 * type 1 = IRQ line 7
-	 */
-	gim_p_int_dst.is = 1;
-	iowrite32be(gim_p_int_dst.value, REG_GIM_P_INT_DST_10);
-	iowrite32be(gim_p_int_dst.value, REG_GIM_P_INT_DST_11);
-	iowrite32be(gim_p_int_dst.value, REG_GIM_P_INT_DST_25);
-	iowrite32be(gim_p_int_dst.value, REG_GIM_P_INT_DST_26);
-
-	/*
-	 * CTOP IRQ lines should be defined
-	 * as blocking in GIM
-	*/
-	iowrite32be(gim_int_lines, REG_GIM_P_INT_BLK_0);
-
-	/* enable CTOP IRQ lines in GIM */
-	iowrite32be(gim_int_lines, REG_GIM_P_INT_EN_0);
-}
-
-static void __init eznps_early_init(void)
-{
-	eznps_configure_msu();
-	eznps_configure_gim();
-}
-
-static const char *eznps_compat[] __initconst = {
-	"ezchip,arc-nps",
-	NULL,
-};
-
-MACHINE_START(NPS, "nps")
-	.dt_compat	= eznps_compat,
-	.init_early	= eznps_early_init,
-MACHINE_END
diff --git a/arch/arc/plat-eznps/smp.c b/arch/arc/plat-eznps/smp.c
deleted file mode 100644
index f119cb7de2ae..000000000000
--- a/arch/arc/plat-eznps/smp.c
+++ /dev/null
@@ -1,138 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright(c) 2015 EZchip Technologies.
- */
-
-#include <linux/smp.h>
-#include <linux/of_fdt.h>
-#include <linux/io.h>
-#include <linux/irqdomain.h>
-#include <asm/irq.h>
-#include <plat/ctop.h>
-#include <plat/smp.h>
-#include <plat/mtm.h>
-
-#define NPS_DEFAULT_MSID	0x34
-#define NPS_MTM_CPU_CFG		0x90
-
-static char smp_cpuinfo_buf[128] = {"Extn [EZNPS-SMP]\t: On\n"};
-
-/* Get cpu map from device tree */
-static int __init eznps_get_map(const char *name, struct cpumask *cpumask)
-{
-	unsigned long dt_root = of_get_flat_dt_root();
-	const char *buf;
-
-	buf = of_get_flat_dt_prop(dt_root, name, NULL);
-	if (!buf)
-		return 1;
-
-	cpulist_parse(buf, cpumask);
-
-	return 0;
-}
-
-/* Update board cpu maps */
-static void __init eznps_init_cpumasks(void)
-{
-	struct cpumask cpumask;
-
-	if (eznps_get_map("present-cpus", &cpumask)) {
-		pr_err("Failed to get present-cpus from dtb");
-		return;
-	}
-	init_cpu_present(&cpumask);
-
-	if (eznps_get_map("possible-cpus", &cpumask)) {
-		pr_err("Failed to get possible-cpus from dtb");
-		return;
-	}
-	init_cpu_possible(&cpumask);
-}
-
-static void eznps_init_core(unsigned int cpu)
-{
-	u32 sync_value;
-	struct nps_host_reg_aux_hw_comply hw_comply;
-	struct nps_host_reg_aux_lpc lpc;
-
-	if (NPS_CPU_TO_THREAD_NUM(cpu) != 0)
-		return;
-
-	hw_comply.value = read_aux_reg(CTOP_AUX_HW_COMPLY);
-	hw_comply.me  = 1;
-	hw_comply.le  = 1;
-	hw_comply.te  = 1;
-	write_aux_reg(CTOP_AUX_HW_COMPLY, hw_comply.value);
-
-	/* Enable MMU clock */
-	lpc.mep = 1;
-	write_aux_reg(CTOP_AUX_LPC, lpc.value);
-
-	/* Boot CPU only */
-	if (!cpu) {
-		/* Write to general purpose register in CRG */
-		sync_value = ioread32be(REG_GEN_PURP_0);
-		sync_value |= NPS_CRG_SYNC_BIT;
-		iowrite32be(sync_value, REG_GEN_PURP_0);
-	}
-}
-
-/*
- * Master kick starting another CPU
- */
-static void __init eznps_smp_wakeup_cpu(int cpu, unsigned long pc)
-{
-	struct nps_host_reg_mtm_cpu_cfg cpu_cfg;
-
-	if (mtm_enable_thread(cpu) == 0)
-		return;
-
-	/* set PC, dmsid, and start CPU */
-	cpu_cfg.value = (u32)res_service;
-	cpu_cfg.dmsid = NPS_DEFAULT_MSID;
-	cpu_cfg.cs = 1;
-	iowrite32be(cpu_cfg.value, nps_mtm_reg_addr(cpu, NPS_MTM_CPU_CFG));
-}
-
-static void eznps_ipi_send(int cpu)
-{
-	struct global_id gid;
-	struct {
-		union {
-			struct {
-				u32 num:8, cluster:8, core:8, thread:8;
-			};
-			u32 value;
-		};
-	} ipi;
-
-	gid.value = cpu;
-	ipi.thread = get_thread(gid);
-	ipi.core = gid.core;
-	ipi.cluster = nps_cluster_logic_to_phys(gid.cluster);
-	ipi.num = NPS_IPI_IRQ;
-
-	__asm__ __volatile__(
-	"	mov r3, %0\n"
-	"	.word %1\n"
-	:
-	: "r"(ipi.value), "i"(CTOP_INST_ASRI_0_R3)
-	: "r3");
-}
-
-static void eznps_init_per_cpu(int cpu)
-{
-	smp_ipi_irq_setup(cpu, NPS_IPI_IRQ);
-
-	eznps_init_core(cpu);
-	mtm_enable_core(cpu);
-}
-
-struct plat_smp_ops plat_smp_ops = {
-	.info		= smp_cpuinfo_buf,
-	.init_early_smp	= eznps_init_cpumasks,
-	.cpu_kick	= eznps_smp_wakeup_cpu,
-	.ipi_send	= eznps_ipi_send,
-	.init_per_cpu	= eznps_init_per_cpu,
-};
-- 
2.25.1

