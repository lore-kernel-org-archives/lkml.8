Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A013C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259FC20708
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:36:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DqxaZTos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgA3Ug2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:36:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40808 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbgA3Ug1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:36:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so1780454plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bXohYy5JDDUpstuMmCZ2nxWIpuXuLrxivGl9GV5Z+aE=;
        b=DqxaZTos43ERCa6DlpM4koE7G/chUkxYWFO8n16pz1S5F9W/gyuhBP1fnjMoGv5DpM
         FwyjLDhbpYnmrnZHYmwe52HnD6jR3vRnVZvKQ9xGcikCD5qLeXV+uzK7zBl8UhnIWliS
         36m8NczkxJQNAl7EuVkhIZKzHzP18KxJTcW6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bXohYy5JDDUpstuMmCZ2nxWIpuXuLrxivGl9GV5Z+aE=;
        b=L51w8cug7xWygMCw7gGiIfpyn84l6bCvdmoMYeJp3BFoOAqrkB8xfKbBUoE4YcQYRP
         fa9pUz6n8+FJVxz1tzdwjscY4G2p9azaz9ubY1hWs02ouzFHSfvHj7qktJ1BpR/wFMAK
         wcTKKzBdM0rFaCmwrWxq/poT7aNqqXfv3c7WhG6b8/aWpNbeGzfQpuC1ToesEpuFzxwg
         MqToc9aMAnGODHbYxXiAMoHrWx8sWtfE/GLFQ9J7h4CY4NJL8w7L8MikABT4xo1BvhaK
         YZ89cOZ05YY1tiUhOIS5MBE3m0bh9GoGfTg1Ic7b07D+zdNE6oPDKHPjUWp6QYNTXdx9
         O2IQ==
X-Gm-Message-State: APjAAAVZHWfPqUyorJ5NgXe3JmR+1yYw50kbRzfr+4673AgQM3hrXbUC
        OSWyhMSQMvjTPSa8WyAt/DEgkLG+kZJ5CA==
X-Google-Smtp-Source: APXvYqxjJL9O3drU0yp0hB8YBtbV6+dJmUxeyYkhezVQgT4wECYASY6yzxPUUoI6GyMQcsJH0Ns3Ew==
X-Received: by 2002:a17:90a:b008:: with SMTP id x8mr8212277pjq.106.1580416586582;
        Thu, 30 Jan 2020 12:36:26 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id q12sm7469321pfh.158.2020.01.30.12.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:36:26 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        linux-i2c@vger.kernel.org (open list:I2C SUBSYSTEM HOST DRIVERS)
Subject: [PATCH 16/17] i2c: cros-ec-tunnel: Use cros_ec_send_cmd_msg()
Date:   Thu, 30 Jan 2020 12:31:08 -0800
Message-Id: <20200130203106.201894-17-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130203106.201894-1-pmalani@chromium.org>
References: <20200130203106.201894-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace cros_ec_cmd_xfer_status() calls with the new function
cros_ec_send_cmd_msg() which takes care of the EC message struct setup
and subsequent cleanup (which is a common pattern among users of
cros_ec_cmd_xfer_status).

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
index 958161c71985d9..50161dff912298 100644
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
@@ -196,36 +195,32 @@ static int ec_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg i2c_msgs[],
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
+	result = cros_ec_send_cmd_msg(bus->ec, 0, EC_CMD_I2C_PASSTHRU,
+				      ec_buf, request_len,
+				      ec_buf, response_len);
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

