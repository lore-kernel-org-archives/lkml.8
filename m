Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D02C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499A32051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="BnKk2/oz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731752AbgCPOk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:40:57 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38677 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731641AbgCPOk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:40:56 -0400
Received: by mail-pj1-f68.google.com with SMTP id m15so8120826pje.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7OkuoIROrh3/KziVfEOswVO+EcIKWD3sx/6QQbkp9qU=;
        b=BnKk2/ozobLoK/U8xQ+txqQjQSCd4EsU9YVwsU26P3aBx7u6k5o34wULJ0vARfMp+4
         cm6x4JrKsqRy5nzQ60PhZYCjbiuNd9uaooB1ivXsFePFPWuAct7du6BjEj7N0+0Sg4L4
         W5sIQgXXTcpm0tls++fXSmuOUgw4sD0ufPIxhu4MyyfB6+vdJDZwzD3XrLAMITo6GmhU
         oB+2CU657r5EzqwGXJPaVypSeu/P+SokajSDNilB+/TEM+l0URad/9KURtNY5tIBglEM
         Jl6SVaaWTeV2sQzGWbjK1Arp9TZgQ5hPvVayoKJUIYC4T09rx1joQp9fOqXxvVcetFDQ
         jP/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7OkuoIROrh3/KziVfEOswVO+EcIKWD3sx/6QQbkp9qU=;
        b=nohARphnEGF7uu8dDRetRBUoIn62DrcW1r8ik5k6jmLwq7g1zgWxCHvcxspjXFLPXU
         vrXJ2fXQwtsD+UCj8BLBwhLNc8q51HuDx/PVXMRHF7yD/EkPCOppT5Ik/XQKEcouFBHW
         GjCASiNCSWIk58k7td6KurulAtr6tvqIcyxIFLUNmv6ZVeZd1VnOyEmCleR0nksGLDL9
         0aKB1tk5Kly7AepHVIwmN1YUYF+6Kty855iqQxc2nESkw43+KlH+2nH3v4GMlZnuFzyJ
         HfzeuSQOvSmJUlZA1TR0qLnCGtlJIg0CnkVSkV0ITUI6HbLXAs5gBUkb18DsYrf48x6R
         g6lg==
X-Gm-Message-State: ANhLgQ3lRhlD5X9F3x+s4fvI2n4L1isVZBlo5kn/x465fiPfHF33Ak+S
        zbifB866wTkhrM/kg/oxsAvCRNui9ngTNQ==
X-Google-Smtp-Source: ADFU+vuBwZqI27O5Ea3xKXyfRICmNeOYbixYBstUfbtm7uXoMF9URKkXHNu95M4x9nzQOpTnMtElvA==
X-Received: by 2002:a17:90b:1b02:: with SMTP id nu2mr19608877pjb.95.1584369655124;
        Mon, 16 Mar 2020 07:40:55 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:40:54 -0700 (PDT)
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
Subject: [PATCHv2 16/50] ia64: Add show_stack_loglvl()
Date:   Mon, 16 Mar 2020 14:38:42 +0000
Message-Id: <20200316143916.195608-17-dima@arista.com>
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

Cc: Fenghua Yu <fenghua.yu@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-ia64@vger.kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/ia64/kernel/process.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
index 0526cc51ff0b..b0eeb19bdd8d 100644
--- a/arch/ia64/kernel/process.c
+++ b/arch/ia64/kernel/process.c
@@ -85,18 +85,25 @@ ia64_do_show_stack (struct unw_frame_info *info, void *arg)
 }
 
 void
-show_stack (struct task_struct *task, unsigned long *sp)
+show_stack_loglvl (struct task_struct *task, unsigned long *sp,
+		   const char *loglvl)
 {
 	if (!task)
-		unw_init_running(ia64_do_show_stack, (void *)KERN_DEFAULT);
+		unw_init_running(ia64_do_show_stack, (void *)loglvl);
 	else {
 		struct unw_frame_info info;
 
 		unw_init_from_blocked_task(&info, task);
-		ia64_do_show_stack(&info, (void *)KERN_DEFAULT);
+		ia64_do_show_stack(&info, (void *)loglvl);
 	}
 }
 
+void
+show_stack (struct task_struct *task, unsigned long *sp)
+{
+	show_stack_loglvl(task, sp, KERN_DEFAULT);
+}
+
 void
 show_regs (struct pt_regs *regs)
 {
-- 
2.25.1

