Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC631C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DCC022CAE
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgHGIih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:38:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:59626 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbgHGIie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 04:38:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 607D9B63F;
        Fri,  7 Aug 2020 08:38:49 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v3 2/7] x86/xen: eliminate xen-asm_64.S
Date:   Fri,  7 Aug 2020 10:38:21 +0200
Message-Id: <20200807083826.16794-3-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200807083826.16794-1-jgross@suse.com>
References: <20200807083826.16794-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 32-bit pv-guest support removed xen-asm_64.S can be merged with
xen-asm.S

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/xen/Makefile     |   3 +-
 arch/x86/xen/xen-asm.S    | 179 +++++++++++++++++++++++++++++++++++
 arch/x86/xen/xen-asm_64.S | 192 --------------------------------------
 3 files changed, 180 insertions(+), 194 deletions(-)
 delete mode 100644 arch/x86/xen/xen-asm_64.S

diff --git a/arch/x86/xen/Makefile b/arch/x86/xen/Makefile
index 084de77a109e..5de137d536cc 100644
--- a/arch/x86/xen/Makefile
+++ b/arch/x86/xen/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-OBJECT_FILES_NON_STANDARD_xen-asm_$(BITS).o := y
+OBJECT_FILES_NON_STANDARD_xen-asm.o := y
 
 ifdef CONFIG_FUNCTION_TRACER
 # Do not profile debug and lowlevel utilities
@@ -34,7 +34,6 @@ obj-$(CONFIG_XEN_PV)		+= mmu_pv.o
 obj-$(CONFIG_XEN_PV)		+= irq.o
 obj-$(CONFIG_XEN_PV)		+= multicalls.o
 obj-$(CONFIG_XEN_PV)		+= xen-asm.o
-obj-$(CONFIG_XEN_PV)		+= xen-asm_$(BITS).o
 
 obj-$(CONFIG_XEN_PVH)		+= enlighten_pvh.o
 
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index c59d077510bf..d1272a63f097 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -6,12 +6,19 @@
  * operations here; the indirect forms are better handled in C.
  */
 
+#include <asm/errno.h>
 #include <asm/asm-offsets.h>
 #include <asm/percpu.h>
 #include <asm/processor-flags.h>
+#include <asm/segment.h>
+#include <asm/thread_info.h>
+#include <asm/asm.h>
 #include <asm/frame.h>
 #include <asm/asm.h>
 
+#include <xen/interface/xen.h>
+
+#include <linux/init.h>
 #include <linux/linkage.h>
 
 /*
@@ -137,3 +144,175 @@ SYM_FUNC_START(xen_read_cr2_direct)
 	FRAME_END
 	ret
 SYM_FUNC_END(xen_read_cr2_direct);
+
+.macro xen_pv_trap name
+SYM_CODE_START(xen_\name)
+	pop %rcx
+	pop %r11
+	jmp  \name
+SYM_CODE_END(xen_\name)
+_ASM_NOKPROBE(xen_\name)
+.endm
+
+xen_pv_trap asm_exc_divide_error
+xen_pv_trap asm_xenpv_exc_debug
+xen_pv_trap asm_exc_int3
+xen_pv_trap asm_xenpv_exc_nmi
+xen_pv_trap asm_exc_overflow
+xen_pv_trap asm_exc_bounds
+xen_pv_trap asm_exc_invalid_op
+xen_pv_trap asm_exc_device_not_available
+xen_pv_trap asm_exc_double_fault
+xen_pv_trap asm_exc_coproc_segment_overrun
+xen_pv_trap asm_exc_invalid_tss
+xen_pv_trap asm_exc_segment_not_present
+xen_pv_trap asm_exc_stack_segment
+xen_pv_trap asm_exc_general_protection
+xen_pv_trap asm_exc_page_fault
+xen_pv_trap asm_exc_spurious_interrupt_bug
+xen_pv_trap asm_exc_coprocessor_error
+xen_pv_trap asm_exc_alignment_check
+#ifdef CONFIG_X86_MCE
+xen_pv_trap asm_exc_machine_check
+#endif /* CONFIG_X86_MCE */
+xen_pv_trap asm_exc_simd_coprocessor_error
+#ifdef CONFIG_IA32_EMULATION
+xen_pv_trap entry_INT80_compat
+#endif
+xen_pv_trap asm_exc_xen_hypervisor_callback
+
+	__INIT
+SYM_CODE_START(xen_early_idt_handler_array)
+	i = 0
+	.rept NUM_EXCEPTION_VECTORS
+	pop %rcx
+	pop %r11
+	jmp early_idt_handler_array + i*EARLY_IDT_HANDLER_SIZE
+	i = i + 1
+	.fill xen_early_idt_handler_array + i*XEN_EARLY_IDT_HANDLER_SIZE - ., 1, 0xcc
+	.endr
+SYM_CODE_END(xen_early_idt_handler_array)
+	__FINIT
+
+hypercall_iret = hypercall_page + __HYPERVISOR_iret * 32
+/*
+ * Xen64 iret frame:
+ *
+ *	ss
+ *	rsp
+ *	rflags
+ *	cs
+ *	rip		<-- standard iret frame
+ *
+ *	flags
+ *
+ *	rcx		}
+ *	r11		}<-- pushed by hypercall page
+ * rsp->rax		}
+ */
+SYM_CODE_START(xen_iret)
+	pushq $0
+	jmp hypercall_iret
+SYM_CODE_END(xen_iret)
+
+SYM_CODE_START(xen_sysret64)
+	/*
+	 * We're already on the usermode stack at this point, but
+	 * still with the kernel gs, so we can easily switch back.
+	 *
+	 * tss.sp2 is scratch space.
+	 */
+	movq %rsp, PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
+	movq PER_CPU_VAR(cpu_current_top_of_stack), %rsp
+
+	pushq $__USER_DS
+	pushq PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
+	pushq %r11
+	pushq $__USER_CS
+	pushq %rcx
+
+	pushq $VGCF_in_syscall
+	jmp hypercall_iret
+SYM_CODE_END(xen_sysret64)
+
+/*
+ * Xen handles syscall callbacks much like ordinary exceptions, which
+ * means we have:
+ * - kernel gs
+ * - kernel rsp
+ * - an iret-like stack frame on the stack (including rcx and r11):
+ *	ss
+ *	rsp
+ *	rflags
+ *	cs
+ *	rip
+ *	r11
+ * rsp->rcx
+ */
+
+/* Normal 64-bit system call target */
+SYM_FUNC_START(xen_syscall_target)
+	popq %rcx
+	popq %r11
+
+	/*
+	 * Neither Xen nor the kernel really knows what the old SS and
+	 * CS were.  The kernel expects __USER_DS and __USER_CS, so
+	 * report those values even though Xen will guess its own values.
+	 */
+	movq $__USER_DS, 4*8(%rsp)
+	movq $__USER_CS, 1*8(%rsp)
+
+	jmp entry_SYSCALL_64_after_hwframe
+SYM_FUNC_END(xen_syscall_target)
+
+#ifdef CONFIG_IA32_EMULATION
+
+/* 32-bit compat syscall target */
+SYM_FUNC_START(xen_syscall32_target)
+	popq %rcx
+	popq %r11
+
+	/*
+	 * Neither Xen nor the kernel really knows what the old SS and
+	 * CS were.  The kernel expects __USER32_DS and __USER32_CS, so
+	 * report those values even though Xen will guess its own values.
+	 */
+	movq $__USER32_DS, 4*8(%rsp)
+	movq $__USER32_CS, 1*8(%rsp)
+
+	jmp entry_SYSCALL_compat_after_hwframe
+SYM_FUNC_END(xen_syscall32_target)
+
+/* 32-bit compat sysenter target */
+SYM_FUNC_START(xen_sysenter_target)
+	/*
+	 * NB: Xen is polite and clears TF from EFLAGS for us.  This means
+	 * that we don't need to guard against single step exceptions here.
+	 */
+	popq %rcx
+	popq %r11
+
+	/*
+	 * Neither Xen nor the kernel really knows what the old SS and
+	 * CS were.  The kernel expects __USER32_DS and __USER32_CS, so
+	 * report those values even though Xen will guess its own values.
+	 */
+	movq $__USER32_DS, 4*8(%rsp)
+	movq $__USER32_CS, 1*8(%rsp)
+
+	jmp entry_SYSENTER_compat_after_hwframe
+SYM_FUNC_END(xen_sysenter_target)
+
+#else /* !CONFIG_IA32_EMULATION */
+
+SYM_FUNC_START_ALIAS(xen_syscall32_target)
+SYM_FUNC_START(xen_sysenter_target)
+	lea 16(%rsp), %rsp	/* strip %rcx, %r11 */
+	mov $-ENOSYS, %rax
+	pushq $0
+	jmp hypercall_iret
+SYM_FUNC_END(xen_sysenter_target)
+SYM_FUNC_END_ALIAS(xen_syscall32_target)
+
+#endif	/* CONFIG_IA32_EMULATION */
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
deleted file mode 100644
index aab1d99b2b48..000000000000
--- a/arch/x86/xen/xen-asm_64.S
+++ /dev/null
@@ -1,192 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Asm versions of Xen pv-ops, suitable for direct use.
- *
- * We only bother with direct forms (ie, vcpu in pda) of the
- * operations here; the indirect forms are better handled in C.
- */
-
-#include <asm/errno.h>
-#include <asm/percpu.h>
-#include <asm/processor-flags.h>
-#include <asm/segment.h>
-#include <asm/asm-offsets.h>
-#include <asm/thread_info.h>
-#include <asm/asm.h>
-
-#include <xen/interface/xen.h>
-
-#include <linux/init.h>
-#include <linux/linkage.h>
-
-.macro xen_pv_trap name
-SYM_CODE_START(xen_\name)
-	pop %rcx
-	pop %r11
-	jmp  \name
-SYM_CODE_END(xen_\name)
-_ASM_NOKPROBE(xen_\name)
-.endm
-
-xen_pv_trap asm_exc_divide_error
-xen_pv_trap asm_xenpv_exc_debug
-xen_pv_trap asm_exc_int3
-xen_pv_trap asm_xenpv_exc_nmi
-xen_pv_trap asm_exc_overflow
-xen_pv_trap asm_exc_bounds
-xen_pv_trap asm_exc_invalid_op
-xen_pv_trap asm_exc_device_not_available
-xen_pv_trap asm_exc_double_fault
-xen_pv_trap asm_exc_coproc_segment_overrun
-xen_pv_trap asm_exc_invalid_tss
-xen_pv_trap asm_exc_segment_not_present
-xen_pv_trap asm_exc_stack_segment
-xen_pv_trap asm_exc_general_protection
-xen_pv_trap asm_exc_page_fault
-xen_pv_trap asm_exc_spurious_interrupt_bug
-xen_pv_trap asm_exc_coprocessor_error
-xen_pv_trap asm_exc_alignment_check
-#ifdef CONFIG_X86_MCE
-xen_pv_trap asm_exc_machine_check
-#endif /* CONFIG_X86_MCE */
-xen_pv_trap asm_exc_simd_coprocessor_error
-#ifdef CONFIG_IA32_EMULATION
-xen_pv_trap entry_INT80_compat
-#endif
-xen_pv_trap asm_exc_xen_hypervisor_callback
-
-	__INIT
-SYM_CODE_START(xen_early_idt_handler_array)
-	i = 0
-	.rept NUM_EXCEPTION_VECTORS
-	pop %rcx
-	pop %r11
-	jmp early_idt_handler_array + i*EARLY_IDT_HANDLER_SIZE
-	i = i + 1
-	.fill xen_early_idt_handler_array + i*XEN_EARLY_IDT_HANDLER_SIZE - ., 1, 0xcc
-	.endr
-SYM_CODE_END(xen_early_idt_handler_array)
-	__FINIT
-
-hypercall_iret = hypercall_page + __HYPERVISOR_iret * 32
-/*
- * Xen64 iret frame:
- *
- *	ss
- *	rsp
- *	rflags
- *	cs
- *	rip		<-- standard iret frame
- *
- *	flags
- *
- *	rcx		}
- *	r11		}<-- pushed by hypercall page
- * rsp->rax		}
- */
-SYM_CODE_START(xen_iret)
-	pushq $0
-	jmp hypercall_iret
-SYM_CODE_END(xen_iret)
-
-SYM_CODE_START(xen_sysret64)
-	/*
-	 * We're already on the usermode stack at this point, but
-	 * still with the kernel gs, so we can easily switch back.
-	 *
-	 * tss.sp2 is scratch space.
-	 */
-	movq %rsp, PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
-	movq PER_CPU_VAR(cpu_current_top_of_stack), %rsp
-
-	pushq $__USER_DS
-	pushq PER_CPU_VAR(cpu_tss_rw + TSS_sp2)
-	pushq %r11
-	pushq $__USER_CS
-	pushq %rcx
-
-	pushq $VGCF_in_syscall
-	jmp hypercall_iret
-SYM_CODE_END(xen_sysret64)
-
-/*
- * Xen handles syscall callbacks much like ordinary exceptions, which
- * means we have:
- * - kernel gs
- * - kernel rsp
- * - an iret-like stack frame on the stack (including rcx and r11):
- *	ss
- *	rsp
- *	rflags
- *	cs
- *	rip
- *	r11
- * rsp->rcx
- */
-
-/* Normal 64-bit system call target */
-SYM_FUNC_START(xen_syscall_target)
-	popq %rcx
-	popq %r11
-
-	/*
-	 * Neither Xen nor the kernel really knows what the old SS and
-	 * CS were.  The kernel expects __USER_DS and __USER_CS, so
-	 * report those values even though Xen will guess its own values.
-	 */
-	movq $__USER_DS, 4*8(%rsp)
-	movq $__USER_CS, 1*8(%rsp)
-
-	jmp entry_SYSCALL_64_after_hwframe
-SYM_FUNC_END(xen_syscall_target)
-
-#ifdef CONFIG_IA32_EMULATION
-
-/* 32-bit compat syscall target */
-SYM_FUNC_START(xen_syscall32_target)
-	popq %rcx
-	popq %r11
-
-	/*
-	 * Neither Xen nor the kernel really knows what the old SS and
-	 * CS were.  The kernel expects __USER32_DS and __USER32_CS, so
-	 * report those values even though Xen will guess its own values.
-	 */
-	movq $__USER32_DS, 4*8(%rsp)
-	movq $__USER32_CS, 1*8(%rsp)
-
-	jmp entry_SYSCALL_compat_after_hwframe
-SYM_FUNC_END(xen_syscall32_target)
-
-/* 32-bit compat sysenter target */
-SYM_FUNC_START(xen_sysenter_target)
-	/*
-	 * NB: Xen is polite and clears TF from EFLAGS for us.  This means
-	 * that we don't need to guard against single step exceptions here.
-	 */
-	popq %rcx
-	popq %r11
-
-	/*
-	 * Neither Xen nor the kernel really knows what the old SS and
-	 * CS were.  The kernel expects __USER32_DS and __USER32_CS, so
-	 * report those values even though Xen will guess its own values.
-	 */
-	movq $__USER32_DS, 4*8(%rsp)
-	movq $__USER32_CS, 1*8(%rsp)
-
-	jmp entry_SYSENTER_compat_after_hwframe
-SYM_FUNC_END(xen_sysenter_target)
-
-#else /* !CONFIG_IA32_EMULATION */
-
-SYM_FUNC_START_ALIAS(xen_syscall32_target)
-SYM_FUNC_START(xen_sysenter_target)
-	lea 16(%rsp), %rsp	/* strip %rcx, %r11 */
-	mov $-ENOSYS, %rax
-	pushq $0
-	jmp hypercall_iret
-SYM_FUNC_END(xen_sysenter_target)
-SYM_FUNC_END_ALIAS(xen_syscall32_target)
-
-#endif	/* CONFIG_IA32_EMULATION */
-- 
2.26.2

