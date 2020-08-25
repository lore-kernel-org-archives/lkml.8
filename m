Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC70C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B0C42075E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vJcgqYPU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WPbcpIKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgHYXlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:41:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53356 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgHYXlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 19:41:04 -0400
Date:   Tue, 25 Aug 2020 23:41:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598398862;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8rzUtZnYC5QJj2uLaMQoCBpzIpFkM8gaIUPjEy44YX4=;
        b=vJcgqYPUPC+xzmH/ROmCO7Zu6FhXK7cawOfP39by7ISwST3aJHUeYIarRtAnSQA1sUbcW1
        GlPEBUZHkfGugYS3JNXpenTh9xowfuPBTkzw5VAxApSA/yH5dMz6yqZkxgUOY6rITWd8PI
        M3dpNUYcY31UMaa3etJGrw3XYs6KlKqS1kUqIfckwZiNlti0fLJt+sf2UeVBJokadomnf1
        3pkLr3wf7f5qEWKEhCTrV2g1gbP9aXcrCoIx5+BuplXLNs9zR3jOkInm51pZTwroG3E9kG
        ptdwwF1NQrIcXUbfaT2piEzUxPkfZ5zRkEIpy9uiK4X3NF/Z+tr02HeQcnv+3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598398862;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8rzUtZnYC5QJj2uLaMQoCBpzIpFkM8gaIUPjEy44YX4=;
        b=WPbcpIKKX6qSJcB6FVi0x5BIZAeiGh0QrjZPwLEGli5XLcAoVcNzRziKu8SVjh61Ejo8Sv
        6ZHSdfJ3dGPqK0Cw==
From:   "tip-bot2 for Lokesh Vutla" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] firmware: ti_sci: Drop unused structure ti_sci_rm_type_map
Cc:     Lokesh Vutla <lokeshvutla@ti.com>, Marc Zyngier <maz@kernel.org>,
        Nishanth Menon <nm@ti.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200806074826.24607-3-lokeshvutla@ti.com>
References: <20200806074826.24607-3-lokeshvutla@ti.com>
MIME-Version: 1.0
Message-ID: <159839886134.389.2645091220673580015.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     9b98e02a3d369c5d0875338ea0717030471b5210
Gitweb:        https://git.kernel.org/tip/9b98e02a3d369c5d0875338ea0717030471b5210
Author:        Lokesh Vutla <lokeshvutla@ti.com>
AuthorDate:    Thu, 06 Aug 2020 13:18:15 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 16 Aug 2020 22:00:22 +01:00

firmware: ti_sci: Drop unused structure ti_sci_rm_type_map

struct ti_sci_rm_type_map is no longer used. Drop its definition and its
declarations.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Nishanth Menon <nm@ti.com>
Link: https://lore.kernel.org/r/20200806074826.24607-3-lokeshvutla@ti.com
---
 drivers/firmware/ti_sci.c | 56 +--------------------------------------
 1 file changed, 1 insertion(+), 55 deletions(-)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 81e4d77..03bd01b 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -65,36 +65,18 @@ struct ti_sci_xfers_info {
 };
 
 /**
- * struct ti_sci_rm_type_map - Structure representing TISCI Resource
- *				management representation of dev_ids.
- * @dev_id:	TISCI device ID
- * @type:	Corresponding id as identified by TISCI RM.
- *
- * Note: This is used only as a work around for using RM range apis
- *	for AM654 SoC. For future SoCs dev_id will be used as type
- *	for RM range APIs. In order to maintain ABI backward compatibility
- *	type is not being changed for AM654 SoC.
- */
-struct ti_sci_rm_type_map {
-	u32 dev_id;
-	u16 type;
-};
-
-/**
  * struct ti_sci_desc - Description of SoC integration
  * @default_host_id:	Host identifier representing the compute entity
  * @max_rx_timeout_ms:	Timeout for communication with SoC (in Milliseconds)
  * @max_msgs: Maximum number of messages that can be pending
  *		  simultaneously in the system
  * @max_msg_size: Maximum size of data per message that can be handled.
- * @rm_type_map: RM resource type mapping structure.
  */
 struct ti_sci_desc {
 	u8 default_host_id;
 	int max_rx_timeout_ms;
 	int max_msgs;
 	int max_msg_size;
-	struct ti_sci_rm_type_map *rm_type_map;
 };
 
 /**
@@ -1710,33 +1692,6 @@ fail:
 	return ret;
 }
 
-static int ti_sci_get_resource_type(struct ti_sci_info *info, u16 dev_id,
-				    u16 *type)
-{
-	struct ti_sci_rm_type_map *rm_type_map = info->desc->rm_type_map;
-	bool found = false;
-	int i;
-
-	/* If map is not provided then assume dev_id is used as type */
-	if (!rm_type_map) {
-		*type = dev_id;
-		return 0;
-	}
-
-	for (i = 0; rm_type_map[i].dev_id; i++) {
-		if (rm_type_map[i].dev_id == dev_id) {
-			*type = rm_type_map[i].type;
-			found = true;
-			break;
-		}
-	}
-
-	if (!found)
-		return -EINVAL;
-
-	return 0;
-}
-
 /**
  * ti_sci_get_resource_range - Helper to get a range of resources assigned
  *			       to a host. Resource is uniquely identified by
@@ -1760,7 +1715,6 @@ static int ti_sci_get_resource_range(const struct ti_sci_handle *handle,
 	struct ti_sci_xfer *xfer;
 	struct ti_sci_info *info;
 	struct device *dev;
-	u16 type;
 	int ret = 0;
 
 	if (IS_ERR(handle))
@@ -1780,15 +1734,9 @@ static int ti_sci_get_resource_range(const struct ti_sci_handle *handle,
 		return ret;
 	}
 
-	ret = ti_sci_get_resource_type(info, dev_id, &type);
-	if (ret) {
-		dev_err(dev, "rm type lookup failed for %u\n", dev_id);
-		goto fail;
-	}
-
 	req = (struct ti_sci_msg_req_get_resource_range *)xfer->xfer_buf;
 	req->secondary_host = s_host;
-	req->type = type & MSG_RM_RESOURCE_TYPE_MASK;
+	req->type = dev_id & MSG_RM_RESOURCE_TYPE_MASK;
 	req->subtype = subtype & MSG_RM_RESOURCE_SUBTYPE_MASK;
 
 	ret = ti_sci_do_xfer(info, xfer);
@@ -3352,7 +3300,6 @@ static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
 	/* Limited by MBOX_TX_QUEUE_LEN. K2G can handle upto 128 messages! */
 	.max_msgs = 20,
 	.max_msg_size = 64,
-	.rm_type_map = NULL,
 };
 
 /* Description for AM654 */
@@ -3363,7 +3310,6 @@ static const struct ti_sci_desc ti_sci_pmmc_am654_desc = {
 	/* Limited by MBOX_TX_QUEUE_LEN. K2G can handle upto 128 messages! */
 	.max_msgs = 20,
 	.max_msg_size = 60,
-	.rm_type_map = NULL,
 };
 
 static const struct of_device_id ti_sci_of_match[] = {
