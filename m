Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A59C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D08920730
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NCEXKNJh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbgDHSRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:17:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33821 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729567AbgDHSRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 14:17:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id l14so3700362pgb.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 11:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a7Kz6mupJHO9uOskSzYFD2yj0NLryLLhKvsjgUXMfWM=;
        b=NCEXKNJhRxnEORMffaLeSM7hn4vYQLeaUg1opXivarf9d+xzMXNVLT0//eVHktufn/
         4rJCRiQmWatDn81aUZ8CVl0Z4thlAeVPtPG2fmWgK5RvZrzbNlxKt15BA4ndLduQuV8U
         71bcRyK5Wa+ThI2e1dJWIJt1ZVYyaRulAcPjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a7Kz6mupJHO9uOskSzYFD2yj0NLryLLhKvsjgUXMfWM=;
        b=W300Cgat97xZUfgjAR2SzyGs8p17IzxT/Lk43hn1z4DsXDDr6O9OjFX8yDlegIBB3K
         urjou32tZcLgsTRIeAz+LclcBSYGESvj8BUrR/Trwqb48LsjJ+gA8fs+rwghsHYl974P
         BjAaJ4aANu6CUy1mnbxunAV9ffNSCI8NS4+ficfisbDVcgu2iN2EX9oB2DSeAkPFhN3J
         G4URM56qN4djz/0oK6Ri2ClRBbbJhgs3owDsOQ9Ab5e9FYn56m8s3bnYp3BNDiiG35ev
         ewtgUnnF1ZkVPAeyWRDBGvt0NggXjddsi6cnN5QowAF8IOZZKWgMQ4LcqAUoBUJBcBrR
         WAag==
X-Gm-Message-State: AGi0PubJhIMwYIdCFTcPqtbzJb9n7a+y5cckn0kaVjETBAoSVm8yLbu3
        DTzL3V4hp4qgO2zOtc+3bsOODHMf6WXbAA==
X-Google-Smtp-Source: APiQypJDyp06l9KBPJGBpRcCRj84HscljaDKmf4SvHLRx1+0H29vlnGcHZvn9U5KebfBiKEbTJhObg==
X-Received: by 2002:aa7:8649:: with SMTP id a9mr8904357pfo.138.1586369826566;
        Wed, 08 Apr 2020 11:17:06 -0700 (PDT)
Received: from mathewk1.lan ([161.97.192.125])
        by smtp.gmail.com with ESMTPSA id e27sm1347074pfl.219.2020.04.08.11.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 11:17:05 -0700 (PDT)
From:   Mathew King <mathewk@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jett Rink <jettrink@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mathew King <mathewk@chromium.org>
Subject: [PATCH 1/2] platform/chrome: skip old cros_ec responses
Date:   Wed,  8 Apr 2020 12:16:37 -0600
Message-Id: <20200408181638.184559-1-mathewk@chromium.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jett Rink <jettrink@chromium.org>

The ISHTP layer can give us old responses that we already gave up on. We
do not want to interpret these old responses as the current response we
are waiting for.

Signed-off-by: Jett Rink <jettrink@chromium.org>
Signed-off-by: Mathew King <mathewk@chromium.org>
---
 drivers/platform/chrome/cros_ec_ishtp.c | 32 ++++++++++++++++++-------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
index 93a71e93a2f1..6f90deb5cf55 100644
--- a/drivers/platform/chrome/cros_ec_ishtp.c
+++ b/drivers/platform/chrome/cros_ec_ishtp.c
@@ -48,7 +48,8 @@ static const guid_t cros_ish_guid =
 struct header {
 	u8 channel;
 	u8 status;
-	u8 reserved[2];
+	u8 id;
+	u8 reserved;
 } __packed;
 
 struct cros_ish_out_msg {
@@ -90,6 +91,7 @@ static DECLARE_RWSEM(init_lock);
  * data exceeds this value, we log an error.
  * @size: Actual size of data received from firmware.
  * @error: 0 for success, negative error code for a failure in process_recv().
+ * @expected_id: Expected id for response that we are waiting on.
  * @received: Set to true on receiving a valid firmware	response to host command
  * @wait_queue: Wait queue for host to wait for firmware response.
  */
@@ -98,6 +100,7 @@ struct response_info {
 	size_t max_size;
 	size_t size;
 	int error;
+	u8 expected_id;
 	bool received;
 	wait_queue_head_t wait_queue;
 };
@@ -162,6 +165,7 @@ static int ish_send(struct ishtp_cl_data *client_data,
 		    u8 *out_msg, size_t out_size,
 		    u8 *in_msg, size_t in_size)
 {
+	static u8 current_id;
 	int rv;
 	struct header *out_hdr = (struct header *)out_msg;
 	struct ishtp_cl *cros_ish_cl = client_data->cros_ish_cl;
@@ -174,8 +178,11 @@ static int ish_send(struct ishtp_cl_data *client_data,
 	client_data->response.data = in_msg;
 	client_data->response.max_size = in_size;
 	client_data->response.error = 0;
+	client_data->response.expected_id = ++current_id;
 	client_data->response.received = false;
 
+	out_hdr->id = client_data->response.expected_id;
+
 	rv = ishtp_cl_send(cros_ish_cl, out_msg, out_size);
 	if (rv) {
 		dev_err(cl_data_to_dev(client_data),
@@ -249,17 +256,23 @@ static void process_recv(struct ishtp_cl *cros_ish_cl,
 
 	switch (in_msg->hdr.channel) {
 	case CROS_EC_COMMAND:
-		/* Sanity check */
-		if (!client_data->response.data) {
+		if (client_data->response.received) {
 			dev_err(dev,
-				"Receiving buffer is null. Should be allocated by calling function\n");
-			client_data->response.error = -EINVAL;
-			goto error_wake_up;
+				"Previous firmware message not yet processed\n");
+			goto end_error;
 		}
 
-		if (client_data->response.received) {
+		if (client_data->response.expected_id != in_msg->hdr.id) {
 			dev_err(dev,
-				"Previous firmware message not yet processed\n");
+				"Dropping old response id %d\n",
+				in_msg->hdr.id);
+			goto end_error;
+		}
+
+		/* Sanity check */
+		if (!client_data->response.data) {
+			dev_err(dev,
+				"Receiving buffer is null. Should be allocated by calling function\n");
 			client_data->response.error = -EINVAL;
 			goto error_wake_up;
 		}
@@ -289,9 +302,10 @@ static void process_recv(struct ishtp_cl *cros_ish_cl,
 		memcpy(client_data->response.data,
 		       rb_in_proc->buffer.data, data_len);
 
+error_wake_up:
 		/* Set flag before waking up the caller */
 		client_data->response.received = true;
-error_wake_up:
+
 		/* Wake the calling thread */
 		wake_up_interruptible(&client_data->response.wait_queue);
 
-- 
2.26.0.292.g33ef6b2f38-goog

