Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D60C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65CBB2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:33:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgIAKdw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:33:52 -0400
Received: from foss.arm.com ([217.140.110.172]:40168 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgIAKdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:33:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3851113E;
        Tue,  1 Sep 2020 03:33:38 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 005BD3F71F;
        Tue,  1 Sep 2020 03:33:37 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        op-tee@lists.trustedfirmware.org
Subject: [PATCH 2/2] tee: avoid explicit sysfs_create/delete_group by initialising dev->groups
Date:   Tue,  1 Sep 2020 11:33:35 +0100
Message-Id: <20200901103335.685-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901103335.685-1-sudeep.holla@arm.com>
References: <20200901103335.685-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the dev->groups is initialised, the sysfs group is created as part
of device_add call. There is no need to call sysfs_create/delete_group
explicitly.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/tee/tee_core.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index b4a8b362d78f..f77d64fafead 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -962,9 +962,7 @@ static struct attribute *tee_dev_attrs[] = {
 	NULL
 };
 
-static const struct attribute_group tee_dev_group = {
-	.attrs = tee_dev_attrs,
-};
+ATTRIBUTE_GROUPS(tee_dev);
 
 /**
  * tee_device_register() - Registers a TEE device
@@ -984,6 +982,8 @@ int tee_device_register(struct tee_device *teedev)
 		return -EINVAL;
 	}
 
+	teedev->dev.groups = tee_dev_groups;
+
 	rc = cdev_device_add(&teedev->cdev, &teedev->dev);
 	if (rc) {
 		dev_err(&teedev->dev,
@@ -993,19 +993,8 @@ int tee_device_register(struct tee_device *teedev)
 		return rc;
 	}
 
-	rc = sysfs_create_group(&teedev->dev.kobj, &tee_dev_group);
-	if (rc) {
-		dev_err(&teedev->dev,
-			"failed to create sysfs attributes, err=%d\n", rc);
-		goto err_sysfs_create_group;
-	}
-
 	teedev->flags |= TEE_DEVICE_FLAG_REGISTERED;
 	return 0;
-
-err_sysfs_create_group:
-	cdev_device_del(&teedev->cdev, &teedev->dev);
-	return rc;
 }
 EXPORT_SYMBOL_GPL(tee_device_register);
 
@@ -1048,10 +1037,8 @@ void tee_device_unregister(struct tee_device *teedev)
 	if (!teedev)
 		return;
 
-	if (teedev->flags & TEE_DEVICE_FLAG_REGISTERED) {
-		sysfs_remove_group(&teedev->dev.kobj, &tee_dev_group);
+	if (teedev->flags & TEE_DEVICE_FLAG_REGISTERED)
 		cdev_device_del(&teedev->cdev, &teedev->dev);
-	}
 
 	tee_device_put(teedev);
 	wait_for_completion(&teedev->c_no_users);
-- 
2.17.1

