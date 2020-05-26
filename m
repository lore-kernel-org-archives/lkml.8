Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFBDC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 03:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F326B20812
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 03:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="O3HjhkoF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388659AbgEZDfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 23:35:18 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:57053 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388634AbgEZDfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 23:35:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590464116; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=PVVBvwC+Tvjc3HogjrsgVETQLb6LhmmPRAVYzJBvsRw=; b=O3HjhkoFV0HEJtkMpqGrE/m991oqWullCIDlq07mlmYVSc37BbLiq1+fcj8rNSqAjR2PY+lE
 3NupZ6ni9G0u4lb9xIaQHAB1g/wF2TUeP50CtAlLyX3Ex0uIztk8X022MrNj2ALMK87ETDC9
 d2ZK2mrV42N5S/ABjfSGlfWuWLs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ecc8e7342288e951f8ae6a5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 26 May 2020 03:35:15
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 61296C433C9; Tue, 26 May 2020 03:35:15 +0000 (UTC)
Received: from zijuhu-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zijuhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CD196C433C6;
        Tue, 26 May 2020 03:35:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD196C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=zijuhu@codeaurora.org
From:   Zijun Hu <zijuhu@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org, mka@chromium.org,
        rjliao@codeaurora.org, zijuhu@codeaurora.org
Subject: [PATCH v1] Bluetooth: hci_qca: Improve controller ID info log level
Date:   Tue, 26 May 2020 11:35:08 +0800
Message-Id: <1590464108-1333-1-git-send-email-zijuhu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Controller ID info got by VSC EDL_PATCH_GETVER is very
important, so improve its log level from DEBUG to INFO.

Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>
---
 drivers/bluetooth/btqca.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 3ea866d..49e5aeb 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -74,10 +74,10 @@ int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version,
 
 	ver = (struct qca_btsoc_version *)(edl->data);
 
-	BT_DBG("%s: Product:0x%08x", hdev->name, le32_to_cpu(ver->product_id));
-	BT_DBG("%s: Patch  :0x%08x", hdev->name, le16_to_cpu(ver->patch_ver));
-	BT_DBG("%s: ROM    :0x%08x", hdev->name, le16_to_cpu(ver->rom_ver));
-	BT_DBG("%s: SOC    :0x%08x", hdev->name, le32_to_cpu(ver->soc_id));
+	bt_dev_info(hdev, "QCA Product:0x%08x", le32_to_cpu(ver->product_id));
+	bt_dev_info(hdev, "QCA Patch  :0x%08x", le16_to_cpu(ver->patch_ver));
+	bt_dev_info(hdev, "QCA ROM    :0x%08x", le16_to_cpu(ver->rom_ver));
+	bt_dev_info(hdev, "QCA SOC    :0x%08x", le32_to_cpu(ver->soc_id));
 
 	/* QCA chipset version can be decided by patch and SoC
 	 * version, combination with upper 2 bytes from SoC
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

