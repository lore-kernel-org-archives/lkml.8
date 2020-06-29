Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811B8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 621D220702
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="mTt0U253"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387503AbgF2Tio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387444AbgF2Tho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:37:44 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F6BC02F009
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:48:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f18so8779607wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J1b86M2kh+1MpYf87oEIYf85WBywI0oiPr8KJ9u58RI=;
        b=mTt0U2539j5JvdQ25iF95WWG5+lHlxdXutNDjMkP6EFt+W8GZIFO426Sm6JsTMXxhV
         H/o6hpyBaf2yA4T+L3Sd7nT9bwM3Vv4vhT9inN7nT9gCJctGewOEO4/aEjsgshwNxlL0
         yd/9umoADm+/qvTR21Bm2NmxnIzXYoRkXoSRpoFCxj4LPf++gzBL3XnB/O/hE68fpbMS
         CGR4YmgDO2U3f10wGrKlvP9rbyQH5jERVwTQDdBsWU/utrL8Q6eVxztVvRtdHNxP7iRX
         5L6DXjvqD3Fi8o4Q7rhoIaIG3dZN/1nTSwTj8hGX93LicI80Y0bGgPB03XjaHX/241Av
         6clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J1b86M2kh+1MpYf87oEIYf85WBywI0oiPr8KJ9u58RI=;
        b=rNkMPrfXJNHiCbIlByucGAdxXrv+qb8UJymDCNx3TryrqOUMfwmdzh5DihY8vO/Cvn
         resEbR32Lgarfeez8XvWyRy7w3EPTAZISi4Dsa1qw6nO8t0Ok8vpLefJz+4RPYDfoJQj
         ZV9RBakljlplsu+IAZnLnpCkizurQKUs6Ql34cSN5u9LLVFH+1iw6NvZJr7OMSHUKHSI
         HWd/hoifR2SzpiWVbQCdPoDGSv9h0Hu7XvAEkQHOoHqA06eVz/QmTfqo9QP/btN0BL01
         Ha+aS+NZaMX1GZpgSWmGDb8HwkL0TVWqkko7Ga98W/iRjSBVoxlHiUpnoMbBudzlJGMC
         WJ/g==
X-Gm-Message-State: AOAM530yWrU+hOPZaT6eh+fVnBHU6DQflpSyk20EGWZN8b8Pwr2KN6F7
        JVUdffrVIECRdFp9Egldric/EZ9C5TjwNA==
X-Google-Smtp-Source: ABdhPJypyIpB85cwV1ubc/hwy6qFS8nE4OliFtCHeU6Pe5uaT2kgbyEF2VtFsFp0eVpJFy98QVJ18w==
X-Received: by 2002:a5d:4b41:: with SMTP id w1mr17884201wrs.27.1593442130685;
        Mon, 29 Jun 2020 07:48:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id s8sm42786336wru.38.2020.06.29.07.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:48:50 -0700 (PDT)
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
Subject: [PATCH v2 1/3] x86/dumpstack: Add log_lvl to show_iret_regs()
Date:   Mon, 29 Jun 2020 15:48:45 +0100
Message-Id: <20200629144847.492794-2-dima@arista.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629144847.492794-1-dima@arista.com>
References: <20200629144847.492794-1-dima@arista.com>
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
Acked-by: Petr Mladek <pmladek@suse.com>
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

