Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619F7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E5D72072D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Q7qutTWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgE2P71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:59:27 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:31961 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727809AbgE2P70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:59:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590767965; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=D/JMvgaJGqi1jK8NRGNKnGGrv9rdFQusuj9ABakOAT0=; b=Q7qutTWugHwaGFoE1EIMCVwZHnV+kMbrN7eL9hiPNesgIIaLNmdY2noaXCSMba2UdzJ/Fl8P
 VKfZ+LH+dESsGvEWfsKhSCsjC3/xdYl2xjYxwAjwopA1nVwLmvTWPqAtqzJyVVoe8xIRLp6X
 7eDCWxwUAwpMByZPShwMaEmm6GU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5ed131483ac6f4f603087c72 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 29 May 2020 15:59:04
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3FE88C433CB; Fri, 29 May 2020 15:59:04 +0000 (UTC)
Received: from zijuhu-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zijuhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B3176C433C6;
        Fri, 29 May 2020 15:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B3176C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=zijuhu@codeaurora.org
From:   Zijun Hu <zijuhu@codeaurora.org>
To:     sean.wang@mediatek.com, marcel@holtmann.org,
        johan.hedberg@gmail.com, matthias.bgg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, mka@chromium.org,
        zijuhu@codeaurora.org
Subject: [PATCH v1] Bluetooth: btmtkuart: Use serdev_device_write_buf() instead of serdev_device_write()
Date:   Fri, 29 May 2020 23:58:56 +0800
Message-Id: <1590767936-21907-1-git-send-email-zijuhu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

serdev_device_write() is not appropriate at here because
serdev_device_write_wakeup() is not used to release completion hold
by the former at @write_wakeup member of struct serdev_device_ops.

Fix by using serdev_device_write_buf() instead of serdev_device_write().

Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>
---
 drivers/bluetooth/btmtkuart.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index 8a81fbca5c9d..6c40bc75fb5b 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -695,8 +695,7 @@ static int btmtkuart_change_baudrate(struct hci_dev *hdev)
 
 	/* Send a dummy byte 0xff to activate the new baudrate */
 	param = 0xff;
-	err = serdev_device_write(bdev->serdev, &param, sizeof(param),
-				  MAX_SCHEDULE_TIMEOUT);
+	err = serdev_device_write_buf(bdev->serdev, &param, sizeof(param));
 	if (err < 0 || err < sizeof(param))
 		return err;
 
-- 
2.7.4

