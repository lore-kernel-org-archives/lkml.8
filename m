Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6283BC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A81C20658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="kvpipGXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731906AbgCPOm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:42:29 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47073 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731736AbgCPOm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:42:28 -0400
Received: by mail-pl1-f196.google.com with SMTP id r3so60742pls.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mu70j2zd27Qp7nZNgZ9zlFDn59B6L0OXaYJ4afCaLWA=;
        b=kvpipGXCr+6Oo/L0DoyyfwJVSvmb8WxSUmNi4PbXLwwMm+xZ1ZlyvV2s3Wt8sil0Jo
         blQfZWiWDbl3yhpDD/VolwKS0pWMyYxOSpg3fTE0Fk7YEjTSz/RQvpcMt+J9vyF6Tz9K
         n/44BenJwpKu2IvC6xJJilyBzDG+zFvR1hAsLLMnOm8XmYjvrrSolOQjrStOk605jm+/
         2tT2N1+iLva4431beqWkfpj1EfI2/BpHpf+jQHh6b1hsaBkNKkl3b25jZR8Vl/aNglRg
         JSPT5Zoe94dB0ydU9m+ncbeh81PB7+ddOIdPGeTQDauLMLUjtsHp/SHz1rFhtQtLDleZ
         iq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mu70j2zd27Qp7nZNgZ9zlFDn59B6L0OXaYJ4afCaLWA=;
        b=aVIv5Ur1QPEnGIJlCwWZlrSovL7mAv8CfL0jyC/j2BgtNrk+6wqMGnnaS3nwL0c6jW
         beO9apsd22mKAgszftQBRD/WgdeIKU+iH/xt3wee0m9IHi+YRez5eeH+VkoWjz3NWTrD
         TnuH3jJy/gWeOS5no4AyYyaYJgQ0M2dM7XCxRI2FkAO2ctHh/CdW0qHqu2JpXAED3IrU
         wzx/hLaWSeKJ0QbIJU0+BUhBMj6I3mdpYUfcwzNe7blraM93zY0LwWzEYcjbhzgTW6Cp
         WSnANV+6zk99bRKIxuVfvNtLaOWYAaMtpriGceUuU1PfgSN5SPOhYOzdEf9ejfA0aQZh
         kx9g==
X-Gm-Message-State: ANhLgQ0sOusbDkVhrFFFcIoD2ZxAyVcrKxTS4Ay9Alb1h5vgSLlSTjBv
        fGyYHELpHd2UPTJ0aVYuoW6AsSJ2eae9XA==
X-Google-Smtp-Source: ADFU+vuIoxQVxDjYcqeKL7mHtMH0kk7HFo9shj7jEP7+JRAKjLGBeODObapBW2IERHpVs8xNeg38MQ==
X-Received: by 2002:a17:90a:b395:: with SMTP id e21mr8964514pjr.103.1584369747111;
        Mon, 16 Mar 2020 07:42:27 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:42:26 -0700 (PDT)
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
        Guan Xuetao <gxt@pku.edu.cn>
Subject: [PATCHv2 37/50] unicore32: Remove unused pmode argument in c_backtrace()
Date:   Mon, 16 Mar 2020 14:39:03 +0000
Message-Id: <20200316143916.195608-38-dima@arista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316143916.195608-1-dima@arista.com>
References: <20200316143916.195608-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pmode parameter isn't used in assembly - remove it.
Second argument will be reused for printk() log level.

Cc: Guan Xuetao <gxt@pku.edu.cn>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/unicore32/kernel/setup.h |  2 +-
 arch/unicore32/kernel/traps.c | 14 +++++---------
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/unicore32/kernel/setup.h b/arch/unicore32/kernel/setup.h
index e40d3603c7e7..03e70e37f472 100644
--- a/arch/unicore32/kernel/setup.h
+++ b/arch/unicore32/kernel/setup.h
@@ -29,7 +29,7 @@ extern void kernel_thread_helper(void);
 extern void __init early_signal_init(void);
 
 extern asmlinkage void __backtrace(void);
-extern asmlinkage void c_backtrace(unsigned long fp, int pmode);
+extern asmlinkage void c_backtrace(unsigned long fp);
 
 extern void __show_regs(struct pt_regs *);
 
diff --git a/arch/unicore32/kernel/traps.c b/arch/unicore32/kernel/traps.c
index e24f67283864..3682a4c5d927 100644
--- a/arch/unicore32/kernel/traps.c
+++ b/arch/unicore32/kernel/traps.c
@@ -137,7 +137,7 @@ static void dump_instr(const char *lvl, struct pt_regs *regs)
 
 static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 {
-	unsigned int fp, mode;
+	unsigned int fp;
 	int ok = 1;
 
 	printk(KERN_DEFAULT "Backtrace: ");
@@ -145,16 +145,12 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 	if (!tsk)
 		tsk = current;
 
-	if (regs) {
+	if (regs)
 		fp = regs->UCreg_fp;
-		mode = processor_mode(regs);
-	} else if (tsk != current) {
+	else if (tsk != current)
 		fp = thread_saved_fp(tsk);
-		mode = 0x10;
-	} else {
+	else
 		asm("mov %0, fp" : "=r" (fp) : : "cc");
-		mode = 0x10;
-	}
 
 	if (!fp) {
 		printk("no frame pointer");
@@ -167,7 +163,7 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 	printk("\n");
 
 	if (ok)
-		c_backtrace(fp, mode);
+		c_backtrace(fp);
 }
 
 void show_stack(struct task_struct *tsk, unsigned long *sp)
-- 
2.25.1

