Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96890C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9052072B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IR4EUOI0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgBETXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 14:23:05 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51700 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgBETXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:23:05 -0500
Received: by mail-pj1-f65.google.com with SMTP id fa20so1399071pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 11:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AB0mPtmmhd4uES+XsmfG8LIdv1jJKRW24bbomYl8aD8=;
        b=IR4EUOI0PS96fst6PUpnxAAEiyW5vWCWKy8OEOWvsK8wU19s5K8fn5ulk+vD0NiP0d
         XdiYMotREZ5jrLS4LMRoc/UwPGFNnTSNuez1UQq1FQVHSm9jTg2DDBA3LjitJHnA/E11
         oQUQusgGsNiqFFOm9vX+YkH3CPwHT6d/oXFig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AB0mPtmmhd4uES+XsmfG8LIdv1jJKRW24bbomYl8aD8=;
        b=dO/x49VIcxzlvL34e0MdJWXGfG8aTurRICWfE2ndr9SWQxYKs8o0kWsuPyN3uFZ5VG
         qON5hpUVOri3+e33fXDh1fSyDXfE+QVU3Qdk4+H3GvOuqy/AAsYUzC6aNj7FdCJCnahO
         lbUbUmfHwXM8A8JXDr4R+UNtDwqheeBrH6rUiEkcUEoYRZObiqdgG9HoYheK9GPBp0nA
         YvkRGaO3e6zqC4UgC2jT1QkIUb1ps56r8wHjfgFCkkvFqiq5QH0jtt8On2yfY41jk4u1
         FAFCNSmH2Fig3cmhFo7msZbCf8au6WZ7Xxje+TIwOJChev2o7bYwlOJi02Eb/OUmxSSa
         tFnA==
X-Gm-Message-State: APjAAAXsQN+shtPESvN7XUI3lrKPLYuq6khipRfhbSlRw0T2gdA5hZI1
        zEG2ggd+l/zTlwDhiAyEIqKWcC/kWt0=
X-Google-Smtp-Source: APXvYqyLLZwJORlgU1YWy2dv2sz3baiBjgGjcqCX3S/3kK7QyuWIeJag6P/sTJgjw9LeLvhQHH0gQA==
X-Received: by 2002:a17:902:b190:: with SMTP id s16mr33845395plr.299.1580930583956;
        Wed, 05 Feb 2020 11:23:03 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id c6sm535886pgk.78.2020.02.05.11.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 11:23:03 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM HOST DRIVERS)
Subject: [PATCH v2 16/17] i2c: cros-ec-tunnel: Use cros_ec_cmd()
Date:   Wed,  5 Feb 2020 11:22:51 -0800
Message-Id: <20200205192253.187649-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace cros_ec_cmd_xfer_status() calls with the new function
cros_ec_cmd() which takes care of the EC message struct setup and
subsequent cleanup (which is a common pattern among users of
cros_ec_cmd_xfer_status).

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Updated to use new function name and parameter list.

 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
index 958161c71985d9..d0e0db2008d1ca 100644
--- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
+++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
@@ -179,9 +179,8 @@ static int ec_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg i2c_msgs[],
 	const u16 bus_num = bus->remote_bus;
 	int request_len;
 	int response_len;
-	int alloc_size;
 	int result;
-	struct cros_ec_command *msg;
+	void *ec_buf;
 
 	request_len = ec_i2c_count_message(i2c_msgs, num);
 	if (request_len < 0) {
@@ -196,36 +195,31 @@ static int ec_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg i2c_msgs[],
 		return response_len;
 	}
 
-	alloc_size = max(request_len, response_len);
-	msg = kmalloc(sizeof(*msg) + alloc_size, GFP_KERNEL);
-	if (!msg)
+	ec_buf = kmalloc(max(request_len, response_len), GFP_KERNEL);
+	if (!ec_buf)
 		return -ENOMEM;
 
-	result = ec_i2c_construct_message(msg->data, i2c_msgs, num, bus_num);
+	result = ec_i2c_construct_message(ec_buf, i2c_msgs, num, bus_num);
 	if (result) {
 		dev_err(dev, "Error constructing EC i2c message %d\n", result);
 		goto exit;
 	}
 
-	msg->version = 0;
-	msg->command = EC_CMD_I2C_PASSTHRU;
-	msg->outsize = request_len;
-	msg->insize = response_len;
-
-	result = cros_ec_cmd_xfer_status(bus->ec, msg);
+	result = cros_ec_cmd(bus->ec, 0, EC_CMD_I2C_PASSTHRU, ec_buf,
+			     request_len, ec_buf, response_len, NULL);
 	if (result < 0) {
 		dev_err(dev, "Error transferring EC i2c message %d\n", result);
 		goto exit;
 	}
 
-	result = ec_i2c_parse_response(msg->data, i2c_msgs, &num);
+	result = ec_i2c_parse_response(ec_buf, i2c_msgs, &num);
 	if (result < 0)
 		goto exit;
 
 	/* Indicate success by saying how many messages were sent */
 	result = num;
 exit:
-	kfree(msg);
+	kfree(ec_buf);
 	return result;
 }
 
-- 
2.25.0.341.g760bfbb309-goog

