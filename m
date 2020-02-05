Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12937C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEF720720
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zw8bC1dY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgBETZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 14:25:10 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39126 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbgBETZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:25:09 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so1280705plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 11:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=af3D51wfgi4CJcqFRsTGVMhjrt5tLd61yOjchsdiqjI=;
        b=Zw8bC1dY65OgR1s/bEKrpfCs4QHcMST3laUKRdjPV3UQynibnYL+Ln4VUp4VrLu6Ya
         6xhxu12NmLfPIgMI/uO439xfTpsGvFaAUEdBL9a0DLySSeFsQCecxcHjHYlFrSv8SaJo
         BygfGuwno7RRRJANFMDgcXv8WVZ7KWJn54ZRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=af3D51wfgi4CJcqFRsTGVMhjrt5tLd61yOjchsdiqjI=;
        b=jYI3KlUVNx3MkzSXNXCgtHYEja1ecIlJ90ktZqhkMzZKx5o3lj6OIXrMl3WhicxqSb
         hFHoDZXzdAxAadBGbae99HwsQEw8uCCk69dT/fC1eB82tRMshCspUQ9Cuesyxcl0lY/O
         QCydPaXw3xNwgRJy5IG+F6nZsEBszgA6YlJLAU1kGoR/JKwov/RnsDW6oOQ0arOaoTYa
         JGTFPxWFcE4ree1I6YFC38JPML7nFFZxYp3iEPxwRwhmjuatM46FP6o9Al2fxIk/Dc4H
         UN0EnGdERxomGdwJ9QiHcINk2A7SfpHF3tM+sPHTJCZq9kc5nGWh0KPJCGVPRzXUMlad
         6rWA==
X-Gm-Message-State: APjAAAV1d8nRAyCwZmdP+/q3MWoUFb10KIDpEb0fJzH/lIHQhM7SJ/wC
        4DXghO3BRKnY6OoOhCBxzHJ3BtXImYw=
X-Google-Smtp-Source: APXvYqxacyB5RJbJDM7m5vdef1D3ROR+h5giC3IutrVfVgJ+7pR3mYWRzz6SeYZz4xtVHgh8ki1K1A==
X-Received: by 2002:a17:902:fe90:: with SMTP id x16mr33746712plm.31.1580930708769;
        Wed, 05 Feb 2020 11:25:08 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id d2sm550157pjv.18.2020.02.05.11.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 11:25:08 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Evan Green <evgreen@chromium.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>
Subject: [PATCH v2 17/17] platform/chrome: Drop cros_ec_cmd_xfer_status()
Date:   Wed,  5 Feb 2020 11:24:54 -0800
Message-Id: <20200205192459.187894-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove cros_ec_cmd_xfer_status() since all usages of that function
have been converted to cros_ec_cmd().

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Updated, since removing function is more straightforward and doesn't
  need any modification of the newly introduced function's
  documentation.

 drivers/platform/chrome/cros_ec_proto.c     | 29 ---------------------
 include/linux/platform_data/cros_ec_proto.h |  3 ---
 2 files changed, 32 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index aa7ae1f394cc91..24ef9ae278c488 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -543,35 +543,6 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 }
 EXPORT_SYMBOL(cros_ec_cmd_xfer);
 
-/**
- * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
- * @ec_dev: EC device.
- * @msg: Message to write.
- *
- * This function is identical to cros_ec_cmd_xfer, except it returns success
- * status only if both the command was transmitted successfully and the EC
- * replied with success status. It's not necessary to check msg->result when
- * using this function.
- *
- * Return: The number of bytes transferred on success or negative error code.
- */
-int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
-			    struct cros_ec_command *msg)
-{
-	int ret;
-
-	ret = cros_ec_cmd_xfer(ec_dev, msg);
-	if (ret < 0) {
-		dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
-	} else if (msg->result != EC_RES_SUCCESS) {
-		dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
-		return -EPROTO;
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
-
 /**
  * cros_ec_cmd() - Utility function to send commands to ChromeOS EC.
  * @ec: EC device struct.
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 54b9bbf9a07c0c..6bd78467c2326d 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -215,9 +215,6 @@ int cros_ec_check_result(struct cros_ec_device *ec_dev,
 int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 		     struct cros_ec_command *msg);
 
-int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
-			    struct cros_ec_command *msg);
-
 int cros_ec_cmd(struct cros_ec_device *ec_dev, u32 version, u32 command,
 		void *outdata, u32 outsize, void *indata, u32 insize,
 		u32 *result);
-- 
2.25.0.341.g760bfbb309-goog

