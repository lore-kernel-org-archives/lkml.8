Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8C3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20998204EA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdaMAUAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405434AbgE2C1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 22:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404312AbgE2C1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:27:43 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF8BC08C5C6;
        Thu, 28 May 2020 19:27:43 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id q8so461136pfu.5;
        Thu, 28 May 2020 19:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q7Ds55mrogGXuEM4SJQgAqnILsJS644/RVVdZVRg++g=;
        b=NdaMAUAEDkjuPmLDmz0DlFfsp4ufVxj0FWetWnq1nPXQTn0gJydk3i7kHOD2PRXom3
         c29KH/BGst0jdrowBQuRWgbkg+GoAXln+xEXP1NqwS47xG3aHSDk1M5w+vVHQpAliTsw
         DeiA/FQE5G/vByHeDu3RZNFz342dKsAcSGOI+Y0MFO2j6LDESQrHfi/LIundli+NzACx
         cONgLmFWbTXn4pbj1NX7NnNFCZuUFS69lclsOMCxJw+eF+FOil6ro4HRH9JAsz7x1Q84
         iwwSNSABC9+blpWz19mnQXvvlQgGvMEwGmhcMWmDRQGo/EYN6d1mnktit0bwCI1FnaLK
         L8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q7Ds55mrogGXuEM4SJQgAqnILsJS644/RVVdZVRg++g=;
        b=GziKYztqRs3kieWU/dTo5KtZZuBM8cd3E7jfH3HO3dwJandvBDk6rkg7X9ivRrVe0v
         kA4KYTfzPpKwWcqwBmSsR2nYDeCv7qBooWERILZnZCYwhETC4sy3wQxD9gcV2t0CP0yR
         pPSq5Qlh6TvRyjvMFNI7QsechE0rLvJc0TtYgBtZWYGTaXGrKVDgDU4hAfT/gXJeSSJC
         KuANMgwKEUE00v42vm9YXEM0cVyTb39o1FqEC7uhpBFX7Q6fydMWU41EQiSo1XHqZBgY
         he2t6P1wFSZHDKCoPwrXPOU5ZIYctA49kZMzgy1hBi9jsBoioaI6V5W5XZRfcqer3CXN
         CwiA==
X-Gm-Message-State: AOAM531tTCq6UPHfQszumHB87fNZ0+zVUWO/Z2dute7AiNVIv57M6lfT
        wqP1H4IxFTV1+rAKJJSK7axO8F9Wz88=
X-Google-Smtp-Source: ABdhPJzx/ymfutkB2+J7IwEf32NLdzpK09ZlEr9zw9Gmck5sFYIuhFuU6NGYaBcMyXxxLR/h8SccjA==
X-Received: by 2002:a62:2f45:: with SMTP id v66mr6665066pfv.45.1590719262506;
        Thu, 28 May 2020 19:27:42 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id u26sm5850316pfn.88.2020.05.28.19.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 19:27:41 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] Bluetooth: btmtkuart: Improve exception handling in btmtuart_probe()
Date:   Fri, 29 May 2020 10:27:26 +0800
Message-Id: <20200529022726.917826-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calls of the functions clk_disable_unprepare() and hci_free_dev()
were missing for the exception handling.
Thus add the missed function calls together with corresponding
jump targets.

Fixes: 055825614c6b ("Bluetooth: btmtkuart: add an implementation for clock osc property")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Modify description.
  - Add fixes tag.

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
2.26.2

