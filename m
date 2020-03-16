Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDCDC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DEC20658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="gRc57iMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731818AbgCPOll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:41:41 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41928 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731579AbgCPOlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:41:40 -0400
Received: by mail-pl1-f195.google.com with SMTP id t16so1080504plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PrRWtisVKQ94pKXrJwec31ZQ/jHPz3Z7raovDWXjHAI=;
        b=gRc57iMdgMfQShHD5ogrtuY1nwAZiA949gwYJ3axoh4dkSv5gQuvh1Vv/0wkrP1Bme
         CHleOLeXuNDpbOZaOPOE+TOQkGJHpYHIxxvsmo7tS87qVo4U8qfnumGodT0CL/IeN1Gp
         Z5roUN/+9ZxdgtFsggMNELdPbbDhA/5webr93q0sXNzLV/IOqZneRxgGQoEb9MCGvpEM
         OHKdsObFtZ4ZFJ6uEbpyk/d/zxC+eGZYYV0Vc3HE6ci3qaDAGw7mHqVwz22y4k6eBSp+
         nFJfgRb0vGYnJVXfawhhzzgA5Mblhi4TwcAHN6C+joc8MenudRLzTL+zt4wmj1m70cMX
         uB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PrRWtisVKQ94pKXrJwec31ZQ/jHPz3Z7raovDWXjHAI=;
        b=uhxDJ9smQZpIm/thIyC9r74xi8z6gnPjw/JU6JGAXA6gQ3RLrsX5WhOf7slr9pcXex
         RTI/a4r6U2X0twd4VhU6MI94Qn5pxhcR43thi5etHumMbRKhnePO2sQuSQgO1L+ntHy6
         fZwv6iyxYC+Rbpj3UJSvaAxSIBp2RasakswSn8r8D3HmVHqblqhHLkmlz5blnqAdGZSu
         RHqrNTv+eJ7qJx8VvfJ+VsPwgeENyW/CGOhnStuKAdZK1vQ4ZTykyIrTyDKa4dlUxRdC
         OzYBGte41ZRYJfiaEnDJwWk1JkIHS2M1zb7Sr8OdBq9Lu0OTX3OChXRR1OrMX1bpknsF
         fsqw==
X-Gm-Message-State: ANhLgQ2DMvFj3fXTOdO+xaiLNLENC/Ft//GvEME2cQGs/2I35Sz6Srjl
        vlBuqr9ml1F4I1XZh6PysdaX21tBw9diwg==
X-Google-Smtp-Source: ADFU+vtZv0iBny86J6iQVSKWaOkHToZN9+OkfUszdLpOg/nq4shB1QMB8Ns0F3xU5tT/5q1A/EU8/A==
X-Received: by 2002:a17:902:724c:: with SMTP id c12mr3075274pll.60.1584369699128;
        Mon, 16 Mar 2020 07:41:39 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:41:38 -0700 (PDT)
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCHv2 26/50] powerpc: Add show_stack_loglvl()
Date:   Mon, 16 Mar 2020 14:38:52 +0000
Message-Id: <20200316143916.195608-27-dima@arista.com>
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

Introduce show_stack_loglvl(), that eventually will substitute
show_stack().

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/powerpc/kernel/process.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index fad50db9dcf2..c1ab7f613da4 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -2034,7 +2034,8 @@ unsigned long get_wchan(struct task_struct *p)
 
 static int kstack_depth_to_print = CONFIG_PRINT_STACK_DEPTH;
 
-void show_stack(struct task_struct *tsk, unsigned long *stack)
+void show_stack_loglvl(struct task_struct *tsk, unsigned long *stack,
+		       const char *loglvl)
 {
 	unsigned long sp, ip, lr, newsp;
 	int count = 0;
@@ -2059,7 +2060,7 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 	}
 
 	lr = 0;
-	printk("Call Trace:\n");
+	printk("%sCall Trace:\n", loglvl);
 	do {
 		if (!validate_sp(sp, tsk, STACK_FRAME_OVERHEAD))
 			break;
@@ -2068,7 +2069,8 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 		newsp = stack[0];
 		ip = stack[STACK_FRAME_LR_SAVE];
 		if (!firstframe || ip != lr) {
-			printk("["REG"] ["REG"] %pS", sp, ip, (void *)ip);
+			printk("%s["REG"] ["REG"] %pS",
+				loglvl, sp, ip, (void *)ip);
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 			ret_addr = ftrace_graph_ret_addr(current,
 						&ftrace_idx, ip, stack);
@@ -2090,8 +2092,9 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 			struct pt_regs *regs = (struct pt_regs *)
 				(sp + STACK_FRAME_OVERHEAD);
 			lr = regs->link;
-			printk("--- interrupt: %lx at %pS\n    LR = %pS\n",
-			       regs->trap, (void *)regs->nip, (void *)lr);
+			printk("%s--- interrupt: %lx at %pS\n    LR = %pS\n",
+			       loglvl, regs->trap,
+			       (void *)regs->nip, (void *)lr);
 			firstframe = 1;
 		}
 
@@ -2101,6 +2104,11 @@ void show_stack(struct task_struct *tsk, unsigned long *stack)
 	put_task_stack(tsk);
 }
 
+void show_stack(struct task_struct *tsk, unsigned long *stack)
+{
+	show_stack_loglvl(tsk, stack, KERN_DEFAULT);
+}
+
 #ifdef CONFIG_PPC64
 /* Called with hard IRQs off */
 void notrace __ppc64_runlatch_on(void)
-- 
2.25.1

