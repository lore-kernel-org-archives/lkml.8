Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12555C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E01E1221F7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="AvXTR7vu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728393AbgDRUWd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728432AbgDRUUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:12 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C018C061A0F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:12 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t14so7125216wrw.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Zx0j9dhsBcoY80rEpVxAPrttTB7YEySwNL8nK9K1gE=;
        b=AvXTR7vuxCognA33cJ6XDtM3eGcgdAyYamMmSXba9fEoe9v887njAbkiwXQrYK3mCm
         LEcK43L/w37TbukKg3urwbiDlDamqT8HaDD/OO5gO1Mb/mnZgJs480LqT3fxFz+DeYVe
         +vRh+DViRnQmfVWpDBfagjtA1gjN8G/53AzMfOjYNGerHnU41i5BLjMiCOkIFoCWfRUY
         NSEMMjmTzpzVmo8h904aIBL020tR3wOalEofk0y3nXst1ZfnjvXm+0B5SAjEjtj/Zj0f
         vUBak4eO1q2iJ5km9mm00VDO1Wm4P32UJpbH+XQh5f5yZzftUE9zJS1mDzfZ4ZOUSBBE
         HlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Zx0j9dhsBcoY80rEpVxAPrttTB7YEySwNL8nK9K1gE=;
        b=WDpV8osqmmn/Kknt9PL8KvD0bE9Cq8TDq/9BETSUoAaHNW5AYCd2RBKcgE0s22sFPi
         xqxOhkNshH0i7iB4ngqc0y5jzKnKiM3LaDSQhXiJZzXsTqABeJWCIjNh8om+1gwiVSOK
         bOBeJN/dat9f0liALmCJa+u2GUx8vP7qxarfYJi/86sqUulU4ndhchn3vsIr576QOX/n
         MGD8KbmSUyAjcIGWmTKCxgGcQI1yl6x9+MCyBiOcTgpwx+7GCbw7xuBgekNgU/LDqDk2
         HsZUmGFtj3hJeeaktlOuMd+CUkNXO3uDECxwGoT8hsLH/y5TMAuY2Hg0ZHR6RpIZpBlg
         JFVw==
X-Gm-Message-State: AGi0PubIMrWsT/94kYNdF6VMeXG9vH3JTJCKCUYsXkq95mImMhkY9NyD
        AI7xyokYJu4itZW6OPTz8kTKLxkaeKs=
X-Google-Smtp-Source: APiQypI9QnAQsgI0SJ6jSbUsnLWDMzELjBwQfoGfl1dERhLb1OVclICsAiPR6ailwe6STfzW84JosA==
X-Received: by 2002:adf:dd8a:: with SMTP id x10mr9456824wrl.308.1587241210875;
        Sat, 18 Apr 2020 13:20:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:10 -0700 (PDT)
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
Subject: [PATCHv3 15/50] ia64: Pass log level as arg into ia64_do_show_stack()
Date:   Sat, 18 Apr 2020 21:19:09 +0100
Message-Id: <20200418201944.482088-16-dima@arista.com>
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

Add log level argument to ia64_do_show_stack() as a preparation to
introduce show_stack_loglvl().
Also, make ia64_do_show_stack() static as it's not used outside.

Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-ia64@vger.kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/ia64/include/asm/ptrace.h |  1 -
 arch/ia64/kernel/process.c     | 13 +++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/ia64/include/asm/ptrace.h b/arch/ia64/include/asm/ptrace.h
index 7ff574d56429..b3aa46090101 100644
--- a/arch/ia64/include/asm/ptrace.h
+++ b/arch/ia64/include/asm/ptrace.h
@@ -114,7 +114,6 @@ static inline long regs_return_value(struct pt_regs *regs)
   struct task_struct;			/* forward decl */
   struct unw_frame_info;		/* forward decl */
 
-  extern void ia64_do_show_stack (struct unw_frame_info *, void *);
   extern unsigned long ia64_get_user_rbs_end (struct task_struct *, struct pt_regs *,
 					      unsigned long *);
   extern long ia64_peek (struct task_struct *, struct switch_stack *, unsigned long,
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 10cb9382ab76..332c6dfe7333 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -64,12 +64,13 @@ EXPORT_SYMBOL(boot_option_idle_override);
 void (*pm_power_off) (void);
 EXPORT_SYMBOL(pm_power_off);
 
-void
+static void
 ia64_do_show_stack (struct unw_frame_info *info, void *arg)
 {
 	unsigned long ip, sp, bsp;
+	const char *loglvl = arg;
 
-	printk("\nCall Trace:\n");
+	printk("%s\nCall Trace:\n", loglvl);
 	do {
 		unw_get_ip(info, &ip);
 		if (ip == 0)
@@ -77,9 +78,9 @@ ia64_do_show_stack (struct unw_frame_info *info, void *arg)
 
 		unw_get_sp(info, &sp);
 		unw_get_bsp(info, &bsp);
-		printk(" [<%016lx>] %pS\n"
+		printk("%s [<%016lx>] %pS\n"
 			 "                                sp=%016lx bsp=%016lx\n",
-			 ip, (void *)ip, sp, bsp);
+			 loglvl, ip, (void *)ip, sp, bsp);
 	} while (unw_unwind(info) >= 0);
 }
 
@@ -87,12 +88,12 @@ void
 show_stack (struct task_struct *task, unsigned long *sp)
 {
 	if (!task)
-		unw_init_running(ia64_do_show_stack, NULL);
+		unw_init_running(ia64_do_show_stack, (void *)KERN_DEFAULT);
 	else {
 		struct unw_frame_info info;
 
 		unw_init_from_blocked_task(&info, task);
-		ia64_do_show_stack(&info, NULL);
+		ia64_do_show_stack(&info, (void *)KERN_DEFAULT);
 	}
 }
 
-- 
2.26.0

