Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC29C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F58205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 06:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L0W/K1xn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgENGEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 02:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725794AbgENGEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 02:04:22 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54BD3C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 23:04:22 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mq3so12109199pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 23:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jIhLxFkEstOsX75pumvf5hU2eBHJHovEbl4Iz1TB1jM=;
        b=L0W/K1xnR7MMQITjCNmLpKOXf7FvtySaQ3VbWxyy+zvlzITfyanCbXc9KlwTBBhvLw
         t51+JQFvtipVmwE6S+b+MUn1JG1Kwlq+MEXyoDr5aMDnHjrVIzqGGdnC4hcRNs3bYxkT
         60jUs75foj5zcp36N8W5Pw/Dr9XIjcNtcCgEoflNRTVNo6+yjeeeuuCsvxkRmUMbQor8
         q2PZOaBLV5ovzv1btAdtbkLPA4MD8/hNc2n8XvNgJ0M2seZJ4YcTxPrNJME0AG/dVEka
         TyU7HXt66Vxa70HfCFlsSs12EEdFV/y7hZGQzLQf33gB4v9gJpMAh5DB6CcDjecCoL5G
         PGlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jIhLxFkEstOsX75pumvf5hU2eBHJHovEbl4Iz1TB1jM=;
        b=EPZEtu62iw0++fdctR4Qt2YBYJpqBFdjPOGLRKRMhZoGK7WbJyFfW+rW87CVN7BXLs
         PKwuS1cVF0BA32JvTaDu7R7rOIhsbtQ+wPo+pg8vpUEeGvcUPQ8R7ogTKWhc1wMr7C2n
         KjILFFJjBp4lWp9CR95op1Y4CEUz8rhOjWq9eTT5xg/7KMBpbFAlXqLmVJLW9q2nqKJm
         EmPbIDXyyUXNAB6uVzreggvwA96cJ1Xvjyi9YvWDk5kWHArXbCFArVejSXWr4kS8c+vE
         KaEZzzI3vvafjPhImyf4z84FEidvUFPUAuSmFHYcnYPKP5Xt2q510dOuFBRoMr7KNont
         ZLPw==
X-Gm-Message-State: AGi0PuZJkYrtEUpeAzsz6mKjgdsa7fWTU2cUF/7WNyykMc023aPciyK0
        C7pPbO/J9ljEgDqhhl0WHqM=
X-Google-Smtp-Source: APiQypIbm5vJB/18u0FHVukAqq/pAqHrSF7OX5evfSOxMv2SwznRLQtf/p9XqjdQHR8VtGHuxbTxFQ==
X-Received: by 2002:a17:90a:104f:: with SMTP id y15mr40049008pjd.191.1589436261882;
        Wed, 13 May 2020 23:04:21 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([124.156.176.138])
        by smtp.gmail.com with ESMTPSA id m6sm17087974pjo.5.2020.05.13.23.04.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 23:04:21 -0700 (PDT)
From:   Qingjie Xing <xqjcool@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        Qingjie Xing <xqjcool@gmail.com>
Subject: [PATCH] kernel/sched/wait.c: set timeout to 0 when kthread should stop
Date:   Mon, 11 May 2020 23:50:21 -0400
Message-Id: <1589255421-28264-1-git-send-email-xqjcool@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using kthread_stop() to terminate a thread causes tcp_recvmsg()
to enter a dead loop when the kernel thread uses tcp_recvmsg()
to receive a message.

tcp_recvmsg()-->sk_wait_data()-->sk_wait_event()-->wait_woken().

wait_woken() will directly return unchanged timeout value rather
than be executed as normally.

tcp_recvmsg () will continues to execute sk_wait_data(). So finally
this situation will creat an endless loop that cannot be exited.

Signed-off-by: Qingjie Xing <xqjcool@gmail.com>
---
 kernel/sched/wait.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index ba059fb..a27bbbd 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -431,6 +431,8 @@ long wait_woken(struct wait_queue_entry *wq_entry, unsigned mode, long timeout)
 	set_current_state(mode); /* A */
 	if (!(wq_entry->flags & WQ_FLAG_WOKEN) && !is_kthread_should_stop())
 		timeout = schedule_timeout(timeout);
+	if (is_kthread_should_stop())
+		timeout = 0;
 	__set_current_state(TASK_RUNNING);
 
 	/*
-- 
1.8.3.1

