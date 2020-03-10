Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA11C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 877AF2468C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845226;
	bh=twco3ffWmfdTyjrm0y+hJHuOZBI8ExV1TIVK5gyIwcs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gfUEbWsFlHkFuzHXC2c3OhxKP0QdLm9qgHdRiOXEHbHhkLRrjeV5zfHxrYNPU4Ozi
	 Ih1AIuAgeWPStJdrcD2yRtJXSw//XJzabjHbg9lNtV9dNVhbZGJhSdfT0VumOHeLpr
	 c+zP+DttO+05IGXpy1wYmWnPtKsy7pLj+5ZWyoqQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgCJNAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:00:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:41074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730123AbgCJNAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:00:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BACF2253D;
        Tue, 10 Mar 2020 13:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845220;
        bh=twco3ffWmfdTyjrm0y+hJHuOZBI8ExV1TIVK5gyIwcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CEgemB6jhOzYzY7ZGioym+NlSIE7op+F0cxVhSmX0i1p1W++UQc25wN/5pqof/iYZ
         Mr9Lp1nEJ+OFDi2xy3m/llaJI7HnbF64BA0aMVYE/qWuwRUn3vuav+vuXaOYhE/287
         PMwba1Orpsaj4Qkn9Ex+PtxdiR9kaG8QAZ50xH3w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Beulich <jbeulich@suse.com>,
        Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 5.5 104/189] x86/ioperm: Add new paravirt function update_io_bitmap()
Date:   Tue, 10 Mar 2020 13:39:01 +0100
Message-Id: <20200310123650.229967504@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123639.608886314@linuxfoundation.org>
References: <20200310123639.608886314@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com>

commit 99bcd4a6e5b8ba201fdd252f1054689884899fee upstream.

Commit 111e7b15cf10f6 ("x86/ioperm: Extend IOPL config to control ioperm()
as well") reworked the iopl syscall to use I/O bitmaps.

Unfortunately this broke Xen PV domains using that syscall as there is
currently no I/O bitmap support in PV domains.

Add I/O bitmap support via a new paravirt function update_io_bitmap which
Xen PV domains can use to update their I/O bitmaps via a hypercall.

Fixes: 111e7b15cf10f6 ("x86/ioperm: Extend IOPL config to control ioperm() as well")
Reported-by: Jan Beulich <jbeulich@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Jan Beulich <jbeulich@suse.com>
Cc: <stable@vger.kernel.org> # 5.5
Link: https://lkml.kernel.org/r/20200218154712.25490-1-jgross@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/io_bitmap.h      |    9 ++++++++-
 arch/x86/include/asm/paravirt.h       |    7 +++++++
 arch/x86/include/asm/paravirt_types.h |    4 ++++
 arch/x86/kernel/paravirt.c            |    5 +++++
 arch/x86/kernel/process.c             |    2 +-
 arch/x86/xen/enlighten_pv.c           |   25 +++++++++++++++++++++++++
 6 files changed, 50 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/io_bitmap.h
+++ b/arch/x86/include/asm/io_bitmap.h
@@ -19,7 +19,14 @@ struct task_struct;
 void io_bitmap_share(struct task_struct *tsk);
 void io_bitmap_exit(void);
 
-void tss_update_io_bitmap(void);
+void native_tss_update_io_bitmap(void);
+
+#ifdef CONFIG_PARAVIRT_XXL
+#include <asm/paravirt.h>
+#else
+#define tss_update_io_bitmap native_tss_update_io_bitmap
+#endif
+
 #else
 static inline void io_bitmap_share(struct task_struct *tsk) { }
 static inline void io_bitmap_exit(void) { }
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -295,6 +295,13 @@ static inline void write_idt_entry(gate_
 	PVOP_VCALL3(cpu.write_idt_entry, dt, entry, g);
 }
 
+#ifdef CONFIG_X86_IOPL_IOPERM
+static inline void tss_update_io_bitmap(void)
+{
+	PVOP_VCALL0(cpu.update_io_bitmap);
+}
+#endif
+
 static inline void paravirt_activate_mm(struct mm_struct *prev,
 					struct mm_struct *next)
 {
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -140,6 +140,10 @@ struct pv_cpu_ops {
 
 	void (*load_sp0)(unsigned long sp0);
 
+#ifdef CONFIG_X86_IOPL_IOPERM
+	void (*update_io_bitmap)(void);
+#endif
+
 	void (*wbinvd)(void);
 
 	/* cpuid emulation, mostly so that caps bits can be disabled */
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -30,6 +30,7 @@
 #include <asm/timer.h>
 #include <asm/special_insns.h>
 #include <asm/tlb.h>
+#include <asm/io_bitmap.h>
 
 /*
  * nop stub, which must not clobber anything *including the stack* to
@@ -341,6 +342,10 @@ struct paravirt_patch_template pv_ops =
 	.cpu.iret		= native_iret,
 	.cpu.swapgs		= native_swapgs,
 
+#ifdef CONFIG_X86_IOPL_IOPERM
+	.cpu.update_io_bitmap	= native_tss_update_io_bitmap,
+#endif
+
 	.cpu.start_context_switch	= paravirt_nop,
 	.cpu.end_context_switch		= paravirt_nop,
 
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -374,7 +374,7 @@ static void tss_copy_io_bitmap(struct ts
 /**
  * tss_update_io_bitmap - Update I/O bitmap before exiting to usermode
  */
-void tss_update_io_bitmap(void)
+void native_tss_update_io_bitmap(void)
 {
 	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
 	struct thread_struct *t = &current->thread;
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -72,6 +72,9 @@
 #include <asm/mwait.h>
 #include <asm/pci_x86.h>
 #include <asm/cpu.h>
+#ifdef CONFIG_X86_IOPL_IOPERM
+#include <asm/io_bitmap.h>
+#endif
 
 #ifdef CONFIG_ACPI
 #include <linux/acpi.h>
@@ -837,6 +840,25 @@ static void xen_load_sp0(unsigned long s
 	this_cpu_write(cpu_tss_rw.x86_tss.sp0, sp0);
 }
 
+#ifdef CONFIG_X86_IOPL_IOPERM
+static void xen_update_io_bitmap(void)
+{
+	struct physdev_set_iobitmap iobitmap;
+	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
+
+	native_tss_update_io_bitmap();
+
+	iobitmap.bitmap = (uint8_t *)(&tss->x86_tss) +
+			  tss->x86_tss.io_bitmap_base;
+	if (tss->x86_tss.io_bitmap_base == IO_BITMAP_OFFSET_INVALID)
+		iobitmap.nr_ports = 0;
+	else
+		iobitmap.nr_ports = IO_BITMAP_BITS;
+
+	HYPERVISOR_physdev_op(PHYSDEVOP_set_iobitmap, &iobitmap);
+}
+#endif
+
 static void xen_io_delay(void)
 {
 }
@@ -1047,6 +1069,9 @@ static const struct pv_cpu_ops xen_cpu_o
 	.write_idt_entry = xen_write_idt_entry,
 	.load_sp0 = xen_load_sp0,
 
+#ifdef CONFIG_X86_IOPL_IOPERM
+	.update_io_bitmap = xen_update_io_bitmap,
+#endif
 	.io_delay = xen_io_delay,
 
 	/* Xen takes care of %gs when switching to usermode for us */


