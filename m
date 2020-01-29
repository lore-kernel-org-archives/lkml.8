Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D02C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A88E206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbgA2SSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:18:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:43660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726823AbgA2SSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 13:18:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 925F4B28E;
        Wed, 29 Jan 2020 18:18:08 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     colyli@suse.de, kent.overstreet@gmail.com
Cc:     linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] bcache: optimize barrier usage for Rmw atomic bitops
Date:   Wed, 29 Jan 2020 10:08:02 -0800
Message-Id: <20200129180802.24626-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can avoid the unnecessary barrier on non LL/SC architectures,
such as x86. Instead, use the smp_mb__after_atomic().

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/md/bcache/writeback.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 4a40f9eadeaf..284ff10f480f 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -183,7 +183,7 @@ static void update_writeback_rate(struct work_struct *work)
 	 */
 	set_bit(BCACHE_DEV_RATE_DW_RUNNING, &dc->disk.flags);
 	/* paired with where BCACHE_DEV_RATE_DW_RUNNING is tested */
-	smp_mb();
+	smp_mb__after_atomic();
 
 	/*
 	 * CACHE_SET_IO_DISABLE might be set via sysfs interface,
@@ -193,7 +193,7 @@ static void update_writeback_rate(struct work_struct *work)
 	    test_bit(CACHE_SET_IO_DISABLE, &c->flags)) {
 		clear_bit(BCACHE_DEV_RATE_DW_RUNNING, &dc->disk.flags);
 		/* paired with where BCACHE_DEV_RATE_DW_RUNNING is tested */
-		smp_mb();
+		smp_mb__after_atomic();
 		return;
 	}
 
@@ -229,7 +229,7 @@ static void update_writeback_rate(struct work_struct *work)
 	 */
 	clear_bit(BCACHE_DEV_RATE_DW_RUNNING, &dc->disk.flags);
 	/* paired with where BCACHE_DEV_RATE_DW_RUNNING is tested */
-	smp_mb();
+	smp_mb__after_atomic();
 }
 
 static unsigned int writeback_delay(struct cached_dev *dc,
-- 
2.16.4

