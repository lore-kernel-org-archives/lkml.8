Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81632C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E4702065F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="I+oZMYMx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgETLzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:55:36 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:37556 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726435AbgETLzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:55:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589975735; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=kk/GsuDE6ll1jB2RxfLcgdLRrs8QROW9zKYeSI1XwB8=; b=I+oZMYMxgmz0IHr5PevjCu1kENR8CbyxmYbgOgu3dPmNX/eblUisR/wjfMIRn4jTN04ra3pf
 fqivSjgCxSo2H0K+0NKo3g+7mAfjGd0EBPNiA+ZX7xH1+9EpGQbg573ptxUs+BO3fDXHAGlu
 ZVlmLhX8P5bEm7xWl0NekDOWz5Y=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5ec51ab04e523733abd3cf59 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 20 May 2020 11:55:28
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AA622C433CB; Wed, 20 May 2020 11:55:27 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 76314C433C6;
        Wed, 20 May 2020 11:55:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76314C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
From:   Pavankumar Kondeti <pkondeti@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     Vinayak Menon <vinmenon@codeaurora.org>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Liang Chen <cl@rock-chips.com>
Subject: [PATCH] kthread: Use TASK_IDLE state for newly created kernel threads
Date:   Wed, 20 May 2020 17:25:09 +0530
Message-Id: <1589975710-9283-1-git-send-email-pkondeti@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel threads are created for later use, they will be in
TASK_UNINTERRUPTIBLE state until they are woken up. This results
in increased loadavg and false hung task reports. To fix this,
use TASK_IDLE state instead of TASK_UNINTERRUPTIBLE when
a kernel thread schedules out for the first time.

Signed-off-by: Pavankumar Kondeti <pkondeti@codeaurora.org>
---
 kernel/kthread.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index bfbfa48..b74ed8e 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -250,7 +250,7 @@ static int kthread(void *_create)
 	current->vfork_done = &self->exited;
 
 	/* OK, tell user we're spawned, wait for stop or wakeup */
-	__set_current_state(TASK_UNINTERRUPTIBLE);
+	__set_current_state(TASK_IDLE);
 	create->result = current;
 	/*
 	 * Thread is going to call schedule(), do not preempt it,
@@ -428,7 +428,7 @@ static void __kthread_bind(struct task_struct *p, unsigned int cpu, long state)
 
 void kthread_bind_mask(struct task_struct *p, const struct cpumask *mask)
 {
-	__kthread_bind_mask(p, mask, TASK_UNINTERRUPTIBLE);
+	__kthread_bind_mask(p, mask, TASK_IDLE);
 }
 
 /**
@@ -442,7 +442,7 @@ void kthread_bind_mask(struct task_struct *p, const struct cpumask *mask)
  */
 void kthread_bind(struct task_struct *p, unsigned int cpu)
 {
-	__kthread_bind(p, cpu, TASK_UNINTERRUPTIBLE);
+	__kthread_bind(p, cpu, TASK_IDLE);
 }
 EXPORT_SYMBOL(kthread_bind);
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

