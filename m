Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20281C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:09:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA9DC2083B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="N0n0VeXJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgHJUJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:09:28 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:27767 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgHJUJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:09:24 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BQRrL4YcwzNH;
        Mon, 10 Aug 2020 22:09:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597090162; bh=HIxMHwvIfGyG6glLDSySIN0Wnvg7/uYliIH96YlCvy0=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=N0n0VeXJiI2hPwD+bdeMgx2Mkvs3msO7vYYeRyrV2uFEFaw8VM7Zzs0Pz4YvBrvFm
         MMBLmdDCbTiiM22ReezYMxT7E2NM8qVuVsMFXInqFC0wdlCO3ocdTPfsbJVWiGFBOd
         E/ZJCHuQpNnMsFC+PCEQkbfISK7xa3lKDmgoXwEQFbOCFn7YdLKTKAXDBgib6zKOQW
         tABW+XG+tua99sKY4xbU/uOkh9t+EIXSZlb3vDMFC5kpf/YmLK/jk3XMfsBO7c8q9n
         d/UtDh6LYCO0/xQoJX460TyOSwyPnaD5zNfH2RJc4eYH6oYxlNnzh1wyY91n1hGJY2
         qtF1IEyTxioEA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Mon, 10 Aug 2020 22:09:22 +0200
Message-Id: <8945eae5cf10d58f3c377b4f8dd578418a296df5.1597089543.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1597089543.git.mirq-linux@rere.qmqm.pl>
References: <cover.1597089543.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [RFC PATCH 3/3] regulator: push supply_name allocation outside of
 lock
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move all allocations outside of the regulator_lock().

======================================================
WARNING: possible circular locking dependency detected
5.7.13+ #535 Not tainted
------------------------------------------------------
f2fs_discard-179:7/702 is trying to acquire lock:
c0e5d920 (regulator_list_mutex){+.+.}-{3:3}, at: regulator_lock_dependent+0x54/0x2c0

but task is already holding lock:
cb95b080 (&dcc->cmd_lock){+.+.}-{3:3}, at: __issue_discard_cmd+0xec/0x5f8

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

[...]

-> #3 (fs_reclaim){+.+.}-{0:0}:
       fs_reclaim_acquire.part.11+0x40/0x50
       fs_reclaim_acquire+0x24/0x28
       __kmalloc_track_caller+0x54/0x218
       kstrdup+0x40/0x5c
       create_regulator+0xf4/0x368
       regulator_resolve_supply+0x1a0/0x200
       regulator_register+0x9c8/0x163c

[...]

other info that might help us debug this:

Chain exists of:
  regulator_list_mutex --> &sit_i->sentry_lock --> &dcc->cmd_lock

[...]

Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 46 +++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 05c9657c99d9..5f518e034c90 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1557,41 +1557,48 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 					  const char *supply_name)
 {
 	struct regulator *regulator;
-	char buf[REG_STR_SIZE];
-	int err, size;
+	int err;
+
+	if (dev) {
+		char buf[REG_STR_SIZE];
+		int size;
+
+		size = snprintf(buf, REG_STR_SIZE, "%s-%s",
+				dev->kobj.name, supply_name);
+		if (size >= REG_STR_SIZE)
+			return NULL;
+
+		supply_name = kstrdup(buf, GFP_KERNEL);
+		if (supply_name == NULL)
+			return NULL;
+	} else {
+		supply_name = kstrdup_const(supply_name, GFP_KERNEL);
+		if (supply_name == NULL)
+			return NULL;
+	}
 
 	regulator = kzalloc(sizeof(*regulator), GFP_KERNEL);
-	if (regulator == NULL)
+	if (regulator == NULL) {
+		kfree(supply_name);
 		return NULL;
+	}
 
 	regulator_lock(rdev);
 	regulator->rdev = rdev;
+	regulator->supply_name = supply_name;
 	list_add(&regulator->list, &rdev->consumer_list);
 
 	if (dev) {
 		regulator->dev = dev;
 
 		/* Add a link to the device sysfs entry */
-		size = snprintf(buf, REG_STR_SIZE, "%s-%s",
-				dev->kobj.name, supply_name);
-		if (size >= REG_STR_SIZE)
-			goto overflow_err;
-
-		regulator->supply_name = kstrdup(buf, GFP_KERNEL);
-		if (regulator->supply_name == NULL)
-			goto overflow_err;
-
 		err = sysfs_create_link_nowarn(&rdev->dev.kobj, &dev->kobj,
-					buf);
+					       supply_name);
 		if (err) {
 			rdev_dbg(rdev, "could not add device link %s err %d\n",
 				  dev->kobj.name, err);
 			/* non-fatal */
 		}
-	} else {
-		regulator->supply_name = kstrdup_const(supply_name, GFP_KERNEL);
-		if (regulator->supply_name == NULL)
-			goto overflow_err;
 	}
 
 	regulator->debugfs = debugfs_create_dir(regulator->supply_name,
@@ -1621,11 +1628,6 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 
 	regulator_unlock(rdev);
 	return regulator;
-overflow_err:
-	list_del(&regulator->list);
-	kfree(regulator);
-	regulator_unlock(rdev);
-	return NULL;
 }
 
 static int _regulator_get_enable_time(struct regulator_dev *rdev)
-- 
2.20.1

