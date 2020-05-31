Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C781BC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 13:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7BF220723
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 13:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgEaN7F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 09:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgEaN7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 09:59:05 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBBEC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 06:59:05 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jfOUO-0004ye-Rf; Sun, 31 May 2020 15:59:01 +0200
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 5508410108E;
        Sun, 31 May 2020 15:59:00 +0200 (CEST)
Date:   Sun, 31 May 2020 13:58:42 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for
References: <159093352092.1582.2279719529823662123.tglx@nanos.tec.linutronix.de>
Message-ID: <159093352213.1582.6158805873763136008.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-05-31

up to:  aa61b7bb00f7: Merge branch 'fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs into x86/urgent


A pile of x86 fixes:

  - Prevent a memory leak in ioperm which was caused by the stupid
    assumption that the exit cleanup is always called for current, which is
    not the case when fork fails after taking a reference on the ioperm
    bitmap.

  - Fix an arithmething overflow in the DMA code on 32bit systems

  - Fill gaps in the xstate copy with defaults instead of leaving them
    uninitialized

  - Revert: "Make __X32_SYSCALL_BIT be unsigned long" as it turned out
    that existing user space fails to build.

Thanks,

	tglx

------------------>
Al Viro (1):
      copy_xstate_to_kernel(): don't leave parts of destination uninitialized

Alexander Dahl (1):
      x86/dma: Fix max PFN arithmetic overflow on 32 bit systems

Andy Lutomirski (1):
      x86/syscalls: Revert "x86/syscalls: Make __X32_SYSCALL_BIT be unsigned long"

Jay Lang (1):
      x86/ioperm: Prevent a memory leak when fork fails


 arch/x86/include/asm/dma.h               |  2 +-
 arch/x86/include/asm/io_bitmap.h         |  4 +-
 arch/x86/include/uapi/asm/unistd.h       | 11 +++-
 arch/x86/kernel/fpu/xstate.c             | 86 ++++++++++++++++++--------------
 arch/x86/kernel/ioport.c                 | 22 ++++----
 arch/x86/kernel/process.c                |  4 +-
 tools/arch/x86/include/uapi/asm/unistd.h |  2 +-
 7 files changed, 74 insertions(+), 57 deletions(-)

diff --git a/arch/x86/include/asm/dma.h b/arch/x86/include/asm/dma.h
index 00f7cf45e699..8e95aa4b0d17 100644
--- a/arch/x86/include/asm/dma.h
+++ b/arch/x86/include/asm/dma.h
@@ -74,7 +74,7 @@
 #define MAX_DMA_PFN   ((16UL * 1024 * 1024) >> PAGE_SHIFT)
 
 /* 4GB broken PCI/AGP hardware bus master zone */
-#define MAX_DMA32_PFN ((4UL * 1024 * 1024 * 1024) >> PAGE_SHIFT)
+#define MAX_DMA32_PFN (1UL << (32 - PAGE_SHIFT))
 
 #ifdef CONFIG_X86_32
 /* The maximum address that we can perform a DMA transfer to on this platform */
diff --git a/arch/x86/include/asm/io_bitmap.h b/arch/x86/include/asm/io_bitmap.h
index 07344d82e88e..ac1a99ffbd8d 100644
--- a/arch/x86/include/asm/io_bitmap.h
+++ b/arch/x86/include/asm/io_bitmap.h
@@ -17,7 +17,7 @@ struct task_struct;
 
 #ifdef CONFIG_X86_IOPL_IOPERM
 void io_bitmap_share(struct task_struct *tsk);
-void io_bitmap_exit(void);
+void io_bitmap_exit(struct task_struct *tsk);
 
 void native_tss_update_io_bitmap(void);
 
@@ -29,7 +29,7 @@ void native_tss_update_io_bitmap(void);
 
 #else
 static inline void io_bitmap_share(struct task_struct *tsk) { }
-static inline void io_bitmap_exit(void) { }
+static inline void io_bitmap_exit(struct task_struct *tsk) { }
 static inline void tss_update_io_bitmap(void) { }
 #endif
 
diff --git a/arch/x86/include/uapi/asm/unistd.h b/arch/x86/include/uapi/asm/unistd.h
index 196fdd02b8b1..be5e2e747f50 100644
--- a/arch/x86/include/uapi/asm/unistd.h
+++ b/arch/x86/include/uapi/asm/unistd.h
@@ -2,8 +2,15 @@
 #ifndef _UAPI_ASM_X86_UNISTD_H
 #define _UAPI_ASM_X86_UNISTD_H
 
-/* x32 syscall flag bit */
-#define __X32_SYSCALL_BIT	0x40000000UL
+/*
+ * x32 syscall flag bit.  Some user programs expect syscall NR macros
+ * and __X32_SYSCALL_BIT to have type int, even though syscall numbers
+ * are, for practical purposes, unsigned long.
+ *
+ * Fortunately, expressions like (nr & ~__X32_SYSCALL_BIT) do the right
+ * thing regardless.
+ */
+#define __X32_SYSCALL_BIT	0x40000000
 
 #ifndef __KERNEL__
 # ifdef __i386__
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 32b153d38748..6a54e83d5589 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -957,18 +957,31 @@ static inline bool xfeatures_mxcsr_quirk(u64 xfeatures)
 	return true;
 }
 
-/*
- * This is similar to user_regset_copyout(), but will not add offset to
- * the source data pointer or increment pos, count, kbuf, and ubuf.
- */
-static inline void
-__copy_xstate_to_kernel(void *kbuf, const void *data,
-			unsigned int offset, unsigned int size, unsigned int size_total)
+static void fill_gap(unsigned to, void **kbuf, unsigned *pos, unsigned *count)
 {
-	if (offset < size_total) {
-		unsigned int copy = min(size, size_total - offset);
+	if (*pos < to) {
+		unsigned size = to - *pos;
+
+		if (size > *count)
+			size = *count;
+		memcpy(*kbuf, (void *)&init_fpstate.xsave + *pos, size);
+		*kbuf += size;
+		*pos += size;
+		*count -= size;
+	}
+}
 
-		memcpy(kbuf + offset, data, copy);
+static void copy_part(unsigned offset, unsigned size, void *from,
+			void **kbuf, unsigned *pos, unsigned *count)
+{
+	fill_gap(offset, kbuf, pos, count);
+	if (size > *count)
+		size = *count;
+	if (size) {
+		memcpy(*kbuf, from, size);
+		*kbuf += size;
+		*pos += size;
+		*count -= size;
 	}
 }
 
@@ -981,8 +994,9 @@ __copy_xstate_to_kernel(void *kbuf, const void *data,
  */
 int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int offset_start, unsigned int size_total)
 {
-	unsigned int offset, size;
 	struct xstate_header header;
+	const unsigned off_mxcsr = offsetof(struct fxregs_state, mxcsr);
+	unsigned count = size_total;
 	int i;
 
 	/*
@@ -998,46 +1012,42 @@ int copy_xstate_to_kernel(void *kbuf, struct xregs_state *xsave, unsigned int of
 	header.xfeatures = xsave->header.xfeatures;
 	header.xfeatures &= ~XFEATURE_MASK_SUPERVISOR;
 
+	if (header.xfeatures & XFEATURE_MASK_FP)
+		copy_part(0, off_mxcsr,
+			  &xsave->i387, &kbuf, &offset_start, &count);
+	if (header.xfeatures & (XFEATURE_MASK_SSE | XFEATURE_MASK_YMM))
+		copy_part(off_mxcsr, MXCSR_AND_FLAGS_SIZE,
+			  &xsave->i387.mxcsr, &kbuf, &offset_start, &count);
+	if (header.xfeatures & XFEATURE_MASK_FP)
+		copy_part(offsetof(struct fxregs_state, st_space), 128,
+			  &xsave->i387.st_space, &kbuf, &offset_start, &count);
+	if (header.xfeatures & XFEATURE_MASK_SSE)
+		copy_part(xstate_offsets[XFEATURE_MASK_SSE], 256,
+			  &xsave->i387.xmm_space, &kbuf, &offset_start, &count);
+	/*
+	 * Fill xsave->i387.sw_reserved value for ptrace frame:
+	 */
+	copy_part(offsetof(struct fxregs_state, sw_reserved), 48,
+		  xstate_fx_sw_bytes, &kbuf, &offset_start, &count);
 	/*
 	 * Copy xregs_state->header:
 	 */
-	offset = offsetof(struct xregs_state, header);
-	size = sizeof(header);
-
-	__copy_xstate_to_kernel(kbuf, &header, offset, size, size_total);
+	copy_part(offsetof(struct xregs_state, header), sizeof(header),
+		  &header, &kbuf, &offset_start, &count);
 
-	for (i = 0; i < XFEATURE_MAX; i++) {
+	for (i = FIRST_EXTENDED_XFEATURE; i < XFEATURE_MAX; i++) {
 		/*
 		 * Copy only in-use xstates:
 		 */
 		if ((header.xfeatures >> i) & 1) {
 			void *src = __raw_xsave_addr(xsave, i);
 
-			offset = xstate_offsets[i];
-			size = xstate_sizes[i];
-
-			/* The next component has to fit fully into the output buffer: */
-			if (offset + size > size_total)
-				break;
-
-			__copy_xstate_to_kernel(kbuf, src, offset, size, size_total);
+			copy_part(xstate_offsets[i], xstate_sizes[i],
+				  src, &kbuf, &offset_start, &count);
 		}
 
 	}
-
-	if (xfeatures_mxcsr_quirk(header.xfeatures)) {
-		offset = offsetof(struct fxregs_state, mxcsr);
-		size = MXCSR_AND_FLAGS_SIZE;
-		__copy_xstate_to_kernel(kbuf, &xsave->i387.mxcsr, offset, size, size_total);
-	}
-
-	/*
-	 * Fill xsave->i387.sw_reserved value for ptrace frame:
-	 */
-	offset = offsetof(struct fxregs_state, sw_reserved);
-	size = sizeof(xstate_fx_sw_bytes);
-
-	__copy_xstate_to_kernel(kbuf, xstate_fx_sw_bytes, offset, size, size_total);
+	fill_gap(size_total, &kbuf, &offset_start, &count);
 
 	return 0;
 }
diff --git a/arch/x86/kernel/ioport.c b/arch/x86/kernel/ioport.c
index a53e7b4a7419..e2fab3ceb09f 100644
--- a/arch/x86/kernel/ioport.c
+++ b/arch/x86/kernel/ioport.c
@@ -33,15 +33,15 @@ void io_bitmap_share(struct task_struct *tsk)
 	set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
 }
 
-static void task_update_io_bitmap(void)
+static void task_update_io_bitmap(struct task_struct *tsk)
 {
-	struct thread_struct *t = &current->thread;
+	struct thread_struct *t = &tsk->thread;
 
 	if (t->iopl_emul == 3 || t->io_bitmap) {
 		/* TSS update is handled on exit to user space */
-		set_thread_flag(TIF_IO_BITMAP);
+		set_tsk_thread_flag(tsk, TIF_IO_BITMAP);
 	} else {
-		clear_thread_flag(TIF_IO_BITMAP);
+		clear_tsk_thread_flag(tsk, TIF_IO_BITMAP);
 		/* Invalidate TSS */
 		preempt_disable();
 		tss_update_io_bitmap();
@@ -49,12 +49,12 @@ static void task_update_io_bitmap(void)
 	}
 }
 
-void io_bitmap_exit(void)
+void io_bitmap_exit(struct task_struct *tsk)
 {
-	struct io_bitmap *iobm = current->thread.io_bitmap;
+	struct io_bitmap *iobm = tsk->thread.io_bitmap;
 
-	current->thread.io_bitmap = NULL;
-	task_update_io_bitmap();
+	tsk->thread.io_bitmap = NULL;
+	task_update_io_bitmap(tsk);
 	if (iobm && refcount_dec_and_test(&iobm->refcnt))
 		kfree(iobm);
 }
@@ -102,7 +102,7 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 		if (!iobm)
 			return -ENOMEM;
 		refcount_set(&iobm->refcnt, 1);
-		io_bitmap_exit();
+		io_bitmap_exit(current);
 	}
 
 	/*
@@ -134,7 +134,7 @@ long ksys_ioperm(unsigned long from, unsigned long num, int turn_on)
 	}
 	/* All permissions dropped? */
 	if (max_long == UINT_MAX) {
-		io_bitmap_exit();
+		io_bitmap_exit(current);
 		return 0;
 	}
 
@@ -192,7 +192,7 @@ SYSCALL_DEFINE1(iopl, unsigned int, level)
 	}
 
 	t->iopl_emul = level;
-	task_update_io_bitmap();
+	task_update_io_bitmap(current);
 
 	return 0;
 }
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 9da70b279dad..35638f1c5791 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -96,7 +96,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src)
 }
 
 /*
- * Free current thread data structures etc..
+ * Free thread data structures etc..
  */
 void exit_thread(struct task_struct *tsk)
 {
@@ -104,7 +104,7 @@ void exit_thread(struct task_struct *tsk)
 	struct fpu *fpu = &t->fpu;
 
 	if (test_thread_flag(TIF_IO_BITMAP))
-		io_bitmap_exit();
+		io_bitmap_exit(tsk);
 
 	free_vm86(t);
 
diff --git a/tools/arch/x86/include/uapi/asm/unistd.h b/tools/arch/x86/include/uapi/asm/unistd.h
index 196fdd02b8b1..30d7d04d72d6 100644
--- a/tools/arch/x86/include/uapi/asm/unistd.h
+++ b/tools/arch/x86/include/uapi/asm/unistd.h
@@ -3,7 +3,7 @@
 #define _UAPI_ASM_X86_UNISTD_H
 
 /* x32 syscall flag bit */
-#define __X32_SYSCALL_BIT	0x40000000UL
+#define __X32_SYSCALL_BIT	0x40000000
 
 #ifndef __KERNEL__
 # ifdef __i386__

