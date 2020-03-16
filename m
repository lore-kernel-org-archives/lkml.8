Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7B3C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D128520674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="VuXFV4S0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbgCPOkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:40:31 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45140 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbgCPOka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:40:30 -0400
Received: by mail-pf1-f194.google.com with SMTP id 2so10034768pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=urHNLfQhgSZxhId56CerdA8qI/pTbhkDosMJIMc+96U=;
        b=VuXFV4S0p0zJmT/b+BXBnIRAf1LhgKRfV+wV0VKglRwBXnyYsZ+d/LLoFN9TM94zgr
         WaR17JqMlUJ+8g6UmGbhdYsuQmZ97yoo3xfFPTrWl2mOrNWT/0G0RctGc6XyIJO/PkF/
         fec1+IeB7QaFr+T8k9/1vEkm/zWL/TCZVG9ZLlcdIDsK7rcmbRtNI+lAWScVc+paWYyZ
         wcvOwUcaUWUxbALtVG0cagwlZA+zEN3O6whFXkuK1Rw3lkn3NSg+zw1viytV7bZhJCyo
         lsPfOYuqPwqPhLoFFwOB3Eij2tAYAKEJL0hcNjqCf2hxscyrl6CFrVrMVgTJ2oGc1Lc4
         5k+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=urHNLfQhgSZxhId56CerdA8qI/pTbhkDosMJIMc+96U=;
        b=Gp6L3a3b5KwAw3uOYNa/nf8cjCVOgs/HSU3zOpmcYyc5ZMxnNqHToMeZfIYtwnv/sE
         tyVzKdfgHHFBrny3EWQzLmiC3g+cLR/29nvGxO+ARSBZwSQZkREJohY/3rLWFNFHcII4
         xLsEb5/9wuCjDrxXJp+KIbfnFwejPXDrZxpJi5NP1WlUpmfNpshHe+EK6hAGWGIPzVta
         4KUObWvhoXyMb3PqHkjKSwDVAuobXBri1sIQq0VCdGdn1eUiaDrgW3TNbIeYxXEFxYE5
         GPxOK4rc6V9bI4l1yfJUuCY5UM7DKnkGbsNLBnzUqI9eNCe8bf2TkAaIpO+HqH+haL45
         cCvQ==
X-Gm-Message-State: ANhLgQ1eoSoQrZmI80WcDOW8412kXGxCPBjl734pOeZv5WW+EXIVxjcB
        CmFampqaQNd7XZytC8eAoMsnq8d4JWcLfw==
X-Google-Smtp-Source: ADFU+vvLU6h1iizXDZ/c/OPZjgMmyqrH0GBzKwotMVtaEeH10SOiZn0xdM5t+Ga+ptP79KwZ0D1zPw==
X-Received: by 2002:a63:ff20:: with SMTP id k32mr138425pgi.371.1584369628536;
        Mon, 16 Mar 2020 07:40:28 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:40:27 -0700 (PDT)
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
Subject: [PATCHv2 10/50] arm64: Add show_stack_loglvl()
Date:   Mon, 16 Mar 2020 14:38:36 +0000
Message-Id: <20200316143916.195608-11-dima@arista.com>
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
2.25.1

