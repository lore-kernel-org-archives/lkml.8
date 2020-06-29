Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68ABFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D3B120663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jP/gf47e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbgF2UsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731531AbgF2TNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:51 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BD3C0149C5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:17:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y18so6808094plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BuikRCWls/1715AYcrraFB3A4+eL6QoET64hwm9dIIo=;
        b=jP/gf47eOAWCydT0MD5J/MqFLIRfzGNtbv40edfut0G47CNTlMQkGiwDTp8xadJX4m
         D0ShTR3QHMoyP4xFqKl6nb+ZPOSRDBgEhhTYvvSt5M+RNSKIk3xY0J/bTlyeOnbe9KXn
         RiStoGsGpw4efhK8fTVYZkT4za65116Fagz+kiU+Xdf4vhkcZ2p61i8n4wuI4gRPRpvG
         tRp+Gtgfl/ZgR2Op/u0RByKENB6mlWeg6AodbP/0TUMtDvEHSquIMc7JFv28XiF1zWxb
         4AIdYlbgOOtpFD7JY1NyI55tClHbn8OCiK9MuBaINVMawfj3E2oIaw2650c5P8+MeHOi
         rFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BuikRCWls/1715AYcrraFB3A4+eL6QoET64hwm9dIIo=;
        b=XMm4KfjMTBwLBhp7j5Bsz92Qto5e8mRnrCT5fRA/R3O5dkffq2AqRlPJfDSnHXhCpL
         FFHsfKK4N8XeM2/Lw6dq7CcRUboEmk+4Zixo2N61nQj4q3Am+CXWjBNVyBlx5Uqda4wz
         Jcw/NTjuCADFmPAv2VBLoweAowTcC9rh5AQJfqdtzRuBK/qUgu+lhL8PvdRFMR1jTUkK
         K5SG8/hAaSYt9JaE6HfVv31nhsxZ6UeNpqRPG9Syzy8vToIz/l8Ye6uphuaX5saNG1dP
         jYYXSGnqpZmK746KoFEAPrfQnxFvwK5xG7y9RB62+Fei4EFU/Y4GpVs2mWeYxa8QHO/z
         VvSQ==
X-Gm-Message-State: AOAM532yBRZU9FUjEFjnfS8SOmCw/Vrpnvbrv9TRau6cz3TZtCJO6t2J
        2vHIlpV7rhWOsKhyLh2e35s=
X-Google-Smtp-Source: ABdhPJxnJPlt/8JXN+pUfZVG1FIXk17uecrD76ia3WS3D9c5PMOoCFl1Z5akYQn/d+t/mhUxZgTk5w==
X-Received: by 2002:a17:90a:304d:: with SMTP id q13mr16206436pjl.73.1593418667901;
        Mon, 29 Jun 2020 01:17:47 -0700 (PDT)
Received: from varodek.localdomain ([106.210.40.90])
        by smtp.gmail.com with ESMTPSA id co1sm3345154pjb.34.2020.06.29.01.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 01:17:47 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, bjorn@helgaas.com,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@gmail.com>, Alex Dubov <oakad@yahoo.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: [PATCH v1 5/5] misc/pch_phub.c: use generic power management
Date:   Mon, 29 Jun 2020 13:45:31 +0530
Message-Id: <20200629081531.214734-6-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629081531.214734-1-vaibhavgupta40@gmail.com>
References: <20200629081531.214734-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers should not use legacy power management as they have to manage power
states and related operations, for the device, themselves. This driver was
handling them with the help of PCI helper functions like
pci_save/restore_state(), pci_enable/disable_device(), etc.

With generic PM, all essentials will be handled by the PCI core. Driver
needs to do only device-specific operations.

The driver was also using pci_enable_wake(...,..., 0) to disable wake. Use
device_wakeup_disable() instead. It was also saving device register
configuration using pch_phub_save/restore_reg_conf() which is not
recommended.

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/misc/pch_phub.c | 48 ++++++++---------------------------------
 1 file changed, 9 insertions(+), 39 deletions(-)

diff --git a/drivers/misc/pch_phub.c b/drivers/misc/pch_phub.c
index 60828af7506a..9321d4239932 100644
--- a/drivers/misc/pch_phub.c
+++ b/drivers/misc/pch_phub.c
@@ -147,9 +147,8 @@ static void pch_phub_read_modify_write_reg(struct pch_phub_reg *chip,
 	iowrite32(((ioread32(reg_addr) & ~mask)) | data, reg_addr);
 }
 
-#ifdef CONFIG_PM
 /* pch_phub_save_reg_conf - saves register configuration */
-static void pch_phub_save_reg_conf(struct pci_dev *pdev)
+static void __maybe_unused pch_phub_save_reg_conf(struct pci_dev *pdev)
 {
 	unsigned int i;
 	struct pch_phub_reg *chip = pci_get_drvdata(pdev);
@@ -210,7 +209,7 @@ static void pch_phub_save_reg_conf(struct pci_dev *pdev)
 }
 
 /* pch_phub_restore_reg_conf - restore register configuration */
-static void pch_phub_restore_reg_conf(struct pci_dev *pdev)
+static void __maybe_unused pch_phub_restore_reg_conf(struct pci_dev *pdev)
 {
 	unsigned int i;
 	struct pch_phub_reg *chip = pci_get_drvdata(pdev);
@@ -270,7 +269,6 @@ static void pch_phub_restore_reg_conf(struct pci_dev *pdev)
 	if ((chip->ioh_type == 2) || (chip->ioh_type == 4))
 		iowrite32(chip->funcsel_reg, p + FUNCSEL_REG_OFFSET);
 }
-#endif
 
 /**
  * pch_phub_read_serial_rom() - Reading Serial ROM
@@ -835,48 +833,19 @@ static void pch_phub_remove(struct pci_dev *pdev)
 	kfree(chip);
 }
 
-#ifdef CONFIG_PM
-
-static int pch_phub_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused pch_phub_suspend(struct device *dev_d)
 {
-	int ret;
-
-	pch_phub_save_reg_conf(pdev);
-	ret = pci_save_state(pdev);
-	if (ret) {
-		dev_err(&pdev->dev,
-			" %s -pci_save_state returns %d\n", __func__, ret);
-		return ret;
-	}
-	pci_enable_wake(pdev, PCI_D3hot, 0);
-	pci_disable_device(pdev);
-	pci_set_power_state(pdev, pci_choose_state(pdev, state));
+	device_wakeup_disable(dev_d);
 
 	return 0;
 }
 
-static int pch_phub_resume(struct pci_dev *pdev)
+static int __maybe_unused pch_phub_resume(struct device *dev_d)
 {
-	int ret;
-
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-	ret = pci_enable_device(pdev);
-	if (ret) {
-		dev_err(&pdev->dev,
-		"%s-pci_enable_device failed(ret=%d) ", __func__, ret);
-		return ret;
-	}
-
-	pci_enable_wake(pdev, PCI_D3hot, 0);
-	pch_phub_restore_reg_conf(pdev);
+	device_wakeup_disable(dev_d);
 
 	return 0;
 }
-#else
-#define pch_phub_suspend NULL
-#define pch_phub_resume NULL
-#endif /* CONFIG_PM */
 
 static const struct pci_device_id pch_phub_pcidev_id[] = {
 	{ PCI_VDEVICE(INTEL, PCI_DEVICE_ID_PCH1_PHUB),       1,  },
@@ -888,13 +857,14 @@ static const struct pci_device_id pch_phub_pcidev_id[] = {
 };
 MODULE_DEVICE_TABLE(pci, pch_phub_pcidev_id);
 
+static SIMPLE_DEV_PM_OPS(pch_phub_pm_ops, pch_phub_suspend, pch_phub_resume);
+
 static struct pci_driver pch_phub_driver = {
 	.name = "pch_phub",
 	.id_table = pch_phub_pcidev_id,
 	.probe = pch_phub_probe,
 	.remove = pch_phub_remove,
-	.suspend = pch_phub_suspend,
-	.resume = pch_phub_resume
+	.driver.pm = &pch_phub_pm_ops,
 };
 
 module_pci_driver(pch_phub_driver);
-- 
2.27.0

