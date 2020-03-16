Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C05CC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74A312051A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:43:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="W+9dXAtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731635AbgCPOnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:43:01 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:53126 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbgCPOm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:42:59 -0400
Received: by mail-pj1-f68.google.com with SMTP id ng8so1482129pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WmFBS14JXMEXPenWApvnYz3pDrUtv1d4djT5B5BXbiU=;
        b=W+9dXAtnYaZ8gb9dzNSVG2ORLV6t4E0Aw9yad9zGvnMHRdAnmYdLvqOpnjRH3txku+
         CkFoOxCrvYtY6PyjpDzY9T2nIRDxc5ESHZVHH3Ko+NMh1lHdpBvJgeGw+Qy9uKAMJcwZ
         WnlHIGHklBepL82SiSnp/chQZf+mTihOY83u0FzXQ2J9o8bqHa8p96PWeKFV3BRme73V
         WruhZA4xc4G6jr5mUrEtgCqAzFFyTKmMssum/4wcbpR3+oWGXbau5Szo6wQBLjv6UwHj
         ixWmn9LDQlFA82iAl6nDHirGb+Jk8YUH3WXSEWmPP0km+cwKQV7n1ZYmRgoTGSqZLS5A
         3f2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WmFBS14JXMEXPenWApvnYz3pDrUtv1d4djT5B5BXbiU=;
        b=j/7X2DmF/Ukth0ORKK+lbIpQlYPrJRuqdf20l8DjuuyNfjYM51Vxunra/CGji7j8YZ
         MUvQASHLi3Ca7ZA8vOYBTZ+z1631LhvYRN5vThycJ9XjNWOtxxCZPhkT7GTq21ujG74S
         DFpAUf1RmBGkXjL4vKC2Xv1IOOTf15QQ08AzXHpZ4FTyKEsmgmCqZ3HKpXEIvPdKdCzY
         y5wJaB1lowzSmEATZLw+Gcl1sUV8Tzag52IIo/zfRpRTwGdbxCgW28CHX5kFjDVBfpMG
         EUB6dzfy+5BM/sPC5yPc3Jx6H5BgEHnU/evdGt7s3WxJZPwWptXA04jfhcGo6sJwm9Os
         w0cA==
X-Gm-Message-State: ANhLgQ1lDyNn+LJ8hQ7dY0p8NPL989N2l5JpuXjHiPCRmC1Gz8/mYCsY
        dRX2KSQfnfOXEKD2rXIEOAJQZqy+FEuMng==
X-Google-Smtp-Source: ADFU+vth/ejP9tW5A/PSBxo3pnW44jD9HKUmh+HMKxy95ZAtVhdr53IZZdydEPgOzA/jnF8ZkONEqQ==
X-Received: by 2002:a17:902:9a08:: with SMTP id v8mr24845571plp.251.1584369778057;
        Mon, 16 Mar 2020 07:42:58 -0700 (PDT)
Received: from Mindolluin.aristanetworks.com ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id i2sm81524pjs.21.2020.03.16.07.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 07:42:57 -0700 (PDT)
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
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCHv2 44/50] sysrq: Use show_stack_loglvl()
Date:   Mon, 16 Mar 2020 14:39:10 +0000
Message-Id: <20200316143916.195608-45-dima@arista.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200316143916.195608-1-dima@arista.com>
References: <20200316143916.195608-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show the stack trace on a CPU with the same log level as "CPU%d" header.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/sysrq.c         | 2 +-
 include/linux/sched/debug.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index f724962a5906..fe1ffcbda194 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -220,7 +220,7 @@ static void showacpu(void *dummy)
 
 	raw_spin_lock_irqsave(&show_lock, flags);
 	pr_info("CPU%d:\n", smp_processor_id());
-	show_stack(NULL, NULL);
+	show_stack_loglvl(NULL, NULL, KERN_INFO);
 	raw_spin_unlock_irqrestore(&show_lock, flags);
 }
 
diff --git a/include/linux/sched/debug.h b/include/linux/sched/debug.h
index 95fb9e025247..373e4e3faf2a 100644
--- a/include/linux/sched/debug.h
+++ b/include/linux/sched/debug.h
@@ -31,6 +31,8 @@ extern void show_regs(struct pt_regs *);
  * trace (or NULL if the entire call-chain of the task should be shown).
  */
 extern void show_stack(struct task_struct *task, unsigned long *sp);
+extern void show_stack_loglvl(struct task_struct *task, unsigned long *sp,
+			      const char *loglvl);
 
 extern void sched_show_task(struct task_struct *p);
 
-- 
2.25.1

