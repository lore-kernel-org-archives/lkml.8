Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEF2C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673B3246B9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583139001;
	bh=x2XgBRclo64fzdBcvO8pzMaQXTfAMNRNaZ2xUBXlvAg=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=RVFoc8yJq2MfSztkWLv2ozf18vlATIBddzdqSiZUgovskrcbsLZgAvYbp7VK+vlyV
	 PFJ7KMeiBD9h2UGAJzZ1+8+MkFp++Ehtdr50/Nr8irlstzsJOW5/4vIt8fYd4QvuKv
	 PX8W9BpLGECY/fRFrt+WO8ftZmZYaY2+m2sUZb8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbgCBIuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:50:00 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41175 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgCBIt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:49:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id v4so11393171wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 00:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eOXR8fXgwMvc6Rsc/8ZzagkZBoU3kc1V/QctTzPKhU8=;
        b=Z75AmcSenCFDwtfT1ZdcibrLrFwSZBBS1yhWjnosj26O/R5vLfO5EbDeg7GBhfT7zP
         CG5XBN36c8/TwylEx9wRcSOb7LBo4CV2hnXbVsh1RTwR/ISjO8hI9daCfsuKAEZw+y1k
         OifRFeUuZzxT9qdg6z94TXdy4VayaQUw9Fq+iD7GjpufD8C4dHL4/UJNEKyjbS6DV5rG
         BvsyRKTAj1p+BilJI04uftl02fSj/1Vm5KB5OZhDQqOgGB5iVLwnEBQUiUHnQXPPkGpf
         qjf0c7smkln/MYUluTSD9uRS02CP+CZcv7I6xek/5XrU9SiSMnmvQ4lFaYSPoBFpLMyt
         kiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=eOXR8fXgwMvc6Rsc/8ZzagkZBoU3kc1V/QctTzPKhU8=;
        b=Y5V4EYGHEsrP0T3X5rS3lfsD5PNHCHFaFT+yFLdAyrC5E2sUfT9b5G4+oBIX/EL59i
         83/k6b7COpHMGSPzJdtSPYkwR5c6UgRrtD+dKABWHlNGfbZ5qlomvqzCoKNEuLjzDKj4
         8I/mWfEROdGbI9qHrV+2Pj6x8r2aFxKYAnOuFvKOpY7aCaeI4s6j8N9eNhETrtapvTYO
         kobVf/kKIsoi3OZhWKW3PWXE2yG43CCDGgbi1xz0w3rt0bSYNBe3gInWp6JJhhS/pajg
         N2QIzPFRkLAVEOxKiuEsb6SUa+Ww7qVI0FHReyaHa4u6lw3Bi0HgQwm365AvUtGRu/q3
         jMRw==
X-Gm-Message-State: APjAAAXneDlUqFp042aV2+oZB6RxgeZ+BVsOKwxJ5r1GGcdqOriibO60
        viVKgglrdFgThv3Dnn4jMfFwOUzM
X-Google-Smtp-Source: APXvYqx4A78TyGI6CM3lSM/xxK6Xc5JjMwXVmji0jn+BmLdMTNJWeChKguLb6il/L/6eW9tuHLtdhg==
X-Received: by 2002:a5d:42c8:: with SMTP id t8mr20935442wrr.261.1583138997271;
        Mon, 02 Mar 2020 00:49:57 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id w206sm848014wmg.11.2020.03.02.00.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 00:49:56 -0800 (PST)
Date:   Mon, 2 Mar 2020 09:49:54 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [GIT PULL] x86 fixes
Message-ID: <20200302084954.GA21837@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-for-linus

   # HEAD: bba42affa732d6fd5bd5c9678e6deacde2de1547 x86/mm: Fix dump_pagetables with Xen PV

Misc fixes: a pkeys fix for a bug that triggers with weird BIOS settings, 
and two Xen PV fixes: a paravirt interface fix, and pagetable dumping 
fix.

 Thanks,

	Ingo

------------------>
Juergen Gross (2):
      x86/ioperm: Add new paravirt function update_io_bitmap()
      x86/mm: Fix dump_pagetables with Xen PV

Sean Christopherson (1):
      x86/pkeys: Manually set X86_FEATURE_OSPKE to preserve existing changes


 arch/x86/include/asm/io_bitmap.h      |  9 ++++++++-
 arch/x86/include/asm/paravirt.h       |  7 +++++++
 arch/x86/include/asm/paravirt_types.h |  4 ++++
 arch/x86/kernel/cpu/common.c          |  2 +-
 arch/x86/kernel/paravirt.c            |  5 +++++
 arch/x86/kernel/process.c             |  2 +-
 arch/x86/mm/dump_pagetables.c         |  7 +------
 arch/x86/xen/enlighten_pv.c           | 25 +++++++++++++++++++++++++
 8 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/io_bitmap.h b/arch/x86/include/asm/io_bitmap.h
index 02c6ef8f7667..07344d82e88e 100644
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
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 86e7317eb31f..694d8daf4983 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -295,6 +295,13 @@ static inline void write_idt_entry(gate_desc *dt, int entry, const gate_desc *g)
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
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 84812964d3dd..732f62e04ddb 100644
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
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 52c9bfbbdb2a..4cdb123ff66a 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -445,7 +445,7 @@ static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 	 * cpuid bit to be set.  We need to ensure that we
 	 * update that bit in this CPU's "cpu_info".
 	 */
-	get_cpu_cap(c);
+	set_cpu_cap(c, X86_FEATURE_OSPKE);
 }
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 789f5e4f89de..c131ba4e70ef 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -30,6 +30,7 @@
 #include <asm/timer.h>
 #include <asm/special_insns.h>
 #include <asm/tlb.h>
+#include <asm/io_bitmap.h>
 
 /*
  * nop stub, which must not clobber anything *including the stack* to
@@ -341,6 +342,10 @@ struct paravirt_patch_template pv_ops = {
 	.cpu.iret		= native_iret,
 	.cpu.swapgs		= native_swapgs,
 
+#ifdef CONFIG_X86_IOPL_IOPERM
+	.cpu.update_io_bitmap	= native_tss_update_io_bitmap,
+#endif
+
 	.cpu.start_context_switch	= paravirt_nop,
 	.cpu.end_context_switch		= paravirt_nop,
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 839b5244e3b7..3053c85e0e42 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -374,7 +374,7 @@ static void tss_copy_io_bitmap(struct tss_struct *tss, struct io_bitmap *iobm)
 /**
  * tss_update_io_bitmap - Update I/O bitmap before exiting to usermode
  */
-void tss_update_io_bitmap(void)
+void native_tss_update_io_bitmap(void)
 {
 	struct tss_struct *tss = this_cpu_ptr(&cpu_tss_rw);
 	struct thread_struct *t = &current->thread;
diff --git a/arch/x86/mm/dump_pagetables.c b/arch/x86/mm/dump_pagetables.c
index 64229dad7eab..69309cd56fdf 100644
--- a/arch/x86/mm/dump_pagetables.c
+++ b/arch/x86/mm/dump_pagetables.c
@@ -363,13 +363,8 @@ static void ptdump_walk_pgd_level_core(struct seq_file *m,
 {
 	const struct ptdump_range ptdump_ranges[] = {
 #ifdef CONFIG_X86_64
-
-#define normalize_addr_shift (64 - (__VIRTUAL_MASK_SHIFT + 1))
-#define normalize_addr(u) ((signed long)((u) << normalize_addr_shift) >> \
-			   normalize_addr_shift)
-
 	{0, PTRS_PER_PGD * PGD_LEVEL_MULT / 2},
-	{normalize_addr(PTRS_PER_PGD * PGD_LEVEL_MULT / 2), ~0UL},
+	{GUARD_HOLE_END_ADDR, ~0UL},
 #else
 	{0, ~0UL},
 #endif
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 79409120a603..507f4fb88fa7 100644
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
@@ -837,6 +840,25 @@ static void xen_load_sp0(unsigned long sp0)
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
@@ -1047,6 +1069,9 @@ static const struct pv_cpu_ops xen_cpu_ops __initconst = {
 	.write_idt_entry = xen_write_idt_entry,
 	.load_sp0 = xen_load_sp0,
 
+#ifdef CONFIG_X86_IOPL_IOPERM
+	.update_io_bitmap = xen_update_io_bitmap,
+#endif
 	.io_delay = xen_io_delay,
 
 	/* Xen takes care of %gs when switching to usermode for us */
