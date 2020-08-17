Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539F6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15C8E22C9F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597678733;
	bh=g3QlPt+fYoFXfI9NUC9KnWXkq1N1N9qW6yj5j+Y6zoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aO0FeyqQFPmnTGE275Dcuz0rwMSGlOdeRHYybmtuNm4H+blSxHHWDxz+OMbGiIPiV
	 1r9oHUH100xntVWzom7wVLqzH2C5cNJRAhN9nF9Wnek0rO8wuDybXq8llUuHaK59Sm
	 TR0bxV4rIHGDkh1dfn9PWv3RqIG+yQio+FJ0eHz0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730622AbgHQPit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:38:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730325AbgHQPcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:32:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCDC5208B3;
        Mon, 17 Aug 2020 15:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678362;
        bh=g3QlPt+fYoFXfI9NUC9KnWXkq1N1N9qW6yj5j+Y6zoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CNJb+zCPHqtkf0ZHlQuGZ1lCZJhKTbg/Q0Izd2KpsyMmbupX6bWQJ1wU3Pwd8o9vd
         +uwLwS4+Y3asL+NcSMcI7PNV2yFYpGzyGO/AGqWLfcT/5HGMVQsDYzK5I1gCd2skPZ
         KeAvRqcsGbSWu2vQByN3reWlIbChm+m3gzn9m1ug=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nicolas Boichat <drinkcat@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 307/464] Bluetooth: hci_serdev: Only unregister device if it was registered
Date:   Mon, 17 Aug 2020 17:14:20 +0200
Message-Id: <20200817143848.505306095@linuxfoundation.org>
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

From: Nicolas Boichat <drinkcat@chromium.org>

[ Upstream commit 202798db9570104728dce8bb57dfeed47ce764bc ]

We should not call hci_unregister_dev if the device was not
successfully registered.

Fixes: c34dc3bfa7642fd ("Bluetooth: hci_serdev: Introduce hci_uart_unregister_device()")
Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_serdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 599855e4c57c1..7b233312e723f 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -355,7 +355,8 @@ void hci_uart_unregister_device(struct hci_uart *hu)
 	struct hci_dev *hdev = hu->hdev;
 
 	clear_bit(HCI_UART_PROTO_READY, &hu->flags);
-	hci_unregister_dev(hdev);
+	if (test_bit(HCI_UART_REGISTERED, &hu->flags))
+		hci_unregister_dev(hdev);
 	hci_free_dev(hdev);
 
 	cancel_work_sync(&hu->write_work);
-- 
2.25.1



