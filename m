Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD888C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A779C20760
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbgFINpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 09:45:11 -0400
Received: from foss.arm.com ([217.140.110.172]:42596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgFINpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:45:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 852E01F1;
        Tue,  9 Jun 2020 06:45:10 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A28C83F66F;
        Tue,  9 Jun 2020 06:45:09 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH] firmware: arm_scmi: Use signed integer to report transfer status
Date:   Tue,  9 Jun 2020 14:45:03 +0100
Message-Id: <20200609134503.55860-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the trace event 'scmi_xfer_end' reports the status of the
transfer using the unsigned status field read from the firmware. This
may not be easy to interpret and also may miss to present any timeouts
that happen in the driver.

Let us use signed integer so that error values are emitted out after
they are mapped from firmware errors to standard linux error codes.
While at this, let us also include any timeouts in the driver itself.

Cc: Jim Quinlan <james.quinlan@broadcom.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/driver.c | 3 +--
 include/trace/events/scmi.h        | 6 +++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 7483cacf63f9..136acbe2f4a1 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -392,8 +392,7 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 		info->desc->ops->mark_txdone(cinfo, ret);
 
 	trace_scmi_xfer_end(xfer->transfer_id, xfer->hdr.id,
-			    xfer->hdr.protocol_id, xfer->hdr.seq,
-			    xfer->hdr.status);
+			    xfer->hdr.protocol_id, xfer->hdr.seq, ret);
 
 	return ret;
 }
diff --git a/include/trace/events/scmi.h b/include/trace/events/scmi.h
index f076c430d243..f3a4b4d60714 100644
--- a/include/trace/events/scmi.h
+++ b/include/trace/events/scmi.h
@@ -35,7 +35,7 @@ TRACE_EVENT(scmi_xfer_begin,
 
 TRACE_EVENT(scmi_xfer_end,
 	TP_PROTO(int transfer_id, u8 msg_id, u8 protocol_id, u16 seq,
-		 u32 status),
+		 int status),
 	TP_ARGS(transfer_id, msg_id, protocol_id, seq, status),
 
 	TP_STRUCT__entry(
@@ -43,7 +43,7 @@ TRACE_EVENT(scmi_xfer_end,
 		__field(u8, msg_id)
 		__field(u8, protocol_id)
 		__field(u16, seq)
-		__field(u32, status)
+		__field(int, status)
 	),
 
 	TP_fast_assign(
@@ -54,7 +54,7 @@ TRACE_EVENT(scmi_xfer_end,
 		__entry->status = status;
 	),
 
-	TP_printk("transfer_id=%d msg_id=%u protocol_id=%u seq=%u status=%u",
+	TP_printk("transfer_id=%d msg_id=%u protocol_id=%u seq=%u status=%d",
 		__entry->transfer_id, __entry->msg_id, __entry->protocol_id,
 		__entry->seq, __entry->status)
 );
-- 
2.17.1

