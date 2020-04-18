Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DDDC3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81EDD22240
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ADHxcUOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728715AbgDRUU5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728667AbgDRUUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:46 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15537C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id t14so7126289wrw.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3uBFpkFa96ongA+8JBMVShH+ZmmRgufQJTs/S9jtmUY=;
        b=ADHxcUOTFIqlVDm6Q0//C0YEWs6z/5RV364963tY3gk40fP+lRfuwbaoWMBcDpMq+J
         4DWzXl+cGcbxNcjcTpC9t4wIlfmuUR/XO0uMwJLonULyD7yicTJnnQK2YbGyNHVpxyvi
         ALuzdNZY90e7jgOWVyRiegjmhxrcuF7uTEcfE5Uy031JtZJGPZ4JfPzTJFZU32t2Esqj
         FYC2M1SCFWsq5LGHj6xFuoOC7vRHQuk1/H3dKW6r9lq2KUlRcfIj2xHtVFqLC97cwDyY
         cl0D7QVXOQHOomafR73Cq62okacAbDJEfPXCbgKSxMFjfbq5/6lyTB75GNeOZTQfdqQA
         /zCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3uBFpkFa96ongA+8JBMVShH+ZmmRgufQJTs/S9jtmUY=;
        b=H1M2ukHQPHadD3iSDHp4Pr2n12GFwrR2riYH5Sjhnn3pFmt80DN8u40YFSrd4flRw+
         v7wJSLIUAWEAwbdQGYtftxPem6a7TrDyfmDxwPY4MxO4djkwkIX2omwz2HSxTQkhzOGf
         /S5DQ7IUTC8ca7tU7TGbMXwcoJHXgTvipyOOUIWUb/sAgc4inzLRoZKJw/aAaVeUSTX1
         Ybx9SwwT96EmFT++4+IXqNgMT+KgGcetV74jF6C4RZSr3Dk8ORVIyLD9DZD2kNxr5J19
         9MU1X+DQnEmBWtyjh//Q2F3pjvROxE5hCqf5pj7IGoyMlo8+mVSxwPixn9/71IaBmmUj
         FLPg==
X-Gm-Message-State: AGi0PuY4KB/a6Dj/+7rYlJJq80WoQ/P/Zv8lzKAFlwX2EffMKcXk2lI2
        +0p9phoGzACrg6QlCtqp5DZmcPPcg+s=
X-Google-Smtp-Source: APiQypIBlZ+9gScv3j/TsuteuqQFBkysSBIXA/tvJzT0u60ziD7M1YkqkEammmXMtHwB9wx/uaW32g==
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr11201817wru.326.1587241244320;
        Sat, 18 Apr 2020 13:20:44 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:43 -0700 (PDT)
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
Subject: [PATCHv3 40/50] x86: Add missing const qualifiers for log_lvl
Date:   Sat, 18 Apr 2020 21:19:34 +0100
Message-Id: <20200418201944.482088-41-dima@arista.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200418201944.482088-1-dima@arista.com>
References: <20200418201944.482088-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Keep log_lvl const show_trace_log_lvl() and printk_stack_address()
as the new generic show_stack_loglvl() wants to have a proper const
qualifier.

And gcc rightfully produces warnings in case it's not keept:
arch/x86/kernel/dumpstack.c: In function ‘show_stack’:
arch/x86/kernel/dumpstack.c:294:37: warning: passing argument 4 of ‘show_trace_log_lv ’ discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
  294 |  show_trace_log_lvl(task, NULL, sp, loglvl);
      |                                     ^~~~~~
arch/x86/kernel/dumpstack.c:163:32: note: expected ‘char *’ but argument is of type ‘const char *’
  163 |    unsigned long *stack, char *log_lvl)
      |                          ~~~~~~^~~~~~~

Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/include/asm/stacktrace.h | 2 +-
 arch/x86/kernel/dumpstack.c       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/stacktrace.h b/arch/x86/include/asm/stacktrace.h
index 14db05086bbf..5ae5a68e469d 100644
--- a/arch/x86/include/asm/stacktrace.h
+++ b/arch/x86/include/asm/stacktrace.h
@@ -87,7 +87,7 @@ get_stack_pointer(struct task_struct *task, struct pt_regs *regs)
 }
 
 void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
-			unsigned long *stack, char *log_lvl);
+			unsigned long *stack, const char *log_lvl);
 
 /* The form of the top of the frame on the stack */
 struct stack_frame {
diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index ae64ec7f752f..b94bc31a1757 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -65,7 +65,7 @@ bool in_entry_stack(unsigned long *stack, struct stack_info *info)
 }
 
 static void printk_stack_address(unsigned long address, int reliable,
-				 char *log_lvl)
+				 const char *log_lvl)
 {
 	touch_nmi_watchdog();
 	printk("%s %s%pB\n", log_lvl, reliable ? "" : "? ", (void *)address);
@@ -160,7 +160,7 @@ static void show_regs_if_on_stack(struct stack_info *info, struct pt_regs *regs,
 }
 
 void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
-			unsigned long *stack, char *log_lvl)
+			unsigned long *stack, const char *log_lvl)
 {
 	struct unwind_state state;
 	struct stack_info stack_info = {0};
-- 
2.26.0

