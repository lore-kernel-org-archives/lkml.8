Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93D2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 19:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87ECC2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 19:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgHNTYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 15:24:08 -0400
Received: from smtprelay0167.hostedemail.com ([216.40.44.167]:57726 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726196AbgHNTYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 15:24:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id CEA4B181D46E7;
        Fri, 14 Aug 2020 19:24:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: clock17_250a4ad26fff
X-Filterd-Recvd-Size: 19533
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Fri, 14 Aug 2020 19:24:04 +0000 (UTC)
Message-ID: <a61afb0e34aeae7af9e0c3198152e014ff75302f.camel@perches.com>
Subject: Re: [RFC PATCH] vsprintf: Add %pv extension replacement for
 print_vma_addr
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date:   Fri, 14 Aug 2020 12:24:02 -0700
In-Reply-To: <20200814143816.33325a49@oasis.local.home>
References: <09f11651f0e913e159b955ac447cd8cadf36cb0d.camel@perches.com>
         <20200814143816.33325a49@oasis.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-08-14 at 14:38 -0400, Steven Rostedt wrote:
> On Fri, 14 Aug 2020 10:53:03 -0700
> Joe Perches <joe@perches.com> wrote:
> I'm fine with all his, but I feel more comfortable if this patch
> created a single copy of the code. Perhaps add:
[]
> diff --git a/mm/memory.c b/mm/memory.c
[]
> @@ -4771,32 +4771,7 @@ EXPORT_SYMBOL_GPL(access_process_vm);
>   */
>  void print_vma_addr(char *prefix, unsigned long ip)
>  {
> -	struct mm_struct *mm = current->mm;
> -	struct vm_area_struct *vma;
> -
> -	/*
> -	 * we might be running from an atomic context so we cannot sleep
> -	 */
> -	if (!mmap_read_trylock(mm))
> -		return;
> -
> -	vma = find_vma(mm, ip);
> -	if (vma && vma->vm_file) {
> -		struct file *f = vma->vm_file;
> -		char *buf = (char *)__get_free_page(GFP_NOWAIT);
> -		if (buf) {
> -			char *p;
> -
> -			p = file_path(f, buf, PAGE_SIZE);
> -			if (IS_ERR(p))
> -				p = "?";
> -			printk("%s%s[%lx+%lx]", prefix, kbasename(p),
> -					vma->vm_start,
> -					vma->vm_end - vma->vm_start);
> -			free_page((unsigned long)buf);
> -		}
> -	}
> -	mmap_read_unlock(mm);
> +	printk("%s%pv", prefix, ip);
>  }

I'd just convert all of them and remove this function instead.

Something like (uncompiled/untested):
---
 arch/arc/kernel/troubleshoot.c |  2 +-
 arch/arm64/kernel/traps.c      | 16 +++++++------
 arch/csky/kernel/traps.c       | 11 ++++-----
 arch/mips/mm/fault.c           | 14 +++++------
 arch/parisc/mm/fault.c         | 15 +++++-------
 arch/powerpc/kernel/traps.c    |  8 ++-----
 arch/riscv/kernel/traps.c      | 11 ++++-----
 arch/s390/mm/fault.c           |  7 +++---
 arch/sparc/mm/fault_32.c       |  8 ++-----
 arch/sparc/mm/fault_64.c       |  8 ++-----
 arch/um/kernel/trap.c          | 13 ++++-------
 arch/x86/kernel/signal.c       |  6 ++---
 arch/x86/kernel/traps.c        |  6 ++---
 arch/x86/mm/fault.c            | 53 +++++++++++++++++++-----------------------
 include/linux/mm.h             |  7 ------
 mm/memory.c                    | 33 --------------------------
 16 files changed, 74 insertions(+), 144 deletions(-)

diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoot.c
index 28e8bf04b253..26ecd59f0057 100644
--- a/arch/arc/kernel/troubleshoot.c
+++ b/arch/arc/kernel/troubleshoot.c
@@ -86,7 +86,7 @@ static void show_faulting_vma(unsigned long address)
 	struct vm_area_struct *vma;
 	struct mm_struct *active_mm = current->active_mm;
 
-	/* can't use print_vma_addr() yet as it doesn't check for
+	/* can't use %pv yet as it doesn't check for
 	 * non-inclusive vma
 	 */
 	mmap_read_lock(active_mm);
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 13ebd5ca2070..294ed81f67d8 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -224,13 +224,15 @@ static void arm64_show_signal(int signo, const char *str)
 	    !__ratelimit(&rs))
 		return;
 
-	pr_info("%s[%d]: unhandled exception: ", tsk->comm, task_pid_nr(tsk));
-	if (esr)
-		pr_cont("%s, ESR 0x%08x, ", esr_get_class_string(esr), esr);
-
-	pr_cont("%s", str);
-	print_vma_addr(KERN_CONT " in ", regs->pc);
-	pr_cont("\n");
+	if (esr) {
+		pr_info("%s[%d]: unhandled exception: %s, ESR 0x%08x, %s in %pv\n",
+			tsk->comm, task_pid_nr(tsk),
+			esr_get_class_string(esr), esr,
+			str, (void *)regs->pc);
+	} else {
+		pr_info("%s[%d]: unhandled exception: %s in %pv\n",
+			tsk->comm, task_pid_nr(tsk), str, (void *)regs->pc);
+	}
 	__show_regs(regs);
 }
 
diff --git a/arch/csky/kernel/traps.c b/arch/csky/kernel/traps.c
index 959a917c989d..bdf1577237df 100644
--- a/arch/csky/kernel/traps.c
+++ b/arch/csky/kernel/traps.c
@@ -118,12 +118,11 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 {
 	struct task_struct *tsk = current;
 
-	if (show_unhandled_signals && unhandled_signal(tsk, signo)
-	    && printk_ratelimit()) {
-		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x%08lx",
-			tsk->comm, task_pid_nr(tsk), signo, code, addr);
-		print_vma_addr(KERN_CONT " in ", instruction_pointer(regs));
-		pr_cont("\n");
+	if (show_unhandled_signals && unhandled_signal(tsk, signo) &&
+	    printk_ratelimit()) {
+		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x%08lx in %pv\n",
+			tsk->comm, task_pid_nr(tsk), signo, code, addr,
+			(void *)instruction_pointer(regs));
 		show_regs(regs);
 	}
 
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 7c871b14e74a..cd87d11d57dc 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -204,14 +204,12 @@ static void __kprobes __do_page_fault(struct pt_regs *regs, unsigned long write,
 				tsk->comm,
 				write ? "write access to" : "read access from",
 				field, address);
-			pr_info("epc = %0*lx in", field,
-				(unsigned long) regs->cp0_epc);
-			print_vma_addr(KERN_CONT " ", regs->cp0_epc);
-			pr_cont("\n");
-			pr_info("ra  = %0*lx in", field,
-				(unsigned long) regs->regs[31]);
-			print_vma_addr(KERN_CONT " ", regs->regs[31]);
-			pr_cont("\n");
+			pr_info("epc = %0*lx in %pv\n",
+				field, (unsigned long)regs->cp0_epc,
+				(void *)(unsigned long)regs->cp0_epc);
+			pr_info("ra  = %0*lx in %pv\n",
+				field, (unsigned long)regs->regs[31],
+				(void *)(unsigned long)regs->regs[31]);
 		}
 		current->thread.trap_nr = (regs->cp0_cause >> 2) & 0x1f;
 		force_sig_fault(SIGSEGV, si_code, (void __user *)address);
diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index 4bfe2da9fbe3..3d519fb80541 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -242,17 +242,14 @@ show_signal_msg(struct pt_regs *regs, unsigned long code,
 	if (!printk_ratelimit())
 		return;
 
-	pr_warn("\n");
-	pr_warn("do_page_fault() command='%s' type=%lu address=0x%08lx",
-	    tsk->comm, code, address);
-	print_vma_addr(KERN_CONT " in ", regs->iaoq[0]);
-
-	pr_cont("\ntrap #%lu: %s%c", code, trap_name(code),
-		vma ? ',':'\n');
+	pr_warn("do_page_fault() command='%s' type=%lu address=0x%08lx in %pv\n",
+		tsk->comm, code, address, (void *)regs->iaoq[0]);
 
 	if (vma)
-		pr_cont(" vm_start = 0x%08lx, vm_end = 0x%08lx\n",
-			vma->vm_start, vma->vm_end);
+		pr_warn("trap #%lu: %s, vm_start = 0x%08lx, vm_end = 0x%08lx\n",
+			code, trap_name(code), vma->vm_start, vma->vm_end);
+	else
+		pr_warn("trap #%lu: %s\n", code, trap_name(code));
 
 	show_regs(regs);
 }
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index d1ebe152f210..a21bad3c059b 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -321,13 +321,9 @@ static void show_signal_msg(int signr, struct pt_regs *regs, int code,
 	if (!__ratelimit(&rs))
 		return;
 
-	pr_info("%s[%d]: %s (%d) at %lx nip %lx lr %lx code %x",
+	pr_info("%s[%d]: %s (%d) at %lx nip %lx lr %lx code %x in %pv\n",
 		current->comm, current->pid, signame(signr), signr,
-		addr, regs->nip, regs->link, code);
-
-	print_vma_addr(KERN_CONT " in ", regs->nip);
-
-	pr_cont("\n");
+		addr, regs->nip, regs->link, code, (void *)regs->nip);
 
 	show_user_instructions(regs);
 }
diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index ad14f4466d92..c08d80b18e33 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -60,12 +60,11 @@ void do_trap(struct pt_regs *regs, int signo, int code, unsigned long addr)
 {
 	struct task_struct *tsk = current;
 
-	if (show_unhandled_signals && unhandled_signal(tsk, signo)
-	    && printk_ratelimit()) {
-		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT,
-			tsk->comm, task_pid_nr(tsk), signo, code, addr);
-		print_vma_addr(KERN_CONT " in ", instruction_pointer(regs));
-		pr_cont("\n");
+	if (show_unhandled_signals && unhandled_signal(tsk, signo) &&
+	    printk_ratelimit()) {
+		pr_info("%s[%d]: unhandled signal %d code 0x%x at 0x" REG_FMT " in %pv\n",
+			tsk->comm, task_pid_nr(tsk), signo, code, addr,
+			(void *)instruction_pointer(regs));
 		show_regs(regs);
 	}
 
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 4c8c063bce5b..4726a440dfdd 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -217,10 +217,9 @@ void report_user_fault(struct pt_regs *regs, long signr, int is_mm_fault)
 		return;
 	if (!printk_ratelimit())
 		return;
-	printk(KERN_ALERT "User process fault: interruption code %04x ilc:%d ",
-	       regs->int_code & 0xffff, regs->int_code >> 17);
-	print_vma_addr(KERN_CONT "in ", regs->psw.addr);
-	printk(KERN_CONT "\n");
+	pr_alert("User process fault: interruption code %04x ilc:%d in %pv\n",
+		 regs->int_code & 0xffff, regs->int_code >> 17,
+		 (void *)regs->psw.addr);
 	if (is_mm_fault)
 		dump_fault_info(regs);
 	show_regs(regs);
diff --git a/arch/sparc/mm/fault_32.c b/arch/sparc/mm/fault_32.c
index 8071bfd72349..c527d77a84d6 100644
--- a/arch/sparc/mm/fault_32.c
+++ b/arch/sparc/mm/fault_32.c
@@ -112,15 +112,11 @@ show_signal_msg(struct pt_regs *regs, int sig, int code,
 	if (!printk_ratelimit())
 		return;
 
-	printk("%s%s[%d]: segfault at %lx ip %px (rpc %px) sp %px error %x",
+	printk("%s%s[%d]: segfault at %lx ip %px (rpc %px) sp %px error %x in %pv\n",
 	       task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG,
 	       tsk->comm, task_pid_nr(tsk), address,
 	       (void *)regs->pc, (void *)regs->u_regs[UREG_I7],
-	       (void *)regs->u_regs[UREG_FP], code);
-
-	print_vma_addr(KERN_CONT " in ", regs->pc);
-
-	printk(KERN_CONT "\n");
+	       (void *)regs->u_regs[UREG_FP], code, (void *)regs->pc);
 }
 
 static void __do_fault_siginfo(int code, int sig, struct pt_regs *regs,
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 0a6bcc85fba7..bbe39cb9560b 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -143,15 +143,11 @@ show_signal_msg(struct pt_regs *regs, int sig, int code,
 	if (!printk_ratelimit())
 		return;
 
-	printk("%s%s[%d]: segfault at %lx ip %px (rpc %px) sp %px error %x",
+	printk("%s%s[%d]: segfault at %lx ip %px (rpc %px) sp %px error %x in %pv\n",
 	       task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG,
 	       tsk->comm, task_pid_nr(tsk), address,
 	       (void *)regs->tpc, (void *)regs->u_regs[UREG_I7],
-	       (void *)regs->u_regs[UREG_FP], code);
-
-	print_vma_addr(KERN_CONT " in ", regs->tpc);
-
-	printk(KERN_CONT "\n");
+	       (void *)regs->u_regs[UREG_FP], code, (void *)regs->tpc);
 }
 
 static void do_fault_siginfo(int code, int sig, struct pt_regs *regs,
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index ad12f78bda7e..f7854e9bc06a 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -140,14 +140,11 @@ static void show_segv_info(struct uml_pt_regs *regs)
 	if (!printk_ratelimit())
 		return;
 
-	printk("%s%s[%d]: segfault at %lx ip %px sp %px error %x",
-		task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG,
-		tsk->comm, task_pid_nr(tsk), FAULT_ADDRESS(*fi),
-		(void *)UPT_IP(regs), (void *)UPT_SP(regs),
-		fi->error_code);
-
-	print_vma_addr(KERN_CONT " in ", UPT_IP(regs));
-	printk(KERN_CONT "\n");
+	printk("%s%s[%d]: segfault at %lx ip %px sp %px error %x in %pv\n",
+	       task_pid_nr(tsk) > 1 ? KERN_INFO : KERN_EMERG,
+	       tsk->comm, task_pid_nr(tsk), FAULT_ADDRESS(*fi),
+	       (void *)UPT_IP(regs), (void *)UPT_SP(regs),
+	       fi->error_code, (void *)UPT_IP(regs));
 }
 
 static void bad_segv(struct faultinfo fi, unsigned long ip)
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index d5fa494c2304..ae7b280f4971 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -845,12 +845,10 @@ void signal_fault(struct pt_regs *regs, void __user *frame, char *where)
 
 	if (show_unhandled_signals && printk_ratelimit()) {
 		printk("%s"
-		       "%s[%d] bad frame in %s frame:%p ip:%lx sp:%lx orax:%lx",
+		       "%s[%d] bad frame in %s frame:%p ip:%lx sp:%lx orax:%lx in %pv\n",
 		       task_pid_nr(current) > 1 ? KERN_INFO : KERN_EMERG,
 		       me->comm, me->pid, where, frame,
-		       regs->ip, regs->sp, regs->orig_ax);
-		print_vma_addr(KERN_CONT " in ", regs->ip);
-		pr_cont("\n");
+		       regs->ip, regs->sp, regs->orig_ax, (void *)regs->ip);
 	}
 
 	force_sig(SIGSEGV);
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 1f66d2d1e998..426324f93929 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -139,11 +139,9 @@ static void show_signal(struct task_struct *tsk, int signr,
 {
 	if (show_unhandled_signals && unhandled_signal(tsk, signr) &&
 	    printk_ratelimit()) {
-		pr_info("%s[%d] %s%s ip:%lx sp:%lx error:%lx",
+		pr_info("%s[%d] %s%s ip:%lx sp:%lx error:%lx in %pv\n",
 			tsk->comm, task_pid_nr(tsk), type, desc,
-			regs->ip, regs->sp, error_code);
-		print_vma_addr(KERN_CONT " in ", regs->ip);
-		pr_cont("\n");
+			regs->ip, regs->sp, error_code, (void *)regs->ip);
 	}
 }
 
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 35f1498e9832..01e9b0f12092 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -246,20 +246,22 @@ static void dump_pagetable(unsigned long address)
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+	char buffer[128] = '\0';
+	char *p = buffer;
+	char *end = buffer + sizeof(buffer) - 1;
 
 #ifdef CONFIG_X86_PAE
-	pr_info("*pdpt = %016Lx ", pgd_val(*pgd));
+	p += scnprintf(p, end - p, "%s*pdpt = %016llx",
+		       p == buffer ? "" : " ", pgd_val(*pgd));
 	if (!low_pfn(pgd_val(*pgd) >> PAGE_SHIFT) || !pgd_present(*pgd))
 		goto out;
-#define pr_pde pr_cont
-#else
-#define pr_pde pr_info
 #endif
 	p4d = p4d_offset(pgd, address);
 	pud = pud_offset(p4d, address);
 	pmd = pmd_offset(pud, address);
-	pr_pde("*pde = %0*Lx ", sizeof(*pmd) * 2, (u64)pmd_val(*pmd));
-#undef pr_pde
+	p += scnprintf(p, end - p, "%s*pde = %0*llx",
+		       p == buffer ? "" : " ",
+		       sizeof(*pmd) * 2, (u64)pmd_val(*pmd));
 
 	/*
 	 * We must not directly access the pte in the highpte
@@ -271,20 +273,12 @@ static void dump_pagetable(unsigned long address)
 		goto out;
 
 	pte = pte_offset_kernel(pmd, address);
-	pr_cont("*pte = %0*Lx ", sizeof(*pte) * 2, (u64)pte_val(*pte));
+	p += snprintf(p, end - p, "%s*pte = %0*llx",
+		      p == buffer ? "" : " ",
+		      sizeof(*pte) * 2, (u64)pte_val(*pte));
 out:
-	pr_cont("\n");
+	pr_info("%s\n", buffer);
 }
-
-#else /* CONFIG_X86_64: */
-
-#ifdef CONFIG_CPU_SUP_AMD
-static const char errata93_warning[] =
-KERN_ERR 
-"******* Your BIOS seems to not contain a fix for K8 errata #93\n"
-"******* Working around it, but it may cause SEGVs or burn power.\n"
-"******* Please consider a BIOS update.\n"
-"******* Disabling USB legacy in the BIOS may also help.\n";
 #endif
 
 /*
@@ -388,7 +382,11 @@ static int is_errata93(struct pt_regs *regs, unsigned long address)
 	address |= 0xffffffffUL << 32;
 	if ((address >= (u64)_stext && address <= (u64)_etext) ||
 	    (address >= MODULES_VADDR && address <= MODULES_END)) {
-		printk_once(errata93_warning);
+		pr_err_once(
+"******* Your BIOS seems to not contain a fix for K8 errata #93\n"
+"******* Working around it, but it may cause SEGVs or burn power.\n"
+"******* Please consider a BIOS update.\n"
+"******* Disabling USB legacy in the BIOS may also help.\n");
 		regs->ip = address;
 		return 1;
 	}
@@ -545,8 +543,8 @@ pgtable_bad(struct pt_regs *regs, unsigned long error_code,
 	tsk = current;
 	sig = SIGKILL;
 
-	printk(KERN_ALERT "%s: Corrupted page table at address %lx\n",
-	       tsk->comm, address);
+	pr_alert("%s: Corrupted page table at address %lx\n",
+		 tsk->comm, address);
 	dump_pagetable(address);
 
 	if (__die("Bad pagetable", regs, error_code))
@@ -688,7 +686,7 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 	show_fault_oops(regs, error_code, address);
 
 	if (task_stack_end_corrupted(tsk))
-		printk(KERN_EMERG "Thread overran stack, or stack corrupted\n");
+		pr_emerg("Thread overran stack, or stack corrupted\n");
 
 	sig = SIGKILL;
 	if (__die("Oops", regs, error_code))
@@ -716,13 +714,10 @@ show_signal_msg(struct pt_regs *regs, unsigned long error_code,
 	if (!printk_ratelimit())
 		return;
 
-	printk("%s%s[%d]: segfault at %lx ip %px sp %px error %lx",
-		loglvl, tsk->comm, task_pid_nr(tsk), address,
-		(void *)regs->ip, (void *)regs->sp, error_code);
-
-	print_vma_addr(KERN_CONT " in ", regs->ip);
-
-	printk(KERN_CONT "\n");
+	printk("%s%s[%d]: segfault at %lx ip %px sp %px error %lx in %pv\n",
+	       loglvl, tsk->comm, task_pid_nr(tsk), address,
+	       (void *)regs->ip, (void *)regs->sp, error_code,
+	       (void *)regs->ip);
 
 	show_opcodes(regs, loglvl);
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8ab941cf73f4..b04cd8a59c8b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2951,13 +2951,6 @@ extern int randomize_va_space;
 #endif
 
 const char * arch_vma_name(struct vm_area_struct *vma);
-#ifdef CONFIG_MMU
-void print_vma_addr(char *prefix, unsigned long rip);
-#else
-static inline void print_vma_addr(char *prefix, unsigned long rip)
-{
-}
-#endif
 
 void *sparse_buffer_alloc(unsigned long size);
 struct page * __populate_section_memmap(unsigned long pfn,
diff --git a/mm/memory.c b/mm/memory.c
index 747594f5225d..3df7a4a2b79c 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4836,39 +4836,6 @@ int access_process_vm(struct task_struct *tsk, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(access_process_vm);
 
-/*
- * Print the name of a VMA.
- */
-void print_vma_addr(char *prefix, unsigned long ip)
-{
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
-
-	/*
-	 * we might be running from an atomic context so we cannot sleep
-	 */
-	if (!mmap_read_trylock(mm))
-		return;
-
-	vma = find_vma(mm, ip);
-	if (vma && vma->vm_file) {
-		struct file *f = vma->vm_file;
-		char *buf = (char *)__get_free_page(GFP_NOWAIT);
-		if (buf) {
-			char *p;
-
-			p = file_path(f, buf, PAGE_SIZE);
-			if (IS_ERR(p))
-				p = "?";
-			printk("%s%s[%lx+%lx]", prefix, kbasename(p),
-					vma->vm_start,
-					vma->vm_end - vma->vm_start);
-			free_page((unsigned long)buf);
-		}
-	}
-	mmap_read_unlock(mm);
-}
-
 #if defined(CONFIG_PROVE_LOCKING) || defined(CONFIG_DEBUG_ATOMIC_SLEEP)
 void __might_fault(const char *file, int line)
 {


