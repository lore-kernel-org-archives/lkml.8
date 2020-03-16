Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C826C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9C72051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="nbZZnEfp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbgCPOmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:42:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43766 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731572AbgCPOmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:42:32 -0400
Received: by mail-pf1-f195.google.com with SMTP id c144so10044802pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GhueJ2UaCVVW7Jyga88aLo/nozhuiEf837Up/fVHxxg=;
        b=nbZZnEfpe30zxeTfvl8tIoz1njbVN/iTYl8M2UYWl62nziJhFMCbpmew3v/2juc1BR
         9flWs3A6Obwjpmo+9zCZa3JrRD2UPon2DEvBclQC626JfAyf3+2l4uS0Beq8oeyfpObs
         Ht41RPs+jOP6lsVVui9MBFY81/NIUMYOLr4cDqtWzxItZ0dUKyPdEVFIqOvQWaAv69gg
         2ebyQ5oVUEUL9hF63TR/KW2eJieRD6EyHJcTWG62tzRpMI3c2uCQYuOi+rXaWrN5shu4
         72H/U+QICUCW7FlEypQu47EfEuhN2gW3mjFJ4WDuiDZLe/K/wEzb6/ANBdbrjs6RJ9Ss
         5QTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GhueJ2UaCVVW7Jyga88aLo/nozhuiEf837Up/fVHxxg=;
        b=jtoOtE7g0+Ew9EZuHOngHDODy//4+wX4VdRX5WXIEN2AjKh7KSLwp1PqH93O8GgVkO
         rLJgpe03MVPvutk2ioSzhNNb3KwPJX+mSGp0r0iSBMgxFxWVmj7Sl21qS0Qdic9GEWwy
         EotEqIpb+Wql9QMNcMxFdfX62ple1JO4iB0bv5x56pCSpi+OGsXrOkhOsm+u/lrmaC9Q
         zNwfMfRLYOcCC+GrM/Fas58OTxqRTMUww9rsu9F8lauTML2b/w9RdlpL2wFSDpX/H8HO
         Zm6ca1HGVMhm+sz5nx/aK2bwPEHDIXXmJSG604vTN++vS1IChURtNG5fEEfFvxa/NF5Z
         odeA==
X-Gm-Message-State: ANhLgQ0MukzFzd3TrvJrhcS6u6AT9RdfT3RO+aSEkcGobSZJojuhwWtS
        Vs9pI9dGZdLfDX2jyHt0cQdGm7LeswBy5w==
X-Google-Smtp-Source: ADFU+vsjDiLl9tQ0Z1KuciKBpteb74fnKOsVIpvO3z/lMYO+KoUVtUwwVr5UAEryLwEW76L65VKoZw==
X-Received: by 2002:a63:68a:: with SMTP id 132mr234723pgg.12.1584369751078;
        Mon, 16 Mar 2020 07:42:31 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:42:30 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Guan Xuetao <gxt@pku.edu.cn>
Subject: [PATCHv2 38/50] unicore32: Add loglvl to c_backtrace()
Date:   Mon, 16 Mar 2020 14:39:04 +0000
Message-Id: <20200316143916.195608-39-dima@arista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316143916.195608-1-dima@arista.com>
References: <20200316143916.195608-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the log-level of show_stack() depends on a platform
realization. It creates situations where the headers are printed with
lower log level or higher than the stacktrace (depending on
a platform or user).

Furthermore, it forces the logic decision from user to an architecture
side. In result, some users as sysrq/kdb/etc are doing tricks with
temporary rising console_loglevel while printing their messages.
And in result it not only may print unwanted messages from other CPUs,
but also omit printing at all in the unlucky case where the printk()
was deferred.

Introducing log-level parameter and KERN_UNSUPPRESSED [1] seems
an easier approach than introducing more printk buffers.
Also, it will consolidate printings with headers.

Add log level parameter to c_backtrace() as a preparation for
introducing show_stack_loglvl()

Cc: Guan Xuetao <gxt@pku.edu.cn>
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/unicore32/kernel/setup.h  |  2 +-
 arch/unicore32/kernel/traps.c  |  2 +-
 arch/unicore32/lib/backtrace.S | 24 ++++++++++++++++--------
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/unicore32/kernel/setup.h b/arch/unicore32/kernel/setup.h
index 03e70e37f472..967352323185 100644
--- a/arch/unicore32/kernel/setup.h
+++ b/arch/unicore32/kernel/setup.h
@@ -29,7 +29,7 @@ extern void kernel_thread_helper(void);
 extern void __init early_signal_init(void);
 
 extern asmlinkage void __backtrace(void);
-extern asmlinkage void c_backtrace(unsigned long fp);
+extern asmlinkage void c_backtrace(unsigned long fp, const char *loglvl);
 
 extern void __show_regs(struct pt_regs *);
 
diff --git a/arch/unicore32/kernel/traps.c b/arch/unicore32/kernel/traps.c
index 3682a4c5d927..2b7d73456865 100644
--- a/arch/unicore32/kernel/traps.c
+++ b/arch/unicore32/kernel/traps.c
@@ -163,7 +163,7 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 	printk("\n");
 
 	if (ok)
-		c_backtrace(fp);
+		c_backtrace(fp, KERN_DEFAULT);
 }
 
 void show_stack(struct task_struct *tsk, unsigned long *sp)
diff --git a/arch/unicore32/lib/backtrace.S b/arch/unicore32/lib/backtrace.S
index f303671e2a4e..6221944b81f3 100644
--- a/arch/unicore32/lib/backtrace.S
+++ b/arch/unicore32/lib/backtrace.S
@@ -16,6 +16,7 @@
 #define sv_fp	v5
 #define sv_pc	v6
 #define offset	v8
+#define loglvl	v9
 
 ENTRY(__backtrace)
 		mov	r0, fp
@@ -27,10 +28,11 @@ ENTRY(c_backtrace)
 ENDPROC(__backtrace)
 ENDPROC(c_backtrace)
 #else
-		stm.w	(v4 - v8, lr), [sp-]	@ Save an extra register
+		stm.w	(v4 - v10, lr), [sp-]	@ Save an extra register
 						@ so we have a location...
 		mov.a	frame, r0		@ if frame pointer is zero
 		beq	no_frame		@ we have no stack frames
+		mov	loglvl, r1
 
 1:		stm.w	(pc), [sp-]		@ calculate offset of PC stored
 		ldw.w	r0, [sp]+, #4		@ by stmfd for this CPU
@@ -95,9 +97,10 @@ for_each_frame:
 		bua	for_each_frame
 
 1006:		adr	r0, .Lbad
-		mov	r1, frame
+		mov	r1, loglvl
+		mov	r2, frame
 		b.l	printk
-no_frame:	ldm.w	(v4 - v8, pc), [sp]+
+no_frame:	ldm.w	(v4 - v10, pc), [sp]+
 ENDPROC(__backtrace)
 ENDPROC(c_backtrace)
 
@@ -128,8 +131,11 @@ ENDPROC(c_backtrace)
 		add	v7, v7, #1
 		cxor.a	v7, #6
 		cmoveq	v7, #1
-		cmoveq	r1, #'\n'
-		cmovne	r1, #' '
+		bne	201f
+		adr	r0, .Lcr
+		mov	r1, loglvl
+		b.l	printk
+201:
 		ldw.w	r3, [stack]+, #-4
 		mov	r2, reg
 		csub.a	r2, #8
@@ -141,18 +147,20 @@ ENDPROC(c_backtrace)
 		add	r2, r2, #0x10		@ so r2 need add 16
 201:
 		adr	r0, .Lfp
+		mov	r1, loglvl
 		b.l	printk
 2:		sub.a	reg, reg, #1
 		bns	1b
 		cxor.a	v7, #0
 		beq	201f
 		adr	r0, .Lcr
+		mov	r1, loglvl
 		b.l	printk
 201:		ldm.w	(instr, reg, stack, v7, pc), [sp]+
 
-.Lfp:		.asciz	"%cr%d:%08x"
-.Lcr:		.asciz	"\n"
-.Lbad:		.asciz	"Backtrace aborted due to bad frame pointer <%p>\n"
+.Lfp:		.asciz	"%sr%d:%08x "
+.Lcr:		.asciz	"%s\n"
+.Lbad:		.asciz	"%sBacktrace aborted due to bad frame pointer <%p>\n"
 		.align
 .Ldsi:		.word	0x92eec000 >> 14	@ stm.w sp, (... fp, ip, lr, pc)
 		.word	0x92e10000 >> 14	@ stm.w sp, ()
-- 
2.25.1

