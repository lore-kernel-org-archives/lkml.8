Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE410C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 13:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A38C21775
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 13:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c7u05Qn/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TGefmsYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgGSNTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 09:19:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51496 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgGSNTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 09:19:10 -0400
Date:   Sun, 19 Jul 2020 13:18:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595164747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=1d0iWHmoAPzp6EbhDsb7joYp9MSQiL0KMiy69k3oPJU=;
        b=c7u05Qn/BYxXO5n5mJdmZjVelpfEgh7sw8h+t6j5arIluJSeuYad/rAMBv5/TIgTuwwsjy
        KLJxgNG5MQgp0s9dslLXEzu4zh6uEkJTk43QtiIsqfrku8oB+GeEzi7o+V/De0vuxLSubT
        muD7fliP1X5MVNoy3wHXMLmymKf6we2eQK+baLrjSOLkE5nnfHRsR+VEtew27u8dYvIZwh
        +0RTp/jxKO/3OnH0xp2W7YhQYvvYj4rGFz771sgtE6cfO8iC8eBBsVYYd6tszsz6B++8H4
        1G1B7Tua1LWLSn8e3Ts3CD8n9hTNMUpfEZz5PL0WXeOpzHmPoOUViJfipawmvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595164747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=1d0iWHmoAPzp6EbhDsb7joYp9MSQiL0KMiy69k3oPJU=;
        b=TGefmsYp4FiWVwyzuZ5KEzzc07zTxG622IZHZFmRmH66i3i1dN0m7eAx/fpfII6nHJZ5G5
        uHqqfrZkI7E+cnCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v5.8-rc6
References: <159516469014.4147.6471285397574034610.tglx@nanos.tec.linutronix.de>
Message-ID: <159516469375.4147.270001582364335381.tglx@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-07-19

up to:  da05b143a308: x86/boot: Don't add the EFI stub to targets

A pile of fixes for x86:

 - Fix the I/O bitmap invalidation on XEN PV, which was overlooked in the
   recent ioperm/iopl rework. This caused the TSS and XEN's I/O bitmap to
   get out of sync.

 - Use the proper vectors for HYPERV.

 - Make disabling of stack protector for the entry code work with GCC
   builds which enable stack protector by default. Removing the option is
   not sufficient, it needs an explicit -fno-stack-protector to shut it
   off.

 - Mark check_user_regs() noinstr as it is called from noinstr code. The
   missing annotation causes it to be placed in the text section which
   makes it instrumentable.

 - Add the missing interrupt disable in exc_alignment_check()
 
 - Fixup a XEN_PV build dependency in the 32bit entry code

 - A few fixes to make the Clang integrated assembler happy

 - Move EFI stub build to the right place for out of tree builds

 - Make prepare_exit_to_usermode() static. It's not longer called from ASM
   code.
Thanks,

	tglx

------------------>
Andy Lutomirski (1):
      x86/ioperm: Fix io bitmap invalidation on Xen PV

Arnd Bergmann (1):
      x86: math-emu: Fix up 'cmp' insn for clang ias

Arvind Sankar (1):
      x86/boot: Don't add the EFI stub to targets

Ingo Molnar (1):
      x86/entry/32: Fix XEN_PV build dependency

Jian Cai (1):
      x86/entry: Add compatibility with IAS

Kees Cook (1):
      x86/entry: Actually disable stack protector

Sedat Dilek (1):
      x86/entry: Fix vectors to IDTENTRY_SYSVEC for CONFIG_HYPERV

Thomas Gleixner (3):
      x86/traps: Disable interrupts in exc_aligment_check()
      x86/entry: Mark check_user_regs() noinstr
      x86/entry/common: Make prepare_exit_to_usermode() static


 arch/x86/boot/compressed/Makefile     |  4 ++--
 arch/x86/entry/Makefile               | 14 +++++++++++---
 arch/x86/entry/common.c               |  4 ++--
 arch/x86/include/asm/idtentry.h       | 22 ++++++++++------------
 arch/x86/include/asm/io_bitmap.h      | 16 ++++++++++++++++
 arch/x86/include/asm/paravirt.h       |  5 +++++
 arch/x86/include/asm/paravirt_types.h |  1 +
 arch/x86/kernel/paravirt.c            |  3 ++-
 arch/x86/kernel/process.c             | 18 ++----------------
 arch/x86/kernel/traps.c               |  2 ++
 arch/x86/math-emu/wm_sqrt.S           |  2 +-
 arch/x86/xen/enlighten_pv.c           | 12 ++++++++++++
 12 files changed, 66 insertions(+), 37 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 7619742f91c9..5a828fde7a42 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -90,8 +90,8 @@ endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
 
-vmlinux-objs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 vmlinux-objs-$(CONFIG_EFI_MIXED) += $(obj)/efi_thunk_$(BITS).o
+efi-obj-$(CONFIG_EFI_STUB) = $(objtree)/drivers/firmware/efi/libstub/lib.a
 
 # The compressed kernel is built with -fPIC/-fPIE so that a boot loader
 # can place it anywhere in memory and it will still run. However, since
@@ -115,7 +115,7 @@ endef
 quiet_cmd_check-and-link-vmlinux = LD      $@
       cmd_check-and-link-vmlinux = $(cmd_check_data_rel); $(cmd_ld)
 
-$(obj)/vmlinux: $(vmlinux-objs-y) FORCE
+$(obj)/vmlinux: $(vmlinux-objs-y) $(efi-obj-y) FORCE
 	$(call if_changed,check-and-link-vmlinux)
 
 OBJCOPYFLAGS_vmlinux.bin :=  -R .comment -S
diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index b7a5790d8d63..08bf95dbc911 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -7,12 +7,20 @@ KASAN_SANITIZE := n
 UBSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
 
-CFLAGS_REMOVE_common.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong
-CFLAGS_REMOVE_syscall_32.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong
-CFLAGS_REMOVE_syscall_64.o = $(CC_FLAGS_FTRACE) -fstack-protector -fstack-protector-strong
+CFLAGS_REMOVE_common.o		= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_syscall_64.o	= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_syscall_32.o	= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_syscall_x32.o	= $(CC_FLAGS_FTRACE)
+
+CFLAGS_common.o			+= -fno-stack-protector
+CFLAGS_syscall_64.o		+= -fno-stack-protector
+CFLAGS_syscall_32.o		+= -fno-stack-protector
+CFLAGS_syscall_x32.o		+= -fno-stack-protector
 
 CFLAGS_syscall_64.o		+= $(call cc-option,-Wno-override-init,)
 CFLAGS_syscall_32.o		+= $(call cc-option,-Wno-override-init,)
+CFLAGS_syscall_x32.o		+= $(call cc-option,-Wno-override-init,)
+
 obj-y				:= entry_$(BITS).o thunk_$(BITS).o syscall_$(BITS).o
 obj-y				+= common.o
 
diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index e83b3f14897c..f09288431f28 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -46,7 +46,7 @@
 #include <trace/events/syscalls.h>
 
 /* Check that the stack and regs on entry from user mode are sane. */
-static void check_user_regs(struct pt_regs *regs)
+static noinstr void check_user_regs(struct pt_regs *regs)
 {
 	if (IS_ENABLED(CONFIG_DEBUG_ENTRY)) {
 		/*
@@ -294,7 +294,7 @@ static void __prepare_exit_to_usermode(struct pt_regs *regs)
 #endif
 }
 
-__visible noinstr void prepare_exit_to_usermode(struct pt_regs *regs)
+static noinstr void prepare_exit_to_usermode(struct pt_regs *regs)
 {
 	instrumentation_begin();
 	__prepare_exit_to_usermode(regs);
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index eeac6dc2adaa..80d3b30d3ee3 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -469,16 +469,15 @@ __visible noinstr void func(struct pt_regs *regs,			\
 	.align 8
 SYM_CODE_START(irq_entries_start)
     vector=FIRST_EXTERNAL_VECTOR
-    pos = .
     .rept (FIRST_SYSTEM_VECTOR - FIRST_EXTERNAL_VECTOR)
 	UNWIND_HINT_IRET_REGS
+0 :
 	.byte	0x6a, vector
 	jmp	asm_common_interrupt
 	nop
 	/* Ensure that the above is 8 bytes max */
-	. = pos + 8
-    pos=pos+8
-    vector=vector+1
+	. = 0b + 8
+	vector = vector+1
     .endr
 SYM_CODE_END(irq_entries_start)
 
@@ -486,16 +485,15 @@ SYM_CODE_END(irq_entries_start)
 	.align 8
 SYM_CODE_START(spurious_entries_start)
     vector=FIRST_SYSTEM_VECTOR
-    pos = .
     .rept (NR_VECTORS - FIRST_SYSTEM_VECTOR)
 	UNWIND_HINT_IRET_REGS
+0 :
 	.byte	0x6a, vector
 	jmp	asm_spurious_interrupt
 	nop
 	/* Ensure that the above is 8 bytes max */
-	. = pos + 8
-    pos=pos+8
-    vector=vector+1
+	. = 0b + 8
+	vector = vector+1
     .endr
 SYM_CODE_END(spurious_entries_start)
 #endif
@@ -553,7 +551,7 @@ DECLARE_IDTENTRY_RAW(X86_TRAP_MC,	exc_machine_check);
 
 /* NMI */
 DECLARE_IDTENTRY_NMI(X86_TRAP_NMI,	exc_nmi);
-#ifdef CONFIG_XEN_PV
+#if defined(CONFIG_XEN_PV) && defined(CONFIG_X86_64)
 DECLARE_IDTENTRY_RAW(X86_TRAP_NMI,	xenpv_exc_nmi);
 #endif
 
@@ -563,7 +561,7 @@ DECLARE_IDTENTRY_DEBUG(X86_TRAP_DB,	exc_debug);
 #else
 DECLARE_IDTENTRY_RAW(X86_TRAP_DB,	exc_debug);
 #endif
-#ifdef CONFIG_XEN_PV
+#if defined(CONFIG_XEN_PV) && defined(CONFIG_X86_64)
 DECLARE_IDTENTRY_RAW(X86_TRAP_DB,	xenpv_exc_debug);
 #endif
 
@@ -626,8 +624,8 @@ DECLARE_IDTENTRY_SYSVEC(POSTED_INTR_NESTED_VECTOR,	sysvec_kvm_posted_intr_nested
 
 #if IS_ENABLED(CONFIG_HYPERV)
 DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_CALLBACK_VECTOR,	sysvec_hyperv_callback);
-DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_REENLIGHTENMENT_VECTOR,	sysvec_hyperv_reenlightenment);
-DECLARE_IDTENTRY_SYSVEC(HYPERVISOR_STIMER0_VECTOR,	sysvec_hyperv_stimer0);
+DECLARE_IDTENTRY_SYSVEC(HYPERV_REENLIGHTENMENT_VECTOR,	sysvec_hyperv_reenlightenment);
+DECLARE_IDTENTRY_SYSVEC(HYPERV_STIMER0_VECTOR,	sysvec_hyperv_stimer0);
 #endif
 
 #if IS_ENABLED(CONFIG_ACRN_GUEST)
diff --git a/arch/x86/include/asm/io_bitmap.h b/arch/x86/include/asm/io_bitmap.h
index ac1a99ffbd8d..7f080f5c7def 100644
--- a/arch/x86/include/asm/io_bitmap.h
+++ b/arch/x86/include/asm/io_bitmap.h
@@ -19,12 +19,28 @@ struct task_struct;
 void io_bitmap_share(struct task_struct *tsk);
 void io_bitmap_exit(struct task_struct *tsk);
 
+static inline void native_tss_invalidate_io_bitmap(void)
+{
+	/*
+	 * Invalidate the I/O bitmap by moving io_bitmap_base outside the
+	 * TSS limit so any subsequent I/O access from user space will
+	 * trigger a #GP.
+	 *
+	 * This is correct even when VMEXIT rewrites the TSS limit
+	 * to 0x67 as the only requirement is that the base points
+	 * outside the limit.
+	 */
+	this_cpu_write(cpu_tss_rw.x86_tss.io_bitmap_base,
+		       IO_BITMAP_OFFSET_INVALID);
+}
+
 void native_tss_update_io_bitmap(void);
 
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
 #define tss_update_io_bitmap native_tss_update_io_bitmap
+#define tss_invalidate_io_bitmap native_tss_invalidate_io_bitmap
 #endif
 
 #else
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 5ca5d297df75..3d2afecde50c 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -302,6 +302,11 @@ static inline void write_idt_entry(gate_desc *dt, int entry, const gate_desc *g)
 }
 
 #ifdef CONFIG_X86_IOPL_IOPERM
+static inline void tss_invalidate_io_bitmap(void)
+{
+	PVOP_VCALL0(cpu.invalidate_io_bitmap);
+}
+
 static inline void tss_update_io_bitmap(void)
 {
 	PVOP_VCALL0(cpu.update_io_bitmap);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 732f62e04ddb..8dfcb2508e6d 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -141,6 +141,7 @@ struct pv_cpu_ops {
 	void (*load_sp0)(unsigned long sp0);
 
 #ifdef CONFIG_X86_IOPL_IOPERM
+	void (*invalidate_io_bitmap)(void);
 	void (*update_io_bitmap)(void);
 #endif
 
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 674a7d66d960..de2138ba38e5 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -324,7 +324,8 @@ struct paravirt_patch_template pv_ops = {
 	.cpu.swapgs		= native_swapgs,
 
 #ifdef CONFIG_X86_IOPL_IOPERM
-	.cpu.update_io_bitmap	= native_tss_update_io_bitmap,
+	.cpu.invalidate_io_bitmap	= native_tss_invalidate_io_bitmap,
+	.cpu.update_io_bitmap		= native_tss_update_io_bitmap,
 #endif
 
 	.cpu.start_context_switch	= paravirt_nop,
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index f362ce0d5ac0..fe67dbd76e51 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -322,20 +322,6 @@ void arch_setup_new_exec(void)
 }
 
 #ifdef CONFIG_X86_IOPL_IOPERM
-static inline void tss_invalidate_io_bitmap(struct tss_struct *tss)
-{
-	/*
-	 * Invalidate the I/O bitmap by moving io_bitmap_base outside the
-	 * TSS limit so any subsequent I/O access from user space will
-	 * trigger a #GP.
-	 *
-	 * This is correct even when VMEXIT rewrites the TSS limit
-	 * to 0x67 as the only requirement is that the base points
-	 * outside the limit.
-	 */
-	tss->x86_tss.io_bitmap_base = IO_BITMAP_OFFSET_INVALID;
-}
-
 static inline void switch_to_bitmap(unsigned long tifp)
 {
 	/*
@@ -346,7 +332,7 @@ static inline void switch_to_bitmap(unsigned long tifp)
 	 * user mode.
 	 */
 	if (tifp & _TIF_IO_BITMAP)
-		tss_invalidate_io_bitmap(this_cpu_ptr(&cpu_tss_rw));
+		tss_invalidate_io_bitmap();
 }
 
 static void tss_copy_io_bitmap(struct tss_struct *tss, struct io_bitmap *iobm)
@@ -380,7 +366,7 @@ void native_tss_update_io_bitmap(void)
 	u16 *base = &tss->x86_tss.io_bitmap_base;
 
 	if (!test_thread_flag(TIF_IO_BITMAP)) {
-		tss_invalidate_io_bitmap(tss);
+		native_tss_invalidate_io_bitmap();
 		return;
 	}
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 6ed8cc5fbe8f..4f3a509e5547 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -299,6 +299,8 @@ DEFINE_IDTENTRY_ERRORCODE(exc_alignment_check)
 
 	do_trap(X86_TRAP_AC, SIGBUS, "alignment check", regs,
 		error_code, BUS_ADRALN, NULL);
+
+	local_irq_disable();
 }
 
 #ifdef CONFIG_VMAP_STACK
diff --git a/arch/x86/math-emu/wm_sqrt.S b/arch/x86/math-emu/wm_sqrt.S
index 3b2b58164ec1..40526dd85137 100644
--- a/arch/x86/math-emu/wm_sqrt.S
+++ b/arch/x86/math-emu/wm_sqrt.S
@@ -209,7 +209,7 @@ sqrt_stage_2_finish:
 
 #ifdef PARANOID
 /* It should be possible to get here only if the arg is ffff....ffff */
-	cmp	$0xffffffff,FPU_fsqrt_arg_1
+	cmpl	$0xffffffff,FPU_fsqrt_arg_1
 	jnz	sqrt_stage_2_error
 #endif /* PARANOID */
 
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 0d68948c82ad..c46b9f2e732f 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -870,6 +870,17 @@ static void xen_load_sp0(unsigned long sp0)
 }
 
 #ifdef CONFIG_X86_IOPL_IOPERM
+static void xen_invalidate_io_bitmap(void)
+{
+	struct physdev_set_iobitmap iobitmap = {
+		.bitmap = 0,
+		.nr_ports = 0,
+	};
+
+	native_tss_invalidate_io_bitmap();
+	HYPERVISOR_physdev_op(PHYSDEVOP_set_iobitmap, &iobitmap);
+}
+
 static void xen_update_io_bitmap(void)
 {
 	struct physdev_set_iobitmap iobitmap;
@@ -1099,6 +1110,7 @@ static const struct pv_cpu_ops xen_cpu_ops __initconst = {
 	.load_sp0 = xen_load_sp0,
 
 #ifdef CONFIG_X86_IOPL_IOPERM
+	.invalidate_io_bitmap = xen_invalidate_io_bitmap,
 	.update_io_bitmap = xen_update_io_bitmap,
 #endif
 	.io_delay = xen_io_delay,

