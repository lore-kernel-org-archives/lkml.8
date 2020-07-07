Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18425C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D52ED20738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594151861;
	bh=ZRPqHjrjXQNzTnP+bbUN9VtxVwenujj/0ds3cIqTmts=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=lbO6+hTdgLCxcKqFajlhULVUFpjM1CBGvlDCb+maE1a5mTARK75gwBuyPceL9pYHm
	 /xFtO9ZA3lJxWkTDI9F/nNEjwU1b4F/QQVBfjoPax/fm0lvOBVQdAj3Jf5qPuWSO3p
	 dVovBihMGDSwTErvEOZ1Jf/D3PMDlym9dZ4zknaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgGGT5j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:57:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727908AbgGGT5j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:57:39 -0400
Received: from embeddedor (unknown [200.39.26.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 593472067D;
        Tue,  7 Jul 2020 19:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594151857;
        bh=ZRPqHjrjXQNzTnP+bbUN9VtxVwenujj/0ds3cIqTmts=;
        h=Date:From:To:Cc:Subject:From;
        b=1119twLO0cx59urQr+pBmRWcDvfwpDvXTEf2PtQuAYUJxRqwR5DrFagQ9Pfg4JgeC
         w4tKj3uwoS34zw3GkC1SeBlVGWw6ZB/ANjEuSLhBX24VO0L+yJYzrS6RIu3MV8PKl3
         LQWekwVvaxLvkVMK/Ma0giuXAg/r3za6XvTSTKFs=
Date:   Tue, 7 Jul 2020 15:03:03 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        "Gustavo A. R. Silva" <kernel.org@embeddedor>
Subject: [PATCH] x86: Use fallthrough pseudo-keyword
Message-ID: <20200707200303.GA4680@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
fall-through markings when it is the case.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/x86/boot/cmdline.c          |    4 ++--
 arch/x86/boot/compressed/kaslr.c |    2 +-
 arch/x86/kernel/alternative.c    |    3 +--
 arch/x86/kernel/apic/io_apic.c   |    4 ++--
 arch/x86/kernel/apic/probe_32.c  |    2 +-
 arch/x86/kernel/cpu/cacheinfo.c  |    2 +-
 arch/x86/kernel/cpu/mtrr/cyrix.c |    2 +-
 arch/x86/kernel/hw_breakpoint.c  |    2 +-
 arch/x86/kernel/kgdb.c           |    4 ++--
 arch/x86/kernel/mpparse.c        |    4 ++--
 arch/x86/kernel/ptrace.c         |    2 +-
 arch/x86/kernel/reboot.c         |    2 +-
 arch/x86/kernel/signal.c         |    2 +-
 arch/x86/kernel/uprobes.c        |    4 ++--
 arch/x86/lib/cmdline.c           |    8 ++++----
 arch/x86/lib/insn-eval.c         |    7 ++-----
 16 files changed, 25 insertions(+), 29 deletions(-)

diff --git a/arch/x86/boot/cmdline.c b/arch/x86/boot/cmdline.c
index 4ff01176c1cc..21d56ae83cdf 100644
--- a/arch/x86/boot/cmdline.c
+++ b/arch/x86/boot/cmdline.c
@@ -54,7 +54,7 @@ int __cmdline_find_option(unsigned long cmdline_ptr, const char *option, char *b
 			/* else */
 			state = st_wordcmp;
 			opptr = option;
-			/* fall through */
+			fallthrough;
 
 		case st_wordcmp:
 			if (c == '=' && !*opptr) {
@@ -129,7 +129,7 @@ int __cmdline_find_option_bool(unsigned long cmdline_ptr, const char *option)
 			state = st_wordcmp;
 			opptr = option;
 			wstart = pos;
-			/* fall through */
+			fallthrough;
 
 		case st_wordcmp:
 			if (!*opptr)
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index d7408af55738..de7115ff10ca 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -185,7 +185,7 @@ parse_memmap(char *p, unsigned long long *start, unsigned long long *size,
 			}
 			*size = 0;
 		}
-		/* Fall through */
+		fallthrough;
 	default:
 		/*
 		 * If w/o offset, only size specified, memmap=nn[KMG] has the
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 8fd39ff74a49..22155ac435fa 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -235,8 +235,7 @@ void __init arch_init_ideal_nops(void)
 			ideal_nops = p6_nops;
 			return;
 		}
-
-		/* fall through */
+		fallthrough;
 
 	default:
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index ce61e3e7d399..edfe05529fac 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -800,7 +800,7 @@ static int irq_polarity(int idx)
 		return IOAPIC_POL_HIGH;
 	case MP_IRQPOL_RESERVED:
 		pr_warn("IOAPIC: Invalid polarity: 2, defaulting to low\n");
-		/* fall through */
+		fallthrough;
 	case MP_IRQPOL_ACTIVE_LOW:
 	default: /* Pointless default required due to do gcc stupidity */
 		return IOAPIC_POL_LOW;
@@ -848,7 +848,7 @@ static int irq_trigger(int idx)
 		return IOAPIC_EDGE;
 	case MP_IRQTRIG_RESERVED:
 		pr_warn("IOAPIC: Invalid trigger mode 2 defaulting to level\n");
-		/* fall through */
+		fallthrough;
 	case MP_IRQTRIG_LEVEL:
 	default: /* Pointless default required due to do gcc stupidity */
 		return IOAPIC_LEVEL;
diff --git a/arch/x86/kernel/apic/probe_32.c b/arch/x86/kernel/apic/probe_32.c
index 67b33d67002f..4aea229ef8f4 100644
--- a/arch/x86/kernel/apic/probe_32.c
+++ b/arch/x86/kernel/apic/probe_32.c
@@ -148,7 +148,7 @@ void __init default_setup_apic_routing(void)
 				break;
 			}
 			/* P4 and above */
-			/* fall through */
+			fallthrough;
 		case X86_VENDOR_HYGON:
 		case X86_VENDOR_AMD:
 			def_to_bigsmp = 1;
diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index c7503be92f35..57074cf3ad7c 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -248,7 +248,7 @@ amd_cpuid4(int leaf, union _cpuid4_leaf_eax *eax,
 	switch (leaf) {
 	case 1:
 		l1 = &l1i;
-		/* fall through */
+		fallthrough;
 	case 0:
 		if (!l1->val)
 			return;
diff --git a/arch/x86/kernel/cpu/mtrr/cyrix.c b/arch/x86/kernel/cpu/mtrr/cyrix.c
index 72182809b333..ca670919b561 100644
--- a/arch/x86/kernel/cpu/mtrr/cyrix.c
+++ b/arch/x86/kernel/cpu/mtrr/cyrix.c
@@ -98,7 +98,7 @@ cyrix_get_free_region(unsigned long base, unsigned long size, int replace_reg)
 	case 7:
 		if (size < 0x40)
 			break;
-		/* Else, fall through */
+		fallthrough;
 	case 6:
 	case 5:
 	case 4:
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 8cdf29ffd95f..b98ff620ba77 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -349,7 +349,7 @@ static int arch_build_bp_info(struct perf_event *bp,
 			hw->len = X86_BREAKPOINT_LEN_X;
 			return 0;
 		}
-		/* fall through */
+		fallthrough;
 	default:
 		return -EINVAL;
 	}
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 68acd30c6b87..c2f02f308ecf 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -450,7 +450,7 @@ int kgdb_arch_handle_exception(int e_vector, int signo, int err_code,
 		ptr = &remcomInBuffer[1];
 		if (kgdb_hex2long(&ptr, &addr))
 			linux_regs->ip = addr;
-		/* fall through */
+		fallthrough;
 	case 'D':
 	case 'k':
 		/* clear the trace bit */
@@ -539,7 +539,7 @@ static int __kgdb_notify(struct die_args *args, unsigned long cmd)
 			 * a system call which should be ignored
 			 */
 			return NOTIFY_DONE;
-		/* fall through */
+		fallthrough;
 	default:
 		if (user_mode(regs))
 			return NOTIFY_DONE;
diff --git a/arch/x86/kernel/mpparse.c b/arch/x86/kernel/mpparse.c
index afac7ccce72f..55554be6c5e3 100644
--- a/arch/x86/kernel/mpparse.c
+++ b/arch/x86/kernel/mpparse.c
@@ -311,7 +311,7 @@ static void __init construct_default_ioirq_mptable(int mpc_default_type)
 		case 2:
 			if (i == 0 || i == 13)
 				continue;	/* IRQ0 & IRQ13 not connected */
-			/* fall through */
+			fallthrough;
 		default:
 			if (i == 2)
 				continue;	/* IRQ2 is never connected */
@@ -355,7 +355,7 @@ static void __init construct_ioapic_table(int mpc_default_type)
 	default:
 		pr_err("???\nUnknown standard configuration %d\n",
 		       mpc_default_type);
-		/* fall through */
+		fallthrough;
 	case 1:
 	case 5:
 		memcpy(bus.bustype, "ISA   ", 6);
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 44130588987f..00b06f5a28a5 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -204,7 +204,7 @@ static int set_segment_reg(struct task_struct *task,
 	case offsetof(struct user_regs_struct, ss):
 		if (unlikely(value == 0))
 			return -EIO;
-		/* Else, fall through */
+		fallthrough;
 
 	default:
 		*pt_regs_access(task_pt_regs(task), offset) = value;
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 0ec7ced727fe..a515e2d230b7 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -654,7 +654,7 @@ static void native_machine_emergency_restart(void)
 
 		case BOOT_CF9_FORCE:
 			port_cf9_safe = true;
-			/* Fall through */
+			fallthrough;
 
 		case BOOT_CF9_SAFE:
 			if (port_cf9_safe) {
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 399f97abee02..9497f96e62ba 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -725,7 +725,7 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 				regs->ax = -EINTR;
 				break;
 			}
-		/* fallthrough */
+			fallthrough;
 		case -ERESTARTNOINTR:
 			regs->ax = regs->orig_ax;
 			regs->ip -= 2;
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 15e5aad8ac2c..3fdaa042823d 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -735,7 +735,7 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 		 * OPCODE1() of the "short" jmp which checks the same condition.
 		 */
 		opc1 = OPCODE2(insn) - 0x10;
-		/* fall through */
+		fallthrough;
 	default:
 		if (!is_cond_jmp_opcode(opc1))
 			return -ENOSYS;
@@ -892,7 +892,7 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_struct *mm,
 			fix_ip_or_call = 0;
 			break;
 		}
-		/* fall through */
+		fallthrough;
 	default:
 		riprel_analyze(auprobe, &insn);
 	}
diff --git a/arch/x86/lib/cmdline.c b/arch/x86/lib/cmdline.c
index 4f1719e22d3c..b6da09339308 100644
--- a/arch/x86/lib/cmdline.c
+++ b/arch/x86/lib/cmdline.c
@@ -58,7 +58,7 @@ __cmdline_find_option_bool(const char *cmdline, int max_cmdline_size,
 			state = st_wordcmp;
 			opptr = option;
 			wstart = pos;
-			/* fall through */
+			fallthrough;
 
 		case st_wordcmp:
 			if (!*opptr) {
@@ -89,7 +89,7 @@ __cmdline_find_option_bool(const char *cmdline, int max_cmdline_size,
 				break;
 			}
 			state = st_wordskip;
-			/* fall through */
+			fallthrough;
 
 		case st_wordskip:
 			if (!c)
@@ -151,7 +151,7 @@ __cmdline_find_option(const char *cmdline, int max_cmdline_size,
 
 			state = st_wordcmp;
 			opptr = option;
-			/* fall through */
+			fallthrough;
 
 		case st_wordcmp:
 			if ((c == '=') && !*opptr) {
@@ -172,7 +172,7 @@ __cmdline_find_option(const char *cmdline, int max_cmdline_size,
 				break;
 			}
 			state = st_wordskip;
-			/* fall through */
+			fallthrough;
 
 		case st_wordskip:
 			if (myisspace(c))
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 31600d851fd8..9c9a58d81ebe 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -178,8 +178,7 @@ static int resolve_default_seg(struct insn *insn, struct pt_regs *regs, int off)
 		/* Need insn to verify address size. */
 		if (insn->addr_bytes == 2)
 			return -EINVAL;
-
-		/* fall through */
+		fallthrough;
 
 	case -EDOM:
 	case offsetof(struct pt_regs, bx):
@@ -362,7 +361,6 @@ static short get_segment_selector(struct pt_regs *regs, int seg_reg_idx)
 		case INAT_SEG_REG_GS:
 			return vm86regs->gs;
 		case INAT_SEG_REG_IGNORE:
-			/* fall through */
 		default:
 			return -EINVAL;
 		}
@@ -386,7 +384,6 @@ static short get_segment_selector(struct pt_regs *regs, int seg_reg_idx)
 		 */
 		return get_user_gs(regs);
 	case INAT_SEG_REG_IGNORE:
-		/* fall through */
 	default:
 		return -EINVAL;
 	}
@@ -786,7 +783,7 @@ int insn_get_code_seg_params(struct pt_regs *regs)
 		 */
 		return INSN_CODE_SEG_PARAMS(4, 8);
 	case 3: /* Invalid setting. CS.L=1, CS.D=1 */
-		/* fall through */
+		fallthrough;
 	default:
 		return -EINVAL;
 	}

