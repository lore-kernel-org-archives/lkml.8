Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B3DC3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E8920848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="YWVot15E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgBKKfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:35:09 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:3586 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728398AbgBKKfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:35:06 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48GzgD2PKMz22X;
        Tue, 11 Feb 2020 11:35:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1581417304; bh=Y/BhaKgufO/WllM1ns+0PP41KsNOl+WZqBMZudUzapE=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=YWVot15Ex/8hLXM0K/dIivih3pVRZnDcDgPU+Gwm6Ld/xcqE/sLbr/WyLqpAn2kaF
         XqMi76Pau1mcsbCM70cWAN+YpuVJgwcKItrHJzBOY+NnZoBZqqhYxbCCEjk504EvfW
         3BY8DTjIKBAZ2bm7kCOR13UMgiGQPCjrVHj48G1f3XZG5hh1Z8oMR+P476xeDRKsEZ
         vZrSuBg8ZYZpt/TfGxXhBqqa41/IlywkHMSiIT6Ot10ddXQFiQOl8Oa0uGt5B4xsoY
         pz7KQM1ecBBtcLGTfj6vpoP3CSGDaZAqfuWwXogpO6ztYWnwhL8q423trk//BGEopF
         z5I6diGdO1vqg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.1 at mail
Date:   Tue, 11 Feb 2020 11:35:04 +0100
Message-Id: <59e1e4e5bd80c1879ef36eaa59916e47005dbb04.1581416843.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1581416843.git.mirq-linux@rere.qmqm.pl>
References: <cover.1581416843.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 6/6] staging: wfx: use more power-efficient sleep for reset
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     =?UTF-8?B?SsOpcsO0bWU=?= Pouiller <jerome.pouiller@silabs.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace udelay() with usleep_range() as all uses are in a sleepable context.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/staging/wfx/bh.c      | 2 +-
 drivers/staging/wfx/bus_spi.c | 4 ++--
 drivers/staging/wfx/hwio.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/wfx/bh.c b/drivers/staging/wfx/bh.c
index c6319ab7e71a..9fcab00a3733 100644
--- a/drivers/staging/wfx/bh.c
+++ b/drivers/staging/wfx/bh.c
@@ -26,7 +26,7 @@ static void device_wakeup(struct wfx_dev *wdev)
 	gpiod_set_value_cansleep(wdev->pdata.gpio_wakeup, 1);
 	if (wfx_api_older_than(wdev, 1, 4)) {
 		if (!completion_done(&wdev->hif.ctrl_ready))
-			udelay(2000);
+			usleep_range(2000, 2500);
 	} else {
 		// completion.h does not provide any function to wait
 		// completion without consume it (a kind of
diff --git a/drivers/staging/wfx/bus_spi.c b/drivers/staging/wfx/bus_spi.c
index e3cd12592662..61e99b09decb 100644
--- a/drivers/staging/wfx/bus_spi.c
+++ b/drivers/staging/wfx/bus_spi.c
@@ -211,9 +211,9 @@ static int wfx_spi_probe(struct spi_device *func)
 		if (spi_get_device_id(func)->driver_data & WFX_RESET_INVERTED)
 			gpiod_toggle_active_low(bus->gpio_reset);
 		gpiod_set_value_cansleep(bus->gpio_reset, 1);
-		udelay(100);
+		usleep_range(100, 150);
 		gpiod_set_value_cansleep(bus->gpio_reset, 0);
-		udelay(2000);
+		usleep_range(2000, 2500);
 	}
 
 	INIT_WORK(&bus->request_rx, wfx_spi_request_rx);
diff --git a/drivers/staging/wfx/hwio.c b/drivers/staging/wfx/hwio.c
index 47e04c59ed93..d3a141d95a0e 100644
--- a/drivers/staging/wfx/hwio.c
+++ b/drivers/staging/wfx/hwio.c
@@ -142,7 +142,7 @@ static int indirect_read(struct wfx_dev *wdev, int reg, u32 addr, void *buf,
 			goto err;
 		if (!(cfg & prefetch))
 			break;
-		udelay(200);
+		usleep_range(200, 250);
 	}
 	if (i == 20) {
 		ret = -ETIMEDOUT;
-- 
2.20.1

