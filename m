Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E399C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D8CE2223F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="hZbmBuYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgDRUUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728379AbgDRUUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:06 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE11EC061A0F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id h2so6496899wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S9UHEvfxwrRnXPy0faw2y8HTiLGhsJabGIVgIOzQk4k=;
        b=hZbmBuYvSaXbYP6DSe47SFq+xJdk5s8P5DGnS9P1+n556dqd46XTEPaHpYnhldQObU
         tMfW5/GeVdqLidhFVtLoEnEhTE5HOpYcJeLosfTjht6J7usmZJF7vIwrPA4HUUulYJE7
         mnbEyGNpW7VNQsdVtuKgII22Z5geWQKzIDcRk+surFpZefl9luUpTGXPS5hYUPEljRVy
         N+jDzTTzHSJ4boN5BYBxehKaBAZOa8lYqJpChcbJmn7tetKqKB5VqdcMyWfAzuSF9nxl
         IDh8x5yd8AHH/PtFnhIx54yaaVLq80uFoYJTskBZvDc38dzNar/uxrwU7q59M1Xru9RZ
         eWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S9UHEvfxwrRnXPy0faw2y8HTiLGhsJabGIVgIOzQk4k=;
        b=pItNXO69AuVM6aZAQVx8CYVwQDGpT06jE1WaNEMJCajvCQBiH9l20zhUIyQUd+4AaL
         T2FFRbP/pk7GH62QtZ+/e3F7ohswJioeGZVBF2T1tVrcdIqR4fw9/gmtf/oZbmTljJUx
         GYgxGUt8rjpmeVqg+OaXqhfDTSb2P7OARp2QPgYXen+EmgiBbcJmMTd8GeAyyaYaPYxH
         +9tYHYQD8vhXSSQOPJt0+FD7/ldqOdrp+DOBY+uivBQzJOawV8NdHFzzNqG1VoAQtUJe
         uWCuVk0x+Ro9PnlzdaWu6EEUjYRi9i74xCYCze3Oj9TI4UAzorPHS+XHUMAt1I/QhToP
         KPiA==
X-Gm-Message-State: AGi0PuY/bKRyRt405bCEJ7kO3+2MND7aBLotoD+fFrnPgX5u5w1ammbG
        ZTugmWzdD2VPO0QavbVoQC9MJ1eXqJ4=
X-Google-Smtp-Source: APiQypK4Qy1tfeCeENkNw5qEez0359RKZu0L0gpM2vI1Wyd4ThavVQZTyo3UbgnzNJs2Nap3JVigCg==
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr10115682wmg.183.1587241204307;
        Sat, 18 Apr 2020 13:20:04 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:03 -0700 (PDT)
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
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCHv3 10/50] arm64: Add show_stack_loglvl()
Date:   Sat, 18 Apr 2020 21:19:04 +0100
Message-Id: <20200418201944.482088-11-dima@arista.com>
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

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm64/kernel/traps.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 6e777cbd4eb5..516e92332fd0 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -137,12 +137,18 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 	put_task_stack(tsk);
 }
 
-void show_stack(struct task_struct *tsk, unsigned long *sp)
+void show_stack_loglvl(struct task_struct *tsk, unsigned long *sp,
+		       const char *loglvl)
 {
-	dump_backtrace(NULL, tsk, KERN_DEFAULT);
+	dump_backtrace(NULL, tsk, loglvl);
 	barrier();
 }
 
+void show_stack(struct task_struct *tsk, unsigned long *sp)
+{
+	show_stack_loglvl(tsk, sp, KERN_DEFAULT);
+}
+
 #ifdef CONFIG_PREEMPT
 #define S_PREEMPT " PREEMPT"
 #elif defined(CONFIG_PREEMPT_RT)
-- 
2.26.0

