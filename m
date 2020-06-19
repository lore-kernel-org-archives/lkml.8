Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED08AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC164217A0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580198;
	bh=PRuINvBRZW2mZwEv6yL9odErB1I7qLxkutEUY51xAFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tf508kyCNGkLsAmTftIV78VH2qeN2mv8AD+4uhbqZlx4DttePIbj8sspuk4IReZO/
	 HJDGEe8mIcR6yALsI5DBKDgSu2Z/94nkOmxzZUJckmGpFhvf5WWCgVs7Pi2lghjgW6
	 d8Hjrww8zWFE6rGHiziZZSwBidAFlj8wvkEBI2fw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393152AbgFSPXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:23:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:50416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392406AbgFSPTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:19:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DC7F206DB;
        Fri, 19 Jun 2020 15:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579971;
        bh=PRuINvBRZW2mZwEv6yL9odErB1I7qLxkutEUY51xAFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BosjqeSf1QikeWpeKes9xGoD5Ws0c3krhw6JKdIU+9RYMi//ZKEqSm/J7p/rYIkHY
         RXSu20iDzvVxB9/ckuQL1i7i9oSJ4jjUIeL5z+UVHpqiIUxv07Mimi12i7mJxYCIU5
         Jb+PuUCj67n3yFcT1s7vMBS8KCGUJEAhmAcdBHTo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 073/376] Bluetooth: btmtkuart: Improve exception handling in btmtuart_probe()
Date:   Fri, 19 Jun 2020 16:29:51 +0200
Message-Id: <20200619141713.807949518@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit 4803c54ca24923a30664bea2a7772db6e7303c51 ]

Calls of the functions clk_disable_unprepare() and hci_free_dev()
were missing for the exception handling.
Thus add the missed function calls together with corresponding
jump targets.

Fixes: 055825614c6b ("Bluetooth: btmtkuart: add an implementation for clock osc property")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/btmtkuart.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index e11169ad8247..8a81fbca5c9d 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -1015,7 +1015,7 @@ static int btmtkuart_probe(struct serdev_device *serdev)
 	if (btmtkuart_is_standalone(bdev)) {
 		err = clk_prepare_enable(bdev->osc);
 		if (err < 0)
-			return err;
+			goto err_hci_free_dev;
 
 		if (bdev->boot) {
 			gpiod_set_value_cansleep(bdev->boot, 1);
@@ -1028,10 +1028,8 @@ static int btmtkuart_probe(struct serdev_device *serdev)
 
 		/* Power on */
 		err = regulator_enable(bdev->vcc);
-		if (err < 0) {
-			clk_disable_unprepare(bdev->osc);
-			return err;
-		}
+		if (err < 0)
+			goto err_clk_disable_unprepare;
 
 		/* Reset if the reset-gpios is available otherwise the board
 		 * -level design should be guaranteed.
@@ -1063,7 +1061,6 @@ static int btmtkuart_probe(struct serdev_device *serdev)
 	err = hci_register_dev(hdev);
 	if (err < 0) {
 		dev_err(&serdev->dev, "Can't register HCI device\n");
-		hci_free_dev(hdev);
 		goto err_regulator_disable;
 	}
 
@@ -1072,6 +1069,11 @@ static int btmtkuart_probe(struct serdev_device *serdev)
 err_regulator_disable:
 	if (btmtkuart_is_standalone(bdev))
 		regulator_disable(bdev->vcc);
+err_clk_disable_unprepare:
+	if (btmtkuart_is_standalone(bdev))
+		clk_disable_unprepare(bdev->osc);
+err_hci_free_dev:
+	hci_free_dev(hdev);
 
 	return err;
 }
-- 
2.25.1



