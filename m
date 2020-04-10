Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10806C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58EC20857
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:23:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ouarj1AP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgDJQXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 12:23:22 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42692 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgDJQXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 12:23:22 -0400
Received: by mail-pf1-f196.google.com with SMTP id 22so1220848pfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 09:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uKOOFpBMpsxQLj3kDvN/9el/ZGEfPFFVWNgPbZWR2c0=;
        b=Ouarj1APAOtAKPq92iy9qVy1+Uuym5EIwg+BdogZj5iIRVBRPNKEXVAQ2foI9cJkXH
         aM5IxKMVsdY97twkrJZ0y8LSK31jgvy1r3pJ4Zx/0XzYAnEE+rNVRCOp5Bu8JQph70Jp
         u7pLKwZk8VB7CfWAZZ10FB2DXDoI0TYdtYYh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uKOOFpBMpsxQLj3kDvN/9el/ZGEfPFFVWNgPbZWR2c0=;
        b=MwuUVRra/Dvg7oQLPn9L6/tX3BAszikUQQ/C5nbAHYB2bxp6iZcBT4ANG9Xuw3Dk3P
         hFa1b8KoonUeHfYeXeZgcWwGr+GRoWU0Ig+aJK9JRm046WW813EgiDQug41Fvq440AwN
         FWZ+CWDgfaCHZcMvKrcL7SpQhekghYXTQBpsZy2GocXj2j9oyFj+ke8xhT9t2kkf0001
         3DFiaegmZgdXT7e0lef38cPzJouME9SrahachreDwhdjvWaRTPzvw06XSTguI2yXN/QS
         7UroLLjkwnCxG+EmteAKyZb1oP5n3TIn2rh7VQR+gckI+CsvKOWuANnV/Ao7j7PwrMd3
         Ur9Q==
X-Gm-Message-State: AGi0PuZr9JiqUpQLl461TDuX4aAD1Cjku5/zBq3lPJBbV+99cGHwYqc1
        4NJAgcnEUniADjNL1RfnaynxktWvo92+yA==
X-Google-Smtp-Source: APiQypJOBFflf3BPt5C1pyEi/lSTrHMdH2PKQqP2X2AIYX8B/n3nDJ1DYvqqKF+iq/+161wCrnx0lg==
X-Received: by 2002:a62:3808:: with SMTP id f8mr5649414pfa.38.1586535798877;
        Fri, 10 Apr 2020 09:23:18 -0700 (PDT)
Received: from mathewk1.lan ([161.97.192.125])
        by smtp.gmail.com with ESMTPSA id c4sm1977138pgg.17.2020.04.10.09.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 09:23:18 -0700 (PDT)
From:   Mathew King <mathewk@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jett Rink <jettrink@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rushikesh S Kadam <rushikesh.s.kadam@intel.com>,
        Mathew King <mathewk@chromium.org>
Subject: [PATCH v2 1/2] platform/chrome: cros_ec_ishtp: skip old cros_ec responses
Date:   Fri, 10 Apr 2020 10:23:04 -0600
Message-Id: <20200410162305.76638-1-mathewk@chromium.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
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

The cros_ish should only have one request in flight at a time. We send
the request and wait for the response from the ISH. If the ISH is too
slow to respond we give up on that request and we can send a new
request. The ISH may still send the response to the request that timed
out and without this we treat the old response as the response to the
current command. This is a condition that should not normally happen but
it has been observed with a bad ISH image. So add a token to the request
header which is copied into the response header when the ISH processes
the message to ensure that response is for the current request.

Signed-off-by: Jett Rink <jettrink@chromium.org>
Signed-off-by: Mathew King <mathewk@chromium.org>
---
v2: - Change from using id to token
    - Reword the commit message
---
 drivers/platform/chrome/cros_ec_ishtp.c | 32 ++++++++++++++++++-------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
index 93a71e93a2f1..e673a7f738fc 100644
--- a/drivers/platform/chrome/cros_ec_ishtp.c
+++ b/drivers/platform/chrome/cros_ec_ishtp.c
@@ -48,7 +48,8 @@ static const guid_t cros_ish_guid =
 struct header {
 	u8 channel;
 	u8 status;
-	u8 reserved[2];
+	u8 token;
+	u8 reserved;
 } __packed;
 
 struct cros_ish_out_msg {
@@ -90,6 +91,7 @@ static DECLARE_RWSEM(init_lock);
  * data exceeds this value, we log an error.
  * @size: Actual size of data received from firmware.
  * @error: 0 for success, negative error code for a failure in process_recv().
+ * @token: Expected token for response that we are waiting on.
  * @received: Set to true on receiving a valid firmware	response to host command
  * @wait_queue: Wait queue for host to wait for firmware response.
  */
@@ -98,6 +100,7 @@ struct response_info {
 	size_t max_size;
 	size_t size;
 	int error;
+	u8 token;
 	bool received;
 	wait_queue_head_t wait_queue;
 };
@@ -162,6 +165,7 @@ static int ish_send(struct ishtp_cl_data *client_data,
 		    u8 *out_msg, size_t out_size,
 		    u8 *in_msg, size_t in_size)
 {
+	static u8 next_token;
 	int rv;
 	struct header *out_hdr = (struct header *)out_msg;
 	struct ishtp_cl *cros_ish_cl = client_data->cros_ish_cl;
@@ -174,8 +178,11 @@ static int ish_send(struct ishtp_cl_data *client_data,
 	client_data->response.data = in_msg;
 	client_data->response.max_size = in_size;
 	client_data->response.error = 0;
+	client_data->response.token = next_token++;
 	client_data->response.received = false;
 
+	out_hdr->token = client_data->response.token;
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
+		if (client_data->response.token != in_msg->hdr.token) {
+			dev_err_ratelimited(dev,
+					    "Dropping old response token %d\n",
+					    in_msg->hdr.token);
+			goto end_error;
+		}
+
+		/* Sanity check */
+		if (!client_data->response.data) {
 			dev_err(dev,
-				"Previous firmware message not yet processed\n");
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
2.26.0.110.g2183baf09c-goog

