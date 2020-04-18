Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CECC352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9E821D93
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="CpqLi0Td"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728929AbgDRUWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728343AbgDRUUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:02 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C94C061A10
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:02 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so7147211wrs.9
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+30pBdntWlJcgkbolNjxFd/p/YpKCMUbtsGUF0cke54=;
        b=CpqLi0TdivFtBdUYdlu0IK8kq03+7R/ZENpjm1PxBJ1oGUqdzIOIhyS2Nj/X0utCfc
         B9p4j4Bjv5hZQE223ADJSzI59HTZY11SjvI0dZYnlsJhRrXkOOnZTavGsOlQ42ztSVjd
         3LzEeCTHznGhIeo4WEPCNICxozCgHV2ha13BrAZrDyo5NWJXUZVIIfW/PL/3TDPT3NoI
         kGdavhK1plQAUPwRv2CaCKve3TSC5HoGM0e2ZIaozI5J7cMdVFhuimrY2wdMRkikD0Or
         aaW3MDikWIs6/9JOkt2Vrml99ykHIKRaseOpn8sc2Q6MPE9OApzYwVmKBL6B9o8ooxOU
         egLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+30pBdntWlJcgkbolNjxFd/p/YpKCMUbtsGUF0cke54=;
        b=Qdj3HiumzT4uAIVVz4/tt2Y6kKCQ3RmkuqbZ4ZHeyVG52F3m3FhvNjBZp0WV1s2a5m
         mLW8YeZqb+0VmfPxKwSQKxDLsBMAudCg9VegeuXMDPQTdZDa0xqiXevlXEF537OHpj/R
         VaH3mhBGvr7etSMPvDyTWH5DmViI0eLGfYCXhlvKVE6ir4+uM1t7PDLHD8Z5Xc3BV29u
         c446drMFZIrcU3ggJ6KXg+qGm80y7Syyz7HwZoXfk9Ujhugc38J/HOfYRd0bK/+kA13P
         iVo5DhpeazSaO6JKCQkbej3zvzo/u+ni2AHFaUWG1+ZxZMARiajcFrELdFRfbZhOyf57
         tE2Q==
X-Gm-Message-State: AGi0PuZG80YAZ3hrhO1PRqx9ho1c8/QV8n/gtwCyftuC1fI1yGfH8WaC
        DRcUEUTRIRAlbJpmKZErGp0RklLY9TI=
X-Google-Smtp-Source: APiQypLcXaHBnW9H0cOYu3yQzZUFMfmWLaUmw0+I88uE591C25vfvZ8CZwoW82VotrQ1EUmOsFrsIA==
X-Received: by 2002:adf:dfc2:: with SMTP id q2mr11297074wrn.390.1587241200532;
        Sat, 18 Apr 2020 13:20:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:19:59 -0700 (PDT)
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
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        clang-built-linux@googlegroups.com
Subject: [PATCHv3 07/50] arm: Wire up dump_backtrace_{entry,stm}
Date:   Sat, 18 Apr 2020 21:19:01 +0100
Message-Id: <20200418201944.482088-8-dima@arista.com>
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

Now that c_backtrace() always emits correct loglvl, use it for printing.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: clang-built-linux@googlegroups.com
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm/kernel/traps.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 0f09ace18e6c..e1be6c85327c 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -68,13 +68,15 @@ void dump_backtrace_entry(unsigned long where, unsigned long from,
 	unsigned long end = frame + 4 + sizeof(struct pt_regs);
 
 #ifdef CONFIG_KALLSYMS
-	printk("[<%08lx>] (%ps) from [<%08lx>] (%pS)\n", where, (void *)where, from, (void *)from);
+	printk("%s[<%08lx>] (%ps) from [<%08lx>] (%pS)\n",
+		loglvl, where, (void *)where, from, (void *)from);
 #else
-	printk("Function entered at [<%08lx>] from [<%08lx>]\n", where, from);
+	printk("%sFunction entered at [<%08lx>] from [<%08lx>]\n",
+		loglvl, where, from);
 #endif
 
 	if (in_entry_text(from) && end <= ALIGN(frame, THREAD_SIZE))
-		dump_mem("", "Exception stack", frame + 4, end);
+		dump_mem(loglvl, "Exception stack", frame + 4, end);
 }
 
 void dump_backtrace_stm(u32 *stack, u32 instruction, const char *loglvl)
@@ -89,12 +91,12 @@ void dump_backtrace_stm(u32 *stack, u32 instruction, const char *loglvl)
 			if (++x == 6) {
 				x = 0;
 				p = str;
-				printk("%s\n", str);
+				printk("%s%s\n", loglvl, str);
 			}
 		}
 	}
 	if (p != str)
-		printk("%s\n", str);
+		printk("%s%s\n", loglvl, str);
 }
 
 #ifndef CONFIG_ARM_UNWIND
-- 
2.26.0

