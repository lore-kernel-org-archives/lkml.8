Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD366C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 05:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F6D0204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 05:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iU/K1KSv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgEUF27 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 01:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgEUF26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 01:28:58 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6309FC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 22:28:57 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s10so2652089pgm.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 22:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aUXIZxcgZXJfmyIHRTlyLReaRWDnMZreFvhKAOWg3UI=;
        b=iU/K1KSveNzXowBaSSyLvQsBk5G39CU6x2DQnVmsl7UNy9nHaieFHCNhkJgqK+VmGe
         ffikWT9M8FsX1CnYgQ9vC0zdfzZpLiELUKYTn8KKti8qfi8DTQr62GHjrUt2N80EoG57
         hWT6FvpTLqO9t5PNVAnrT0xGEnVqEoSpW7z9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=aUXIZxcgZXJfmyIHRTlyLReaRWDnMZreFvhKAOWg3UI=;
        b=KA5xBTl2+tM1nDSBoDitVv2ZHk5h0jq1ms/v7pTFgN8vsqR+caq7VtyGaD8tbabG1f
         Uxz3M9tNuxD+D7EbsNz3rq6in5SRkbYlSBN7zsLLHVMx2f1aYQZm6R4HvaW7aLFtL0Ns
         LxihHxRMSO1dnwnHaxbMmJZwESBHksB0FtqDUoIPRwlfOlmBGy5Cinw13g25CmJIccYF
         FLf/ylb2YCLFYWafxnOR7/qSx1EzLXfu2H8NEYiHwEvChYCMPV+BWCHClR9sXDOy59dK
         hBcCK76dZUWfGkthnV7lISIp75qrO9igy8lhDiq5tsY7XBt5WqvpH+0bpLiS3afXAK6d
         1Q5A==
X-Gm-Message-State: AOAM5312rjAZlV4cOQWx93l2IWxxABKyIuL484frXqhlFQq3UUsL+Hvm
        NsYryGzM/L5/wN81qRMJQi9Hgw==
X-Google-Smtp-Source: ABdhPJyuBjt/iib9O9I71T0ViGztUI4PxkN5aQvIyVGOHDy2rAhJhMt0uP9iiu1+9hk6ckbtos+/kg==
X-Received: by 2002:a62:2ad2:: with SMTP id q201mr7663088pfq.323.1590038936775;
        Wed, 20 May 2020 22:28:56 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id z21sm3502163pfr.77.2020.05.20.22.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 22:28:56 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     groeck@chromium.org, bleung@chromium.org,
        enric.balletbo@collabora.com, twawrzynczak@chromium.org
Cc:     linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] platform: cros_ec_debugfs: control uptime information request
Date:   Wed, 20 May 2020 22:28:32 -0700
Message-Id: <20200521052832.66620-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When EC does not support uptime command (EC_CMD_GET_UPTIME_INFO),
return -EPROTO to read of /sys/kernel/debug/cros_ec/uptime without
calling the EC after the first try.

The EC console log will not contain EC_CMD_GET_UPTIME_INFO anymore.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/platform/chrome/cros_ec_debugfs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 6ae484989d1f5..70a29afb6d9e7 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -49,6 +49,8 @@ struct cros_ec_debugfs {
 	struct delayed_work log_poll_work;
 	/* EC panicinfo */
 	struct debugfs_blob_wrapper panicinfo_blob;
+	/* EC uptime */
+	bool uptime_supported;
 };
 
 /*
@@ -256,12 +258,19 @@ static ssize_t cros_ec_uptime_read(struct file *file, char __user *user_buf,
 	char read_buf[32];
 	int ret;
 
+	if (!debug_info->uptime_supported)
+		return -EPROTO;
+
 	resp = (struct ec_response_uptime_info *)&msg.resp;
 
 	msg.cmd.command = EC_CMD_GET_UPTIME_INFO;
 	msg.cmd.insize = sizeof(*resp);
 
 	ret = cros_ec_cmd_xfer_status(ec_dev, &msg.cmd);
+	if (ret == -EPROTO && msg.cmd.result == EC_RES_INVALID_COMMAND) {
+		debug_info->uptime_supported = false;
+		return ret;
+	}
 	if (ret < 0)
 		return ret;
 
@@ -434,6 +443,9 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
 	debug_info->ec = ec;
 	debug_info->dir = debugfs_create_dir(name, NULL);
 
+	/* Give uptime a chance to run. */
+	debug_info->uptime_supported = true;
+
 	ret = cros_ec_create_panicinfo(debug_info);
 	if (ret)
 		goto remove_debugfs;
-- 
2.26.2.761.g0e0b3e54be-goog

