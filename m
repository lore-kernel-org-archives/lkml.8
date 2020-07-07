Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09357C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D24AC206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 17:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594142351;
	bh=UI6ad7jF+GLOgLZjqwH7py9rzEms/ROJb7QA5wR5xgk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=S6BpLMqtMQX13ZP0SiLFgeJGcZPf9cvDSKOSyTQD3NC8902h9MqXcaiyxP6enDHoR
	 LBRCzKpyOyLNRMSlsTMLf//oaR/ZdnbCqP7Jgd/qAbbBFYn5d+NK/AIY+EbpkUiHF7
	 0wLt924rm6YcOw7ISk6CLQaYlFXc+tIssTrZNVns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgGGRTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 13:19:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727886AbgGGRTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 13:19:10 -0400
Received: from embeddedor (unknown [200.39.26.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F734206C3;
        Tue,  7 Jul 2020 17:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594142349;
        bh=UI6ad7jF+GLOgLZjqwH7py9rzEms/ROJb7QA5wR5xgk=;
        h=Date:From:To:Cc:Subject:From;
        b=ZSyuTZ6EI24W2lQFqC5tugp4B+j3WbMCzNaJsmb+4wy+MKNIjYTO4a14tOCIu9L4v
         +M3NYX7Th3J3RntZFay5DBm7cu75ivq7ciStXnRAycFHcd44cGXqObLLFWkq7WM8QU
         UMGv2QE2wvZsYpmb8rnjJrHPuIymJnDP2vsDLzhU=
Date:   Tue, 7 Jul 2020 12:24:36 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] sparc: Use fallthrough pseudo-keyword
Message-ID: <20200707172436.GA27273@embeddedor>
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
 arch/sparc/kernel/auxio_64.c  |    1 -
 arch/sparc/kernel/central.c   |    2 +-
 arch/sparc/kernel/kgdb_32.c   |    2 +-
 arch/sparc/kernel/kgdb_64.c   |    2 +-
 arch/sparc/kernel/pcr.c       |    2 +-
 arch/sparc/kernel/prom_32.c   |    2 +-
 arch/sparc/kernel/signal32.c  |    4 ++--
 arch/sparc/kernel/signal_32.c |    4 ++--
 arch/sparc/kernel/signal_64.c |    4 ++--
 arch/sparc/math-emu/math_32.c |    8 ++++----
 10 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/kernel/auxio_64.c b/arch/sparc/kernel/auxio_64.c
index 4843f48bfe85..774a82b0c649 100644
--- a/arch/sparc/kernel/auxio_64.c
+++ b/arch/sparc/kernel/auxio_64.c
@@ -87,7 +87,6 @@ void auxio_set_lte(int on)
 		__auxio_sbus_set_lte(on);
 		break;
 	case AUXIO_TYPE_EBUS:
-		/* FALL-THROUGH */
 	default:
 		break;
 	}
diff --git a/arch/sparc/kernel/central.c b/arch/sparc/kernel/central.c
index bfae98ab8638..23f8838dd96e 100644
--- a/arch/sparc/kernel/central.c
+++ b/arch/sparc/kernel/central.c
@@ -55,7 +55,7 @@ static int clock_board_calc_nslots(struct clock_board *p)
 			else
 				return 5;
 		}
-		/* Fallthrough */
+		fallthrough;
 	default:
 		return 4;
 	}
diff --git a/arch/sparc/kernel/kgdb_32.c b/arch/sparc/kernel/kgdb_32.c
index 7580775a14b9..58ad3f7de1fb 100644
--- a/arch/sparc/kernel/kgdb_32.c
+++ b/arch/sparc/kernel/kgdb_32.c
@@ -122,7 +122,7 @@ int kgdb_arch_handle_exception(int e_vector, int signo, int err_code,
 			linux_regs->pc = addr;
 			linux_regs->npc = addr + 4;
 		}
-		/* fall through */
+		fallthrough;
 
 	case 'D':
 	case 'k':
diff --git a/arch/sparc/kernel/kgdb_64.c b/arch/sparc/kernel/kgdb_64.c
index 5d6c2d287e85..177746ae2c81 100644
--- a/arch/sparc/kernel/kgdb_64.c
+++ b/arch/sparc/kernel/kgdb_64.c
@@ -148,7 +148,7 @@ int kgdb_arch_handle_exception(int e_vector, int signo, int err_code,
 			linux_regs->tpc = addr;
 			linux_regs->tnpc = addr + 4;
 		}
-		/* fall through */
+		fallthrough;
 
 	case 'D':
 	case 'k':
diff --git a/arch/sparc/kernel/pcr.c b/arch/sparc/kernel/pcr.c
index c0886b400dad..2a12c86af956 100644
--- a/arch/sparc/kernel/pcr.c
+++ b/arch/sparc/kernel/pcr.c
@@ -359,7 +359,7 @@ int __init pcr_arch_init(void)
 		 * counter overflow interrupt so we can't make use of
 		 * their hardware currently.
 		 */
-		/* fallthrough */
+		fallthrough;
 	default:
 		err = -ENODEV;
 		goto out_unregister;
diff --git a/arch/sparc/kernel/prom_32.c b/arch/sparc/kernel/prom_32.c
index da8902295c8c..3df960c137f7 100644
--- a/arch/sparc/kernel/prom_32.c
+++ b/arch/sparc/kernel/prom_32.c
@@ -224,7 +224,7 @@ void __init of_console_init(void)
 
 		case PROMDEV_TTYB:
 			skip = 1;
-			/* FALLTHRU */
+			fallthrough;
 
 		case PROMDEV_TTYA:
 			type = "serial";
diff --git a/arch/sparc/kernel/signal32.c b/arch/sparc/kernel/signal32.c
index e2c6f0abda00..e9695a06492f 100644
--- a/arch/sparc/kernel/signal32.c
+++ b/arch/sparc/kernel/signal32.c
@@ -646,7 +646,7 @@ static inline void syscall_restart32(unsigned long orig_i0, struct pt_regs *regs
 	case ERESTARTSYS:
 		if (!(sa->sa_flags & SA_RESTART))
 			goto no_system_call_restart;
-		/* fallthrough */
+		fallthrough;
 	case ERESTARTNOINTR:
 		regs->u_regs[UREG_I0] = orig_i0;
 		regs->tpc -= 4;
@@ -686,7 +686,7 @@ void do_signal32(struct pt_regs * regs)
 				regs->tpc -= 4;
 				regs->tnpc -= 4;
 				pt_regs_clear_syscall(regs);
-				/* fall through */
+				fallthrough;
 			case ERESTART_RESTARTBLOCK:
 				regs->u_regs[UREG_G1] = __NR_restart_syscall;
 				regs->tpc -= 4;
diff --git a/arch/sparc/kernel/signal_32.c b/arch/sparc/kernel/signal_32.c
index 3b005b6c3e0f..e08d294d63e4 100644
--- a/arch/sparc/kernel/signal_32.c
+++ b/arch/sparc/kernel/signal_32.c
@@ -441,7 +441,7 @@ static inline void syscall_restart(unsigned long orig_i0, struct pt_regs *regs,
 	case ERESTARTSYS:
 		if (!(sa->sa_flags & SA_RESTART))
 			goto no_system_call_restart;
-		/* fallthrough */
+		fallthrough;
 	case ERESTARTNOINTR:
 		regs->u_regs[UREG_I0] = orig_i0;
 		regs->pc -= 4;
@@ -507,7 +507,7 @@ static void do_signal(struct pt_regs *regs, unsigned long orig_i0)
 				regs->pc -= 4;
 				regs->npc -= 4;
 				pt_regs_clear_syscall(regs);
-				/* fall through */
+				fallthrough;
 			case ERESTART_RESTARTBLOCK:
 				regs->u_regs[UREG_G1] = __NR_restart_syscall;
 				regs->pc -= 4;
diff --git a/arch/sparc/kernel/signal_64.c b/arch/sparc/kernel/signal_64.c
index 6937339a272c..255264bcb46a 100644
--- a/arch/sparc/kernel/signal_64.c
+++ b/arch/sparc/kernel/signal_64.c
@@ -461,7 +461,7 @@ static inline void syscall_restart(unsigned long orig_i0, struct pt_regs *regs,
 	case ERESTARTSYS:
 		if (!(sa->sa_flags & SA_RESTART))
 			goto no_system_call_restart;
-		/* fallthrough */
+		fallthrough;
 	case ERESTARTNOINTR:
 		regs->u_regs[UREG_I0] = orig_i0;
 		regs->tpc -= 4;
@@ -532,7 +532,7 @@ static void do_signal(struct pt_regs *regs, unsigned long orig_i0)
 				regs->tpc -= 4;
 				regs->tnpc -= 4;
 				pt_regs_clear_syscall(regs);
-				/* fall through */
+				fallthrough;
 			case ERESTART_RESTARTBLOCK:
 				regs->u_regs[UREG_G1] = __NR_restart_syscall;
 				regs->tpc -= 4;
diff --git a/arch/sparc/math-emu/math_32.c b/arch/sparc/math-emu/math_32.c
index 72e560ef4a09..d5beec856146 100644
--- a/arch/sparc/math-emu/math_32.c
+++ b/arch/sparc/math-emu/math_32.c
@@ -359,7 +359,7 @@ static int do_one_mathemu(u32 insn, unsigned long *pfsr, unsigned long *fregs)
 			*pfsr |= (6 << 14);
 			return 0;			/* simulate invalid_fp_register exception */
 		}
-	/* fall through */
+		fallthrough;
 	case 2:
 		if (freg & 1) {				/* doublewords must have bit 5 zeroed */
 			*pfsr |= (6 << 14);
@@ -380,7 +380,7 @@ static int do_one_mathemu(u32 insn, unsigned long *pfsr, unsigned long *fregs)
 			*pfsr |= (6 << 14);
 			return 0;			/* simulate invalid_fp_register exception */
 		}
-	/* fall through */
+		fallthrough;
 	case 2:
 		if (freg & 1) {				/* doublewords must have bit 5 zeroed */
 			*pfsr |= (6 << 14);
@@ -408,13 +408,13 @@ static int do_one_mathemu(u32 insn, unsigned long *pfsr, unsigned long *fregs)
 			*pfsr |= (6 << 14);
 			return 0;			/* simulate invalid_fp_register exception */
 		}
-	/* fall through */
+		fallthrough;
 	case 2:
 		if (freg & 1) {				/* doublewords must have bit 5 zeroed */
 			*pfsr |= (6 << 14);
 			return 0;
 		}
-	/* fall through */
+		fallthrough;
 	case 1:
 		rd = (void *)&fregs[freg];
 		break;

