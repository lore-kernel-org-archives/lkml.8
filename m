Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97E8C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 09:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 859C72192A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 09:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="U4w5dbE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgEIJVh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 05:21:37 -0400
Received: from m15-112.126.com ([220.181.15.112]:55589 "EHLO m15-112.126.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgEIJVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 05:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=npA6K8XR6m/Q7D+a+F
        d/I+FwASzBrx710iIbSXi75Zw=; b=U4w5dbE1Fuf8bTwppyjMdPTDl0+/3u/6A/
        LOhMaJS1/zqiUXGpxzNOYsc0ipgi72lPAoGzIfp7V3CN4HThAuopqaK9W4MCMS9Q
        0oid2UDPQ1i4awOzngUhRUjwgC/DUqcX5EFbmqPwlocTk7BDJl363HDmZEvNhtkg
        vPo6g/jYE=
Received: from coding1221.verisilicon.com (unknown [222.65.245.108])
        by smtp2 (Coremail) with SMTP id DMmowABXjQHjb7Ze7FwJCw--.5965S2;
        Sat, 09 May 2020 16:54:59 +0800 (CST)
From:   joe_zhuchg@126.com
To:     sudeep.holla@arm.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Joe Zhu <Chunguang.Zhu@verisilicon.com>
Subject: [PATCH 1/1] firmware: arm_scmi/mailbox: ignore notification for tx done using irq
Date:   Sat,  9 May 2020 16:54:57 +0800
Message-Id: <20200509085457.31920-1-joe_zhuchg@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: DMmowABXjQHjb7Ze7FwJCw--.5965S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZr1rKF4kGFy7XryruF43trb_yoWktFX_Cw
        nFkw4jgr1UAFyFvwnrAwn3G3sIv3y5Wa4vg3Wqvw12qasrX398Wwnrtws5A34UWr4DZryI
        kas5Grs5Cwn8WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU5y7K7UUUUU==
X-Originating-IP: [222.65.245.108]
X-CM-SenderInfo: pmrhs6xkxfxwa6rslhhfrp/1tbifgMfN1pD-wcCJgAAsQ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joe Zhu <Chunguang.Zhu@verisilicon.com>

If mailbox uses IRQ method, it already notified framework with
mbox_chan_txdone() in ISR.

Signed-off-by: Joe Zhu <Chunguang.Zhu@verisilicon.com>
---
 drivers/firmware/arm_scmi/mailbox.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_scmi/mailbox.c b/drivers/firmware/arm_scmi/mailbox.c
index 73077bbc4ad9..303a5dc42429 100644
--- a/drivers/firmware/arm_scmi/mailbox.c
+++ b/drivers/firmware/arm_scmi/mailbox.c
@@ -9,6 +9,7 @@
 #include <linux/err.h>
 #include <linux/device.h>
 #include <linux/mailbox_client.h>
+#include <linux/mailbox_controller.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/slab.h>
@@ -147,7 +148,8 @@ static void mailbox_mark_txdone(struct scmi_chan_info *cinfo, int ret)
 	 * Unfortunately, we have to kick the mailbox framework after we have
 	 * received our message.
 	 */
-	mbox_client_txdone(smbox->chan, ret);
+	if (!smbox->chan->mbox->txdone_irq)
+		mbox_client_txdone(smbox->chan, ret);
 }
 
 static void mailbox_fetch_response(struct scmi_chan_info *cinfo,
-- 
2.17.1

