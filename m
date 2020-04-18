Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F60C352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D70DC21D93
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="lYVr5Q6m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgDRUVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728617AbgDRUUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:39 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B04C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:39 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f13so7133808wrm.13
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=34+/2L5UqZgBD/IEOPObgtOlHcvjMeH49/BCWrNQFRQ=;
        b=lYVr5Q6mYH8AmVq6OU4YmLn8RUAV3sQNQXlFRdBPQ07PHMpbjiwy0oPX7HOR8exvUd
         K9vI3EpW9zUjMOTsBLsypCukIXcBvw0KV0kAyVnVxe49XUTSf9V91PrnlJbUoftl8RHd
         ARVKZ8KqpFVPRF+mhM63SLNVvgRW8Ok783XZXHljhyBtcNCcTA4BMJzvhkPFNoizrRSh
         dbi72HKv7TuWpZR7MuL4WIP3ZusAf/OvzMKc9K6GZi2xzvJ4kX7QsOwlFeG0Nhs2LGFX
         bTS1b9rt+h+Q9g6Jh5c1VaDJDnk4g36hJhHm0prLcPci4Y96aYFx+mEU7TQOYLam0Xmy
         v7aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=34+/2L5UqZgBD/IEOPObgtOlHcvjMeH49/BCWrNQFRQ=;
        b=F/UkfpGxkmYWdG8nUPZ0VAVyantUiD/jCTAmgfhB0ErndfVDZ1vLg2STmcguUTaH82
         UwxFyIfJ8/HUbhRv9fW6RZ+rtzZZ7+Tun0pR3ecLE4eRk3x3QipH6oqpY0OlmZH2qMLi
         h/KlZmIh05TF003/Bz1ldwTZ2WLTV2C+tslQ9a+aSaKiJDepTQQ/nvmlVa6fetPaQFit
         8hSsnNvGJQnEXpT9k/Vam6VE4x2Bd64WLBDg/HOHNVwJx2ZfgSIcXyFXDAhUsJFohI/8
         Fb22RbQ8xMUol0T0QREuyl3wJuxYF29mh6abwByvTqTIqUCkZPQ+gnRfu8qtYBoNiFjs
         oF3Q==
X-Gm-Message-State: AGi0PuYGoTjlRQC4zjQ8d4nPtkWdGfNvidQy1zjhP7pEnYEb3vnaZLaX
        Kjw1fYJ2+wgCfpcYTGDYm1I7RnWRAk0=
X-Google-Smtp-Source: APiQypLM6PDfnzjDMeuJBxiNPqjL1kTWX8NkLTX0CVmTpUvmG3a5IKcijZ0Abw7if66VU3/X6gD8Fg==
X-Received: by 2002:adf:f9c6:: with SMTP id w6mr10555302wrr.341.1587241237870;
        Sat, 18 Apr 2020 13:20:37 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:37 -0700 (PDT)
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
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org
Subject: [PATCHv3 35/50] um/sysrq: Remove needless variable sp
Date:   Sat, 18 Apr 2020 21:19:29 +0100
Message-Id: <20200418201944.482088-36-dima@arista.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200418201944.482088-1-dima@arista.com>
References: <20200418201944.482088-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`sp' is a needless excercise here.

Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: linux-um@lists.infradead.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/um/kernel/sysrq.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
index c71b5ef7ea8c..c831a1c2eb94 100644
--- a/arch/um/kernel/sysrq.c
+++ b/arch/um/kernel/sysrq.c
@@ -27,7 +27,6 @@ static const struct stacktrace_ops stackops = {
 
 void show_stack(struct task_struct *task, unsigned long *stack)
 {
-	unsigned long *sp = stack;
 	struct pt_regs *segv_regs = current->thread.segv_regs;
 	int i;
 
@@ -38,10 +37,9 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 	}
 
 	if (!stack)
-		sp = get_stack_pointer(task, segv_regs);
+		stack = get_stack_pointer(task, segv_regs);
 
 	pr_info("Stack:\n");
-	stack = sp;
 	for (i = 0; i < 3 * STACKSLOTS_PER_LINE; i++) {
 		if (kstack_end(stack))
 			break;
-- 
2.26.0

