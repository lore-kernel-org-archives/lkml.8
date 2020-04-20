Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47882C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E2A20575
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgDTPXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:23:36 -0400
Received: from foss.arm.com ([217.140.110.172]:50908 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727889AbgDTPXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:23:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A3FCA11D4;
        Mon, 20 Apr 2020 08:23:32 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFC283F73D;
        Mon, 20 Apr 2020 08:23:31 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com
Subject: [PATCH 4/4] firmware: arm_scmi: Fix handling of unexpected delayed responses
Date:   Mon, 20 Apr 2020 16:23:15 +0100
Message-Id: <20200420152315.21008-5-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200420152315.21008-1-cristian.marussi@arm.com>
References: <20200420152315.21008-1-cristian.marussi@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon reception of an unexpected bogus delayed response, clear the channel
and bail-out safely.

Fixes: 4d09852b6f01 ("firmware: arm_scmi: Add support for notifications message processing")
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 07de196f15aa..0146332d06a1 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -247,6 +247,21 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
 	}
 
 	xfer = &minfo->xfer_block[xfer_id];
+	/*
+	 * Even if a response was indeed expected on this slot at this point,
+	 * a buggy platform could wrongly reply feeding us an unexpected
+	 * delayed response we're not prepared to handle: bail-out safely
+	 * blaming fw guys.
+	 */
+	if (unlikely(msg_type == MSG_TYPE_DELAYED_RESP && !xfer->async_done)) {
+		dev_err(dev,
+			"Delayed Response for %d not expected! Buggy FW ?\n",
+			xfer_id);
+		info->desc->ops->clear_channel(cinfo);
+		/* It was unexpected, so nobody will clear the xfer if not us */
+		__scmi_xfer_put(minfo, xfer);
+		return;
+	}
 
 	scmi_dump_header_dbg(dev, &xfer->hdr);
 
-- 
2.17.1

