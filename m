Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73FA4C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE0721D93
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="jKxQgsxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgDRUUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728401AbgDRUUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:10 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC62C061A0F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:09 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id t63so5495597wmt.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iIaAqVAZ4Nn/ZqLxByeE28HzHwDa9XF4+Vf5SMjFFRM=;
        b=jKxQgsxzRnh6w1hJ+oy8rEcBix30foFlx7l3Y4qYtj0h19P50Q6WdqaraU4IRViCIW
         /6vu8Io4X6qytkj/oL/5ewxLMPF5R1bALG6zwmdsF/DWggUk4L6OZ9jkhdbIlSsEA/Hq
         fKRfNe9AeES51eltZB3K5+olQihXcjGjxIXzMVISaS6GgcvzpIRm+02LuR49IHqGvjuA
         67k/sUNsubRDuhUgVLzIFPzcvlwRWDor9GsTmyDI5ERDQ8sV4ZS4e5ahvdpDpADqOvKJ
         Ija1aSw17c5avcpi1URmzYDH85ObkTD2sIp2uLuKiWCdi4IEz9CpROTI8XWSIlkSa+Vo
         5REA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iIaAqVAZ4Nn/ZqLxByeE28HzHwDa9XF4+Vf5SMjFFRM=;
        b=ihkwYv6+MCkDW9TGUTdCp+41GbLYiO3msFi0nN8C+l2KSdwI5HoYLlEa6higqJvtKo
         hGKCrI3Y0tWUdu4aNETdiD2EpEilzH54pOs6CKqaL28gv7xQRGyw9iofJQ4HfkozY0h/
         9WJDJNMz+Yd5F2CTY3KtusCRBgD6up2dlbRerx6aa40erul5vpV6zBKx5zv947ncRgjJ
         SK3RyL1d88qeJXJyMK55inv7+UvSY8mMc6280noj/Cm5CIOenb2nP0+t9u8f31PIGb1t
         cOMOhYhqsqMoSlowLGY1GpIG9LAyUmDTc4k0c4hbaSfRkF4uaEVEIEd30LixCcaDbL3q
         1z7A==
X-Gm-Message-State: AGi0PuaCgb6Uhbxt29QFvyhGvCNY2pBhFdrwY99+fPeODJOWhLFn0Tva
        0KbzK8EPYLg6h9dIN24bd9aLc1VTB2k=
X-Google-Smtp-Source: APiQypIpxCbLF/K++0OKxrEoNG3zsdzFnCWVPceFZou2dJoYcxVbz7IF/OmRN6BSYZx563joWEoW2A==
X-Received: by 2002:a7b:c38e:: with SMTP id s14mr8936457wmj.12.1587241208457;
        Sat, 18 Apr 2020 13:20:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:07 -0700 (PDT)
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
Subject: [PATCHv3 13/50] h8300: Add show_stack_loglvl()
Date:   Sat, 18 Apr 2020 21:19:07 +0100
Message-Id: <20200418201944.482088-14-dima@arista.com>
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
2.26.0

