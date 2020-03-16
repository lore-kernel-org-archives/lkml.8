Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81F6C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D4DE20658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ie6XMNLr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731882AbgCPOmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:42:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35906 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731572AbgCPOmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:42:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id g2so5602914plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2WuROG7p9xDXrDUoQmG0UFQkyt5AI2QC9GLLPwUWwUk=;
        b=ie6XMNLrZLpp5pcj+BVZDJ72LWYVqbHhlW0828D0/mPHBOnmjfQF3VKXCZiIzICs5R
         9HKirNYcJ89fGuZEPkn0x37FUK9ItKTmo3J42PXpMkTMwhKBUuQkOFAr9+diJOW3Whrq
         gRDLavz6TiymVV85bRVdYMUCFip+ei/I8H7y9+Qq1/9vbxOBH+vdvEytxZd0ZDX2iMTd
         ZQ4J2jyFBXmqKlEWfYekIkxZp8kLFkWsONqmbpcIKvV9JpvnDHNX/SsEvk65L4gNWZ31
         vtAfbZzC3BGBRUoSXiLoOiAAdO6+ezS9/gpcUm/073xe9/sO2tJWoEz1qJYOUUm38VFP
         tVsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2WuROG7p9xDXrDUoQmG0UFQkyt5AI2QC9GLLPwUWwUk=;
        b=Rl6nzoo+0/dkprTYPSTzT3HeCrKpXgPy/WIHFD0h3BiAW+/vaTNyEKO7i8qKZuA0Ba
         RF/fsW2GmupfLsVx7Yr/sIZtp0VKtYTH7WYMsU8QSt8XEwKHyS2cawLmzixZM947+is1
         x8tI9BRaMOusMCWIK/NyiCjXEIFP/QZPcv9b113rF1/+IzMyBisdc/TW9Ps90f6XlsTg
         P1zxeaeARb4oSHdIMcbOh79GcV3g+uY49syXlq80JvfQG22PeIO8kWeiJpoGcUna028Y
         vi2AfQxgaonTvomtq/PZYLuZDNsjQjmrB4zlMylk+QTfu4rC1NxcOBR6zjGAaRxHsgb1
         xynQ==
X-Gm-Message-State: ANhLgQ0ttd1lT9Ioy1dbQx8M4z+eTPA8Df75+gFkeW2SFYWd4rz/TDSe
        EjOoXaQFoC+vhmmdZXvJED1aRJDipk/SDQ==
X-Google-Smtp-Source: ADFU+vtDwRfD1spfik9No8awM5gOWgWPwX1SkirikXB9ACrvcvRlcbGJOGLtvB6BzYEUvynLZB4ccQ==
X-Received: by 2002:a17:90b:1997:: with SMTP id mv23mr5926595pjb.84.1584369737997;
        Mon, 16 Mar 2020 07:42:17 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:42:17 -0700 (PDT)
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
Subject: [PATCHv2 35/50] um/sysrq: Remove needless variable sp
Date:   Mon, 16 Mar 2020 14:39:01 +0000
Message-Id: <20200316143916.195608-36-dima@arista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316143916.195608-1-dima@arista.com>
References: <20200316143916.195608-1-dima@arista.com>
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
2.25.1

