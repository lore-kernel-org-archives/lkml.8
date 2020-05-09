Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DDEC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 06:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16314214D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 06:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgEIGLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 02:11:39 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:36069 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgEIGLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 02:11:38 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 2ACB3983D1DBAF8B2C8F;
        Sat,  9 May 2020 14:11:31 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notessmtp.zte.com.cn [10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id 0496AtnM050893;
        Sat, 9 May 2020 14:10:55 +0800 (GMT-8)
        (envelope-from tan.hu@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020050914113786-3504531 ;
          Sat, 9 May 2020 14:11:37 +0800 
From:   Tan Hu <tan.hu@zte.com.cn>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, wang.liang82@zte.com.cn,
        Tan Hu <tan.hu@zte.com.cn>
Subject: [PATCH v2] lib/flex_proportions.c: cleanup __fprop_inc_percpu_max
Date:   Sat, 9 May 2020 14:12:33 +0800
Message-Id: <1589004753-27554-1-git-send-email-tan.hu@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-05-09 14:11:37,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-05-09 14:11:01,
        Serialize complete at 2020-05-09 14:11:01
X-MAIL: mse-fl1.zte.com.cn 0496AtnM050893
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the given type has fraction smaller than max_frac/FPROP_FRAC_BASE,
the code could be modified to call __fprop_inc_percpu() directly and
easier to understand. After this patch, fprop_reflect_period_percpu()
will be called twice, and quicky return on pl->period == p->period
test, so it would not result to significant downside of performance.

Thanks for Jan's guidance.

Signed-off-by: Tan Hu <tan.hu@zte.com.cn>
---
 lib/flex_proportions.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
index 7852bfff5..451543937 100644
--- a/lib/flex_proportions.c
+++ b/lib/flex_proportions.c
@@ -266,8 +266,7 @@ void __fprop_inc_percpu_max(struct fprop_global *p,
 		if (numerator >
 		    (((u64)denominator) * max_frac) >> FPROP_FRAC_SHIFT)
 			return;
-	} else
-		fprop_reflect_period_percpu(p, pl);
-	percpu_counter_add_batch(&pl->events, 1, PROP_BATCH);
-	percpu_counter_add(&p->events, 1);
+	}
+
+	__fprop_inc_percpu(p, pl);
 }
-- 
2.19.1

