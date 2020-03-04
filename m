Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84F0C3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB71A22522
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 16:26:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388218AbgCDQ0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 11:26:47 -0500
Received: from foss.arm.com ([217.140.110.172]:36602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730011AbgCDQ0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 11:26:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F5694B2;
        Wed,  4 Mar 2020 08:26:46 -0800 (PST)
Received: from e120937-lin.cambridge.arm.com (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AEBC3F6CF;
        Wed,  4 Mar 2020 08:26:45 -0800 (PST)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@Huawei.com,
        cristian.marussi@arm.com
Subject: [PATCH v4 08/13] firmware: arm_scmi: Enable notification core
Date:   Wed,  4 Mar 2020 16:25:53 +0000
Message-Id: <20200304162558.48836-9-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304162558.48836-1-cristian.marussi@arm.com>
References: <20200304162558.48836-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize and enable SCMI Notifications core support during bus/driver
probe phase, so that protocols can start registering their supported
events during their initialization.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
V3 --> V4
- simplified core initialization: protocols events' registrations is now
  disjoint from users' callback registrations, so that events' generation
  can be enabled earlier for registered events and delayed for pending
  ones in order to support deferred (or missing) protocol initialization
V2 --> V3
- reviewed core initialization: all implemented protocols must complete
  their protocol-events registration phases before notifications can be
  enabled as a whole; in the meantime any user's callback registration
  requests possibly issued while the notifications were not enabled
  remain pending: a dedicated worker completes the handlers registration
  once all protocols have been initialized.
  NOTE THAT this can lead to ISSUES with late inserted or missing SCMI
  modules (i.e. for protocols defined in the DT and implemented by the
  platform but lazily loaded or not loaded at all.), since in these
  scenarios notifications dispatching will be enabled later or never.
- reviewed core exit: protocol users (devices) are accounted on probe/
  remove, and protocols' events are unregisteredonce last user go
  (can happen only at shutdown)
V1 --> V2
- added timestamping
- moved notification init/exit and using devres
---
 drivers/firmware/arm_scmi/driver.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 868cc36a07c9..5c43d82e3260 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 
 #include "common.h"
+#include "notify.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/scmi.h>
@@ -204,11 +205,13 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
 
 static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 {
+	u64 ts;
 	struct scmi_xfer *xfer;
 	struct device *dev = cinfo->dev;
 	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
 	struct scmi_xfers_info *minfo = &info->rx_minfo;
 
+	ts = ktime_get_boottime_ns();
 	xfer = scmi_xfer_get(cinfo->handle, minfo);
 	if (IS_ERR(xfer)) {
 		dev_err(dev, "failed to get free message slot (%ld)\n",
@@ -221,6 +224,8 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
 	scmi_dump_header_dbg(dev, &xfer->hdr);
 	info->desc->ops->fetch_notification(cinfo, info->desc->max_msg_size,
 					    xfer);
+	scmi_notify(cinfo->handle, xfer->hdr.protocol_id,
+		    xfer->hdr.id, xfer->rx.buf, xfer->rx.len, ts);
 
 	trace_scmi_rx_done(xfer->transfer_id, xfer->hdr.id,
 			   xfer->hdr.protocol_id, xfer->hdr.seq,
@@ -771,6 +776,9 @@ static int scmi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (scmi_notification_init(handle))
+		dev_err(dev, "SCMI Notifications NOT available.\n");
+
 	ret = scmi_base_protocol_init(handle);
 	if (ret) {
 		dev_err(dev, "unable to communicate with SCMI(%d)\n", ret);
@@ -813,6 +821,8 @@ static int scmi_remove(struct platform_device *pdev)
 	struct scmi_info *info = platform_get_drvdata(pdev);
 	struct idr *idr = &info->tx_idr;
 
+	scmi_notification_exit(&info->handle);
+
 	mutex_lock(&scmi_list_mutex);
 	if (info->users)
 		ret = -EBUSY;
-- 
2.17.1

