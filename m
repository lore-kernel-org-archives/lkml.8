Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6184EC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353E72051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="BcUu/qEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbgCPOlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:41:50 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:32851 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731614AbgCPOlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:41:49 -0400
Received: by mail-pg1-f196.google.com with SMTP id m5so9889629pgg.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Eirw1+CPEwOm9XDny2XZP8XgLLmqTIbu051zNlJl2YI=;
        b=BcUu/qEEKClkKnpXgI3q3V6khj8IpC2a07GWHZIS/cr6Fb4nNDLbhXbdOCHRroK6L4
         ro0wccURxr4wDaYw64s/ljpNl9dLHr13jsdHV0PenUisf6MFApAooUzSDzk3FScrWx9w
         5oyNFyPrxI4bHYDB9aiLGSRTMV+C567KMX5ZUWurCcceMY9ukOeszTlbNv3bqbZoHDkO
         e8R6LNu97lmLaJS7qWq7BRJET51MFPKGp205IP40HYNWxNtM1Kgdz5gNdvvQb96b4LDZ
         YnuLBV+ZR4loerJ5CsjUhI5DyQsqML8V95JuVNawxivCDa1bi1gUBQAhRzPTMcwBP5i3
         qE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Eirw1+CPEwOm9XDny2XZP8XgLLmqTIbu051zNlJl2YI=;
        b=gb6Ex+EDWfaiaVOhZ6NeJ2+N6Uvf6ykMG4WR/OL9mh4A3kkBZT8CB59TQJOQcVB8UF
         Dn6iiOfL0A8tISv7kPYpOI8mztLRQYI2gTDm1inFxGCD51IsR7pvFIb99dTiQBG7F/XL
         49SMroT6ojoGhq3ol0Qhp0JqyH5K7lHta5Tx1opa+BsvB7L2B3fPiPDmrmB6DnPtaHWt
         15LyKZhhqHrZ8Iebf9ES/F/sixk8A3j6pTYrnEl2D2ep0FIeA5JMBtJynpicu0f4Ckur
         bKW0iprmnrrwJyrKXPjlNHNyGcx3sG2kCcNYfSGY5J5qK0qRm8uz5mmiFtMuxgnvmh7k
         gzBA==
X-Gm-Message-State: ANhLgQ1W/JyW4dNqChhzhEvne7jund9WTaU+w27qroYVA/JRFLDeWJxS
        NwSws71WQnT39op2kemOWrF6HHw3sKlO4w==
X-Google-Smtp-Source: ADFU+vtmKxkjoaf5j4+z2trd3YLJQDV0qB59iuP8qelC8HGL/enlXyLmnej0EP3ur2rgqjBHdpEtcw==
X-Received: by 2002:a65:5a8a:: with SMTP id c10mr160621pgt.315.1584369708294;
        Mon, 16 Mar 2020 07:41:48 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:41:47 -0700 (PDT)
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
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCHv2 28/50] s390: Add show_stack_loglvl()
Date:   Mon, 16 Mar 2020 14:38:54 +0000
Message-Id: <20200316143916.195608-29-dima@arista.com>
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

Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/s390/kernel/dumpstack.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
index 2c122d8bab93..887a054919fc 100644
--- a/arch/s390/kernel/dumpstack.c
+++ b/arch/s390/kernel/dumpstack.c
@@ -126,18 +126,24 @@ int get_stack_info(unsigned long sp, struct task_struct *task,
 	return -EINVAL;
 }
 
-void show_stack(struct task_struct *task, unsigned long *stack)
+void show_stack_loglvl(struct task_struct *task, unsigned long *stack,
+		       const char *loglvl)
 {
 	struct unwind_state state;
 
-	printk("Call Trace:\n");
+	printk("%sCall Trace:\n", loglvl);
 	unwind_for_each_frame(&state, task, NULL, (unsigned long) stack)
-		printk(state.reliable ? " [<%016lx>] %pSR \n" :
-					"([<%016lx>] %pSR)\n",
-		       state.ip, (void *) state.ip);
+		printk(state.reliable ? "%s [<%016lx>] %pSR \n" :
+					"%s([<%016lx>] %pSR)\n",
+		       loglvl, state.ip, (void *) state.ip);
 	debug_show_held_locks(task ? : current);
 }
 
+void show_stack(struct task_struct *task, unsigned long *stack)
+{
+	show_stack_loglvl(task, stack, KERN_DEFAULT);
+}
+
 static void show_last_breaking_event(struct pt_regs *regs)
 {
 	printk("Last Breaking-Event-Address:\n");
-- 
2.25.1

