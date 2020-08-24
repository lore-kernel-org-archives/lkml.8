Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6654FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40701206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598260250;
	bh=ZLh3nAFbAikCrPJtpuDCEG1Ecop/YnQ/DXbQjY5ipAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sYcz7Zn9fMet3Cxomp5QoYPPpEARagrfQ/A+Gketdj+EGHlePr0/O7dsscgV01B8y
	 eD7iPcgy2qzsa0rvUxbFjLQPbvMBn4z8eZFw82BoMXQeq8uQX4U7zxcEyEV9otGg/j
	 RVSqpNH14auGVQR3qZtONL97rJ1v9D4Tw8W6mYsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgHXJKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730518AbgHXI4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:56:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24E86207D3;
        Mon, 24 Aug 2020 08:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259381;
        bh=ZLh3nAFbAikCrPJtpuDCEG1Ecop/YnQ/DXbQjY5ipAc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JWKPc7yhR4UpnaZpi0gsDOeeC3jYC0hIYQP4flOVNWUAMT0/Ayb/IAkGoXdULyGpN
         Ac2StXzaH9ZOejpvGcZRJHWu8i5Dut38WcbzYLOvOYJQVGOM9GhOS2cxelaJkBvNiA
         dcf/4lrcj9ctmV+Rnf18FCOVskT3JYm6Vn1wz1cY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Octavian Purdila <octavian.purdila@intel.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 20/71] spi: Prevent adding devices below an unregistering controller
Date:   Mon, 24 Aug 2020 10:31:11 +0200
Message-Id: <20200824082356.903719626@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082355.848475917@linuxfoundation.org>
References: <20200824082355.848475917@linuxfoundation.org>
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
index 671d078349cc6..0a7fd56c1ed9d 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -817,4 +817,7 @@ config SPI_SLAVE_SYSTEM_CONTROL
 
 endif # SPI_SLAVE
 
+config SPI_DYNAMIC
+	def_bool ACPI || OF_DYNAMIC || SPI_SLAVE
+
 endif # SPI
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f589d8100e957..92e6b6774d98e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -432,6 +432,12 @@ static LIST_HEAD(spi_controller_list);
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
@@ -510,7 +516,6 @@ static int spi_dev_check(struct device *dev, void *data)
  */
 int spi_add_device(struct spi_device *spi)
 {
-	static DEFINE_MUTEX(spi_add_lock);
 	struct spi_controller *ctlr = spi->controller;
 	struct device *dev = ctlr->dev.parent;
 	int status;
@@ -538,6 +543,13 @@ int spi_add_device(struct spi_device *spi)
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
 
@@ -2306,6 +2318,10 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	struct spi_controller *found;
 	int id = ctlr->bus_num;
 
+	/* Prevent addition of new devices, unregister existing ones */
+	if (IS_ENABLED(CONFIG_SPI_DYNAMIC))
+		mutex_lock(&spi_add_lock);
+
 	device_for_each_child(&ctlr->dev, NULL, __unregister);
 
 	/* First make sure that this controller was ever added */
@@ -2326,6 +2342,9 @@ void spi_unregister_controller(struct spi_controller *ctlr)
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



