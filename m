Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96267C4CC77
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71189221F7
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="a/jtp0Jm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgDRUVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728721AbgDRUU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353AAC061A0F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:58 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k13so5962805wrw.7
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hRu8VCdc7vaeiedjRdNjAGlCNOIN/tL02I9o+YdNwkk=;
        b=a/jtp0JmRv/UizRoeCRV4s0gEUh8a9giLCssCAkA7ZnBO1fwL9Oz00K2OBbmVtecMf
         MyLcJ0lIeVbTOlZITSApfrEmWdurIbeeqNxPqdHBSvtlFyUjZ0n1e1fRDbFMY1m5/10W
         oBfRHSa+pEIwcmf0s+HukSKPO5szC7dgjmys9wkSmQp7oqnZbrRgrQ/lWQg9E2EFuRN1
         ifizDzx25TamBKfJ7UqUdiQi7YzJwtelj6Q169q7GY9Svvo5II2ktYM1yXLhOEh9OH6r
         REr10uX59OebDK4mkTO/Om5UuiBrJ/G1hVNJUoxEeHC+/dwg/gkpcfaj8AmeejZ71D+N
         7XWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hRu8VCdc7vaeiedjRdNjAGlCNOIN/tL02I9o+YdNwkk=;
        b=D6MELdi2tz53VqYPkVtxDRUO4FOT5f5ZKKx3bKSK8mQ2A5/EvqrKi2IZgWaK8rqi3E
         bdWFpv9cABN1rXTW1f1Air3e3KcFyal2VK8m61tVeebLmGvL4SSabzXNF5YDAPfJSMe9
         kTdzRDgWqNxQoGKUqAm3KlMVhF403USNW9uwmkdOUrZT51YSd0ZJybKDfcE2F+1BGjLU
         eyOwHHiDducpldNjNuiFgUZQBTamovRyfDGR5q+DCHcurgbOzmO321Px26vYVvQXnevh
         n8p7ko/5i/71i+nlARxWIjCMTajl3eZtxi1yJDDpUJWFDYo8kWeernzpvXpZiDre5WOt
         SDxg==
X-Gm-Message-State: AGi0PuY5HJp7tJ2OlgJz6/5CqHjcONzbXoaLlWJ2mNhM3GgwbLbVuDET
        6ZHHlFe120lXlH3XIqLVbZwGB6WwPJg=
X-Google-Smtp-Source: APiQypLcM0vqXBNgqZ2hG7+LLAEYFDUMFF16tb85WEAGvQ3h70EfTsEhSGlF2dIDPQk0STkat3uZbQ==
X-Received: by 2002:a5d:6785:: with SMTP id v5mr10011971wru.376.1587241256805;
        Sat, 18 Apr 2020 13:20:56 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:56 -0700 (PDT)
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
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCHv3 49/50] kernel: Use show_stack_loglvl()
Date:   Sat, 18 Apr 2020 21:19:43 +0100
Message-Id: <20200418201944.482088-50-dima@arista.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200418201944.482088-1-dima@arista.com>
References: <20200418201944.482088-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the last users of show_stack() by KERN_DEFAULT as the surrounding
headers/messages.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 kernel/locking/rtmutex-debug.c | 2 +-
 lib/dump_stack.c               | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/rtmutex-debug.c b/kernel/locking/rtmutex-debug.c
index fd4fe1f5b458..5e63d6e8a223 100644
--- a/kernel/locking/rtmutex-debug.c
+++ b/kernel/locking/rtmutex-debug.c
@@ -125,7 +125,7 @@ void debug_rt_mutex_print_deadlock(struct rt_mutex_waiter *waiter)
 
 	printk("\n%s/%d's [blocked] stackdump:\n\n",
 		task->comm, task_pid_nr(task));
-	show_stack(task, NULL);
+	show_stack_loglvl(task, NULL, KERN_DEFAULT);
 	printk("\n%s/%d's [current] stackdump:\n\n",
 		current->comm, task_pid_nr(current));
 	dump_stack();
diff --git a/lib/dump_stack.c b/lib/dump_stack.c
index 33ffbf308853..5595e8962cf6 100644
--- a/lib/dump_stack.c
+++ b/lib/dump_stack.c
@@ -74,7 +74,7 @@ void show_regs_print_info(const char *log_lvl)
 static void __dump_stack(void)
 {
 	dump_stack_print_info(KERN_DEFAULT);
-	show_stack(NULL, NULL);
+	show_stack_loglvl(NULL, NULL, KERN_DEFAULT);
 }
 
 /**
-- 
2.26.0

