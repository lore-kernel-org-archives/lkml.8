Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22B6C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BE612223F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:21:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="W0osrk2v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbgDRUVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728681AbgDRUUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:20:51 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55314C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b11so7164687wrs.6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 13:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cxaQsGwcajCaAbE0AN0/6fxs/dmraz1psCcScZx1Yww=;
        b=W0osrk2vhOkOKECIEVaoRIQRGIStYR/Gq9ZLhzJydrJUEmPLo7IOWBTGy/+TuBFBiz
         YrsZdFGM8DITKx1eC9mH58q7boAOynAJziYAR6XvIQ/veHKkGgxcI7URmEqaJtZ6dRvT
         Lur/KV422Ua1BkkaLndb5h2f6GMgVtQzDrVnRPSaxt4aOrIhvYQXMJUyKr49/rkZbm1/
         jokFUHTnWk5tXBimUror8oGePOY5MzonaxiSZS9P33uFCcb5u6NJwFJpJKIRd7bKGTLI
         Ljgdd+eSqsd2ygNUK8vKlTb5OwV+FK79JB1BZzMZWj1ocjcTAqS2CumLdY9QfjrJOYdU
         2rcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cxaQsGwcajCaAbE0AN0/6fxs/dmraz1psCcScZx1Yww=;
        b=eyoKCBGDd5tferV2EgUFL3ChkuiCeWUJXk4PYzunwkZWAO50ufmrcC57c3MSPqqWmW
         0Z4L913Kn/hi8glIISRArPnBXSdRwk/1vQkEX2EWAmrx3QH0w9SECdePFvVIUY2imMuE
         k3L1Zk7t9+U1TEJNy1LA472PyjOz4lYdZSEm8KgQGlQyKdVkKlzr3oNbGheC1yCLL752
         K/xO1TCSLQwGb8pcUKPehbzAVfl0cSMhEs4XPBa0JANVqxFBub1qPfSclEHx467CCGXr
         WSevjIMmr13jaH4puGcjsU628VkSwfmUOjUrPArUQjKYYP7uANo4wgN0W2I8Ic82LMug
         KaDQ==
X-Gm-Message-State: AGi0PuakR5AxuJMVjOJ7Bs4VRb0dEXJTcCYwr+0/Z3BmR7sOLjBbDGo7
        Fqrbnsa36kMkFRmwu8GDKtwplwzcmCE=
X-Google-Smtp-Source: APiQypKS6wD5obobIyQqRezqByToFHevr3HrrYTxsW8VXI4SjRXjS2TRCkQPTKoKavKRewg5cnR+fg==
X-Received: by 2002:adf:df01:: with SMTP id y1mr10317595wrl.401.1587241248861;
        Sat, 18 Apr 2020 13:20:48 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id m1sm31735255wro.64.2020.04.18.13.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 13:20:48 -0700 (PDT)
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
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Subject: [PATCHv3 43/50] xtensa: Add show_stack_loglvl()
Date:   Sat, 18 Apr 2020 21:19:37 +0100
Message-Id: <20200418201944.482088-44-dima@arista.com>
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

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/xtensa/kernel/traps.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index c397a02457bc..3a50813eeb70 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -501,7 +501,8 @@ static void show_trace(struct task_struct *task, unsigned long *sp,
 #define STACK_DUMP_LINE_SIZE 32
 static size_t kstack_depth_to_print = CONFIG_PRINT_STACK_DEPTH;
 
-void show_stack(struct task_struct *task, unsigned long *sp)
+void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
+		       const char *loglvl)
 {
 	size_t len;
 
@@ -511,11 +512,16 @@ void show_stack(struct task_struct *task, unsigned long *sp)
 	len = min((-(size_t)sp) & (THREAD_SIZE - STACK_DUMP_ENTRY_SIZE),
 		  kstack_depth_to_print * STACK_DUMP_ENTRY_SIZE);
 
-	pr_info("Stack:\n");
-	print_hex_dump(KERN_INFO, " ", DUMP_PREFIX_NONE,
+	printk("%sStack:\n", loglvl);
+	print_hex_dump(loglvl, " ", DUMP_PREFIX_NONE,
 		       STACK_DUMP_LINE_SIZE, STACK_DUMP_ENTRY_SIZE,
 		       sp, len, false);
-	show_trace(task, stack, KERN_INFO);
+	show_trace(task, stack, loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+	show_stack_loglvl(task, sp, KERN_INFO);
 }
 
 DEFINE_SPINLOCK(die_lock);
-- 
2.26.0

