Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ABDC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EA3020736
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ivxAv/QI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731743AbgCPOkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:40:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42378 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731735AbgCPOkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:40:52 -0400
Received: by mail-pf1-f193.google.com with SMTP id x2so9689109pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tH14vsCJSuW7zZrLo5hHQ6Asz5cLIWfJR/NJ1vUZ0eY=;
        b=ivxAv/QITm61FxIIm5vY4yOx4EfV2g+Km/JeZdcEBkjq2PexINlAtiwxVXcsaMjGIM
         vPa3EKiz/ohsAyXfL//cwkSpnhYEplisBElCKta2BjThLIQHcpbO8vg/LRRS0yO8MU0D
         yeolVvdtokiUk04WQsFKW3RjVVNzWIr3NhmK+YnrSDcp371fEScy2m/+KmM6zAlwmkHH
         wvr+aUZh50hC6n1shyIkEZNJnI0W3xri42OyNiQhEtemB7qrYYNYX9LqnVmS+qduy25y
         loJYCfasK3CJGbtewUu0om7Yi4UJR61LgyPHkhwy94TdxisBm31U3fckE5iquhI7vJ16
         /wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tH14vsCJSuW7zZrLo5hHQ6Asz5cLIWfJR/NJ1vUZ0eY=;
        b=KXuzvKyBImw49/KxBdmCOMAHXdvQ6S44mln+QDttay3EC5e8HLgFomzOgS+8ld0I8B
         oMTWZqr3VHtGek9VivCt52Et/uwX3lMziAt/qPwRLcOLsWmqL1q6teEgpcGDX/mQmGfp
         lk8AW/pPa9QzBZCgQYpYiLGwPY8lk3/kLKxb5vHOmR+kQvMhIT4piQRTiPO5v4WszJ2F
         2C7qXntlRiV89wqkSCYFBkhiGIOGVPDqw81/xzlZojnTEjKbwWYhdSQYIIBT3TRWs5u2
         qjCTr6neNCnvsKnABeSeEQ8h8ATsgdOa5kHzjAfHfUTyrI2QmVpdZhwrYBtEwHJZlvtW
         MspQ==
X-Gm-Message-State: ANhLgQ3bCkZ1p7ruDjpJrPW8wpENCumDQjuL3FS5LTIgfb3ZT+/dpPKk
        HuW4wnorkr5qQ73KVXXGYosE6q/BFmavng==
X-Google-Smtp-Source: ADFU+vv33KVdzJhx3I0wZlH3r+fvYP4599ca97Z17ZK/K68o2Pb3q7OjovY9fVwnhnh72ynKkF5aHg==
X-Received: by 2002:a63:450b:: with SMTP id s11mr178648pga.45.1584369650601;
        Mon, 16 Mar 2020 07:40:50 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:40:49 -0700 (PDT)
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
Subject: [PATCHv2 15/50] ia64: Pass log level as arg into ia64_do_show_stack()
Date:   Mon, 16 Mar 2020 14:38:41 +0000
Message-Id: <20200316143916.195608-16-dima@arista.com>
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
index 968b5f33e725..0526cc51ff0b 100644
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
2.25.1

