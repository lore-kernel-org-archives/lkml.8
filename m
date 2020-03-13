Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CA6C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F60F20749
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 08:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="e5Dd9wVT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgCMIR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 04:17:56 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:39372 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgCMIRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 04:17:50 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02D8HnIF071937;
        Fri, 13 Mar 2020 03:17:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584087469;
        bh=9W5vTN/5yldWwJ7WFO5+AkbjB0CXv7qyOvqx0nLoARI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=e5Dd9wVT5i3NrsjBo95eIttKA1ZazTkjRvHWCPsC0Ti45zAhKJ6XRLkSHsedAFrXt
         09Tnz7+dvrnRwUi/45UTYukXKpB+Bu2nxohoBqGAyJ4adcJnXABObDid7Mu8DixIWZ
         HdDSZrgjhWSaRAOBwM2N3x8G7RUKZIcVsvZ2N7Sg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02D8Hna2047435
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 13 Mar 2020 03:17:49 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 13
 Mar 2020 03:17:49 -0500
Received: from localhost.localdomain (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 13 Mar 2020 03:17:49 -0500
Received: from sokoban.bb.dnainternet.fi (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 02D8HQlf097835;
        Fri, 13 Mar 2020 03:17:47 -0500
From:   Tero Kristo <t-kristo@ti.com>
To:     <bjorn.andersson@linaro.org>, <ohad@wizery.com>,
        <linux-remoteproc@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <mathieu.poirier@linaro.org>,
        <s-anna@ti.com>, <afd@ti.com>, Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 09/15] remoteproc/omap: Check for undefined mailbox messages
Date:   Fri, 13 Mar 2020 10:17:12 +0200
Message-ID: <20200313081718.30612-10-t-kristo@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200313081718.30612-1-t-kristo@ti.com>
References: <20200313081718.30612-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

Add some checks in the mailbox callback function to limit
any processing in the mailbox callback function to only
certain currently valid messages, and drop all the remaining
messages. A debug message is added to print any such invalid
messages when the appropriate trace control is enabled.

Co-developed-by: Subramaniam Chanderashekarapuram <subramaniam.ca@ti.com>
Signed-off-by: Subramaniam Chanderashekarapuram <subramaniam.ca@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Andrew F. Davis <afd@ti.com>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/remoteproc/omap_remoteproc.c | 6 ++++++
 drivers/remoteproc/omap_remoteproc.h | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/remoteproc/omap_remoteproc.c b/drivers/remoteproc/omap_remoteproc.c
index 09eae548a691..7717a514d41a 100644
--- a/drivers/remoteproc/omap_remoteproc.c
+++ b/drivers/remoteproc/omap_remoteproc.c
@@ -130,6 +130,12 @@ static void omap_rproc_mbox_callback(struct mbox_client *client, void *data)
 		dev_info(dev, "received echo reply from %s\n", name);
 		break;
 	default:
+		if (msg >= RP_MBOX_READY && msg < RP_MBOX_END_MSG)
+			return;
+		if (msg > oproc->rproc->max_notifyid) {
+			dev_dbg(dev, "dropping unknown message 0x%x", msg);
+			return;
+		}
 		/* msg contains the index of the triggered vring */
 		if (rproc_vq_interrupt(oproc->rproc, msg) == IRQ_NONE)
 			dev_dbg(dev, "no message was found in vqid %d\n", msg);
diff --git a/drivers/remoteproc/omap_remoteproc.h b/drivers/remoteproc/omap_remoteproc.h
index f6d2036d383d..72f656c93caa 100644
--- a/drivers/remoteproc/omap_remoteproc.h
+++ b/drivers/remoteproc/omap_remoteproc.h
@@ -56,6 +56,12 @@
  *
  * @RP_MBOX_ABORT_REQUEST: a "please crash" request, used for testing the
  * recovery mechanism (to some extent).
+ *
+ * Introduce new message definitions if any here.
+ *
+ * @RP_MBOX_END_MSG: Indicates end of known/defined messages from remote core
+ * This should be the last definition.
+ *
  */
 enum omap_rp_mbox_messages {
 	RP_MBOX_READY		= 0xFFFFFF00,
@@ -64,6 +70,7 @@ enum omap_rp_mbox_messages {
 	RP_MBOX_ECHO_REQUEST	= 0xFFFFFF03,
 	RP_MBOX_ECHO_REPLY	= 0xFFFFFF04,
 	RP_MBOX_ABORT_REQUEST	= 0xFFFFFF05,
+	RP_MBOX_END_MSG		= 0xFFFFFF06,
 };
 
 #endif /* _OMAP_RPMSG_H */
-- 
2.17.1

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
