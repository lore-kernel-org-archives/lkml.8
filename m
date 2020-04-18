Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE15C352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7FFB22242
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="IGWkWXGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgDRUUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728396AbgDRUUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:09 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6748C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id i10so7137535wrv.10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eWiHCf9OKtX8dEhwm3cEWQqlBOGveXlw1dckMiY1JX0=;
        b=IGWkWXGb4rL9nsLXyUqPYfaiVEtfjqShiqaZpVut6/VXFcuWisgCp4v7jGjtqHRPVc
         jS+xZ83OvHCcOvXulOnNY4hsLagCUEJlwebiei/qkJU8mvv/4V9US+kkf3FyXRSguIUy
         mOs0+KndXMDy4rsrHz6gGGyM3+63gb/UrlZ0cGautLxqMAE1SubyxmCUgQkR4bdJ3Kbv
         NMAVR4nOSzbU3L46ag1qDcZ3KbxZbDDm2+VFcc4Aff7HYC+Yqf8mL0MFXuGWt8HkeQik
         EA87OustByoipCdwQmtfIGUZCfHWaESoUpFBIiQt1cB83FH8YWE9McLye1PUt25nLBcM
         TO4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eWiHCf9OKtX8dEhwm3cEWQqlBOGveXlw1dckMiY1JX0=;
        b=T91Vh0ngRf82vYNbrBg+4YYZ4o0wq0HiXzk2CYesoGAvnRk24IZYZFlV+XLdX8Zfw7
         idQLSj93Rnu5AjjhPYKlFYQZ6yt0PwppsqNdH/e8HLM9IBvPLmQseNWa1TXArxB917jQ
         rGHP/H71VVdmsBqfYx39om0erIIZh44rANXCE0GlL5IPmQVDZjkvcg4KSA+gBzYwznda
         jSqGzrH2CXE7FQq8zPJPPVnKotn5Xlczsg20bclKO6vpSzQYus9m1WzFjsINkccsyW9R
         1528LeWyFYwuxsGe50sl7X3MqLG3aIIh4xpo3KF9VmEm7CYVUHTUGZ23VYCn5DNPTfWd
         044A==
X-Gm-Message-State: AGi0PuZf9jtMzKlfv2GSo0Nq5fV1hsSnPO7P8X1JGRbcvFymaJBw/aaa
        Iq//ZRaW0tvZb4bxfh7/AsHIIC+9DIM=
X-Google-Smtp-Source: APiQypLNQ9+nAQYXPHwB+1jD7iKORdxM6rwfvmLhqxOgfkdO/cL9zkUpRLy8D7X71vEzTZBT9svIIg==
X-Received: by 2002:adf:978c:: with SMTP id s12mr7860174wrb.312.1587241207161;
        Sat, 18 Apr 2020 13:20:07 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:06 -0700 (PDT)
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
        Guo Ren <guoren@kernel.org>
Subject: [PATCHv3 12/50] csky: Add show_stack_loglvl()
Date:   Sat, 18 Apr 2020 21:19:06 +0100
Message-Id: <20200418201944.482088-13-dima@arista.com>
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

Cc: Guo Ren <guoren@kernel.org>
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/csky/kernel/dumpstack.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/csky/kernel/dumpstack.c b/arch/csky/kernel/dumpstack.c
index d67f9777cfd9..c500837390d3 100644
--- a/arch/csky/kernel/dumpstack.c
+++ b/arch/csky/kernel/dumpstack.c
@@ -5,7 +5,7 @@
 
 int kstack_depth_to_print = 48;
 
-void show_trace(unsigned long *stack)
+static void show_trace(unsigned long *stack, const char *loglvl)
 {
 	unsigned long *stack_end;
 	unsigned long *stack_start;
@@ -17,7 +17,7 @@ void show_trace(unsigned long *stack)
 	stack_end = (unsigned long *) (addr + THREAD_SIZE);
 
 	fp = stack;
-	pr_info("\nCall Trace:");
+	printk("%s\nCall Trace:", loglvl);
 
 	while (fp > stack_start && fp < stack_end) {
 #ifdef CONFIG_STACKTRACE
@@ -32,7 +32,8 @@ void show_trace(unsigned long *stack)
 	pr_cont("\n");
 }
 
-void show_stack(struct task_struct *task, unsigned long *stack)
+void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
+		const char *loglvl)
 {
 	if (!stack) {
 		if (task)
@@ -45,5 +46,10 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 #endif
 	}
 
-	show_trace(stack);
+	show_trace(stack, loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *stack)
+{
+	show_stack_loglvl(task, stack, KERN_INFO);
 }
-- 
2.26.0

