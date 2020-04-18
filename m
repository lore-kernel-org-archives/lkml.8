Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B97C352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51D122223F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="FyK+AZV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgDRUUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728628AbgDRUUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:47 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E666C061A0F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:47 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a25so7200048wrd.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2jZwlQD4gqI36lXAmMasBJFs4IJHJbTRUEMd6SsTmYs=;
        b=FyK+AZV2SKxUDijAOA9+xzchNYk4rID01texBJb4kTBQsK46o1E7kdjV+V4bGzKAlF
         HSw6rZa2MRXQf5tfyrCfONbJfg2k0Beh4vrJtXxOtvWXtXVCzdWcbX1mSq+55J+KTZnY
         nGuS8AdjkwaZwNfmzANo1DUbnF8PMOY47NnWhMgBgRH3KsKgkoowbxRlFYBXZz3o4qhk
         qoCz/jEbDCUiDK9NWThmbl6YSXBHJm+t2EB2Y5kZTahz/S9eJjdipODJnlO9x7KtmcPE
         GVqXBa+//Y6Czt+rZD9Ew3wAsIPtUEhbOeAd5CIv0Psoj1u1R8C28vI6D4AqsvObNOrQ
         iB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2jZwlQD4gqI36lXAmMasBJFs4IJHJbTRUEMd6SsTmYs=;
        b=Z4mVFMn9Po10/eEOjdiMbWGkX19imGLs9KjDBVP3LQoQgCMEWOi5CZBbzIWODrhEF0
         zXelywFTWLwuyR+FvFLS84f7vjhMnzGt7AI4B4a8Rj3buauU3BhavWizV33jrZ7/+R6X
         HETXr4anqxUYms+boM2Vs4pQEdfIuJfD33MBqIP2TaWRvnzvqu9iPjQ6ccO5dQhqhRzO
         mtZgd068lNM1/twYU2Liybv5oNTsmEjmHy2HPhoSQYP57K36STe6IuMhQqYy6D58uU9y
         l1DKx6UhyqwkXy2dEoMVqVX8rafZ3c76jdbT+E/QzBp9iCPjXwUYY8cNVHy9TqrmII3q
         s5nA==
X-Gm-Message-State: AGi0PuY48a3f3YlXMYayepiy+pXH0KDLP0dimhfvpvV0ebmem0N6E9Kp
        Q+j1oTWC0SPthphpno82n7DDld9h8hk=
X-Google-Smtp-Source: APiQypKAGKQw8GHCLShJtJF5fnR52/gE6UOvfm9Ey1ntNkckwmWu9+qF8ol+qU97Idhpnq0zvSVMow==
X-Received: by 2002:adf:f881:: with SMTP id u1mr10202601wrp.348.1587241245998;
        Sat, 18 Apr 2020 13:20:45 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:45 -0700 (PDT)
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
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Subject: [PATCHv3 41/50] x86: Add show_stack_loglvl()
Date:   Sat, 18 Apr 2020 21:19:35 +0100
Message-Id: <20200418201944.482088-42-dima@arista.com>
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

Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/kernel/dumpstack.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index b94bc31a1757..4396f2cfad19 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -279,7 +279,8 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	}
 }
 
-void show_stack(struct task_struct *task, unsigned long *sp)
+void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
+		       const char *loglvl)
 {
 	task = task ? : current;
 
@@ -290,7 +291,12 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 	if (!sp && task == current)
 		sp = get_stack_pointer(current, NULL);
 
-	show_trace_log_lvl(task, NULL, sp, KERN_DEFAULT);
+	show_trace_log_lvl(task, NULL, sp, loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+	show_stack_loglvl(task, sp, KERN_DEFAULT);
 }
 
 void show_stack_regs(struct pt_regs *regs)
-- 
2.26.0

