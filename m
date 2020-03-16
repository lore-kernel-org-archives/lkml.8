Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F29C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6372051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="HOh8OHo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbgCPOnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:43:16 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40331 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731569AbgCPOnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:43:15 -0400
Received: by mail-pg1-f196.google.com with SMTP id t24so9875581pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FAh4+ZsRsbWtICuJgMDzpa3wZ0ySHTOVMGXpJ/bEEEg=;
        b=HOh8OHo6JRPnKsknISWiWoXxam2wMiNmGRR6NvyiakbYVwxifIWYmCejVB3MMOjK4a
         8M38Xj1sTNOC2Y4qPpwuVbgnfSHf/rFunliwQ8fzM2CSdhz7RmthIcAeXUBApR98akuP
         kSGv1c3iSq4XZRtYD36sYYz2Ohe99YSJvhIXF2tQL1a8fdtgC12+j40wENiIYQSVHZYM
         kekNhjR/ph995qgVpRygRWUKQELRT7EeBTFjpNHsqVJ6uVPCGdXiNoyyylBhFUqd8A0o
         pXNnfBs02zcST84fApXSJZ5slczDB6UmDi572Xl6Dlds7Dw0c4hWEcyixFEkzdJW+pYu
         68Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FAh4+ZsRsbWtICuJgMDzpa3wZ0ySHTOVMGXpJ/bEEEg=;
        b=LlTzfcWdLSO9cfNgKkLCcvJGTVX0RG73bfYHt0GYjYep7z0JfB9Jp4xWGzfwvemMer
         TtOgZcW7DMFvNvFKePeCOMH6A7MSnPGbKsEJR9fav885/PCJhh/YGi/bTM/VQMctBfPv
         63ms5+Er5sw1XOxAOob7qt9lGL52gXCvBsvAemy2h68mXfOXwKO3fvWbw2GfzTTNDUTy
         c5oQcHTpGqyIUTbAgSJ7zCb6TjuAxonlMeF4SZ7tqQ1Zuckxq8thouBnIZpRyGtkWL7X
         PsRAia3SzueZwhLGPQC1R9WDgYRNmcQhyFSgosFiOFSeWJLAlev842ySEYUZ0yxydnRh
         GN4w==
X-Gm-Message-State: ANhLgQ37eI0nzi6Jlkm4HJgsCg3Jc2NyoUMrY+AztBlDbDcS5Cr2bClw
        MB33IKG2vZAPyyGTiJnSCiubEg/Nn0FbaA==
X-Google-Smtp-Source: ADFU+vu2BdclTm/Ckvk1/5m1YDHtMAw0ZoNs/0obu/+OQJVH2x5b3hVPR0yN+rdlnFAUDBtzCxVJ9g==
X-Received: by 2002:a63:2cd:: with SMTP id 196mr220042pgc.188.1584369792534;
        Mon, 16 Mar 2020 07:43:12 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:43:11 -0700 (PDT)
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
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net
Subject: [PATCHv2 47/50] kdb: Don't play with console_loglevel
Date:   Mon, 16 Mar 2020 14:39:13 +0000
Message-Id: <20200316143916.195608-48-dima@arista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316143916.195608-1-dima@arista.com>
References: <20200316143916.195608-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Print the stack trace with KERN_EMERG - it should be always visible.

Playing with console_loglevel is a bad idea as there may be more
messages printed than wanted. Also the stack trace might be not printed
at all if printk() was deferred and console_loglevel was raised back
before the trace got flushed.

Unfortunately, after rebasing on commit 2277b492582d ("kdb: Fix stack
crawling on 'running' CPUs that aren't the master"), kdb_show_stack()
uses now kdb_dump_stack_on_cpu(), which for now won't be converted as it
uses dump_stack() instead of show_stack().

Convert for now the branch that uses show_stack() and remove
console_loglevel exercise from that case.

Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Douglas Anderson <dianders@chromium.org>
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: kgdb-bugreport@lists.sourceforge.net
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/debug/kdb/kdb_bt.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/debug/kdb/kdb_bt.c b/kernel/debug/kdb/kdb_bt.c
index 3de0cc780c16..43f5dcd2b9ac 100644
--- a/kernel/debug/kdb/kdb_bt.c
+++ b/kernel/debug/kdb/kdb_bt.c
@@ -21,17 +21,18 @@
 
 static void kdb_show_stack(struct task_struct *p, void *addr)
 {
-	int old_lvl = console_loglevel;
-
-	console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
 	kdb_trap_printk++;
 
-	if (!addr && kdb_task_has_cpu(p))
+	if (!addr && kdb_task_has_cpu(p)) {
+		int old_lvl = console_loglevel;
+
+		console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
 		kdb_dump_stack_on_cpu(kdb_process_cpu(p));
-	else
-		show_stack(p, addr);
+		console_loglevel = old_lvl;
+	} else {
+		show_stack_loglvl(p, addr, KERN_EMERG);
+	}
 
-	console_loglevel = old_lvl;
 	kdb_trap_printk--;
 }
 
-- 
2.25.1

