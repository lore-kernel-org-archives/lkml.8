Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A42C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 137E22051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Jk9g1oUN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbgCPOkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:40:13 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:50918 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731572AbgCPOkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:40:11 -0400
Received: by mail-pj1-f65.google.com with SMTP id o23so2702258pjp.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NTTI3yeeENs2ZgUYcRA67its707iG/GndxpZmZw7i/c=;
        b=Jk9g1oUNFqnrxDjJjiHsiZmC4IEi4NNiURUYTAbuBjADgpPEe2ER75XEbFXwxLgdzc
         EFpD7ogpTsYeloXgC70ErIaA94WpDZnQUm3mVWdn+qoLWpQIqdWn/p4RIUMFC2RgKr1S
         ilBB6T1nv+ru4Qg1whMKn71h3wu12lQBzNSHjJzdwYMWocfPxkp2J+YwTxr7qa5Zmh0Z
         bltg4MN4hrMmRefnpiBA09URG8ZTpda1kP0IwuEl5YrrPplA0kqlOgKGGxDFTgUR11QH
         TEkoJ3Xcls/wzi9r1CCQKbmA2JWd/t5lGLasBpMAL2yyuiaJKR2dAPyYWwoGFQUySS/Y
         FGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NTTI3yeeENs2ZgUYcRA67its707iG/GndxpZmZw7i/c=;
        b=E3AVM40qSNq8KtpoP48GmTADSbjj/nPiXoYFvSkN2W3Ne3IHM1vb0XcX9hkAUTlHbG
         jt7C8t++hmXrui3bq398GItSNaKxZUhE9/CUB0EAsEWbewapVQG0hLtcWhuF9E58ir+E
         dp63O6TgKXWbfju2A1bX2/4e7SuzcMCf0mNkUcUGKdf1gGczlEUKNtFvuTLOoob5LOz/
         d9nqiTqZeU3T6wStUKCxCUEj53C3NzWvQPCMrp96X0lFHPr5wSlfHpaggPoNI0CXQXaA
         K4kttzwOwroWOAW+RMi2NffXktchUgy6lyjTSFSUUTGr2sEtpCHXwxSuRN4e0xxQPCVO
         jCaw==
X-Gm-Message-State: ANhLgQ2RCzwSoQuW1RONLd75cFpazvDRFoT/B42k9TM+dYeUZYv5QdRs
        h9we85s5ZMU/vVVPx9ZP7r2F9VqaBYc9/Q==
X-Google-Smtp-Source: ADFU+vs61F04BWjvxDCeZwFtjsQYjDIVpWt/23PJlfO2bLlD7Ck7GLB062kqMhXBrKwYN+ji9n4JWg==
X-Received: by 2002:a17:902:bccc:: with SMTP id o12mr5824551pls.96.1584369609808;
        Mon, 16 Mar 2020 07:40:09 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:40:09 -0700 (PDT)
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
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com
Subject: [PATCHv2 06/50] arm: Add loglvl to dump_backtrace()
Date:   Mon, 16 Mar 2020 14:38:32 +0000
Message-Id: <20200316143916.195608-7-dima@arista.com>
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

Add log level argument to dump_backtrace() as a preparation for
introducing show_stack_loglvl().

As a good side-effect __die() now prints not only "Stack:" header with
KERN_EMERG, but the backtrace itself.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: clang-built-linux@googlegroups.com
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm/kernel/traps.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 685e17c2e275..0f09ace18e6c 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -202,17 +202,19 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
 }
 
 #ifdef CONFIG_ARM_UNWIND
-static inline void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
+static inline void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
+				  const char *loglvl)
 {
-	unwind_backtrace(regs, tsk, KERN_DEFAULT);
+	unwind_backtrace(regs, tsk, loglvl);
 }
 #else
-static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
+static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
+			   const char *loglvl)
 {
 	unsigned int fp, mode;
 	int ok = 1;
 
-	printk("Backtrace: ");
+	printk("%sBacktrace: ", loglvl);
 
 	if (!tsk)
 		tsk = current;
@@ -239,13 +241,13 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 	pr_cont("\n");
 
 	if (ok)
-		c_backtrace(fp, mode, NULL);
+		c_backtrace(fp, mode, loglvl);
 }
 #endif
 
 void show_stack(struct task_struct *tsk, unsigned long *sp)
 {
-	dump_backtrace(NULL, tsk);
+	dump_backtrace(NULL, tsk, KERN_DEFAULT);
 	barrier();
 }
 
@@ -289,7 +291,7 @@ static int __die(const char *str, int err, struct pt_regs *regs)
 	if (!user_mode(regs) || in_interrupt()) {
 		dump_mem(KERN_EMERG, "Stack: ", regs->ARM_sp,
 			 THREAD_SIZE + (unsigned long)task_stack_page(tsk));
-		dump_backtrace(regs, tsk);
+		dump_backtrace(regs, tsk, KERN_EMERG);
 		dump_instr(KERN_EMERG, regs);
 	}
 
-- 
2.25.1

