Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA845C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD5C2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AOPfMzy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389085AbgEZSxp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbgEZSxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:53:44 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49667C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:53:44 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q9so181868pjm.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AYEornrO55/O2vkyg63H37SzJb1PbET1/v8+PaIhXQo=;
        b=AOPfMzy1y5kg7hzg+86dXzbMaVe2uPjkfrP4bDpqJDouSIpAHMxHVg5Hw7LCx3K8mX
         ceoZkjrcunBiURVcY78tKen5WyGec5pB7lwjAvx2p4sA1gyx4iRFm/HFSGV8wlOlv963
         XPNm6o61oAkLxWQwdyu/fQdcl36Utl+1sQ2mo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AYEornrO55/O2vkyg63H37SzJb1PbET1/v8+PaIhXQo=;
        b=tR7ap2/jnnyFGoUUYBzn4AQ1viAKC2ojUgtjs5fEe72hp85fVN0O+S/LEcjskRnnF6
         eM1+F+CjMOGBKMwFYXV1/TtS1I2L7njR8FZHuvyCPqevRYKQqZ0n8OSPgafMGafLZfcW
         35uR68x1cz69Q3DM1b5oPRhpmMuoQii6xN9vj7VcHJLQb+wfBldnLuZMCs4sZRk4VmB/
         ICKGYDEnxvCZlRRZ3gUgou12dS7MPsdjAYKO3L8kadTv+k4TkhShSyI224tMGzoiG0n/
         +wJo5Axm9Ma1DDH+0Bi7rBQ4A90/afO/ISMi4upKCL2CNKbwXdt0jzMmbjBLFL0ssP1y
         uB1A==
X-Gm-Message-State: AOAM533N3NaAK2nMQAbbuhjLwv/I/du+yhxpxCge1HP0hLo0kvwa4WDz
        x1kmaGdjK0gJwC+oUPxnND7V/Q==
X-Google-Smtp-Source: ABdhPJxigxbh0j3FBrPPeAHkeEdoUZ/QL4FFN27PHoJXsS+9pWwsXNha36wP7KDhgEp5oXlux78RAQ==
X-Received: by 2002:a17:902:9f97:: with SMTP id g23mr2480589plq.30.1590519223726;
        Tue, 26 May 2020 11:53:43 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id nl8sm242133pjb.13.2020.05.26.11.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 11:53:43 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     groeck@chromium.org, bleung@chromium.org,
        enric.balletbo@collabora.com, twawrzynczak@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v2] platform: cros_ec_debugfs: control uptime information request
Date:   Tue, 26 May 2020 11:53:28 -0700
Message-Id: <20200526185328.231840-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.27.0.rc0.183.gde8f92d652-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When EC does not support uptime command (EC_CMD_GET_UPTIME_INFO),
do not create the uptime sysfs entry point.
User space application will not probe the file needlessly.

The EC console log will not contain EC_CMD_GET_UPTIME_INFO anymore.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/platform/chrome/cros_ec_debugfs.c | 24 +++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 6ae484989d1f5..303a8c4686f89 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -243,6 +243,25 @@ static ssize_t cros_ec_pdinfo_read(struct file *file,
 				       read_buf, p - read_buf);
 }
 
+static bool cros_ec_uptime_is_supported(struct cros_ec_device *ec_dev)
+{
+	struct {
+		struct cros_ec_command cmd;
+		struct ec_response_uptime_info resp;
+	} __packed msg = {};
+	int ret;
+
+	msg.cmd.command = EC_CMD_GET_UPTIME_INFO;
+	msg.cmd.insize = sizeof(msg.resp);
+
+	ret = cros_ec_cmd_xfer_status(ec_dev, &msg.cmd);
+	if (ret == -EPROTO && msg.cmd.result == EC_RES_INVALID_COMMAND)
+		return false;
+
+	/* Other errors maybe a transient error, do not rule about support. */
+	return true;
+}
+
 static ssize_t cros_ec_uptime_read(struct file *file, char __user *user_buf,
 				   size_t count, loff_t *ppos)
 {
@@ -445,8 +464,9 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
 	debugfs_create_file("pdinfo", 0444, debug_info->dir, debug_info,
 			    &cros_ec_pdinfo_fops);
 
-	debugfs_create_file("uptime", 0444, debug_info->dir, debug_info,
-			    &cros_ec_uptime_fops);
+	if (cros_ec_uptime_is_supported(ec->ec_dev))
+		debugfs_create_file("uptime", 0444, debug_info->dir, debug_info,
+				    &cros_ec_uptime_fops);
 
 	debugfs_create_x32("last_resume_result", 0444, debug_info->dir,
 			   &ec->ec_dev->last_resume_result);
-- 
2.27.0.rc0.183.gde8f92d652-goog

