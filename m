Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBE2C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 276B02051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="h2FlJSNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbgCPOmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:42:43 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37258 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbgCPOml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:42:41 -0400
Received: by mail-pj1-f67.google.com with SMTP id ca13so8824511pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R3WlkMq8F0DL+8HOyrBobJIXLwasaELBzuoWoB4z8LM=;
        b=h2FlJSNhqQea8YRgUjseza/AiVqSrTPb0VA9vJos6CxzbeAl+SPE5yxKqylPiaTRFx
         Fe973kXwvy2nN/DBx745rnln1fjp6eoXO7JGUx0s+O15Tmp56NvYzcLo9KrrNT76EoGP
         zpiCPRyZDH7NAtcXtIbprCX3gnXQ54KARECzrMN3EhvSSV7fSDS11P8RUco2dtoNzJsE
         +iI39aIzYUfTR2nmhwJc2M8sLmuSyW+NJve7uRJjkWrAvy1zAe3Pp/CgJuzeLCLt8HjQ
         7Teh+Ev/7JwjVWvEeLEX8IQjKl0PrG9Pm15vurctOPIuxiiC6s4oawscQ5j+DsoLGDKs
         CP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R3WlkMq8F0DL+8HOyrBobJIXLwasaELBzuoWoB4z8LM=;
        b=k+jf9/95/FokoVsps4qdsmGJks5WPTKS2jH/4VSvnUT95/KB27RcvdAP1/sKOkuWVe
         PcNFCT+/yw0uaousFkAH89EyCwItQl/nQulrrhtcuQ+hTVNrhq39zA346kWVrwvpsLRU
         IhRlX5F8K1NNSty/48owQsIZFIdmpSSuakd57Asww2xMKGi7QgRIXeEyQHvH0BuqLsZR
         oPzIJupAT+oXJ5FPslVrVE+N46MtBWEllfXX89QC9PSutmy6pGsPOniOI5e6eTw1EcVf
         Q07lxGYal7qlY195V1ZKPxPsq+sNWOHPiB8j3s+wLnKtPTrqOChD5N62aXIZQGAAy2rO
         lkVQ==
X-Gm-Message-State: ANhLgQ2Rf5VJTkiK0HfZcs3Q00zudLqYoKZdyn+udhdsqJmxQLfe55bH
        /n/RV/T1Ond7R5Yxrs8CpxVcqmVRJQT8BA==
X-Google-Smtp-Source: ADFU+vvKPXCoJUUr3rHWxh4j6KZyTXYB5MQOyJngIPdBM0959euYJG8rAEGWfQPQz3Sg5wroZ/3Ycw==
X-Received: by 2002:a17:90a:350d:: with SMTP id q13mr25248329pjb.171.1584369759940;
        Mon, 16 Mar 2020 07:42:39 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:42:39 -0700 (PDT)
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
Subject: [PATCHv2 40/50] x86: Add missing const qualifiers for log_lvl
Date:   Mon, 16 Mar 2020 14:39:06 +0000
Message-Id: <20200316143916.195608-41-dima@arista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316143916.195608-1-dima@arista.com>
References: <20200316143916.195608-1-dima@arista.com>
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
2.25.1

