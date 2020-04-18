Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1189C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EC27221F7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Nn/+89+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgDRUUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728354AbgDRUUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:03 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40812C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:03 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a25so7198674wrd.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z+YS35j1pthADYOggJksZ21+AYvy9Q5Svl8xq7/1/0E=;
        b=Nn/+89+nvtJcrb7DBbO2QVeuqrrEAsfyt8w3dgJayKBBa48cP9wU+J/JHNKkkhWcZ9
         3c1FWeoaX9CRuZ2udzCWwNPqp+c1Vu3b8YX7z+YwUKwd0bBcNVnK5Tm5zvBX5CmNP2R/
         OimT+kEn+UBfklPCBzqtZkhoZraW1G/57/Thrj0BMB8D1FHsGXkgJeHGCMwV4hPy1Te7
         9Rn0VwctIieJF37geg3dxzn8wxqWSbalM/ps5C2DcoDKs87qrBgZ4LsXaHI79fkXpbzl
         k2kKban/YP7QixnAgSGf+yyKRxSSlgQyBZyJn+dj0bztNz0rShgW9OCTShudtJiOg97x
         QB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z+YS35j1pthADYOggJksZ21+AYvy9Q5Svl8xq7/1/0E=;
        b=ZzEtMXImh5YET7E8UmU1oq3ousa7ytLbqsidfuMtmREujAdMKV/iISq4Jto0mJ4mRv
         Ion+KzDaIwnOHk3+Bu3lQNuqCQwnz/FU4YqZm8IkZ2nszZ+qTNcUXCZUnTWdwTIPS1ys
         UbWbU4pwnCcMkd28TMt58hWGHwa8MGkYLG/Os5qmMnYFULiFIuHygBHM03XfYrTQl2hy
         /Py9BlXO1H0Ae3zt6rD6AFD8+4VpkjgLp/AAO4rleFkqGBHoQejQzgthLQQRdFdnsxMZ
         Gp9vZxEaCr+hXunz0tl2RrQnIMp/8lAdpSWRBjcqteotV6Lpj7hlA2M8PM/+v9wRZr5P
         6YkA==
X-Gm-Message-State: AGi0PuYaQ8M2ER6gRBJXHfmESHXX5DxWbEjsexZMjq7liTNvrpUvNwRI
        qSfaK7OFKX9sI6IsQuUpmAXd/VzJcVQ=
X-Google-Smtp-Source: APiQypIYLF+ATds0aKxggIYh9U9zg3NGkQVvBb/u4rvxkjM65KuNTWBa954InfurDolr1GHhBYSjxA==
X-Received: by 2002:adf:e98a:: with SMTP id h10mr10648536wrm.370.1587241201776;
        Sat, 18 Apr 2020 13:20:01 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:01 -0700 (PDT)
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
Subject: [PATCHv3 08/50] arm: Add show_stack_loglvl()
Date:   Sat, 18 Apr 2020 21:19:02 +0100
Message-Id: <20200418201944.482088-9-dima@arista.com>
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

Cc: Russell King <linux@armlinux.org.uk>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: clang-built-linux@googlegroups.com
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/arm/kernel/traps.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index e1be6c85327c..00455b5bbf8a 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -247,12 +247,18 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 }
 #endif
 
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

