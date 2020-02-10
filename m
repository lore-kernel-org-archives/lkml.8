Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8AFC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6868C208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgBJJvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:51:42 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:32984 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgBJJvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:51:42 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1j15j9-00056R-Ih; Mon, 10 Feb 2020 09:51:39 +0000
From:   Colin King <colin.king@canonical.com>
To:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: debug: fix string position formatting mixup with ret and len
Date:   Mon, 10 Feb 2020 09:51:39 +0000
Message-Id: <20200210095139.328711-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the string formatting is mixing up the offset of ret and
len. Re-work the code to use just len, remove ret and use scnprintf
instead of snprintf and len position accumulation where required.
Remove the -ve return check since scnprintf never returns a failure
-ve size. Also break overly long lines to clean up checkpatch
warnings.

Addresses-Coverity: ("Unused value")
Fixes: 1381a5113caf ("usb: dwc3: debug: purge usage of strcat")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
V2: rework original fix, remove strlens and use scnprintf as helpfully
    suggested by Dan Carpenter. Change the subject line to match the
    changes to the V2 of the fix.
---
 drivers/usb/dwc3/debug.h | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/dwc3/debug.h b/drivers/usb/dwc3/debug.h
index e56beb9d1e36..4a13ceaf4093 100644
--- a/drivers/usb/dwc3/debug.h
+++ b/drivers/usb/dwc3/debug.h
@@ -256,86 +256,77 @@ static inline const char *dwc3_ep_event_string(char *str, size_t size,
 	u8 epnum = event->endpoint_number;
 	size_t len;
 	int status;
-	int ret;
 
-	ret = snprintf(str, size, "ep%d%s: ", epnum >> 1,
+	len = scnprintf(str, size, "ep%d%s: ", epnum >> 1,
 			(epnum & 1) ? "in" : "out");
-	if (ret < 0)
-		return "UNKNOWN";
 
 	status = event->status;
 
 	switch (event->endpoint_event) {
 	case DWC3_DEPEVT_XFERCOMPLETE:
-		len = strlen(str);
-		snprintf(str + len, size - len, "Transfer Complete (%c%c%c)",
+		len += scnprintf(str + len, size - len,
+				"Transfer Complete (%c%c%c)",
 				status & DEPEVT_STATUS_SHORT ? 'S' : 's',
 				status & DEPEVT_STATUS_IOC ? 'I' : 'i',
 				status & DEPEVT_STATUS_LST ? 'L' : 'l');
 
-		len = strlen(str);
-
 		if (epnum <= 1)
-			snprintf(str + len, size - len, " [%s]",
+			scnprintf(str + len, size - len, " [%s]",
 					dwc3_ep0_state_string(ep0state));
 		break;
 	case DWC3_DEPEVT_XFERINPROGRESS:
-		len = strlen(str);
-
-		snprintf(str + len, size - len, "Transfer In Progress [%d] (%c%c%c)",
+		scnprintf(str + len, size - len,
+				"Transfer In Progress [%d] (%c%c%c)",
 				event->parameters,
 				status & DEPEVT_STATUS_SHORT ? 'S' : 's',
 				status & DEPEVT_STATUS_IOC ? 'I' : 'i',
 				status & DEPEVT_STATUS_LST ? 'M' : 'm');
 		break;
 	case DWC3_DEPEVT_XFERNOTREADY:
-		len = strlen(str);
-
-		snprintf(str + len, size - len, "Transfer Not Ready [%d]%s",
+		len += scnprintf(str + len, size - len,
+				"Transfer Not Ready [%d]%s",
 				event->parameters,
 				status & DEPEVT_STATUS_TRANSFER_ACTIVE ?
 				" (Active)" : " (Not Active)");
 
-		len = strlen(str);
-
 		/* Control Endpoints */
 		if (epnum <= 1) {
 			int phase = DEPEVT_STATUS_CONTROL_PHASE(event->status);
 
 			switch (phase) {
 			case DEPEVT_STATUS_CONTROL_DATA:
-				snprintf(str + ret, size - ret,
+				scnprintf(str + len, size - len,
 						" [Data Phase]");
 				break;
 			case DEPEVT_STATUS_CONTROL_STATUS:
-				snprintf(str + ret, size - ret,
+				scnprintf(str + len, size - len,
 						" [Status Phase]");
 			}
 		}
 		break;
 	case DWC3_DEPEVT_RXTXFIFOEVT:
-		snprintf(str + ret, size - ret, "FIFO");
+		scnprintf(str + len, size - len, "FIFO");
 		break;
 	case DWC3_DEPEVT_STREAMEVT:
 		status = event->status;
 
 		switch (status) {
 		case DEPEVT_STREAMEVT_FOUND:
-			snprintf(str + ret, size - ret, " Stream %d Found",
+			scnprintf(str + len, size - len, " Stream %d Found",
 					event->parameters);
 			break;
 		case DEPEVT_STREAMEVT_NOTFOUND:
 		default:
-			snprintf(str + ret, size - ret, " Stream Not Found");
+			scnprintf(str + len, size - len, " Stream Not Found");
 			break;
 		}
 
 		break;
 	case DWC3_DEPEVT_EPCMDCMPLT:
-		snprintf(str + ret, size - ret, "Endpoint Command Complete");
+		scnprintf(str + len, size - len, "Endpoint Command Complete");
 		break;
 	default:
-		snprintf(str, size, "UNKNOWN");
+		scnprintf(str + len, size - len, "UNKNOWN");
 	}
 
 	return str;
-- 
2.25.0

