Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E149C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA2C21D93
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="FES+oZNE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgDRUWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728439AbgDRUUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:13 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84724C061A41
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:13 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i10so7137706wrv.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YcAGMtuF0rhY5/CwFkS6y19jwNr4v/OVvU1ZdxXAJXI=;
        b=FES+oZNEIEsmmj51DKeJqushAlZRr7Qyhs0t52CNC/JtFGiRCkDZ1lrdgRDBoJVdmC
         uGKLXTsyQQAq/CTc7N89gZUjzQmKHQAJYlnGzfgfxTEDzIPDzXPKtDLKs+KdlfyCciPV
         JprcrR1IEcHrnnVKyaq4btYzWjf9Ad6Ki/jZfMm6BnrIpGx4l82mc/etx8k5Rn+5oe7R
         F8us6C+qDk92IRvLz6UOxtTgfh4CLKYbMC0vf2tinG+xBd9UXsWHEEeKyBehVT8ZIIcp
         fPzI68Et5QjrOlwu3Ys2d3571063Vjr2fVU+bKHh7/YRKu+w9JOeP7R+krablit5g9EB
         n8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YcAGMtuF0rhY5/CwFkS6y19jwNr4v/OVvU1ZdxXAJXI=;
        b=hOkkvIHZhjSpcqVolT8V8cIueRC+M3IiVohVn5N9IF0QaYIsvDY9jo6N3HQBV60Atn
         ckJyIIucQ36+zp3MEDYaCt1ffRXUK7InFeTyuSgNIPbaJXTxFrrj6XXQ1A892mhhKLRH
         if2WTB07DaVDe1LUBEXhzLmfjdSvF9ZvkMO0DYu+O4DDJS6XtFcVyY5zlgvQYrH8Z6go
         Wwhqf1WAEYcQk7KMAk/Y2iuCZYhoq3PX+Up9XBMwnTilQwlC6pvwUbEBG4Lb99dTB8lg
         l3xQMvIxwIKgFfn5mt0oFuUL7Xcw8R5Cm3fVCcn/jKvZsbR8y2nwjHj8tgWwg28SWIyb
         RYxw==
X-Gm-Message-State: AGi0PuZtcSJCkDH0Ys54msDUisCnpaf75/dFoN6ZBSVNtxqTw97MKLqm
        3KVYDb9mp1F67GtD1ASeyEsA12UCexs=
X-Google-Smtp-Source: APiQypJE1L+v+FBvyz+zKGSwkl8f3+Jyj0m1yDLkX+uEjYV6Y2Q10HvgN4fmJxgHa6iZZhsQhuJaMg==
X-Received: by 2002:a5d:6785:: with SMTP id v5mr10009583wru.376.1587241212065;
        Sat, 18 Apr 2020 13:20:12 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:11 -0700 (PDT)
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
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org
Subject: [PATCHv3 16/50] ia64: Add show_stack_loglvl()
Date:   Sat, 18 Apr 2020 21:19:10 +0100
Message-Id: <20200418201944.482088-17-dima@arista.com>
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

Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-ia64@vger.kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/ia64/kernel/process.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 332c6dfe7333..913d9a01cbf9 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -85,18 +85,25 @@ ia64_do_show_stack (struct unw_frame_info *info, void *arg)
 }
 
 void
-show_stack (struct task_struct *task, unsigned long *sp)
+show_stack_loglvl (struct task_struct *task, unsigned long *sp,
+		   const char *loglvl)
 {
 	if (!task)
-		unw_init_running(ia64_do_show_stack, (void *)KERN_DEFAULT);
+		unw_init_running(ia64_do_show_stack, (void *)loglvl);
 	else {
 		struct unw_frame_info info;
 
 		unw_init_from_blocked_task(&info, task);
-		ia64_do_show_stack(&info, (void *)KERN_DEFAULT);
+		ia64_do_show_stack(&info, (void *)loglvl);
 	}
 }
 
+void
+show_stack (struct task_struct *task, unsigned long *sp)
+{
+	show_stack_loglvl(task, sp, KERN_DEFAULT);
+}
+
 void
 show_regs (struct pt_regs *regs)
 {
-- 
2.26.0

