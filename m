Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F0BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A07FA2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 15:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="isnKMIlX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgENPyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 11:54:08 -0400
Received: from m15114.mail.126.com ([220.181.15.114]:50670 "EHLO
        m15114.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbgENPyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 11:54:07 -0400
X-Greylist: delayed 1901 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 May 2020 11:54:06 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=loOkN7VR0utdCoO10a
        fFg9YFqd0qPWF5aEj3qXr6pO4=; b=isnKMIlXy9yyH2wYUE/NeeCXFvUqWcr4Dv
        VruGSwZ7uk/v7k5kBHCwMV1UemAeigPfehx/Wgrx5SgcS7hpUXvrD2G4oQMAHp48
        gKH8Jiegh5INBeBrWpK9gXa3vDkOBvoP2qknwb7uYzMuvsZg93AzhdP61Um3U8Jh
        LStIF/sG4=
Received: from 192.168.137.228 (unknown [112.10.75.116])
        by smtp7 (Coremail) with SMTP id DsmowADH5yPPYb1e4wrUEw--.20957S3;
        Thu, 14 May 2020 23:20:49 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     tglx@linutronix.de, john.stultz@linaro.org, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] timers: Use set_current_state macro
Date:   Thu, 14 May 2020 11:20:47 -0400
Message-Id: <1589469647-33814-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DsmowADH5yPPYb1e4wrUEw--.20957S3
X-Coremail-Antispam: 1Uf129KBjvdXoW5KF4fZrWfJF4fCw4kGFyDJrb_yoWxWrXEk3
        97tF409r45JF9FgF4UC3yfury0gr13GF1kAw4UuF43Aw4qy3y5twnYqFn8CFn3Wr98WFy5
        Zan8J34DKr1rtjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8kpnPUUUUU==
X-Originating-IP: [112.10.75.116]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbiwQEkpFpD+ZN0LAAAsr
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use set_current_state macro instead of current->state = TASK_RUNNING

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 kernel/time/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 4820823..b9ecf87 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1882,7 +1882,7 @@ signed long __sched schedule_timeout(signed long timeout)
 			printk(KERN_ERR "schedule_timeout: wrong timeout "
 				"value %lx\n", timeout);
 			dump_stack();
-			current->state = TASK_RUNNING;
+			set_current_state(TASK_RUNNING);
 			goto out;
 		}
 	}
-- 
1.8.3.1

