Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F94C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6A32051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:43:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="X6Ep94lO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbgCPOnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:43:24 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37336 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731634AbgCPOnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:43:24 -0400
Received: by mail-pj1-f68.google.com with SMTP id ca13so8825647pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k2DKMzLKpWPoePhkNzUYoz346KeCU9iJAnRLemYYamI=;
        b=X6Ep94lO4hEAubgNo5c3gfXUM887DGyMnATJNudkbeyHEU1B/xwY6agzgeAgl15sqZ
         XbcKI5HDS6M8GO/M2vQqFqYKc7+x6/GtELckop+mTsYMqDURW9sCf0+E8Om1MhtrEiYD
         MozVkxacGNAidvqsFkrREQUTfSpp210cSLf0870wIVChda7hv9j32gBNkxncd2Uoc5WV
         RFNfhn9VxlFVa6s4JQVwvyNVfpV88t810Nt1/OEa3uO43PDk5S+c5OSF4UwRWCn9J+29
         f4efAMnIOOKe2RSimJiaxaHvIMzReWdtgTle8FXMbIyI8FstuZD/oaI9fcrZc1Yt28xJ
         zDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k2DKMzLKpWPoePhkNzUYoz346KeCU9iJAnRLemYYamI=;
        b=XxMNlPxTQq77lFZvREOhwchd4u8YM/J6a8F294Xv5gN2+0LC2VhnvxSjLo7+1834sW
         uPX21iUWoR3Q5vvARQ093uu8qQnSvsmkSvAUDHothCH5DWrKOacBEY7ENztNtKGll1WH
         /miVi/LzJhmBk57h2ImJlwRTSslNG/0dhFdHgFjRXI5Aq0ob+q+iHOVDu68OKgtaU90I
         8veyxkwJ10Y8xRp37vgwBWx+iurFMIODp0IxBYTysmjUIXUFoKQ6tDd0i2KGy+BEd0NV
         GntVD2d++/aCRmxEcINj3mZR9FQvCIe2L37TFj5/EOeOKw6SrQT2idIzC0hIXI55gHpj
         36xw==
X-Gm-Message-State: ANhLgQ23uXtwmY6ULYmGKIn/YQEfJs++7yzTgBu2+PBH7cauTMb94Eyt
        sLRk7C2a3+KzVCmOkNHP6l/ifU/OsU6ZEg==
X-Google-Smtp-Source: ADFU+vv7z0EaZP1JK86FaA1e9qRhNjU7eg6oUr006KcIxkJx9/pbC7MK4KMNoxy6quWosDIXWbCB2A==
X-Received: by 2002:a17:902:b58b:: with SMTP id a11mr27782580pls.9.1584369802459;
        Mon, 16 Mar 2020 07:43:22 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:43:21 -0700 (PDT)
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
Subject: [PATCHv2 49/50] kernel: Use show_stack_loglvl()
Date:   Mon, 16 Mar 2020 14:39:15 +0000
Message-Id: <20200316143916.195608-50-dima@arista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316143916.195608-1-dima@arista.com>
References: <20200316143916.195608-1-dima@arista.com>
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
2.25.1

