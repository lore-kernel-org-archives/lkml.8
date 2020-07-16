Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E112C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE9E4206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XD/PyXYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgGPHbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728124AbgGPHbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:31:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378ECC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:31:37 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f2so5908581wrp.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 00:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=0wfzzbiUSnIi5DuGPbozs3Wq9AJhaleKMHYqWmaknaY=;
        b=XD/PyXYeYtpKZvWnTRTd5/QUI6vQI0EGzK8Q41u2BDp74uC0tC5pedzU4XmnUM8Gxm
         PLvRkfTzeZIqaNDUrWYgk2ZN7yuPZkQpe7PCDMhPn3ny8MAb/lLS575CqjcznLx9cKPO
         L3d29mudQMQwXQSiDDEiaPz3oZrx9JK1XECE3ClhuIDjUp/ac/oypw7MdC00iV8Y9Qf2
         b1iR20C4Y1LjgOMGsDtKj4vVO1uY1I6xJfbxD0Wa5MkhVVsj6bXUCG2e7EeKan33Oa29
         MsPMlkKfgv97ZVLZVKTNmCLjusu0OsgiPOCkdtuE44nMTn2MAOdwL6e64Xij8GPOdAl2
         GZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=0wfzzbiUSnIi5DuGPbozs3Wq9AJhaleKMHYqWmaknaY=;
        b=R5Eezsyb/rjIhTb6QrXgUVtXQcsFR0fPdy2V1Cfil92pPIuC0kPQuNmAF2NuHisnnz
         ZVoIcwEvI2XTNOgP9xORlVXIZC8YF9zl63+Qf7qlxzIcmuOJT4toBqz9Ti4kraxfvaVg
         jWgjdRuw/IOF9ENs03XLMt2jHcyXMVfExW7fJzdTx9Yvb3Oqc//MGbENXoMtVZN8VTNx
         UjxIrPjCEjeUaerfPaygqUDSh1h81M7b5P91TVMb4YhZ4sToOieauen7szMnuVTnAtgd
         hAIRNTWA0RS2aFhas/xbpeFhr7FHrGwacL7KBR7ObsfZsrynjZwaaD04KjnFyJxZUHM4
         DttQ==
X-Gm-Message-State: AOAM531zYv0UuZurfKWu8cxwgaeqtteXMScDs84uRyrt6A22E6oqqptU
        c4p3gB2PCWvwBBRDZ+Bu32mTXdvX
X-Google-Smtp-Source: ABdhPJy5bTxKDPUIKzXrZozfk1JqHkYLXF9gcY6906u0jvT3YdEanIZTwI/22d1CJi7PTDAmuu50cQ==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr3652774wro.214.1594884695499;
        Thu, 16 Jul 2020 00:31:35 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id a2sm7352017wrn.68.2020.07.16.00.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 00:31:34 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH 2/2] habanalabs: enable device before hw_init()
Date:   Thu, 16 Jul 2020 10:31:29 +0300
Message-Id: <20200716073129.5924-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716073129.5924-1-oded.gabbay@gmail.com>
References: <20200716073129.5924-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device is now enabled before the hw_init() because part of the
initialization requires communication with the device firmware to get
information that is required for the initialization itself

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/device.c | 16 ++++++++++++----
 drivers/misc/habanalabs/common/sysfs.c  |  3 +++
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 84800efec10d..9919ff121067 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -1033,6 +1033,12 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 		}
 	}
 
+	/* Device is now enabled as part of the initialization requires
+	 * communication with the device firmware to get information that
+	 * is required for the initialization itself
+	 */
+	hdev->disabled = false;
+
 	rc = hdev->asic_funcs->hw_init(hdev);
 	if (rc) {
 		dev_err(hdev->dev,
@@ -1040,8 +1046,6 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
 		goto out_err;
 	}
 
-	hdev->disabled = false;
-
 	/* Check that the communication with the device is working */
 	rc = hdev->asic_funcs->test_queues(hdev);
 	if (rc) {
@@ -1261,6 +1265,12 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 	 */
 	add_cdev_sysfs_on_err = true;
 
+	/* Device is now enabled as part of the initialization requires
+	 * communication with the device firmware to get information that
+	 * is required for the initialization itself
+	 */
+	hdev->disabled = false;
+
 	rc = hdev->asic_funcs->hw_init(hdev);
 	if (rc) {
 		dev_err(hdev->dev, "failed to initialize the H/W\n");
@@ -1268,8 +1278,6 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 		goto out_disabled;
 	}
 
-	hdev->disabled = false;
-
 	/* Check that the communication with the device is working */
 	rc = hdev->asic_funcs->test_queues(hdev);
 	if (rc) {
diff --git a/drivers/misc/habanalabs/common/sysfs.c b/drivers/misc/habanalabs/common/sysfs.c
index 5d78d5e1c782..c4e7c682d584 100644
--- a/drivers/misc/habanalabs/common/sysfs.c
+++ b/drivers/misc/habanalabs/common/sysfs.c
@@ -334,6 +334,9 @@ static ssize_t eeprom_read_handler(struct file *filp, struct kobject *kobj,
 	char *data;
 	int rc;
 
+	if (hl_device_disabled_or_in_reset(hdev))
+		return -ENODEV;
+
 	if (!max_size)
 		return -EINVAL;
 
-- 
2.17.1

