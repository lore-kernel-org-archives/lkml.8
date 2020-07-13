Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3E1C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D0E206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 02:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgGMCNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 22:13:41 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58281 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgGMCNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 22:13:39 -0400
Received: from fsav101.sakura.ne.jp (fsav101.sakura.ne.jp [27.133.134.228])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06D2D8mK060769;
        Mon, 13 Jul 2020 11:13:08 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav101.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav101.sakura.ne.jp);
 Mon, 13 Jul 2020 11:13:08 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav101.sakura.ne.jp)
Received: from localhost.localdomain (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06D2Cv1J060718
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 13 Jul 2020 11:13:07 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        syzbot <syzbot+805f5f6ae37411f15b64@syzkaller.appspotmail.com>
Subject: [PATCH] driver core: Fix probe_count imbalance in really_probe()
Date:   Mon, 13 Jul 2020 11:12:54 +0900
Message-Id: <20200713021254.3444-1-penguin-kernel@I-love.SAKURA.ne.jp>
X-Mailer: git-send-email 2.18.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot is reporting hung task in wait_for_device_probe() [1]. At least,
we always need to decrement probe_count if we incremented probe_count in
really_probe().

However, since I can't find "Resources present before probing" message in
the console log, both "this message simply flowed off" and "syzbot is not
hitting this path" will be possible. Therefore, while we are at it, let's
also prepare for concurrent wait_for_device_probe() calls by replacing
wake_up() with wake_up_all().

[1] https://syzkaller.appspot.com/bug?id=25c833f1983c9c1d512f4ff860dd0d7f5a2e2c0f

Reported-by: syzbot <syzbot+805f5f6ae37411f15b64@syzkaller.appspotmail.com>
Fixes: 7c35e699c88bd607 ("driver core: Print device when resources present in really_probe()")
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 drivers/base/dd.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 9a1d940342ac..c0fb9a2ff6f5 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -281,7 +281,7 @@ static void deferred_probe_timeout_work_func(struct work_struct *work)
 
 	list_for_each_entry_safe(private, p, &deferred_probe_pending_list, deferred_probe)
 		dev_info(private->device, "deferred probe pending\n");
-	wake_up(&probe_timeout_waitqueue);
+	wake_up_all(&probe_timeout_waitqueue);
 }
 static DECLARE_DELAYED_WORK(deferred_probe_timeout_work, deferred_probe_timeout_work_func);
 
@@ -492,7 +492,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		 drv->bus->name, __func__, drv->name, dev_name(dev));
 	if (!list_empty(&dev->devres_head)) {
 		dev_crit(dev, "Resources present before probing\n");
-		return -EBUSY;
+		ret = -EBUSY;
+		goto done;
 	}
 
 re_probe:
@@ -612,7 +613,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	ret = 0;
 done:
 	atomic_dec(&probe_count);
-	wake_up(&probe_waitqueue);
+	wake_up_all(&probe_waitqueue);
 	return ret;
 }
 
-- 
2.18.4

