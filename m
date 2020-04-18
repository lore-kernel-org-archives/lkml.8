Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9862DC352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7665521D93
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="iZHz5P39"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728860AbgDRUV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728539AbgDRUU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:28 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B5AC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:28 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j1so1743989wrt.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ybffadE8dqAJo382dZkDBzwR2ts70k1w2gIXA5Uhhzw=;
        b=iZHz5P399RHWKayzJ9qhD1e4JsSZ67BJPWz35fMSi+5VfWXH3u7MezAMmPUnrNInK6
         V9gYot/f+iEEBeTzY9MiRQifCbNvawCYDgFzi26hgPhMjiBZBVEDIKiu9aVk8DxJJ4y9
         KxHw6gAG3Dz9EbMNGQ3nl+xzWbuKYXLOJP6iV4RC+JDPcSVIcqKv6OY4J53IYVqeXCBy
         oryOCx51hk7QYCd3Dyjnl2pTaotPog1JhIQW5lsCot1Z5vSuQAv7N/Rs6WQ/BNAz9qrc
         0yyk1FdT+UCgcn4cAEENMdOcrXCRrK/83CGuTNUvEDIqJEEWouhjGPwJgVaR8jsuepKC
         GalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ybffadE8dqAJo382dZkDBzwR2ts70k1w2gIXA5Uhhzw=;
        b=jQ7UrxRsOqzckL8931IsuN6JBO5MhaRdN1xPI/VZpeXW4XGMNGIgYiDr8SkWu6fP+0
         pRXf67t4c3Fyyj/vVSoj7z1Tz2hEu6pLy0/V73malBJQnKif71Nzb1jjmTdZqBT/6g9Y
         sFVHtJOLlTo5trIzVE71fT5XjIlpy+/rB8FzQt9I1PR00yuw9Hm+ZE5YWq2BnMbUZVzG
         2tdqVRN5lDyGiWIcAITOLT30X3blIJdnjT4YBAATpWJu3Y5lXXqif+TfDGPmj0ZCLZZK
         RWyPp8shQWP812g3hBUBUjnqqv/DcjWNN1gLwEY1PFXvJKWYEclLL8y2aG1V/3kvLGsF
         9biw==
X-Gm-Message-State: AGi0PuYt55JC50kSgXVu69KtSwEmhdUmwpFO2/RTkGIG5sfMjc4zDR0C
        NefbTZBz2/fhhbSQKAartK+HoMp8/2E=
X-Google-Smtp-Source: APiQypIe0nED3rMPLTQENe6HaS/vs2AUCMRZNrcnsR+mudM1rommFYQcpSXtLZ73oHRLDO4iH1Z8YA==
X-Received: by 2002:adf:ce0a:: with SMTP id p10mr10089157wrn.89.1587241227000;
        Sat, 18 Apr 2020 13:20:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:26 -0700 (PDT)
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
Subject: [PATCHv3 27/50] riscv: Add show_stack_loglvl()
Date:   Sat, 18 Apr 2020 21:19:21 +0100
Message-Id: <20200418201944.482088-28-dima@arista.com>
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
index eeee844fb93d..05bf537310a8 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -99,16 +99,23 @@ static void notrace walk_stackframe(struct task_struct *task,
 
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
2.26.0

