Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212A1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEB2920716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693209;
	bh=4EeZo2BVJkUQH+XtB+Bb6i6GYCa2O/0wHaEUqGFgXQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fXLsR+HUtf7mX8E0UzIN2MxtPG/Yz4O6GJog772tWLz35q1ltwsjKzBu8vd8kEsxW
	 FJahQA1YUkmoRoyLC3aOXQhp78A8ttOAEY+QnKHpQ7tifq7+0AsY8NpSJqFts1P3Qg
	 S+qi3stcmxWQcrKIW/kSwZpCd50EgiEhM048D5n8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbgHQTkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729488AbgHQPZ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:25:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1219E205CB;
        Mon, 17 Aug 2020 15:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597677958;
        bh=4EeZo2BVJkUQH+XtB+Bb6i6GYCa2O/0wHaEUqGFgXQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HjsuZZ1TXN4lsEhK8tRxn3cKkESPjegsKs1wBgrr5aMJjjhq4v1/z3c+7sz9Xm+B/
         eGR2UClTH2fXhhYU9WNQiVeto3j1IHhS8MHd+V4HMeV4mi5gbgjmoWNobhy91iGrWc
         Psn4qRdkxCJYHuP1PXHdBslEQS/+Mhx9NBWfTW74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Chen <Mark-YW.Chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 170/464] Bluetooth: btusb: fix up firmware download sequence
Date:   Mon, 17 Aug 2020 17:12:03 +0200
Message-Id: <20200817143841.964263701@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

[ Upstream commit f645125711c80f9651e4a57403d799070c6ad13b ]

Data RAM on the device have to be powered on before starting to download
the firmware.

Fixes: a1c49c434e15 ("Bluetooth: btusb: Add protocol support for MediaTek MT7668U USB devices")
Co-developed-by: Mark Chen <Mark-YW.Chen@mediatek.com>
Signed-off-by: Mark Chen <Mark-YW.Chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btusb.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5f022e9cf667e..61ffe185e0e49 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2925,7 +2925,7 @@ static int btusb_mtk_setup_firmware(struct hci_dev *hdev, const char *fwname)
 	const u8 *fw_ptr;
 	size_t fw_size;
 	int err, dlen;
-	u8 flag;
+	u8 flag, param;
 
 	err = request_firmware(&fw, fwname, &hdev->dev);
 	if (err < 0) {
@@ -2933,6 +2933,20 @@ static int btusb_mtk_setup_firmware(struct hci_dev *hdev, const char *fwname)
 		return err;
 	}
 
+	/* Power on data RAM the firmware relies on. */
+	param = 1;
+	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
+	wmt_params.flag = 3;
+	wmt_params.dlen = sizeof(param);
+	wmt_params.data = &param;
+	wmt_params.status = NULL;
+
+	err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to power on data RAM (%d)", err);
+		return err;
+	}
+
 	fw_ptr = fw->data;
 	fw_size = fw->size;
 
-- 
2.25.1



