Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7635C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F91520709
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgEUBwY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 21:52:24 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:43644 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbgEUBwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 21:52:23 -0400
X-Greylist: delayed 939 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 May 2020 21:52:23 EDT
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id C9082AE1BE9BF50C7FD8;
        Thu, 21 May 2020 09:36:37 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id 04L1a4wt072645;
        Thu, 21 May 2020 09:36:04 +0800 (GMT-8)
        (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020052109363117-3642064 ;
          Thu, 21 May 2020 09:36:31 +0800 
From:   root <wang.yi59@zte.com.cn>
To:     pmladek@suse.com
Cc:     sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, jiang.xuexin@zte.com.cn,
        =?UTF-8?q?=E6=B1=AA=E5=8B=8710269566?= <wang.yong12@zte.com.cn>
Subject: [PATCH] [PATCH]Fixed: line break of pr_cont not take effect in linux-rt
Date:   Thu, 21 May 2020 09:37:44 +0800
Message-Id: <1590025064-14433-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-05-21 09:36:31,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-05-21 09:36:09
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse-fl1.zte.com.cn 04L1a4wt072645
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: 汪勇10269566 <wang.yong12@zte.com.cn>

Line break of pr_cont not take effect.
Use several pr_cont to print continuous paragraph, it is expected to
have line break when line ends up with  '\n', however the paragraph
does not have line break
-printk_kthread_func will not print info before log_store insert msg
 into printk_rb, and pr_cont calls cont_add to keep data in buffer.
 cont_add only when the following conditions are met insert msg to
 printk_rb
 1.cpu != c->cpu_owner || !(flags & LOG_CONT)
 2.c->len + len > sizeof(c->buf)

Signed-off-by: 汪勇10269566 <wang.yong12@zte.com.cn>
---
 kernel/printk/printk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 0605a74..d898f50 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -1871,6 +1871,7 @@ static void cont_add(int ctx, int cpu, u32 caller_id, int facility, int level,
 	// but later continuations can add a newline.
 	if (flags & LOG_NEWLINE) {
 		c->flags |= LOG_NEWLINE;
+		cont_flush(ctx);
 	}
 }
 
-- 
2.15.2

