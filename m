Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB164C35240
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A29C24655
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 01:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579828655;
	bh=mjJrS8A36FDuKb9fONPOUFh7RpbbhF9DWKvJqd6eeek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JKk9/qicRKDZf/H6dG7gvnDqIhjW3sJ5P5RP0SE+fm07R+/poKJxBYyn9jXD74sWX
	 dTTiq0SStyL26omxU2LdfjOF7TLiznK4/D75JSDiVK2f6ufhgYjFIgNsfIFXDRav5n
	 mZVRRM1BCk4r7Te4Xy1+cCQ4I0Xor6olQ1s+5T0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbgAXBRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 20:17:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:60608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730540AbgAXBRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 20:17:33 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 267BB206A2;
        Fri, 24 Jan 2020 01:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579828652;
        bh=mjJrS8A36FDuKb9fONPOUFh7RpbbhF9DWKvJqd6eeek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WUQAnr1hBA6trx/jqbtxnTW008yoPauNJT7J8Q+RM0i8cQfCPcnH4l1wJJ7i3e3+X
         Icl3wIBOERFq7q6kJTB0azb/I7+3ZZAlUHAySkTYAL6grtBZEk30Xg9EZHMcfv7DN+
         yLST+GOIptyiEeSTyuXVDPBrLTAPJAmfD4JM28+g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Raul E Rangel <rrangel@chromium.org>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-mmc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 20/33] mmc: sdhci-pci: Quirk for AMD SDHC Device 0x7906
Date:   Thu, 23 Jan 2020 20:16:55 -0500
Message-Id: <20200124011708.18232-20-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124011708.18232-1-sashal@kernel.org>
References: <20200124011708.18232-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raul E Rangel <rrangel@chromium.org>

[ Upstream commit 7a869f00bb15bcefb8804d798a49b086267b03e6 ]

AMD SDHC 0x7906 requires a hard reset to clear all internal state.
Otherwise it can get into a bad state where the DATA lines are always
read as zeros.

This change requires firmware that can transition the device into
D3Cold for it to work correctly. If the firmware does not support
transitioning to D3Cold then the power state transitions are a no-op.

Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mmc/host/sdhci-pci-core.c | 51 ++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 642a9667db4dd..96a163f36a395 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -21,6 +21,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/scatterlist.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/gpio.h>
 #include <linux/pm_runtime.h>
 #include <linux/mmc/slot-gpio.h>
@@ -1598,11 +1599,59 @@ static int amd_probe(struct sdhci_pci_chip *chip)
 	return 0;
 }
 
+static u32 sdhci_read_present_state(struct sdhci_host *host)
+{
+	return sdhci_readl(host, SDHCI_PRESENT_STATE);
+}
+
+void amd_sdhci_reset(struct sdhci_host *host, u8 mask)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev = slot->chip->pdev;
+	u32 present_state;
+
+	/*
+	 * SDHC 0x7906 requires a hard reset to clear all internal state.
+	 * Otherwise it can get into a bad state where the DATA lines are always
+	 * read as zeros.
+	 */
+	if (pdev->device == 0x7906 && (mask & SDHCI_RESET_ALL)) {
+		pci_clear_master(pdev);
+
+		pci_save_state(pdev);
+
+		pci_set_power_state(pdev, PCI_D3cold);
+		pr_debug("%s: power_state=%u\n", mmc_hostname(host->mmc),
+			pdev->current_state);
+		pci_set_power_state(pdev, PCI_D0);
+
+		pci_restore_state(pdev);
+
+		/*
+		 * SDHCI_RESET_ALL says the card detect logic should not be
+		 * reset, but since we need to reset the entire controller
+		 * we should wait until the card detect logic has stabilized.
+		 *
+		 * This normally takes about 40ms.
+		 */
+		readx_poll_timeout(
+			sdhci_read_present_state,
+			host,
+			present_state,
+			present_state & SDHCI_CD_STABLE,
+			10000,
+			100000
+		);
+	}
+
+	return sdhci_reset(host, mask);
+}
+
 static const struct sdhci_ops amd_sdhci_pci_ops = {
 	.set_clock			= sdhci_set_clock,
 	.enable_dma			= sdhci_pci_enable_dma,
 	.set_bus_width			= sdhci_set_bus_width,
-	.reset				= sdhci_reset,
+	.reset				= amd_sdhci_reset,
 	.set_uhs_signaling		= sdhci_set_uhs_signaling,
 };
 
-- 
2.20.1

