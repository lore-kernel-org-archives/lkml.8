Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C47BC8300B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 261ED2192A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588241463;
	bh=91ZNjhxl/4Uk0CVDSwzfRxA1xGjjiJCyaQ+kB6AFPbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vifnIs2R29TQ0W7hyR/fDcvfFFW3dw5wGFja9yfea7CWuzDTi+B2K/NXnWtFdDamF
	 nMfMqmuhEJ0R6cz2U+z7b1QkvV8JpgdX1F3rpxp31I+ZnBi8t09fannEYuRfpRmc7U
	 xInD56pYk5e/j4npkPaj562nOvGIOTxiAkp0ztMY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbgD3KLC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 06:11:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:45022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726962AbgD3KK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 06:10:58 -0400
Received: from localhost.localdomain (unknown [122.182.217.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE58B2192A;
        Thu, 30 Apr 2020 10:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588241457;
        bh=91ZNjhxl/4Uk0CVDSwzfRxA1xGjjiJCyaQ+kB6AFPbQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BBCyF0iufkmTpMNXobvqeArzVdrhaEgmX4P2La6MP92thxnYsT8VAh/dr/KJXE/lh
         0dH/4oBxgYxH397IGiO/QmjoteV+xisWR6jhZcZrLwEJmpUO2TAKJ9KdVcc4OObfyw
         CYIJUnKWvSNUrXoPgHLYfoQO4ob8O12hDUrNS4EY=
From:   Vinod Koul <vkoul@kernel.org>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        John Stultz <john.stultz@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        =?UTF-8?q?Andreas=20B=C3=B6hler?= <dev@aboehler.at>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 5/5] usb: xhci: provide a debugfs hook for erasing rom
Date:   Thu, 30 Apr 2020 15:40:19 +0530
Message-Id: <20200430101019.1130956-6-vkoul@kernel.org>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200430101019.1130956-1-vkoul@kernel.org>
References: <20200430101019.1130956-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

run "echo 1 > /sys/kernel/debug/renesas-usb/rom_erase" to erase firmware
when driver is loaded.

Subsequent init of driver shall reload the firmware

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/usb/host/xhci-pci-renesas.c | 33 +++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/usb/host/xhci-pci-renesas.c b/drivers/usb/host/xhci-pci-renesas.c
index aebd9546d994..977a4d4a3b54 100644
--- a/drivers/usb/host/xhci-pci-renesas.c
+++ b/drivers/usb/host/xhci-pci-renesas.c
@@ -2,6 +2,7 @@
 /* Copyright (C) 2019-2020 Linaro Limited */
 
 #include <linux/acpi.h>
+#include <linux/debugfs.h>
 #include <linux/firmware.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -170,6 +171,8 @@ static int renesas_fw_verify(const void *fw_data,
 	return 0;
 }
 
+static void debugfs_init(struct pci_dev *pdev);
+
 static bool renesas_check_rom(struct pci_dev *pdev)
 {
 	u16 rom_status;
@@ -183,6 +186,7 @@ static bool renesas_check_rom(struct pci_dev *pdev)
 	rom_status &= RENESAS_ROM_STATUS_ROM_EXISTS;
 	if (rom_status) {
 		dev_dbg(&pdev->dev, "External ROM exists\n");
+		debugfs_init(pdev);
 		return true; /* External ROM exists */
 	}
 
@@ -449,6 +453,34 @@ static void renesas_rom_erase(struct pci_dev *pdev)
 	dev_dbg(&pdev->dev, "ROM Erase... Done success\n");
 }
 
+static int debugfs_rom_erase(void *data, u64 value)
+{
+	struct pci_dev *pdev = data;
+
+	if (value == 1) {
+		dev_dbg(&pdev->dev, "Userspace requested ROM erase\n");
+		renesas_rom_erase(pdev);
+		return 0;
+	}
+	return -EINVAL;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(rom_erase_ops, NULL, debugfs_rom_erase, "%llu\n");
+
+static struct dentry *debugfs_root;
+
+static void debugfs_init(struct pci_dev *pdev)
+{
+	debugfs_root = debugfs_create_dir("renesas_usb", NULL);
+
+	debugfs_create_file("rom_erase", 0200, debugfs_root,
+			    pdev, &rom_erase_ops);
+}
+
+static void debugfs_exit(void)
+{
+	debugfs_remove_recursive(debugfs_root);
+}
+
 static bool renesas_setup_rom(struct pci_dev *pdev, const struct firmware *fw)
 {
 	const u32 *fw_data = (const u32 *)fw->data;
@@ -638,4 +670,5 @@ int renesas_xhci_check_request_fw(struct pci_dev *pdev,
 
 void renesas_xhci_pci_exit(struct pci_dev *dev)
 {
+	debugfs_exit();
 }
-- 
2.25.3

