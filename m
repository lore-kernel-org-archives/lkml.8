Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C33C352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C15A821D93
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="UO2w4Cj3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgDRUWJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728519AbgDRUUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:24 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6BFC061A0F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:24 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id x25so6515115wmc.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WC9mNKw2+5FlWy70C2k6LiZDHHegVmgpkuPg2LNTGBE=;
        b=UO2w4Cj3iPpGEhYraPmiWwMT5uPdUROXDJll3KIy+0nF+WxGWWg0rYDy8pfhM1h5N2
         emtYe29zAqphH15dijSwzJKANF4v8bW+VYmlvnETClN6aPBqcADSkjqrBmpDj65LHqFG
         5yAjLKErTCBfC81JtV22IrdOJTCZw/J3unKEG7bs9T8ue4Awd7JEqnf7w5oxjW+XEBU6
         DRYInxBWbi+Uw7/ckjJ/JaCrUyinm2j33Lkpbgiu0ByjY+8VE7FrT4WENtp9wFFZyJRM
         1H0Knd/lRrOYydUd0x2sK9KoMAhiKgLwHQZQpsSjtxLtstfCEwbwpyJa3CJ+VRl72PJi
         w0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WC9mNKw2+5FlWy70C2k6LiZDHHegVmgpkuPg2LNTGBE=;
        b=THnoOZVH7LTB1ANNZB19yPKQUZm0d+1pmED0hl3fMJg7Ntfaqnk7GBKBHFtslRjzDM
         6ZuoztHWmrg1r0HUnbkCaguQkzkjBrJj3VlBIbmxY3kr/DhX82ieVEwrKNCoagbMY/fa
         k2tAY7aX+o4paFHX564+WGYmtG4tzlCJyPCc1D+g8Ve42GfAuS32hRe3DwR1QiT+6sDv
         LfM6iFF1Sn0kE/s1Pl/yzz8aGQxARmR5INICsn8SfIwXLQkWq1U6mbsIfmBVXBiagUjX
         uVp01FtQRy4ktoudssDHECXjVr1dkmpjNtHJmgWs95aLXU8b0wJtZL/jura5/DvZ0G6a
         PgBg==
X-Gm-Message-State: AGi0PuYT8NmYDPPcvngtP4ww99eg963K05rOFhchLokgcGo60b1CAytQ
        kLPjcGbfTfkNORo8WlvHudVbxyAKXDQ=
X-Google-Smtp-Source: APiQypIenAk6V4c55rzjRLn1IYanu1AaBCr6wTQxlJXfLLt9PdK1uvt+9MvtWSymUg8sTEqOZ2iSCA==
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr9573267wmg.177.1587241222874;
        Sat, 18 Apr 2020 13:20:22 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:22 -0700 (PDT)
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
        Jonas Bonn <jonas@southpole.se>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: [PATCHv3 24/50] openrisc: Add show_stack_loglvl()
Date:   Sat, 18 Apr 2020 21:19:18 +0100
Message-Id: <20200418201944.482088-25-dima@arista.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200418201944.482088-1-dima@arista.com>
References: <20200418201944.482088-1-dima@arista.com>
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

Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stafford Horne <shorne@gmail.com>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: openrisc@lists.librecores.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/openrisc/kernel/traps.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index c11aa2e17ce0..3b7978a22d68 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -41,18 +41,26 @@ unsigned long __user *lwa_addr;
 
 void print_trace(void *data, unsigned long addr, int reliable)
 {
-	pr_emerg("[<%p>] %s%pS\n", (void *) addr, reliable ? "" : "? ",
+	const char *loglvl = data;
+
+	printk("%s[<%p>] %s%pS\n", loglvl, (void *) addr, reliable ? "" : "? ",
 	       (void *) addr);
 }
 
 /* displays a short stack trace */
-void show_stack(struct task_struct *task, unsigned long *esp)
+void show_stack_loglvl(struct task_struct *task, unsigned long *esp,
+		const char *loglvl)
 {
 	if (esp == NULL)
 		esp = (unsigned long *)&esp;
 
-	pr_emerg("Call trace:\n");
-	unwind_stack(NULL, esp, print_trace);
+	printk("%sCall trace:\n", loglvl);
+	unwind_stack((void *)loglvl, esp, print_trace);
+}
+
+void show_stack(struct task_struct *task, unsigned long *esp)
+{
+	show_stack_loglvl(task, esp, KERN_EMERG);
 }
 
 void show_registers(struct pt_regs *regs)
-- 
2.26.0

