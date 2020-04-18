Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281D7C352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08D0D22209
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="TfPj9ySB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgDRUVk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728632AbgDRUUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:42 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083A2C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:42 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id x25so6515574wmc.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WOAAL059q08TUQyLaU5h1Qu4oH/W2Ner7N3PjhGnKis=;
        b=TfPj9ySBzrHWXH6qy4syTHIgj9+AMHcw4ivE3mb2lFL3fB/rqtaXCYj8lNRcubqMrA
         WOa7I/l2j/VxXkWBuwiiQtpkgOtskErvb8ByXtFT4zCxxzaYaUcjj3TEW3twJ3AK7NZq
         ccKfADHyXpd0MCWDVh80oMal3/A/B7oUHkjp1tS+s44wD4oasOMcethPLY2GCj2oYwTK
         enFwT/whZWW7xLNH7WfcJ235FDyWGiIaOWnYS9es0CC665MxI0hk6MsErux5t406PMRQ
         QT+Sq8gVyfYZrUInAj8sIdxg/xlUfitvD0YJOhllco2Zm7VLyz9dbPtdY2K6m17JZdOU
         9xkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WOAAL059q08TUQyLaU5h1Qu4oH/W2Ner7N3PjhGnKis=;
        b=hHsyMNs0FyJvoKeN6faiaZuQg0OMFS3Q6I2NS9BAo/1GahyocYFqN21Ie9tR3EpV/X
         UhmZY6/uviMOicBrQQdEDMIPnTm5qoyztiU8xoo3RdGMLSAk9TIzKCIwNmTxyk8G8QLI
         wiIANKdtXssury3scpI1K6FJdcx38dCD8P2rktCr1l7Lia7Edz/wv2EUFOGL8bOXhYWu
         Eggm3wIcurqlDy0X1YXa8mCWTagzgsIB8UutLMn0jh3AGnPdVtpOKhT4xdedFm51Kf+8
         M/aUpXx3tSxnmqLtH0gyZ3Icwj/cPDsoOaqs+q8hEIQBL0joqQ9vqd/jxRtDRPSyzIv3
         jYrQ==
X-Gm-Message-State: AGi0PuaFpgdXg3bRXP7Un99h+JPQzNSjWZiOzFJThO99mCkzcqMhxolj
        4PsA7fpLDg42AUWZESzzkWKCvIybT9M=
X-Google-Smtp-Source: APiQypK8/oNPHfokJBnzBa5DaRylIg+2GWeXVmcZZqG1yLQFt/g5AR4S25puF2X8Ay2v2lmmdF8Ong==
X-Received: by 2002:a7b:c959:: with SMTP id i25mr9383433wml.20.1587241240522;
        Sat, 18 Apr 2020 13:20:40 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:40 -0700 (PDT)
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
Subject: [PATCHv3 37/50] unicore32: Remove unused pmode argument in c_backtrace()
Date:   Sat, 18 Apr 2020 21:19:31 +0100
Message-Id: <20200418201944.482088-38-dima@arista.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200418201944.482088-1-dima@arista.com>
References: <20200418201944.482088-1-dima@arista.com>
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
2.26.0

