Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33594C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 096BE20674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="MYkZIxy2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731720AbgCPOko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:40:44 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52871 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbgCPOkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:40:43 -0400
Received: by mail-pj1-f68.google.com with SMTP id ng8so1478526pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zBHOgyLEZ5r85R272wFN9sBw9jILT7cn4Ky0rcV2SIc=;
        b=MYkZIxy2XeKjs+V9xB58jdXdUpcU6IZVviLbe3NECyl9u6565FXZNazZYXK8WVbGGp
         wqqtqcr4qpQuIinzSoHhAQ2OnbO/tBjFvYnvUGj4MQJVQ+CmVBFyymzUlYnfnb1shm0i
         VXyNz60DmU8RlVgoqaXQ6Uc2mcnwqpZrh4ZHGhSq1fwCWHOfKxa/ASbhSjwrLzB+Ar6y
         PDGGckT870MdrCOjKZz8kfDAPiw/yWC3S60bjGD93d928ZGj1gn3Ff+8f/maKG142WjX
         hzNQaFOFDO3cKZdR+Qlji+s8rOQsxpkgOwNOPZJJCo1IMh69Weh3aAcIx5nymt8VSRVo
         Nv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zBHOgyLEZ5r85R272wFN9sBw9jILT7cn4Ky0rcV2SIc=;
        b=jFatVUye1Xhy4wkwCjCG9+p02Mi1ZdJXucyhUlyVhEOB7obSFb9wQ6MbwwRdcFJjXI
         y0gARj3gYg7gbsEFyEqBWxk7rE1Z9I2daqPpmn5FoORVLZf4yfTRsaTgzAqg4cyTksVg
         pBLpTMkKo3Yy6hbXNWj7GDVlW7UHYMOi9rDOIbVcuSsFaJYN0jccQ5waXFnZmHiJgzMc
         bqIhzCEoWaDTx/W91f6+cBblZ6exCPV6VH19pbIM50y8YgZ1j1GOUOdE3BUwTmoB9B5c
         2S0NAYvAd6oZy+1rI7cUyll8shkO097IUXyGYM7gOC4gxYTOiUTx/+QccVBk5EpBnTm7
         EMJw==
X-Gm-Message-State: ANhLgQ1zUCPd/zYhD00koZ/oJ87IYyWCJRmxfbmHmjaiX3nVXOLXX0ME
        dhBwF7IMbvlYNEV17nyQb3c0kX9j/1kdmg==
X-Google-Smtp-Source: ADFU+vtaZTnfAL6/i5p7oo7caqYCNYzoPpDeqZG5/l1xOh3L9hMyIiSyiKjpui4ZWYql9+I0v/iZoA==
X-Received: by 2002:a17:902:5ac9:: with SMTP id g9mr27676801plm.125.1584369641913;
        Mon, 16 Mar 2020 07:40:41 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:40:41 -0700 (PDT)
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
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        uclinux-h8-devel@lists.sourceforge.jp
Subject: [PATCHv2 13/50] h8300: Add show_stack_loglvl()
Date:   Mon, 16 Mar 2020 14:38:39 +0000
Message-Id: <20200316143916.195608-14-dima@arista.com>
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

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: uclinux-h8-devel@lists.sourceforge.jp
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/h8300/kernel/traps.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/h8300/kernel/traps.c b/arch/h8300/kernel/traps.c
index e47a9e0dc278..6362446563d6 100644
--- a/arch/h8300/kernel/traps.c
+++ b/arch/h8300/kernel/traps.c
@@ -115,7 +115,8 @@ void die(const char *str, struct pt_regs *fp, unsigned long err)
 
 static int kstack_depth_to_print = 24;
 
-void show_stack(struct task_struct *task, unsigned long *esp)
+void show_stack_loglvl(struct task_struct *task, unsigned long *esp,
+		       const char *loglvl)
 {
 	unsigned long *stack,  addr;
 	int i;
@@ -125,17 +126,17 @@ void show_stack(struct task_struct *task, unsigned long *esp)
 
 	stack = esp;
 
-	pr_info("Stack from %08lx:", (unsigned long)stack);
+	printk("%sStack from %08lx:", loglvl, (unsigned long)stack);
 	for (i = 0; i < kstack_depth_to_print; i++) {
 		if (((unsigned long)stack & (THREAD_SIZE - 1)) >=
 		    THREAD_SIZE-4)
 			break;
 		if (i % 8 == 0)
-			pr_info(" ");
+			printk("%s ", loglvl);
 		pr_cont(" %08lx", *stack++);
 	}
 
-	pr_info("\nCall Trace:\n");
+	printk("%s\nCall Trace:\n", loglvl);
 	i = 0;
 	stack = esp;
 	while (((unsigned long)stack & (THREAD_SIZE - 1)) < THREAD_SIZE-4) {
@@ -150,10 +151,15 @@ void show_stack(struct task_struct *task, unsigned long *esp)
 		 */
 		if (check_kernel_text(addr)) {
 			if (i % 4 == 0)
-				pr_info("       ");
+				printk("%s       ", loglvl);
 			pr_cont(" [<%08lx>]", addr);
 			i++;
 		}
 	}
-	pr_info("\n");
+	printk("%s\n", loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *esp)
+{
+	show_stack_loglvl(task, esp, KERN_INFO);
 }
-- 
2.25.1

