Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB213C38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA5F92224F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Xf9zp2g4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgDRUUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728594AbgDRUUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0D6C061A0F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x18so7198920wrq.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pWP1TiVa3Z/49zUv5iBWad3qqtGR6PIT7upIk6b62Jo=;
        b=Xf9zp2g4LCddomJz7JWy+3gYRrTMItbNxGNfRcpX1cXgWLb6ETr7vFhWMAZpdbp28k
         ou1eQSjRG9G7c69lo2USYUtWUy1Nkw7+DV11Dh2NqJxBV3gtDCCt6YwCs6Brbyot0oCu
         OhJgYe76XpZQVfwQ3lK30zqY1lHV3mXgsCxPQfV/dBKD3vwAUcB1D0RjqmkpBcCAk2c+
         xGYYGG6eFn8oNOVzzcDFme4mpn17EsoOlhyezLjcCme/vnTAHifsAvB+CN47kj30eUqr
         FLYhYBt2P0fXiaGQA3h4yLcMQilt2z8We+gdIQKBny7lvOvccNCmG1zANSEBk613JL7b
         9PAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pWP1TiVa3Z/49zUv5iBWad3qqtGR6PIT7upIk6b62Jo=;
        b=mSAU86HJbreK9MXRW4RcORQk871Wzhtbe6lJ98PNeg9fetw/SnYa7+Gr1YcoSBmE6W
         wmNgCDlfu0dEtk294msHel+ktxNoqwsEZ7j3OYx1C7vYq3AuDiz+bJPrSVNCTYz70wTv
         Iz8zYY8y2BEr2+AbrETtJx0o6BIgkAKtzgfb3t9xIbkrEuqxxM+/NR2vbxlojpptTqm5
         C95p8pEuIdTY7FotYOkopXloRzLuPu7HZfN136ZxZ4vA35PBohd0FBlfzKm2CjSo3WxM
         wINrchVRBkv2R7YqAyPnL0Smh/0Nux+mMIG3gPPW/KQsUr6MH4rYO7jUSd7SDLj7QxDC
         IVyw==
X-Gm-Message-State: AGi0PuYz8EA6o30b8ct3WAyd7GN1OkopPleqPMF4HIFhxWjm/GBq5hd5
        BXtxx4/u1kaWeE4dHdPiiqLtvcQONlM=
X-Google-Smtp-Source: APiQypLHLGID2ARNYIaz/2slcwB5mzsYUtgu99lpIjUi2FHkb0Okl1ZImZjnpQgBFImF+H37yJigxQ==
X-Received: by 2002:a5d:4111:: with SMTP id l17mr11403027wrp.271.1587241235272;
        Sat, 18 Apr 2020 13:20:35 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:34 -0700 (PDT)
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
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Subject: [PATCHv3 33/50] sh: Add show_stack_loglvl()
Date:   Sat, 18 Apr 2020 21:19:27 +0100
Message-Id: <20200418201944.482088-34-dima@arista.com>
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

Cc: Rich Felker <dalias@libc.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-sh@vger.kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/sh/kernel/dumpstack.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index d488a47a1f0f..cc51e9d74667 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -144,7 +144,8 @@ void show_trace(struct task_struct *tsk, unsigned long *sp,
 	debug_show_held_locks(tsk);
 }
 
-void show_stack(struct task_struct *tsk, unsigned long *sp)
+void show_stack_loglvl(struct task_struct *tsk, unsigned long *sp,
+		       const char *loglvl)
 {
 	unsigned long stack;
 
@@ -156,7 +157,12 @@ void show_stack(struct task_struct *tsk, unsigned long *sp)
 		sp = (unsigned long *)tsk->thread.sp;
 
 	stack = (unsigned long)sp;
-	dump_mem("Stack: ", KERN_DEFAULT, stack, THREAD_SIZE +
+	dump_mem("Stack: ", loglvl, stack, THREAD_SIZE +
 		 (unsigned long)task_stack_page(tsk));
-	show_trace(tsk, sp, NULL, KERN_DEFAULT);
+	show_trace(tsk, sp, NULL, loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+	show_stack_loglvl(task, sp, KERN_DEFAULT);
 }
-- 
2.26.0

