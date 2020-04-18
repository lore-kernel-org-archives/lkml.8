Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9418EC352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DD0F22242
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="l6Y1aep6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgDRUUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728389AbgDRUUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:07 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2A3C061A10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e26so6491939wmk.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gjjMlhd0xdp/iVvywCOFWXlZIH/BbSpHfTomxkGQSOk=;
        b=l6Y1aep6te8XloL+tAxCiiiQRtLdyv/F1Fs0BNrqf6bM7+n3C4HwvwRXfb6KpsnSiB
         0Y0ltFrJGLl8ArSTpYgtE25lNA/R9J6HAjmGM2Lz3OgH3OBw+xKj1kMPYLxV3c4g7dUJ
         cLarlKDr5njQev0k1n4B8X/Ll64TaQpczs3RV7PGWB2Nf03nJiNRSwThiDjX7NR90TtR
         KL+dt5jw8pvMlaiwGFBgrYJDGGoWof6naCPXtyIiHHlBgjn1LGayWq/PVuL1Ob3zF69F
         HTb0cfiiqhH8HZEIohKx5MCAGu+VsXl8chrfFtHRtCX86JLTNFfTFroXlgPBiWHM9Jge
         ZuUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gjjMlhd0xdp/iVvywCOFWXlZIH/BbSpHfTomxkGQSOk=;
        b=aAuSild7uIiuOGCzp6+ghIW9rgHsZ+382aKUwbB9mG1z1Upn0uGlXH0mvXAdtGjhOc
         lHA6fgneGd9fy1Ab2VsZ0wRM+GDa8pvKRNORAdIDVLbdOBx8KgznlgF7hWO/sJCQyHXc
         K/QRjOO52t389B1MQz8G493T3dFFEldQl3RiKfTCW2MzZph+b38SKomCWeO6jnYH9onZ
         0PS4zYL9+kfUR4S0XsmVwTc1lqaqXFc1Kw77lv6dmhcjzB0lyG55LyqdaEetHO97DqI+
         VWlFMNHZ9HUryHv3X2uM5zBBTbQ9JF8IDt3RPHID5hhRpO3TrzHsPDIzJLrH6znSvjP/
         LyvQ==
X-Gm-Message-State: AGi0PuaF6vkVE86/2H0DkfWLSaRKwwgMCzIZoOeWXA04aZ7hclotKmcB
        ZufN6f/V1TblmPB/9NRcNjvIV0LWzac=
X-Google-Smtp-Source: APiQypIvQ583v2n0vIU4RizRyTRxiTsSKd/p4QUyTcvXudRp47/amfqlygTPDLacqVApbGi+cu29+g==
X-Received: by 2002:a1c:2506:: with SMTP id l6mr9227350wml.44.1587241205520;
        Sat, 18 Apr 2020 13:20:05 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:05 -0700 (PDT)
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
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Mark Salter <msalter@redhat.com>, linux-c6x-dev@linux-c6x.org
Subject: [PATCHv3 11/50] c6x: Add show_stack_loglvl()
Date:   Sat, 18 Apr 2020 21:19:05 +0100
Message-Id: <20200418201944.482088-12-dima@arista.com>
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

Cc: Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc: Mark Salter <msalter@redhat.com>
Cc: linux-c6x-dev@linux-c6x.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/c6x/kernel/traps.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/c6x/kernel/traps.c b/arch/c6x/kernel/traps.c
index ec61034fdf56..4afbf48f1ce0 100644
--- a/arch/c6x/kernel/traps.c
+++ b/arch/c6x/kernel/traps.c
@@ -344,12 +344,13 @@ asmlinkage int process_exception(struct pt_regs *regs)
 
 static int kstack_depth_to_print = 48;
 
-static void show_trace(unsigned long *stack, unsigned long *endstack)
+static void show_trace(unsigned long *stack, unsigned long *endstack,
+		       const char *loglvl)
 {
 	unsigned long addr;
 	int i;
 
-	pr_debug("Call trace:");
+	printk("%sCall trace:", loglvl);
 	i = 0;
 	while (stack + 1 <= endstack) {
 		addr = *stack++;
@@ -364,16 +365,17 @@ static void show_trace(unsigned long *stack, unsigned long *endstack)
 		if (__kernel_text_address(addr)) {
 #ifndef CONFIG_KALLSYMS
 			if (i % 5 == 0)
-				pr_debug("\n	    ");
+				printk("%s\n	    ", loglvl);
 #endif
-			pr_debug(" [<%08lx>] %pS\n", addr, (void *)addr);
+			printk("%s [<%08lx>] %pS\n", loglvl, addr, (void *)addr);
 			i++;
 		}
 	}
-	pr_debug("\n");
+	printk("%s\n", loglvl);
 }
 
-void show_stack(struct task_struct *task, unsigned long *stack)
+void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
+		const char *loglvl)
 {
 	unsigned long *p, *endstack;
 	int i;
@@ -398,7 +400,12 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 		pr_cont(" %08lx", *p++);
 	}
 	pr_cont("\n");
-	show_trace(stack, endstack);
+	show_trace(stack, endstack, loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *stack)
+{
+	show_stack_loglvl(task, stack, KERN_DEBUG);
 }
 
 int is_valid_bugaddr(unsigned long addr)
-- 
2.26.0

