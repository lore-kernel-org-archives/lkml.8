Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07212C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D33B420674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="k8DqLuIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbgCPOkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:40:39 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45156 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbgCPOki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:40:38 -0400
Received: by mail-pf1-f195.google.com with SMTP id 2so10035000pfg.12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1W3BWeYXeaTy6R6tz8F0+ltPWyHSG7kXSfeInCCAOo4=;
        b=k8DqLuICYe1A5NmZpNp8i9hg3p1Ml1HTg8MPahxN5OtvLf6V/oCN5tIWBJE2EkvIgx
         zsHZrh88AP5p5lw22tQ4Hc4xzCntBGSsoWStbp849vygfzcy/efGhGBKOPvgh4RSLsNq
         GkzqK/2KFRFuAJHTKQTYWvC33U4LytZJtJp2GISNiQ/ptfW/UnltXjNoP0k58hvsU/9q
         6Gy90xOS59QKuU4t8Kqd7Zcyp8KL46BTATH81zPgs0RuFUb65ES2btzWxoPl8ESg4ZT/
         iNEQwJv0BvHT/aqjp30qn1SzzhyANZ+0/CFmCGoQ//5yKnNBhoPH8SzjbeAtmcIUeFO3
         h3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1W3BWeYXeaTy6R6tz8F0+ltPWyHSG7kXSfeInCCAOo4=;
        b=fNdQkUV14wdEAogBZn12C4rbVBEQZ/nbIr1U6bUCidrRiioqOgBTzCdm6aRV3xfRx9
         U+rZvgUrqK2WnnKMytpBKFgWUTfafcF7rm+YCU6bQNNep4zfp3AR4c36TGZksRhJ/T+T
         YrSHIWRESrQy0hnv9VcP/YRWa8oGBulUSy6HCcT09kM7NyzuLAXcNGHesDom3+BKfByo
         wdvQhq2QDMw3MUgA761bk5FIZEkvnAcGnlW4EL4sy93bMT7Bk90+EE+tMyomMEmmQ6UJ
         24Xl1V0dRY6emMBgaTnnmqzTDFd2B10Fp2KC6XX+Sb++HI5pqoKW3VJ/OXbPmPv4MAnY
         CyNw==
X-Gm-Message-State: ANhLgQ1CX8dkVAiBfr7ZGXq8yucfke8y2sPaZ7caCEE8UTpQt1CgPmC2
        Q5EC+4Vqtuar6IEAz1YP/9moERzHdOM8rw==
X-Google-Smtp-Source: ADFU+vvZAMQv9VHSbGhYJpVO1MnD5NsA/P6WItDDiS2PKzahMpEPI8pyDTeUnIp3RauDekgApc8LJA==
X-Received: by 2002:a63:1862:: with SMTP id 34mr166772pgy.191.1584369637320;
        Mon, 16 Mar 2020 07:40:37 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:40:36 -0700 (PDT)
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
        Guo Ren <guoren@kernel.org>
Subject: [PATCHv2 12/50] csky: Add show_stack_loglvl()
Date:   Mon, 16 Mar 2020 14:38:38 +0000
Message-Id: <20200316143916.195608-13-dima@arista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316143916.195608-1-dima@arista.com>
References: <20200316143916.195608-1-dima@arista.com>
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

Cc: Guo Ren <guoren@kernel.org>
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/csky/kernel/dumpstack.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/csky/kernel/dumpstack.c b/arch/csky/kernel/dumpstack.c
index d67f9777cfd9..c500837390d3 100644
--- a/arch/csky/kernel/dumpstack.c
+++ b/arch/csky/kernel/dumpstack.c
@@ -5,7 +5,7 @@
 
 int kstack_depth_to_print = 48;
 
-void show_trace(unsigned long *stack)
+static void show_trace(unsigned long *stack, const char *loglvl)
 {
 	unsigned long *stack_end;
 	unsigned long *stack_start;
@@ -17,7 +17,7 @@ void show_trace(unsigned long *stack)
 	stack_end = (unsigned long *) (addr + THREAD_SIZE);
 
 	fp = stack;
-	pr_info("\nCall Trace:");
+	printk("%s\nCall Trace:", loglvl);
 
 	while (fp > stack_start && fp < stack_end) {
 #ifdef CONFIG_STACKTRACE
@@ -32,7 +32,8 @@ void show_trace(unsigned long *stack)
 	pr_cont("\n");
 }
 
-void show_stack(struct task_struct *task, unsigned long *stack)
+void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
+		const char *loglvl)
 {
 	if (!stack) {
 		if (task)
@@ -45,5 +46,10 @@ void show_stack(struct task_struct *task, unsigned long *stack)
 #endif
 	}
 
-	show_trace(stack);
+	show_trace(stack, loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *stack)
+{
+	show_stack_loglvl(task, stack, KERN_INFO);
 }
-- 
2.25.1

