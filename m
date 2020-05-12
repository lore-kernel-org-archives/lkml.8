Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF90DC54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 03:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B585A206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 03:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgELDaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 23:30:46 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:61864 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728753AbgELDao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 23:30:44 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 81AE933B73D18C427C12;
        Tue, 12 May 2020 11:30:14 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id 04C3Pnvg019360;
        Tue, 12 May 2020 11:25:49 +0800 (GMT-8)
        (envelope-from tan.hu@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2020051211260006-3533846 ;
          Tue, 12 May 2020 11:26:00 +0800 
From:   Tan Hu <tan.hu@zte.com.cn>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, wang.liang82@zte.com.cn,
        Tan Hu <tan.hu@zte.com.cn>
Subject: [PATCH v3] lib/flex_proportions.c: cleanup __fprop_inc_percpu_max
Date:   Tue, 12 May 2020 11:27:34 +0800
Message-Id: <1589254054-48833-1-git-send-email-tan.hu@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2020-05-12 11:26:00,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-05-12 11:25:51,
        Serialize complete at 2020-05-12 11:25:51
X-MAIL: mse-fl2.zte.com.cn 04C3Pnvg019360
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
Reviewed-by: Jan Kara <jack@suse.cz>
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

