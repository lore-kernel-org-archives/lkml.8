Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A91C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 04:53:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E922082E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 04:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Yc9NoAIT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729622AbgGHExQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 00:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgGHExQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 00:53:16 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E533C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 21:53:16 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e8so21088124pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 21:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n8PnW3sFHAwVEzGZ63D4MDBKW+EPhyK1cLjmjloA+4g=;
        b=Yc9NoAITE98gAWoI7c21HmGv2cbj4L3Bb0cH5RajuuYQM5zScqrDN8hHcmjxM3CRa2
         9dvRZKO02Gg5eF33MXy5UvA2TsXjN9GmEZpPBOUUq2HSanFAeS6JB1RXqw2xrppORwdr
         1FASBv9+T3x25rMUtNu5LljdtFOPx+JMl16xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n8PnW3sFHAwVEzGZ63D4MDBKW+EPhyK1cLjmjloA+4g=;
        b=I+rhM1VdwSx9M6OWmVZvlwwnlwTu20xYlyDnyiAM0NOc8YHajeEcRywm3M5m+k2Zyv
         KpGqh6vGy5/gcNPOQkgWZwsYvJPkFmMVP4z/Iy9DveKuqvfvhSIRPKZEgstnz38rcZI9
         IOpSAef0S61ugvrCtqU+L/V6KZVGpFHa+ZSPpd9UAwfMYKF9H1ZGLvuIkPUWY0aZkg2C
         aVaazrfJgoJ6OIRCKI1YSWqazYwO75i+u7w7u+3JvVznMDB9vDWfu2YN6qtKYgMFPdtP
         QEMZDJ1KYC7UaKQd0bduXE4q5g/ap9wPdmuToQQA830RIwIw9zeY4XiizZjAdnkVIL7m
         zzTQ==
X-Gm-Message-State: AOAM533O77vSDJuWVmBz6JXKIW+lDFX8lhoCKT0la0U18Wlc+Zkuz2CW
        kMLmiHKHYnDcDcuqVRZ/L6kJ28DFzW8=
X-Google-Smtp-Source: ABdhPJwhKXH+mqUVO+EIkFPLEhWrb+5c8UOe7v4gIa0pfuanGmhuqscsjiC8pQT3xtvqfZ/W72oZ2A==
X-Received: by 2002:aa7:8d95:: with SMTP id i21mr4807045pfr.240.1594183995606;
        Tue, 07 Jul 2020 21:53:15 -0700 (PDT)
Received: from localhost ([2401:fa00:9:14:f693:9fff:fef4:fbcd])
        by smtp.gmail.com with ESMTPSA id e5sm4020470pjy.26.2020.07.07.21.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 21:53:15 -0700 (PDT)
From:   Eizan Miyamoto <eizan@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Eizan Miyamoto <eizan@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v1] platform/chrome: cros_ec_debugfs: conditionally create uptime node
Date:   Wed,  8 Jul 2020 14:53:00 +1000
Message-Id: <20200708145215.v1.1.I9d49b374536424fcc98bc6bd935cdab8fac2ae71@changeid>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before creating an 'uptime' node in debugfs, this change adds a check to
see if a EC_CMD_GET_UPTIME_INFO command can be successfully run.

If the uptime node is created, userspace programs may periodically poll
it (e.g., timberslide), causing commands to be sent to the EC each time.
If the EC doesn't support EC_CMD_GET_UPTIME_INFO, an error will be
emitted in the EC console, producing noise.

Signed-off-by: Eizan Miyamoto <eizan@chromium.org>
---

 drivers/platform/chrome/cros_ec_debugfs.c | 35 +++++++++++++++++------
 1 file changed, 26 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index ecfada00e6c51..8708fe12f8ca8 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -242,17 +242,14 @@ static ssize_t cros_ec_pdinfo_read(struct file *file,
 				       read_buf, p - read_buf);
 }
 
-static ssize_t cros_ec_uptime_read(struct file *file, char __user *user_buf,
-				   size_t count, loff_t *ppos)
+static int cros_ec_get_uptime(struct cros_ec_device *ec_dev,
+			      uint32_t *uptime)
 {
-	struct cros_ec_debugfs *debug_info = file->private_data;
-	struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
 	struct {
 		struct cros_ec_command cmd;
 		struct ec_response_uptime_info resp;
 	} __packed msg = {};
 	struct ec_response_uptime_info *resp;
-	char read_buf[32];
 	int ret;
 
 	resp = (struct ec_response_uptime_info *)&msg.resp;
@@ -264,8 +261,24 @@ static ssize_t cros_ec_uptime_read(struct file *file, char __user *user_buf,
 	if (ret < 0)
 		return ret;
 
-	ret = scnprintf(read_buf, sizeof(read_buf), "%u\n",
-			resp->time_since_ec_boot_ms);
+	*uptime = resp->time_since_ec_boot_ms;
+	return 0;
+}
+
+static ssize_t cros_ec_uptime_read(struct file *file, char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	struct cros_ec_debugfs *debug_info = file->private_data;
+	struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
+	char read_buf[32];
+	int ret;
+	uint32_t uptime;
+
+	ret = cros_ec_get_uptime(ec_dev, &uptime);
+	if (ret < 0)
+		return ret;
+
+	ret = scnprintf(read_buf, sizeof(read_buf), "%u\n", uptime);
 
 	return simple_read_from_buffer(user_buf, count, ppos, read_buf, ret);
 }
@@ -425,6 +438,7 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
 	const char *name = ec_platform->ec_name;
 	struct cros_ec_debugfs *debug_info;
 	int ret;
+	uint32_t uptime;
 
 	debug_info = devm_kzalloc(ec->dev, sizeof(*debug_info), GFP_KERNEL);
 	if (!debug_info)
@@ -444,8 +458,11 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
 	debugfs_create_file("pdinfo", 0444, debug_info->dir, debug_info,
 			    &cros_ec_pdinfo_fops);
 
-	debugfs_create_file("uptime", 0444, debug_info->dir, debug_info,
-			    &cros_ec_uptime_fops);
+	if (cros_ec_get_uptime(debug_info->ec->ec_dev, &uptime) >= 0)
+		debugfs_create_file("uptime", 0444, debug_info->dir, debug_info,
+				    &cros_ec_uptime_fops);
+	else
+		dev_dbg(ec->dev, "EC does not provide uptime");
 
 	debugfs_create_x32("last_resume_result", 0444, debug_info->dir,
 			   &ec->ec_dev->last_resume_result);
-- 
2.27.0.383.g050319c2ae-goog

