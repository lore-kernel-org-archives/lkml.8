Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90096C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 633D92051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="YhoDYWj6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731921AbgCPOms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:42:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37895 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbgCPOmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:42:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id x7so9878170pgh.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ju3Njn5NotWuQ3oLE1KcS84vF3InDYC+aV5NVuCJqsk=;
        b=YhoDYWj6l4mRX5dsP++3w+m8Z4HaLuNhLmjIGJpsJEOPXWkSRx6TJDVQtHfJDmIENO
         2B69I24eEXomBnJuRJsAXSEd2erDBmlJ80CAE51EJS4E1eoVp0+VqI6kCIAIp6HcJhQr
         DKxthTmn8jrrTRIHQurbAkxnocGe620X3fVBXJdyjh+5ZNDRpr+fdNiLQ9vX+GnyuqAi
         klQwpYVvOitq46DB8HWGqHP7UdOH4Gk8cQda+QAbHe4vElmx2DwBr8J+CJxwoGy4Qc5H
         g9FfnoC+GNwZBLm6b39vOXwai3Rj+0NPFWnmxCiSX2Jnae3E5CsMbP0pMt/KyKX2XjAe
         5xGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ju3Njn5NotWuQ3oLE1KcS84vF3InDYC+aV5NVuCJqsk=;
        b=D6EFhRE1Z0WLVeRi979iU3rlSMQ/nrBXLMrTb+DhR3+xKtRTfaCr7OAas9FOCOtFRK
         7Q8DX6o1L7FDeugpuej8lgXAhNIy2ALmvt/6IZrhCAminXIYX94tgjQ7FN46IaygHV8t
         XSvJor6pR8s5PRzbQQgXRX8/rw+LZMoK6j0yV8GBdKn84TWze5vufhC4qiXrlmqPUdfn
         7MXEGr650CMMIdCsz79AZ+WzI8Ix+h5H6LO4EV/4JA3s9GgUGB+wrIS7r/K/2pRmGjAF
         7pfOyFiB5hlqBJz9RSt/ckvXKp47ALAiw111ZrZpzAjgiu7HqJ3U3XwNQFCj1ErD2Rcg
         H0xg==
X-Gm-Message-State: ANhLgQ1xIcWk4xcHupDOFZGfwWNmBT/qxpFjDGLK+qdPLxmKLmxvM9Fo
        Xr7AWclhIUwkzCVuNbVRojIqwUWtJIKuig==
X-Google-Smtp-Source: ADFU+vuLwxIAH/W01ZsVoSHLQxItDbUipns0V56puawDa9JFjyo39OEZooDtS5vJmMorib0bFCx0+Q==
X-Received: by 2002:a63:c445:: with SMTP id m5mr208045pgg.194.1584369764830;
        Mon, 16 Mar 2020 07:42:44 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:42:44 -0700 (PDT)
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
Subject: [PATCHv2 41/50] x86: Add show_stack_loglvl()
Date:   Mon, 16 Mar 2020 14:39:07 +0000
Message-Id: <20200316143916.195608-42-dima@arista.com>
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

Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/x86/kernel/dumpstack.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/dumpstack.c b/arch/x86/kernel/dumpstack.c
index b94bc31a1757..4396f2cfad19 100644
--- a/arch/x86/kernel/dumpstack.c
+++ b/arch/x86/kernel/dumpstack.c
@@ -279,7 +279,8 @@ void show_trace_log_lvl(struct task_struct *task, struct pt_regs *regs,
 	}
 }
 
-void show_stack(struct task_struct *task, unsigned long *sp)
+void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
+		       const char *loglvl)
 {
 	task = task ? : current;
 
@@ -290,7 +291,12 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 	if (!sp && task == current)
 		sp = get_stack_pointer(current, NULL);
 
-	show_trace_log_lvl(task, NULL, sp, KERN_DEFAULT);
+	show_trace_log_lvl(task, NULL, sp, loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+	show_stack_loglvl(task, sp, KERN_DEFAULT);
 }
 
 void show_stack_regs(struct pt_regs *regs)
-- 
2.25.1

