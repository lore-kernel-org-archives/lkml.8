Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96814C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AD0B20781
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="UG1vmDDj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732855AbgFWQaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732224AbgFWQaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:30:09 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF75C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 09:30:09 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id b5so10076473pgm.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 09:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qVu9T6WkD9iz8UzYAGdnFb+cO+PXP0JZQ7M9blIu2Qw=;
        b=UG1vmDDjTolUaI3btyXj2KfqVrfM0mwE7LeFBLHLD7Va7CkLjF1wyqEH8cTyRm1jgF
         dgXaTLx5/39hCdBwasvQRgzRZb1cv7HR+OMPbLgLj7xGJ35xwSF5ddP9YXfpNZLp5LIP
         COHK/OHTOD5Yp557cmab2aPLl/0gih9xDzLWDubdEbiLmaK10W7i4x0iH6q5RBeGEuUc
         c48DbGXxQuXlv1MT0OqRQQcY3obvb2zNxF+Pm+/ryGzdjnVmjeemYIJHjiph9OpuJBM7
         QGcJ1DdQ56uMDJqh+KH1n4odXgXhzBZBoos/G1rBODQ+MkzziGOv2Y2sGhXg4GQj4Pls
         AZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qVu9T6WkD9iz8UzYAGdnFb+cO+PXP0JZQ7M9blIu2Qw=;
        b=ltM3BxwO4Dh+LcOauG/0SzH2TRumc5y1YAyLF1BCbQQe43Jq0Kx1rgSSKFmJ5LB2RX
         0z2oWcHdzYYQNaYqnbMteHjBUJPnskjHufDt2ItUOFzNVGcaXdc3OZX6Obxdl4ZrRcbk
         XlDSGqsUFOk3QR2IWK+ZInkHKonWDJwCTTGrqTk9XY3r2rQUwJvkGypqC5KeZ/EQHhvl
         RfA9d7+dZrkMIoU0HgG/SySuOxSclVaDCRPCN9rnTTOCEV7PQZCH1jfEmEHhWgb3HG+A
         AmPh6/N1HJHEoxdU8yv1/lvAiMbIpLGgbSmIFHJz4lfCzjKC8KpwdHrwItgv8EP12VJi
         nK9w==
X-Gm-Message-State: AOAM533yY9rMm4edALFqVNNEzQ8SiIimbUb9zS3W5a3IFo+KB9l2leLu
        Lk8rWkj3PydX7tnk6OrPCnewjrEvaWti91+0
X-Google-Smtp-Source: ABdhPJwncI/wXG+zZ7LwZfPu4CIjuQmbVKcfLlMKfLOMg9MgGsNr+8DxCKvxk4ULMtazKPMRvtKyyg==
X-Received: by 2002:a65:6119:: with SMTP id z25mr18624744pgu.52.1592929808263;
        Tue, 23 Jun 2020 09:30:08 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id n12sm13753969pgr.88.2020.06.23.09.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 09:30:07 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCH 1/3] x86/dumpstack: Add log_lvl to show_iret_regs()
Date:   Tue, 23 Jun 2020 17:29:56 +0100
Message-Id: <20200623162958.331051-2-dima@arista.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623162958.331051-1-dima@arista.com>
References: <20200623162958.331051-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

show_trace_log_lvl() provides x86 platform-specific way to unwind
backtrace with a given log level. Unfortunately, registers dump(s) are
not printed with the same log level - instead, KERN_DEFAULT is always
used.

Arista's switches uses quite common setup with rsyslog, where only
urgent messages goes to console (console_log_level=KERN_ERR), everything
else goes into /var/log/ as the console baud-rate often is indecently
slow (9600 bps).

Backtrace dumps without registers printed have proven to be as useful as
morning standups. Furthermore, in order to introduce KERN_UNSUPPRESSED
(which I believe is still the most elegant way to fix raciness of sysrq[1])
the log level should be passed down the stack to register dumping
functions. Besides, I have a potential use-case for printing traces
with KERN_DEBUG level [2] (where registers dump shouldn't appear with
higher log level).

Add log_lvl parameter to show_iret_regs() as a preparation to add it
to __show_regs() and show_regs_if_on_stack().

[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/
[2]: https://lore.kernel.org/linux-doc/20190724170249.9644-1-dima@arista.com/
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/include/asm/kdebug.h | 2 +-
 arch/x86/kernel/dumpstack.c   | 8 ++++----
 arch/x86/kernel/process_64.c  | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kdebug.h b/arch/x86/include/asm/kdebug.h
index 247ab14c6309..da024bbda6f4 100644
--- a/arch/x86/include/asm/kdebug.h
+++ b/arch/x86/include/asm/kdebug.h
@@ -37,7 +37,7 @@ void die_addr(const char *str, struct pt_regs *regs, long err, long gp_addr);
 extern int __must_check __die(const char *, struct pt_regs *, long);
 extern void show_stack_regs(struct pt_regs *regs);
 extern void __show_regs(struct pt_regs *regs, enum show_regs_mode);
-extern void show_iret_regs(struct pt_regs *regs);
+extern void show_iret_regs(struct pt_regs *regs, const char *log_lvl);
 extern unsigned long oops_begin(void);
 extern void oops_end(unsigned long, struct pt_regs *, int signr);
 
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index b037cfa7c0c5..c36d629a25a8 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -126,10 +126,10 @@ void show_ip(struct pt_regs *regs, const char *loglvl)
 	show_opcodes(regs, loglvl);
 }
 
-void show_iret_regs(struct pt_regs *regs)
+void show_iret_regs(struct pt_regs *regs, const char *log_lvl)
 {
-	show_ip(regs, KERN_DEFAULT);
-	printk(KERN_DEFAULT "RSP: %04x:%016lx EFLAGS: %08lx", (int)regs->ss,
+	show_ip(regs, log_lvl);
+	printk("%sRSP: %04x:%016lx EFLAGS: %08lx", log_lvl, (int)regs->ss,
 		regs->sp, regs->flags);
 }
 
@@ -155,7 +155,7 @@ static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
 		 * full pt_regs might not have been saved yet.  In that case
 		 * just print the iret frame.
 		 */
-		show_iret_regs(regs);
+		show_iret_regs(regs, KERN_DEFAULT);
 	}
 }
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 9a97415b2139..09bcb296cda6 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -69,7 +69,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode)
 	unsigned int fsindex, gsindex;
 	unsigned int ds, es;
 
-	show_iret_regs(regs);
+	show_iret_regs(regs, KERN_DEFAULT);
 
 	if (regs->orig_ax != -1)
 		pr_cont(" ORIG_RAX: %016lx\n", regs->orig_ax);
-- 
2.27.0

