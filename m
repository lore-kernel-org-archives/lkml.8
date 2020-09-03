Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49008C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEC0420709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="daq4GzOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgICJy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 05:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbgICJyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 05:54:24 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8BFC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 02:54:24 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id np15so3501956pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 02:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wjC0tbIDPPDTdCpRz9F+/eEg4mMonLjJNrNCC1I0r9s=;
        b=daq4GzOXr0Z4qXadeIiXFl0GoIQv5p5aWjjn8L4bzFstMV1iXf6T1eOyAb29z/63DH
         901cv/i9bSMfhV6ZJaoa4quAW1mkxH62dAvWCKGMCNUH4GT5aOfskc9OvOX63vlFbmIQ
         cnFAV8hrGatz5otidu+w6Glv1cDOWC0dSR2rE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wjC0tbIDPPDTdCpRz9F+/eEg4mMonLjJNrNCC1I0r9s=;
        b=hxTxe3KSI3hzyrijOBwQ4rhIAau4rCeDY0GecCpnWViwAV0MRMvMyxnpII+cDuWWrm
         mY5g6wkXRI3qt8H46DtDb8mzEpwOWHosdIXgpjGtqoqJBuGaHG8c9f56A4dNc1JvbxgQ
         /k/Not0nSvNN9daJKbiPu+Mxo/88A73zp4WGpkpMJea7/IfC61HVZG5/Mafh5Wo1ozzH
         wWXGM1fWtPI0B43a7uy1iaa8BeSaIRrqYsH/tXlbYQABKEfzrMhJ9rk6xwlKGspeURpm
         e8PApGK96Ppfcp34AB07UkXaeYvt2U3GqdD5HEuSM1g127SpLlr/5Uig2AwdF5IIl84e
         pTcg==
X-Gm-Message-State: AOAM532r4RKe9G9GHsBxEuN8JN8wqQl2wUSfLjPW2uNRrSZJBA2h5T1F
        GUN7eDVcQQ4J2x0ZZ8VCb7Bvz9xXIRhvQQ==
X-Google-Smtp-Source: ABdhPJx5dCHM8X+wC1wiwFYO5IQ2Q8oOzLpB2grWDJbWV1PLV2uAzP2C48iuuoKRTrtU/SPCHDBGrQ==
X-Received: by 2002:a17:90a:86c2:: with SMTP id y2mr2565470pjv.3.1599126863608;
        Thu, 03 Sep 2020 02:54:23 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id y7sm2094475pgk.73.2020.09.03.02.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 02:54:23 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwendal@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 1/2] platform/chrome: cros_ec_proto: Update cros_ec_cmd_xfer() call-sites
Date:   Thu,  3 Sep 2020 02:54:14 -0700
Message-Id: <20200903095415.2572049-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since all the other call-sites of cros_ec_cmd_xfer() have been converted
to use cros_ec_cmd_xfer_status() instead, update the remaining
call-sites to prepare for the merge of cros_ec_cmd_xfer() into
cros_ec_cmd_xfer_status().

As part of this update, change the error handling inside
cros_ec_get_sensor_count() such that the legacy LPC interface is tried
on all error values, not just when msg->result != EC_RESULT_SUCCESS.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_proto.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index dda182132a6a..2cb1defcdd13 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -650,7 +650,7 @@ static int get_next_event_xfer(struct cros_ec_device *ec_dev,
 	msg->insize = size;
 	msg->outsize = 0;
 
-	ret = cros_ec_cmd_xfer(ec_dev, msg);
+	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
 	if (ret > 0) {
 		ec_dev->event_size = ret - 1;
 		ec_dev->event_data = *event;
@@ -694,7 +694,7 @@ static int get_keyboard_state_event(struct cros_ec_device *ec_dev)
 	msg->insize = sizeof(ec_dev->event_data.data);
 	msg->outsize = 0;
 
-	ec_dev->event_size = cros_ec_cmd_xfer(ec_dev, msg);
+	ec_dev->event_size = cros_ec_cmd_xfer_status(ec_dev, msg);
 	ec_dev->event_data.event_type = EC_MKBP_EVENT_KEY_MATRIX;
 	memcpy(&ec_dev->event_data.data, msg->data,
 	       sizeof(ec_dev->event_data.data));
@@ -883,11 +883,9 @@ int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
 	params = (struct ec_params_motion_sense *)msg->data;
 	params->cmd = MOTIONSENSE_CMD_DUMP;
 
-	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
 	if (ret < 0) {
 		sensor_count = ret;
-	} else if (msg->result != EC_RES_SUCCESS) {
-		sensor_count = -EPROTO;
 	} else {
 		resp = (struct ec_response_motion_sense *)msg->data;
 		sensor_count = resp->dump.sensor_count;
@@ -898,9 +896,7 @@ int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
 	 * Check legacy mode: Let's find out if sensors are accessible
 	 * via LPC interface.
 	 */
-	if (sensor_count == -EPROTO &&
-	    ec->cmd_offset == 0 &&
-	    ec_dev->cmd_readmem) {
+	if (sensor_count < 0 && ec->cmd_offset == 0 && ec_dev->cmd_readmem) {
 		ret = ec_dev->cmd_readmem(ec_dev, EC_MEMMAP_ACC_STATUS,
 				1, &status);
 		if (ret >= 0 &&
@@ -915,9 +911,6 @@ int cros_ec_get_sensor_count(struct cros_ec_dev *ec)
 			 */
 			sensor_count = 0;
 		}
-	} else if (sensor_count == -EPROTO) {
-		/* EC responded, but does not understand DUMP command. */
-		sensor_count = 0;
 	}
 	return sensor_count;
 }
-- 
2.28.0.526.ge36021eeef-goog

