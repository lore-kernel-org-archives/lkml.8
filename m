Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD01C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 308832083B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgIAKdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:33:42 -0400
Received: from foss.arm.com ([217.140.110.172]:40158 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726107AbgIAKdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:33:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0CE01063;
        Tue,  1 Sep 2020 03:33:37 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1BE643F71F;
        Tue,  1 Sep 2020 03:33:37 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        op-tee@lists.trustedfirmware.org
Subject: [PATCH 1/2] tee: replace cdev_add + device_add with cdev_device_add
Date:   Tue,  1 Sep 2020 11:33:34 +0100
Message-Id: <20200901103335.685-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 233ed09d7fda ("chardev: add helper function to register char devs
with a struct device") added a helper function 'cdev_device_add'.

Make use of cdev_device_add in tee_device_register to replace cdev_add
and device_add. Since cdev_device_add takes care of setting the
kobj->parent, drop explicit initialisation in tee_device_alloc.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/tee/tee_core.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 64637e09a095..b4a8b362d78f 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -917,7 +917,6 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
 
 	cdev_init(&teedev->cdev, &tee_fops);
 	teedev->cdev.owner = teedesc->owner;
-	teedev->cdev.kobj.parent = &teedev->dev.kobj;
 
 	dev_set_drvdata(&teedev->dev, driver_data);
 	device_initialize(&teedev->dev);
@@ -985,24 +984,15 @@ int tee_device_register(struct tee_device *teedev)
 		return -EINVAL;
 	}
 
-	rc = cdev_add(&teedev->cdev, teedev->dev.devt, 1);
+	rc = cdev_device_add(&teedev->cdev, &teedev->dev);
 	if (rc) {
 		dev_err(&teedev->dev,
-			"unable to cdev_add() %s, major %d, minor %d, err=%d\n",
+			"unable to cdev_device_add() %s, major %d, minor %d, err=%d\n",
 			teedev->name, MAJOR(teedev->dev.devt),
 			MINOR(teedev->dev.devt), rc);
 		return rc;
 	}
 
-	rc = device_add(&teedev->dev);
-	if (rc) {
-		dev_err(&teedev->dev,
-			"unable to device_add() %s, major %d, minor %d, err=%d\n",
-			teedev->name, MAJOR(teedev->dev.devt),
-			MINOR(teedev->dev.devt), rc);
-		goto err_device_add;
-	}
-
 	rc = sysfs_create_group(&teedev->dev.kobj, &tee_dev_group);
 	if (rc) {
 		dev_err(&teedev->dev,
@@ -1014,9 +1004,7 @@ int tee_device_register(struct tee_device *teedev)
 	return 0;
 
 err_sysfs_create_group:
-	device_del(&teedev->dev);
-err_device_add:
-	cdev_del(&teedev->cdev);
+	cdev_device_del(&teedev->cdev, &teedev->dev);
 	return rc;
 }
 EXPORT_SYMBOL_GPL(tee_device_register);
@@ -1062,8 +1050,7 @@ void tee_device_unregister(struct tee_device *teedev)
 
 	if (teedev->flags & TEE_DEVICE_FLAG_REGISTERED) {
 		sysfs_remove_group(&teedev->dev.kobj, &tee_dev_group);
-		cdev_del(&teedev->cdev);
-		device_del(&teedev->dev);
+		cdev_device_del(&teedev->cdev, &teedev->dev);
 	}
 
 	tee_device_put(teedev);
-- 
2.17.1

