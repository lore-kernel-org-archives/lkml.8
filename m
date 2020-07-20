Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A53C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFEC122B4D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pF2xi4w6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgGTPJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgGTPJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:09:40 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD97C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 08:09:40 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a14so9190350pfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P2mRU9DML+WlUjG+x0KgX1XxnekTukVWP0rhuq7mq9o=;
        b=pF2xi4w6gHUB6KW6oVO8ioBNFr4YuhVG9jm+hW8Zh4OrXm28Dd17IN8/kmz4H2P4oc
         ISGLz5n0zY0gA4ad2Nx38ctTepSAW3OALHb1zN8K6Foel9279E6gvQzFhrN82mLQEUZx
         JtTx7YTY52uGnM7rUnkEKUNfZ5yXRDy+6YhHrJT25y0ZJp+NFT+LL0kSBcOM/HN1FHI2
         7rKtd/WT8rLzBvDXhQRMK6ZbtG+d6L2A3iOCg7XUWIB+Qu4xFimDWE0vVwJjo/C5Z7bA
         qnFxGBBONqB9BmFEE4Ur0rP0MBBcQcngNzyZVAUsoN4RkyGlSQwe/Ba/aWdcLt2yeJwY
         cw9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P2mRU9DML+WlUjG+x0KgX1XxnekTukVWP0rhuq7mq9o=;
        b=m3ouAFCZ9uMVPX3NtuNf38+10XHpUE0JTWZW5XWuAI86gcVAtH51f58dvx5yKLIbZB
         k88WcBr5BsA3GnT9oRFtZ6QAYrizRxfaaxs/A+1YwxRml9wAFhEedIEi2b29F46rw01N
         7jJ0WnFAw/gMnxJ6VtdMJBU2lmBz2BKQviU5yhMw77MuVUFuQ+icrhYnT+oUMJohk5Ig
         xgiBBQuHFxZUCI5YFDd0z6FExGCET5Ba3Nj/chvBynq7je9dsmQ/ue41Ewj2DLXtFvip
         OL6k0/0qE/TXulx7McXGvfWgF0tII1w8168e/WPW02fV9gcfXXRpjehMTfMO4/6d0jSm
         mnZw==
X-Gm-Message-State: AOAM530yY74EFhkKxXg71/dVvys6jRJ578M5pZC7a6qn9RpO0EiJQ/xL
        7AzEdc1rz8zO2Hb0zkVKnsE=
X-Google-Smtp-Source: ABdhPJws8JrM5TULRLzImq9oyGdayyre0j2HUv0+tiud6sIC2oAR/xrn7Ia6p4g9JrdCMX4x7qpP9Q==
X-Received: by 2002:aa7:9155:: with SMTP id 21mr19004277pfi.306.1595257779413;
        Mon, 20 Jul 2020 08:09:39 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id f207sm17723624pfa.107.2020.07.20.08.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 08:09:38 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux1394-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v1] firewire: ohci: use generic power management
Date:   Mon, 20 Jul 2020 20:37:16 +0530
Message-Id: <20200720150715.624520-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers using legacy PM have to manage PCI states and device's PM states
themselves. They also need to take care of configuration registers.

With improved and powerful support of generic PM, PCI Core takes care of
above mentioned, device-independent, jobs.

This driver makes use of PCI helper functions like
pci_save/restore_state(), pci_disable_device() and pci_set_power_state() to
do required operations. In generic mode, they are no longer needed.

Change function parameter in both .suspend() and .resume() to
"struct device*" type. Use to_pci_dev() to get "struct pci_dev*" variable.

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/firewire/ohci.c | 43 ++++++++++++-----------------------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 54fdc39cd0bc..2d19db5e81a1 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -3169,8 +3169,7 @@ static int ohci_set_iso_channels(struct fw_iso_context *base, u64 *channels)
 	return ret;
 }
 
-#ifdef CONFIG_PM
-static void ohci_resume_iso_dma(struct fw_ohci *ohci)
+static void __maybe_unused ohci_resume_iso_dma(struct fw_ohci *ohci)
 {
 	int i;
 	struct iso_context *ctx;
@@ -3187,7 +3186,6 @@ static void ohci_resume_iso_dma(struct fw_ohci *ohci)
 			ohci_start_iso(&ctx->base, 0, ctx->sync, ctx->tags);
 	}
 }
-#endif
 
 static int queue_iso_transmit(struct iso_context *ctx,
 			      struct fw_iso_packet *packet,
@@ -3793,39 +3791,24 @@ static void pci_remove(struct pci_dev *dev)
 	dev_notice(&dev->dev, "removed fw-ohci device\n");
 }
 
-#ifdef CONFIG_PM
-static int pci_suspend(struct pci_dev *dev, pm_message_t state)
+static int __maybe_unused pci_suspend(struct device *dev)
 {
-	struct fw_ohci *ohci = pci_get_drvdata(dev);
-	int err;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct fw_ohci *ohci = pci_get_drvdata(pdev);
 
 	software_reset(ohci);
-	err = pci_save_state(dev);
-	if (err) {
-		ohci_err(ohci, "pci_save_state failed\n");
-		return err;
-	}
-	err = pci_set_power_state(dev, pci_choose_state(dev, state));
-	if (err)
-		ohci_err(ohci, "pci_set_power_state failed with %d\n", err);
-	pmac_ohci_off(dev);
+	pmac_ohci_off(pdev);
 
 	return 0;
 }
 
-static int pci_resume(struct pci_dev *dev)
+static int __maybe_unused pci_resume(struct device *dev)
 {
-	struct fw_ohci *ohci = pci_get_drvdata(dev);
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct fw_ohci *ohci = pci_get_drvdata(pdev);
 	int err;
 
-	pmac_ohci_on(dev);
-	pci_set_power_state(dev, PCI_D0);
-	pci_restore_state(dev);
-	err = pci_enable_device(dev);
-	if (err) {
-		ohci_err(ohci, "pci_enable_device failed\n");
-		return err;
-	}
+	pmac_ohci_on(pdev);
 
 	/* Some systems don't setup GUID register on resume from ram  */
 	if (!reg_read(ohci, OHCI1394_GUIDLo) &&
@@ -3842,7 +3825,6 @@ static int pci_resume(struct pci_dev *dev)
 
 	return 0;
 }
-#endif
 
 static const struct pci_device_id pci_table[] = {
 	{ PCI_DEVICE_CLASS(PCI_CLASS_SERIAL_FIREWIRE_OHCI, ~0) },
@@ -3851,15 +3833,14 @@ static const struct pci_device_id pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, pci_table);
 
+static SIMPLE_DEV_PM_OPS(pci_pm_ops, pci_suspend, pci_resume);
+
 static struct pci_driver fw_ohci_pci_driver = {
 	.name		= ohci_driver_name,
 	.id_table	= pci_table,
 	.probe		= pci_probe,
 	.remove		= pci_remove,
-#ifdef CONFIG_PM
-	.resume		= pci_resume,
-	.suspend	= pci_suspend,
-#endif
+	.driver.pm	= &pci_pm_ops,
 };
 
 static int __init fw_ohci_init(void)
-- 
2.27.0

