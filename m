Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE833C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8085220714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 10:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="fkEanw0C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgBKKfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 05:35:13 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:26190 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728389AbgBKKfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 05:35:06 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48GzgC5kMmz20v;
        Tue, 11 Feb 2020 11:35:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1581417303; bh=raqJPwQCWLMgqidgr8190O09gGllM1uWjbFerVN4PWE=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=fkEanw0CAzq99Uei3PXZe2fn+lVKe252S8tSkylJ9mEZ6ELkT+IgKko4Uc3CVOEY7
         mBBna3sZFrFripKqpUdmDO85DZOqBXAcLdutYhsoTS3ApG0mDefMzQQuXYNs/aO2FM
         swOnPrF4hAwVMKQt2NQrcxE7udhpn95NrylX1ehvyCVvDJVEnrcYXkMziszqzeHw2t
         B66dwWAZivXiHE8gzRMh+b2agZqShSwQivGRArtyABNmeSVmKJxjOFZH9537U8rXLl
         de7n60mTkyVDdBsVFjT+oYEDsu0J1sGWBFyy4AX0bTpZbjyGlf5Mt7WCZi1ounB+Io
         GRttimZWNKxnw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.1 at mail
Date:   Tue, 11 Feb 2020 11:35:03 +0100
Message-Id: <cb19e7c521712d5a166e0b7e9cac4450798fdce0.1581416843.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1581416843.git.mirq-linux@rere.qmqm.pl>
References: <cover.1581416843.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 5/6] staging: wfx: use sleeping gpio accessors
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

Driver calls GPIO get/set only from non-atomic context and so can use any
GPIOs.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/staging/wfx/bh.c      | 6 +++---
 drivers/staging/wfx/bus_spi.c | 4 ++--
 drivers/staging/wfx/main.c    | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/wfx/bh.c b/drivers/staging/wfx/bh.c
index 983c41d1fe7c..c6319ab7e71a 100644
--- a/drivers/staging/wfx/bh.c
+++ b/drivers/staging/wfx/bh.c
@@ -20,10 +20,10 @@ static void device_wakeup(struct wfx_dev *wdev)
 {
 	if (!wdev->pdata.gpio_wakeup)
 		return;
-	if (gpiod_get_value(wdev->pdata.gpio_wakeup))
+	if (gpiod_get_value_cansleep(wdev->pdata.gpio_wakeup))
 		return;
 
-	gpiod_set_value(wdev->pdata.gpio_wakeup, 1);
+	gpiod_set_value_cansleep(wdev->pdata.gpio_wakeup, 1);
 	if (wfx_api_older_than(wdev, 1, 4)) {
 		if (!completion_done(&wdev->hif.ctrl_ready))
 			udelay(2000);
@@ -45,7 +45,7 @@ static void device_release(struct wfx_dev *wdev)
 	if (!wdev->pdata.gpio_wakeup)
 		return;
 
-	gpiod_set_value(wdev->pdata.gpio_wakeup, 0);
+	gpiod_set_value_cansleep(wdev->pdata.gpio_wakeup, 0);
 }
 
 static int rx_helper(struct wfx_dev *wdev, size_t read_len, int *is_cnf)
diff --git a/drivers/staging/wfx/bus_spi.c b/drivers/staging/wfx/bus_spi.c
index d6a75bd61595..e3cd12592662 100644
--- a/drivers/staging/wfx/bus_spi.c
+++ b/drivers/staging/wfx/bus_spi.c
@@ -210,9 +210,9 @@ static int wfx_spi_probe(struct spi_device *func)
 	} else {
 		if (spi_get_device_id(func)->driver_data & WFX_RESET_INVERTED)
 			gpiod_toggle_active_low(bus->gpio_reset);
-		gpiod_set_value(bus->gpio_reset, 1);
+		gpiod_set_value_cansleep(bus->gpio_reset, 1);
 		udelay(100);
-		gpiod_set_value(bus->gpio_reset, 0);
+		gpiod_set_value_cansleep(bus->gpio_reset, 0);
 		udelay(2000);
 	}
 
diff --git a/drivers/staging/wfx/main.c b/drivers/staging/wfx/main.c
index 76b2ff7fc7fe..3c4c240229ad 100644
--- a/drivers/staging/wfx/main.c
+++ b/drivers/staging/wfx/main.c
@@ -425,7 +425,7 @@ int wfx_probe(struct wfx_dev *wdev)
 			"enable 'quiescent' power mode with gpio %d and PDS file %s\n",
 			desc_to_gpio(wdev->pdata.gpio_wakeup),
 			wdev->pdata.file_pds);
-		gpiod_set_value(wdev->pdata.gpio_wakeup, 1);
+		gpiod_set_value_cansleep(wdev->pdata.gpio_wakeup, 1);
 		control_reg_write(wdev, 0);
 		hif_set_operational_mode(wdev, HIF_OP_POWER_MODE_QUIESCENT);
 	} else {
-- 
2.20.1

