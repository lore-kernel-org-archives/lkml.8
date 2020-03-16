Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF87C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 343532051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="PPDVtvTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731880AbgCPOmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:42:16 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:34174 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731872AbgCPOmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:42:15 -0400
Received: by mail-pj1-f67.google.com with SMTP id q16so1435783pje.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CKzmyWGTBxUz5GAvFJd/RAIPCL6otj16Tz4SiAfElss=;
        b=PPDVtvTLLuLVBBfjuG5HCnZ604AsQtpovQaVrospEvbfrdNJHG0dUj+z/uXvbO92V5
         QQTAwVWXq+xy4nNZcPMtv+1YEK7HOw3jqaSeKlkyXzZBJA+bJOo5HGetbjFgA2ScD0fU
         fz8BQaqjEmhaXFmot90WuLHM2hAJ+hzuqV/OyYMG4p7D1LDaAFwJqDOI1ap2W+PC4Wdv
         ooXbaJepE1fUhHdceIl+aV47yUvclxNZzxgdGaadVZPQBhO2YLQ1/ypZQYOSWm9LBbPW
         o0xZeMOtKCwy2vTq0JotdPddh5uKKi5v2kAJPiOGV9Zf+V7B1lucUpReN/cTTDq9AQgT
         u+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CKzmyWGTBxUz5GAvFJd/RAIPCL6otj16Tz4SiAfElss=;
        b=TtmM1hx9gjc8hH+NPdBT0MfmgD8dzR4rcBQ7Sdd/rKoEsUzsdNNiJnc5p5XB9N20md
         KcJWl6ZR45FMepVmmeDwYt08Aq3vRpTLNFRnZc+ZNKzAOp4XHEsoxeTisDV8zP0Xz23I
         +tfzLbBpQcvR2XaBsD8CDskhDfApNntk9XIQEAALF5fU64GepYf3u8zFi+nKf6yGSM+Z
         yu93ynb49Cr5FVAdQ1VQNveD4pnSJG94J1z6kHQZzoxKAdobqemwUNfpvM1NJZjxJM24
         S1Ylm0OHNOkXLm7iDGwuOrX3hcQgsjq65Fjd3IPMMfnOlWQ6OhxzeBgevHIh7C5NiA3d
         myjg==
X-Gm-Message-State: ANhLgQ2AwhJnuwPdQcjwlt4uy/ZBwHc9QRdKuBXQHlnsMo0tGag1+uz5
        MW7AxQ3+TOucZc5L1Lq5x1nLr5nwovYh1A==
X-Google-Smtp-Source: ADFU+vt5V4s6MO/GQlwK2npa7WQnZw4mRUtHAN7IY4q6iRlMzvJTAc+W0zCvC1+Mq/QtohzWjHRt2A==
X-Received: by 2002:a17:90a:b94a:: with SMTP id f10mr1374711pjw.62.1584369733612;
        Mon, 16 Mar 2020 07:42:13 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:42:12 -0700 (PDT)
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
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCHv2 34/50] sparc: Add show_stack_loglvl()
Date:   Mon, 16 Mar 2020 14:39:00 +0000
Message-Id: <20200316143916.195608-35-dima@arista.com>
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

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
[1]: https://lore.kernel.org/lkml/20190528002412.1625-1-dima@arista.com/T/#u
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/sparc/kernel/process_32.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index 26cca65e9246..0b07de5618e5 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -145,10 +145,12 @@ void show_regs(struct pt_regs *r)
 }
 
 /*
- * The show_stack is an external API which we do not use ourselves.
+ * The show_stack(), show_stack_loglvl() are external APIs which
+ * we do not use ourselves.
  * The oops is printed in die_if_kernel.
  */
-void show_stack(struct task_struct *tsk, unsigned long *_ksp)
+void show_stack_loglvl(struct task_struct *tsk, unsigned long *_ksp,
+		       const char *loglvl)
 {
 	unsigned long pc, fp;
 	unsigned long task_base;
@@ -170,11 +172,16 @@ void show_stack(struct task_struct *tsk, unsigned long *_ksp)
 			break;
 		rw = (struct reg_window32 *) fp;
 		pc = rw->ins[7];
-		printk("[%08lx : ", pc);
-		printk("%pS ] ", (void *) pc);
+		printk("%s[%08lx : ", loglvl, pc);
+		printk("%s%pS ] ", loglvl, (void *) pc);
 		fp = rw->ins[6];
 	} while (++count < 16);
-	printk("\n");
+	printk("%s\n", loglvl);
+}
+
+void show_stack(struct task_struct *task, unsigned long *sp)
+{
+	show_stack_loglvl(task, sp, KERN_DEFAULT);
 }
 
 /*
-- 
2.25.1

