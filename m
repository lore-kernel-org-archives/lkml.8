Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E280C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6677F2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598261150;
	bh=/8YEzwcP0zWpKHuJBvzSVvL4szz0MFoDDS3Im5pvGWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XqW8sfYC2MpmM9lqoec5USgsE14wAiI5R1U2Ql78Iyx0RiheUR0e96fPvhSAHd7Xv
	 rz1TcG2SorZon1VlP7yOA1wc0ITXLUB9zxEtbRBZ6hHG71z4osygpi+PNBlwsGzDa2
	 C2w05bqVXQsi3WlVmarrL3mhCjI4JJ0aVHUHq93o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbgHXJZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:25:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730168AbgHXIxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:53:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE4D92072D;
        Mon, 24 Aug 2020 08:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259201;
        bh=/8YEzwcP0zWpKHuJBvzSVvL4szz0MFoDDS3Im5pvGWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CVnWfodIwBRaA6cA6nV+at9cirjV2sthVnEJqZ4ofkpCA0nV/hxij92hDg53VAAcy
         T9m/TvXAFZ65b/s2XiRewlb5qqKZe3vZqJiK7xI+qzKSHXnbq9vdiaRLUnquRvbNmz
         yaH70FzZoxH9vAGabtPfGnCas5WisEWJFQMVd54E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 19/50] spi: Prevent adding devices below an unregistering controller
Date:   Mon, 24 Aug 2020 10:31:20 +0200
Message-Id: <20200824082352.970191528@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082351.823243923@linuxfoundation.org>
References: <20200824082351.823243923@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit ddf75be47ca748f8b12d28ac64d624354fddf189 ]

CONFIG_OF_DYNAMIC and CONFIG_ACPI allow adding SPI devices at runtime
using a DeviceTree overlay or DSDT patch.  CONFIG_SPI_SLAVE allows the
same via sysfs.

But there are no precautions to prevent adding a device below a
controller that's being removed.  Such a device is unusable and may not
even be able to unbind cleanly as it becomes inaccessible once the
controller has been torn down.  E.g. it is then impossible to quiesce
the device's interrupt.

of_spi_notify() and acpi_spi_notify() do hold a ref on the controller,
but otherwise run lockless against spi_unregister_controller().

Fix by holding the spi_add_lock in spi_unregister_controller() and
bailing out of spi_add_device() if the controller has been unregistered
concurrently.

Fixes: ce79d54ae447 ("spi/of: Add OF notifier handler")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v3.19+
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Octavian Purdila <octavian.purdila@intel.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Link: https://lore.kernel.org/r/a8c3205088a969dc8410eec1eba9aface60f36af.1596451035.git.lukas@wunner.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/Kconfig |  3 +++
 drivers/spi/spi.c   | 21 ++++++++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a75f2a2cf7805..4b6a1629969f3 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -827,4 +827,7 @@ config SPI_SLAVE_SYSTEM_CONTROL
 
 endif # SPI_SLAVE
 
+config SPI_DYNAMIC
+	def_bool ACPI || OF_DYNAMIC || SPI_SLAVE
+
 endif # SPI
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 49eee894f51d4..ab6a4f85bcde7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -428,6 +428,12 @@ static LIST_HEAD(spi_controller_list);
  */
 static DEFINE_MUTEX(board_lock);
 
+/*
+ * Prevents addition of devices with same chip select and
+ * addition of devices below an unregistering controller.
+ */
+static DEFINE_MUTEX(spi_add_lock);
+
 /**
  * spi_alloc_device - Allocate a new SPI device
  * @ctlr: Controller to which device is connected
@@ -506,7 +512,6 @@ static int spi_dev_check(struct device *dev, void *data)
  */
 int spi_add_device(struct spi_device *spi)
 {
-	static DEFINE_MUTEX(spi_add_lock);
 	struct spi_controller *ctlr = spi->controller;
 	struct device *dev = ctlr->dev.parent;
 	int status;
@@ -534,6 +539,13 @@ int spi_add_device(struct spi_device *spi)
 		goto done;
 	}
 
+	/* Controller may unregister concurrently */
+	if (IS_ENABLED(CONFIG_SPI_DYNAMIC) &&
+	    !device_is_registered(&ctlr->dev)) {
+		status = -ENODEV;
+		goto done;
+	}
+
 	if (ctlr->cs_gpios)
 		spi->cs_gpio = ctlr->cs_gpios[spi->chip_select];
 
@@ -2265,6 +2277,10 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	struct spi_controller *found;
 	int id = ctlr->bus_num;
 
+	/* Prevent addition of new devices, unregister existing ones */
+	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
+		mutex_lock(&spi_add_lock);
+
 	device_for_each_child(&ctlr->dev, NULL, __unregister);
 
 	/* First make sure that this controller was ever added */
@@ -2285,6 +2301,9 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	if (found == ctlr)
 		idr_remove(&spi_master_idr, id);
 	mutex_unlock(&board_lock);
+
+	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
+		mutex_unlock(&spi_add_lock);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_controller);
 
-- 
2.25.1



