Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA4AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 761DE20734
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 01:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="qhrHgMxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbgHKBHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 21:07:50 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:23898 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727879AbgHKBHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 21:07:41 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BQZSW07gnzNH;
        Tue, 11 Aug 2020 03:07:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597108059; bh=I1YYHRYByEQpnexzWJYpaabhHYOB7QOBwttBNq6vd6s=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=qhrHgMxz4Gd4zo3MkDQbWk9eWkD7Tc1gqPwLmq/JTXpD9KzUBxmmB4Zv4LULBrqGv
         L6XLMqQmtS+Tw9ZKMejhyqeYzcnfdlp+hKDv3c0MyUdGoyhdmwtvqtETpda+djRYhT
         InqwQLXHq+cC+2e+Rg4Cb/xo9sOylDNDXpxdBdBHcjQUOlwqJOoMFm8ORDdZI9AhGn
         RpVrrTLr5yMZKmnjQBNxrmnkUw0AB7E1ynoVqyxuw8dWRuTkst2sI1QYadGkmdFQ3N
         1slcCsbSk74W0VyV7fXIwixZD95qPFgrbRKRqDiOGkfHg8yvyizVI1jl95Z0w3PjFj
         4to8VZKNPuE4Q==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Tue, 11 Aug 2020 03:07:38 +0200
Message-Id: <d03a02be142741644276758d71925862f82ed090.1597107682.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1597107682.git.mirq-linux@rere.qmqm.pl>
References: <cover.1597107682.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 3/7] regulator: push allocations in create_regulator() outside
 of lock
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Dmitry Osipenko <digetx@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move all allocations outside of the regulator_lock()ed section.

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

Cc: stable@vger.kernel.org
Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/regulator/core.c | 53 +++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 3dd4d4914075..c95397798275 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -1553,44 +1553,53 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
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
 
-	regulator_lock(rdev);
 	regulator->rdev = rdev;
+	regulator->supply_name = supply_name;
+
+	regulator_lock(rdev);
 	list_add(&regulator->list, &rdev->consumer_list);
+	regulator_unlock(rdev);
 
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
 
-	regulator->debugfs = debugfs_create_dir(regulator->supply_name,
+	regulator->debugfs = debugfs_create_dir(supply_name,
 						rdev->debugfs);
 	if (!regulator->debugfs) {
 		rdev_dbg(rdev, "Failed to create debugfs directory\n");
@@ -1615,13 +1624,7 @@ static struct regulator *create_regulator(struct regulator_dev *rdev,
 	    _regulator_is_enabled(rdev))
 		regulator->always_on = true;
 
-	regulator_unlock(rdev);
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

