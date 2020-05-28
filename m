Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA545C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE25208A7
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FocExwZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387823AbgE1KWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387717AbgE1KUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:20:32 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9D4C05BD1E;
        Thu, 28 May 2020 03:20:32 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id nu7so2990778pjb.0;
        Thu, 28 May 2020 03:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n8iipgJAi/NQyT9g10+jXpAAhQUJmCgX3ykzxFLrLKM=;
        b=FocExwZgEGs3gT0g8mnUyvPa6RpF30FXKarH1WH9tVM3Qfk2UMDFsUGGktPrgs6eG8
         oWa6KQ3j+BOpYt1wNostFfpItGTf7Nia2InQUTO4w8rOcch2k+RjAUsNbvmSK/nxbgDp
         HOSdd++QHNr67yGxv/1ozdj8+NQjB7FB8qxJMmDpuAv0IP2tidoiPkWbNp4AAileJdUN
         QdUH88+CtMfwJs0OtDlUNxQ4KSfvGtRsAtsXTTE9PD0sEuaBlzkpIWj9IJNujmvNiVNe
         Dr9VGxowiAhoIecs4k25fXf/tzGz9WKaUTZ5NiqHo5NEQkJnHkq98nLVkPhtXHFA+mMw
         +hTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=n8iipgJAi/NQyT9g10+jXpAAhQUJmCgX3ykzxFLrLKM=;
        b=YklP6LXx4oECV0SSYmXgiqZbepkwFWyP8xO6sqMNDl87aFiDnqQ93A4+5OBV9Kboxy
         vguPffM0h5oI1ETxtnEtQDsGzjlGJn4HsWTzHoSNwDl5oMHI8yaS8AiI6FTk2HwX90jI
         7kRNOpJUw/PzOH9oriqlJK7s93em9wObm5HF0TJlf8r9JdpamWYgvF7ft4SZImV84zGZ
         jNPrg/KN5EuVEoVeluQFwoptesN6dlcqZgJtGmisyrSh3MwWkmt4hli79seck2Zr5coh
         eM7Y5qVEN5xWljone/2hUTIEmq2+BZkiTly3ROqEyyGqiFH4veYnNULMDfTAs1IEOyGr
         gfEw==
X-Gm-Message-State: AOAM531HDHOMXT5yQOujRrIZ8e5sXn80ap6zg6yoLXjIXOrKpSfDKxH+
        /wi/JwUhetq2UuRcJRv6zNc=
X-Google-Smtp-Source: ABdhPJywCGzsdw5guspTvAxKu+Juxq4ii0vQsLONLmhQYEB+Q72DtYuN3e5AP5ezkwffsfJqoQc9hQ==
X-Received: by 2002:a17:90a:1485:: with SMTP id k5mr2995699pja.108.1590661231748;
        Thu, 28 May 2020 03:20:31 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id e16sm4193122pgg.8.2020.05.28.03.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 03:20:30 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] Bluetooth: btmtkuart: add missed functions in the error paths of btmtuart_probe()
Date:   Thu, 28 May 2020 18:20:21 +0800
Message-Id: <20200528102021.911709-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

btmtuart_probe() misses several function calls in its error paths,
including hci_free_dev() and clk_disable_unprepare().
Refactor the code and call correct undo functions to fix the error
paths.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
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
2.26.2

