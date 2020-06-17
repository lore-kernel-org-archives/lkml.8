Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C695C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EABAC20853
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 07:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mJhHZKkF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgFQHiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 03:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFQHiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 03:38:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEDCC061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 00:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=JbUyEN9rQHlpfKmGSPmXjorW7ULQuj6JIuEla7Eyif8=; b=mJhHZKkFP8HZbDPzbxYkvyO3x7
        rfv9OcazBctnUG5SH65uUVfVGmST9bYsVNXg5ncUpIMAzwSEoy/6DyLpZfOrvJ6O4sMcWSBogNMS9
        Yo/vMoyq5pV8lUZWUcieswqu2w3iy3/87NTLpl4MnN/sSxPYNzsOGE31g/5c4DOrvycRdYEYjskxu
        IVxCEGGIUzPJHvO3nfBUXfDbYKOu95BFZJ4noD1Th9SObijstgBrpIc3ymuj7fS4xgX+Lum0zBJ0R
        f4QWZ/Zsohy4a/8e1gE3Yzl4FR9bKdpPQdKdA4lZNrLAXAh/riXrZj5VIpGi96seuHdgJhFB1JGM3
        dhRupfaA==;
Received: from 195-192-102-148.dyn.cablelink.at ([195.192.102.148] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlSe3-0001YA-IN; Wed, 17 Jun 2020 07:38:03 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] maccess: rename probe_user_{read,write} to copy_{from,to}_user_nofault
Date:   Wed, 17 Jun 2020 09:37:54 +0200
Message-Id: <20200617073755.8068-3-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200617073755.8068-1-hch@lst.de>
References: <20200617073755.8068-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Better describe what these functions do.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/kernel/process.c          |  3 ++-
 arch/powerpc/kvm/book3s_64_mmu_radix.c |  4 ++--
 arch/powerpc/lib/inst.c                |  6 +++---
 arch/powerpc/oprofile/backtrace.c      |  6 ++++--
 arch/powerpc/perf/callchain_32.c       |  2 +-
 arch/powerpc/perf/callchain_64.c       |  2 +-
 arch/powerpc/perf/core-book3s.c        |  3 ++-
 arch/powerpc/sysdev/fsl_pci.c          |  4 ++--
 include/linux/uaccess.h                |  4 ++--
 kernel/trace/bpf_trace.c               |  4 ++--
 kernel/trace/trace_kprobe.c            |  2 +-
 mm/maccess.c                           | 12 ++++++------
 12 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 7bb7faf84490ec..d4d0d10485003d 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1305,7 +1305,8 @@ void show_user_instructions(struct pt_regs *regs)
 		for (i = 0; i < 8 && n; i++, n--, pc += sizeof(int)) {
 			int instr;
 
-			if (probe_user_read(&instr, (void __user *)pc, sizeof(instr))) {
+			if (copy_from_user_nofault(&instr, (void __user *)pc,
+					sizeof(instr))) {
 				seq_buf_printf(&s, "XXXXXXXX ");
 				continue;
 			}
diff --git a/arch/powerpc/kvm/book3s_64_mmu_radix.c b/arch/powerpc/kvm/book3s_64_mmu_radix.c
index 3cb0c9843d01da..e738ea6521927f 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_radix.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_radix.c
@@ -64,9 +64,9 @@ unsigned long __kvmhv_copy_tofrom_guest_radix(int lpid, int pid,
 	isync();
 
 	if (is_load)
-		ret = probe_user_read(to, (const void __user *)from, n);
+		ret = copy_from_user_nofault(to, (const void __user *)from, n);
 	else
-		ret = probe_user_write((void __user *)to, from, n);
+		ret = copy_to_user_nofault((void __user *)to, from, n);
 
 	/* switch the pid first to avoid running host with unallocated pid */
 	if (quadrant == 1 && pid != old_pid)
diff --git a/arch/powerpc/lib/inst.c b/arch/powerpc/lib/inst.c
index 6c7a20af9fd673..9cc17eb62462a6 100644
--- a/arch/powerpc/lib/inst.c
+++ b/arch/powerpc/lib/inst.c
@@ -15,11 +15,11 @@ int probe_user_read_inst(struct ppc_inst *inst,
 	unsigned int val, suffix;
 	int err;
 
-	err = probe_user_read(&val, nip, sizeof(val));
+	err = copy_from_user_nofault(&val, nip, sizeof(val));
 	if (err)
 		return err;
 	if (get_op(val) == OP_PREFIX) {
-		err = probe_user_read(&suffix, (void __user *)nip + 4, 4);
+		err = copy_from_user_nofault(&suffix, (void __user *)nip + 4, 4);
 		*inst = ppc_inst_prefix(val, suffix);
 	} else {
 		*inst = ppc_inst(val);
@@ -51,7 +51,7 @@ int probe_user_read_inst(struct ppc_inst *inst,
 	unsigned int val;
 	int err;
 
-	err = probe_user_read(&val, nip, sizeof(val));
+	err = copy_from_user_nofault(&val, nip, sizeof(val));
 	if (!err)
 		*inst = ppc_inst(val);
 
diff --git a/arch/powerpc/oprofile/backtrace.c b/arch/powerpc/oprofile/backtrace.c
index 6f347fa29f41ef..9db7ada79d10d4 100644
--- a/arch/powerpc/oprofile/backtrace.c
+++ b/arch/powerpc/oprofile/backtrace.c
@@ -33,7 +33,8 @@ static unsigned int user_getsp32(unsigned int sp, int is_first)
 	 * which means that we've done all that we can do from
 	 * interrupt context.
 	 */
-	if (probe_user_read(stack_frame, (void __user *)p, sizeof(stack_frame)))
+	if (copy_from_user_nofault(stack_frame, (void __user *)p,
+			sizeof(stack_frame)))
 		return 0;
 
 	if (!is_first)
@@ -51,7 +52,8 @@ static unsigned long user_getsp64(unsigned long sp, int is_first)
 {
 	unsigned long stack_frame[3];
 
-	if (probe_user_read(stack_frame, (void __user *)sp, sizeof(stack_frame)))
+	if (copy_from_user_nofault(stack_frame, (void __user *)sp,
+			sizeof(stack_frame)))
 		return 0;
 
 	if (!is_first)
diff --git a/arch/powerpc/perf/callchain_32.c b/arch/powerpc/perf/callchain_32.c
index f7d888d39cd3a9..542e68b8eae0b1 100644
--- a/arch/powerpc/perf/callchain_32.c
+++ b/arch/powerpc/perf/callchain_32.c
@@ -44,7 +44,7 @@ static int read_user_stack_32(unsigned int __user *ptr, unsigned int *ret)
 	    ((unsigned long)ptr & 3))
 		return -EFAULT;
 
-	rc = probe_user_read(ret, ptr, sizeof(*ret));
+	rc = copy_from_user_nofault(ret, ptr, sizeof(*ret));
 
 	if (IS_ENABLED(CONFIG_PPC64) && rc)
 		return read_user_stack_slow(ptr, ret, 4);
diff --git a/arch/powerpc/perf/callchain_64.c b/arch/powerpc/perf/callchain_64.c
index 814d1c2c2b9cf0..fa2a1b83b9b0e7 100644
--- a/arch/powerpc/perf/callchain_64.c
+++ b/arch/powerpc/perf/callchain_64.c
@@ -50,7 +50,7 @@ static int read_user_stack_64(unsigned long __user *ptr, unsigned long *ret)
 	    ((unsigned long)ptr & 7))
 		return -EFAULT;
 
-	if (!probe_user_read(ret, ptr, sizeof(*ret)))
+	if (!copy_from_user_nofault(ret, ptr, sizeof(*ret)))
 		return 0;
 
 	return read_user_stack_slow(ptr, ret, 8);
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index efe97ff82557d0..cd6a742ac6ef5d 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -426,7 +426,8 @@ static __u64 power_pmu_bhrb_to(u64 addr)
 	}
 
 	/* Userspace: need copy instruction here then translate it */
-	if (probe_user_read(&instr, (unsigned int __user *)addr, sizeof(instr)))
+	if (copy_from_user_nofault(&instr, (unsigned int __user *)addr,
+			sizeof(instr)))
 		return 0;
 
 	target = branch_target((struct ppc_inst *)&instr);
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 4a8874bc10574a..73fa37ca40ef95 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -1066,8 +1066,8 @@ int fsl_pci_mcheck_exception(struct pt_regs *regs)
 
 	if (is_in_pci_mem_space(addr)) {
 		if (user_mode(regs))
-			ret = probe_user_read(&inst, (void __user *)regs->nip,
-					      sizeof(inst));
+			ret = copy_from_user_nofault(&inst,
+					(void __user *)regs->nip, sizeof(inst));
 		else
 			ret = probe_kernel_address((void *)regs->nip, inst);
 
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 70a3d9cd9113f8..bef48da242cc2c 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -306,8 +306,8 @@ bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size);
 long copy_from_kernel_nofault(void *dst, const void *src, size_t size);
 long notrace copy_to_kernel_nofault(void *dst, const void *src, size_t size);
 
-extern long probe_user_read(void *dst, const void __user *src, size_t size);
-extern long notrace probe_user_write(void __user *dst, const void *src,
+long copy_from_user_nofault(void *dst, const void __user *src, size_t size);
+long notrace copy_to_user_nofault(void __user *dst, const void *src,
 		size_t size);
 
 long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 204afc12425fd7..dc05626979b8f8 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -141,7 +141,7 @@ bpf_probe_read_user_common(void *dst, u32 size, const void __user *unsafe_ptr)
 {
 	int ret;
 
-	ret = probe_user_read(dst, unsafe_ptr, size);
+	ret = copy_from_user_nofault(dst, unsafe_ptr, size);
 	if (unlikely(ret < 0))
 		memset(dst, 0, size);
 	return ret;
@@ -326,7 +326,7 @@ BPF_CALL_3(bpf_probe_write_user, void __user *, unsafe_ptr, const void *, src,
 	if (unlikely(!nmi_uaccess_okay()))
 		return -EPERM;
 
-	return probe_user_write(unsafe_ptr, src, size);
+	return copy_to_user_nofault(unsafe_ptr, src, size);
 }
 
 static const struct bpf_func_proto bpf_probe_write_user_proto = {
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 841c74863ff896..aefb6065b508de 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1290,7 +1290,7 @@ probe_mem_read_user(void *dest, void *src, size_t size)
 {
 	const void __user *uaddr =  (__force const void __user *)src;
 
-	return probe_user_read(dest, uaddr, size);
+	return copy_from_user_nofault(dest, uaddr, size);
 }
 
 static nokprobe_inline int
diff --git a/mm/maccess.c b/mm/maccess.c
index cc5d8c6233c05a..f98ff91e32c6df 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -194,7 +194,7 @@ long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
 #endif /* HAVE_GET_KERNEL_NOFAULT */
 
 /**
- * probe_user_read(): safely attempt to read from a user-space location
+ * copy_from_user_nofault(): safely attempt to read from a user-space location
  * @dst: pointer to the buffer that shall take the data
  * @src: address to read from. This must be a user address.
  * @size: size of the data chunk
@@ -202,7 +202,7 @@ long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
  * Safely read from user address @src to the buffer at @dst. If a kernel fault
  * happens, handle that and return -EFAULT.
  */
-long probe_user_read(void *dst, const void __user *src, size_t size)
+long copy_from_user_nofault(void *dst, const void __user *src, size_t size)
 {
 	long ret = -EFAULT;
 	mm_segment_t old_fs = get_fs();
@@ -219,10 +219,10 @@ long probe_user_read(void *dst, const void __user *src, size_t size)
 		return -EFAULT;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(probe_user_read);
+EXPORT_SYMBOL_GPL(copy_from_user_nofault);
 
 /**
- * probe_user_write(): safely attempt to write to a user-space location
+ * copy_to_user_nofault(): safely attempt to write to a user-space location
  * @dst: address to write to
  * @src: pointer to the data that shall be written
  * @size: size of the data chunk
@@ -230,7 +230,7 @@ EXPORT_SYMBOL_GPL(probe_user_read);
  * Safely write to address @dst from the buffer at @src.  If a kernel fault
  * happens, handle that and return -EFAULT.
  */
-long probe_user_write(void __user *dst, const void *src, size_t size)
+long copy_to_user_nofault(void __user *dst, const void *src, size_t size)
 {
 	long ret = -EFAULT;
 	mm_segment_t old_fs = get_fs();
@@ -247,7 +247,7 @@ long probe_user_write(void __user *dst, const void *src, size_t size)
 		return -EFAULT;
 	return 0;
 }
-EXPORT_SYMBOL_GPL(probe_user_write);
+EXPORT_SYMBOL_GPL(copy_to_user_nofault);
 
 /**
  * strncpy_from_user_nofault: - Copy a NUL terminated string from unsafe user
-- 
2.26.2

