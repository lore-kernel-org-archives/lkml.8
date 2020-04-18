Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0D8C352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B2C822247
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="FVFERnXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgDRUU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728408AbgDRUUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:18 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEE8C061A0F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:18 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x25so6514926wmc.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H+NvfEakrhg0L+C4igKfudz2JE5z5px0NIUXyiWGlRY=;
        b=FVFERnXivMedYAJDVhm+RSVswHC5G03EXSzs4b3/jWDktasC7KgKNVrnpiaGG4CLSM
         jeLiO4ziyqw1/7lYKxnjhQ1wUFdLfK/oOJ2lvlfS3NDpP75lMuFDNmvjd0QGnMupsSm/
         xjOcM3p68ptJN58R/EgLBUfXAGuvef8/CuOxqnoIs/tzsMZSipUghmLbCpql+DzmDcp2
         mqJ6xjDvIPtI6eiDdoE3CHu/r3SFkBL+03sqdOQp8mlpGf/zs5bvUEbT3SW5Veoz2DQM
         rkUfZNo55yf8rQjabSQUJn+ngqxeU3iP20TXmdzuEZgZtwnd49tIrJ9hWbxzcHhYeNgj
         xbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H+NvfEakrhg0L+C4igKfudz2JE5z5px0NIUXyiWGlRY=;
        b=Vc0CCYmsyLFSjwjBRMlC+l7sjwWNn/dXLOqaQy8Ub3+Do/FEHD+TSXhDWsRNGM2e4k
         vavoXdT+8Uv/vYSLi2lIv2E4NL9H+CcbUWd8GLhWgrl9OXIRiByFnnYkTGrDxhizy6yh
         gqalSIlLacgy43GIJT0q9oTzsJP2zQLFVHVuP7kRZ0aGddWYKza3e4WqZ500pzy7ESHw
         TYb4lUY7tIZKN53sPyZjSNVi7vfzKU3nC6qj4/Z6Jf/rGzST/iGsI6YngH04uKhbsMoD
         Ehz0+zfvYT40K0hOGxsFl8GIpwy04dzKfrk5az8AEFl6C9FK6I04yATmAc/raGeyB2vl
         fxbA==
X-Gm-Message-State: AGi0PuZ+yhKpa8RsY+cGWIqeqnX448i8BpPf0EfXKsUEdEWLSfma/Sst
        MrcC6FUe3bVTtJwpQ56H9k9iNAhmKBg=
X-Google-Smtp-Source: APiQypJugDl25ODjYBjhf+yGAPq4bwHA8BhYswoOR1M2U509IhI5s0wTSLkOvtbYxnWEQFNABsYebg==
X-Received: by 2002:a1c:e284:: with SMTP id z126mr10039587wmg.32.1587241216725;
        Sat, 18 Apr 2020 13:20:16 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:16 -0700 (PDT)
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
        Michal Simek <monstr@monstr.eu>
Subject: [PATCHv3 20/50] microblaze: Add show_stack_loglvl()
Date:   Sat, 18 Apr 2020 21:19:14 +0100
Message-Id: <20200418201944.482088-21-dima@arista.com>
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

Cc: Michal Simek <monstr@monstr.eu>
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/microblaze/kernel/traps.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/microblaze/kernel/traps.c b/arch/microblaze/kernel/traps.c
index be726ee120fb..149ae534937e 100644
--- a/arch/microblaze/kernel/traps.c
+++ b/arch/microblaze/kernel/traps.c
@@ -31,7 +31,8 @@ static int __init kstack_setup(char *s)
 }
 __setup("kstack=", kstack_setup);
 
-void show_stack(struct task_struct *task, unsigned long *sp)
+void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
+		       const char *loglvl)
 {
 	unsigned long words_to_show;
 	u32 fp = (u32) sp;
@@ -50,7 +51,7 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 	if (kstack_depth_to_print && (words_to_show > kstack_depth_to_print))
 		words_to_show = kstack_depth_to_print;
 
-	pr_info("Kernel Stack:\n");
+	printk("%sKernel Stack:\n", loglvl);
 
 	/*
 	 * Make the first line an 'odd' size if necessary to get
@@ -65,14 +66,19 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 			words_to_show -= line1_words;
 		}
 	}
-	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_ADDRESS, 32, 4, (void *)fp,
+	print_hex_dump(loglvl, "", DUMP_PREFIX_ADDRESS, 32, 4, (void *)fp,
 		       words_to_show << 2, 0);
-	pr_info("\n\nCall Trace:\n");
-	microblaze_unwind(task, NULL, KERN_INFO);
-	pr_info("\n");
+	printk("%s\n\nCall Trace:\n", loglvl);
+	microblaze_unwind(task, NULL, loglvl);
+	printk("%s\n", loglvl);
 
 	if (!task)
 		task = current;
 
 	debug_show_held_locks(task);
 }
+
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+	show_stack_loglvl(task, sp, KERN_INFO);
+}
-- 
2.26.0

