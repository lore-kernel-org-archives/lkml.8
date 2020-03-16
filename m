Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADC7C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127A02051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="aoP/I5iM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731824AbgCPOlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:41:47 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:32782 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731534AbgCPOlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:41:46 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay11so8119639plb.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Isoz3LwZmPnBDo0625f8t5ukU0k8QDgmY80SxT2TERc=;
        b=aoP/I5iM2ugMfowB7bjyytMydk/n6aoWtTLmJLR8uMHzaJ4mr8K9tJSBBDUKy74L7Z
         s6a5fi9h+uxYy1VnJCGW0vBqf//8lzMyCybRm6Bcdblh4mUWGOZmniWaegZhdnWEsQXd
         f9Qw94PIr2vwe+bsKzrYPA7N5EtI2PDM6NQdCar4p7visX00pwUMDLv5iyEJgI77LhKs
         Hr7vtd/xWaP/8ggYhkOAAV0LpwskLWUy3FoTFQT9mIm59SvCchuWs7Gish+6ModLS6Dy
         RyTI+yLyj0a0dUrvLgqQ03bUVpNAdjfu1VnQkucNqGm6avCMTDvRYxv9C2IJFKw/3Kuy
         nR1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Isoz3LwZmPnBDo0625f8t5ukU0k8QDgmY80SxT2TERc=;
        b=dM0aowc0y4dtbHYt23xKQ91wG/c1cLBmLhQQgkmd/LW+Nb4UbKjCRgtpIIh+Sb5iLd
         GL4gsBbsvKglA4cnDMT6KKREEn6OytF1n2i5tnbK/IJ+JagK/lDZ2hfnXgWGObdv43K7
         xglLfClKkgtsYpg0B3NRUODCQkc0IJwJ8juGeib4h7lzZQK2uG1nA8VtAEfdf07Ti3in
         ZiXXy0NthcQ8+8+02kQsavlDlxOSOo+KTYYBin19ohOvvsCdSmJsQUWcXtDaDpnkNnD2
         L/V09w2io7TFoYLUlKriiGGLQsqo5LSms+EG+njd1DkGk4AXI3RWdqC3hVN6peLW9IYB
         ucow==
X-Gm-Message-State: ANhLgQ2m0ows4go5rBVFDWxlCfzHXg+utfzmFVSrT8Z0cvHg4JRE/Fc+
        r7aAtmZfC9FvPeh3gSyWQsaAQgoRYGoj7Q==
X-Google-Smtp-Source: ADFU+vuL0nf/DJlLIyAc8NRzlpOV3mETsruswkGU8JdK7McgdYDmy379i5WqPUbtpaiE3utrMzyUxQ==
X-Received: by 2002:a17:90a:23cc:: with SMTP id g70mr11019823pje.122.1584369703895;
        Mon, 16 Mar 2020 07:41:43 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:41:43 -0700 (PDT)
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
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: [PATCHv2 27/50] riscv: Add show_stack_loglvl()
Date:   Mon, 16 Mar 2020 14:38:53 +0000
Message-Id: <20200316143916.195608-28-dima@arista.com>
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

Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: linux-riscv@lists.infradead.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/riscv/kernel/stacktrace.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index a76892b48fff..5b414ba9848b 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -98,16 +98,23 @@ static void notrace walk_stackframe(struct task_struct *task,
 
 static bool print_trace_address(unsigned long pc, void *arg)
 {
-	print_ip_sym(KERN_DEFAULT, pc);
+	const char *loglvl = arg;
+
+	print_ip_sym(loglvl, pc);
 	return false;
 }
 
-void show_stack(struct task_struct *task, unsigned long *sp)
+void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
+		       const char *loglvl)
 {
 	pr_cont("Call Trace:\n");
-	walk_stackframe(task, NULL, print_trace_address, NULL);
+	walk_stackframe(task, NULL, print_trace_address, (void *)loglvl);
 }
 
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+	show_stack_loglvl(task, sp, KERN_DEFAULT);
+}
 
 static bool save_wchan(unsigned long pc, void *arg)
 {
-- 
2.25.1

