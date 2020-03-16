Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAEAC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 114C220679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="liD2Idf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731782AbgCPOm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:42:58 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33708 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbgCPOmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:42:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id n7so10072083pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j3cUbQVabICfO1CIrkEBsh0/UMvP5KLxWFAs81fDdU4=;
        b=liD2Idf8gdBWIOPa2UK7LFiJgH+gdYdIEZOohCBJgL1SPdRCDNc5/Zk/Atg2XeWQiT
         OfzD6U5bJdyOdDpZQhcqGiaAWX2Fa1uzI2IUrfELIbUzz7CMAusUE7tM8skEDKpGDSt7
         cB3ID6eAymjLnITog18ktFdxp6bg85faeTnEgOpargSUZFBYeH0+tqrkZIElOOQYu2qb
         2xqLTHQexpgTmx3/8WfdyZDu3e447tNLos3xzIB09N4sCsl5NhtduGYNk27e5i/9N3TF
         EG3p5RUQBkAU0qAkNgaY2OO6hBJINpHReVvT5hUzhAiNRozdLAILBvi0OMbwRV6ptoUq
         u6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j3cUbQVabICfO1CIrkEBsh0/UMvP5KLxWFAs81fDdU4=;
        b=UWMwiRKVYyNNppXu4Fn/JkcKVmDU5TAsNIvDxrKmIqD60s1Gxk8Fak3oprmk843W3D
         Ti5VTFiI/ibxk79o72kNgcB0HdSZmVhlV89X+UooimOJwdb0ZLvnP62QikrobLCMoy0m
         /uQ7Yong9sZSdJHp+5BVeCSZtzaf52XyMOOjUnSm+1P1SDFgMpOwcMR0MuEJFVlyUSs3
         9+9KeMa/xNV4bWYGxgdfq4EhvKVn/Hu9N69Nr5hlQhJhlElDzGFKpGb+umjyExHIURgJ
         g+zPiKXMf47hRwM2ymliTHmaKYGRxFxN5h3FtBge2XX19PM6AnVvAuacOaUNsNABV3jY
         AfUQ==
X-Gm-Message-State: ANhLgQ0QzxzvrtHxNrf8UQy7ThR9LmgCtWXJzENjAGgy77lPwi84XUIB
        jNTRyEnWsFdCE4XMh3ujKczdWk999zgczA==
X-Google-Smtp-Source: ADFU+vsfcpDv3wFgwcL3RJlNVhGlD9LAlf50NK8mE9XXybmQUygyzjMZHS+PUaMKY2XT6kETFltDNw==
X-Received: by 2002:a62:d408:: with SMTP id a8mr26928913pfh.99.1584369773995;
        Mon, 16 Mar 2020 07:42:53 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:42:53 -0700 (PDT)
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
Subject: [PATCHv2 43/50] xtensa: Add show_stack_loglvl()
Date:   Mon, 16 Mar 2020 14:39:09 +0000
Message-Id: <20200316143916.195608-44-dima@arista.com>
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
2.25.1

