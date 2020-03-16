Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 994C9C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FDAD2051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="jyesnZc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbgCPOmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:42:52 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36378 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbgCPOmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:42:50 -0400
Received: by mail-pj1-f68.google.com with SMTP id nu11so5573274pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9l+wWBOfSBMIyXuLdYYRbynfSuSviwsAcrFvYuXXKYQ=;
        b=jyesnZc+pnNv4stNLJoNav6+7GENTQ6+U6xxezUlEgUF9ZB/4NnP+xLLsaH5eoG81h
         tLTg1bK7UPOWVvSCDhpwoVPU3+zAWiBYq0gCqkhPajy2vnr1Mr43DueQfqjvV21pt/9P
         ee5JG+KiZInIFAlRM4MRzp/NWgiRd2o9ZKMqg8lSIkgxXYEuyAD5TIGbrBUursVCko8p
         zSGHNPpG+s4hVj41Tv7ksb33zV1qZLro4NPwP9egOI7rrmkpM1bTSr/FYQYAZf/RW6Qm
         bipwdBpYmI+vsE0RTF4yj5Q/uOe8Q3uIq6QcwOiABZaNtI+2HSuNsLZUwMiHDZvr6mTL
         qSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9l+wWBOfSBMIyXuLdYYRbynfSuSviwsAcrFvYuXXKYQ=;
        b=OBrWIqxfAWgAgtoONCKyPiHtw+KyDAiYaIEHssL3T5O6dPrXA2wES1ZGCje67gTa7D
         6CS/UB+ehRmAZgWEy5KeuljUvzSr20ieLG1l9eeTiM+F2CSx2aD1QE6kEgGDp4kKZzO0
         KMeFB0QxA14GbBq2ZmQreIeVq9MtKgv3PaFC3+XpOMewCyBLcvwOKZXloFkvi9byIa25
         gFhN4n3yOwuHc2PstynK0RDv/TwIHa+97Ollh5ylri53CjclMJnieDTZrCBW3T+Pqkas
         PtZEB35P8C+45YE+ojGVDBhcCmUA5rGxY3wzXBJL8Lcsp/QvtCuc74fgeGbcTmICQ4NZ
         wnWQ==
X-Gm-Message-State: ANhLgQ38nX8QM5vJlEAANLAPQYaX3DcEFxMm94EJ28ABaI1LRMSLDrld
        934TpByGIBzyv4jJO++/eK9fFx5/tsuYsA==
X-Google-Smtp-Source: ADFU+vv1gjc3CefDFGciNcdkAwCtQ0Chq7leYuvkV/SrELQIGIJsqBVW4/kt6PloYuXxBhhFBEYnDQ==
X-Received: by 2002:a17:902:8509:: with SMTP id bj9mr27957195plb.123.1584369769335;
        Mon, 16 Mar 2020 07:42:49 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:42:48 -0700 (PDT)
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
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCHv2 42/50] xtensa: Add loglvl to show_trace()
Date:   Mon, 16 Mar 2020 14:39:08 +0000
Message-Id: <20200316143916.195608-43-dima@arista.com>
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

Add log level argument to show_trace() as a preparation for introducing
show_stack_loglvl().

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/xtensa/kernel/traps.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 0976e27b8d5d..c397a02457bc 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -479,18 +479,22 @@ void show_regs(struct pt_regs * regs)
 
 static int show_trace_cb(struct stackframe *frame, void *data)
 {
+	const char *loglvl = data;
+
 	if (kernel_text_address(frame->pc))
-		pr_cont(" [<%08lx>] %pB\n", frame->pc, (void *)frame->pc);
+		printk("%s [<%08lx>] %pB\n",
+			loglvl, frame->pc, (void *)frame->pc);
 	return 0;
 }
 
-void show_trace(struct task_struct *task, unsigned long *sp)
+static void show_trace(struct task_struct *task, unsigned long *sp,
+		       const char *loglvl)
 {
 	if (!sp)
 		sp = stack_pointer(task);
 
-	pr_info("Call Trace:\n");
-	walk_stackframe(sp, show_trace_cb, NULL);
+	printk("%sCall Trace:\n", loglvl);
+	walk_stackframe(sp, show_trace_cb, (void *)loglvl);
 }
 
 #define STACK_DUMP_ENTRY_SIZE 4
@@ -511,7 +515,7 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 	print_hex_dump(KERN_INFO, " ", DUMP_PREFIX_NONE,
 		       STACK_DUMP_LINE_SIZE, STACK_DUMP_ENTRY_SIZE,
 		       sp, len, false);
-	show_trace(task, sp);
+	show_trace(task, stack, KERN_INFO);
 }
 
 DEFINE_SPINLOCK(die_lock);
-- 
2.25.1

