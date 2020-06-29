Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0476CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0BDB206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:56:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMQ90uHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389985AbgF2U4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731267AbgF2TNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:07 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0385CC014A5E
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:17:35 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id j12so7568737pfn.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=arjTPx8IlIG3Faejt7byV8E3hxyauMop9P6uXWb4FG0=;
        b=AMQ90uHUA7E18kK7PM3qs+qkCHIEBr/2YsGM884IGiHe8bl9IF+TBUR41PqeoaPqzx
         OmeWZ9q8OnSCLd4PphAMKt1qHDDRzq1O1bPXIAeID6K4S+G2jtr+SvWIaZSJbe/EIRL3
         65jSxbF0YxiwOJrRC4Ddx0JDQICnkKioA0K88phNtx02WNdqIcRgJwsyChCVjjKoEohN
         YBSTlTeart+jflKn18fRZ2QxC7a11LzCPeIBzC+wXl44aTLz3zfmBAljb2Te/YrtT8g0
         q9a+1suAj2hYNzwMIfsMwfzQoyE5h6XIeglbLxIJqRsUFmv3UW+i9lHeK9EON+2ZXjEX
         lUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=arjTPx8IlIG3Faejt7byV8E3hxyauMop9P6uXWb4FG0=;
        b=V5cl5q/PzbJe+AgvQO4hN/kUdF4A6Hp/NIdQdnqL5mKE3oWPaqHcqiAtHuZ3NaEcVo
         FhOst06aWSp9gFv0JaMNxL+NYNgZpSy8pd6Ypfjh48hoFvvii+e5Rt6sa7lEd4qczXB8
         El4gJ34zo6IoAg1AqQ2/NERy+xxeCbh8Jr6/f/uJN9kewRZjbKjR5xgR6MjvKq5qIZ6n
         Gm/uwW3tyfTvPo3wlmoy9pz7HA+Ldko6iSEcysuJrbALa88ATUA/85+BoYlwehrrUpNZ
         ZxCwWUZWT0wBNL+bDzC+sO64bbvONjxaS9cm6WtPMSQvd3g4I2l/wqOTQ6HX7lt3Yelo
         mDbw==
X-Gm-Message-State: AOAM532u0Gqge8yXI1jIF/Q3JxaT1RwwzOfNXHj83tJWs0ToEhlEvdV+
        DT2eK1R7Nyf692qm/DMwfo0=
X-Google-Smtp-Source: ABdhPJynwBo1/481k/kTslfiIhadtlrrNybnr1PxMyeVh81m/kwbIePqoYulSXlVcW7u8ianI6gxQg==
X-Received: by 2002:a65:644d:: with SMTP id s13mr9449614pgv.103.1593418654500;
        Mon, 29 Jun 2020 01:17:34 -0700 (PDT)
Received: from varodek.localdomain ([106.210.40.90])
        by smtp.gmail.com with ESMTPSA id co1sm3345154pjb.34.2020.06.29.01.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 01:17:34 -0700 (PDT)
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
Subject: [PATCH v1 3/5] misc/tifm_7xx1.c: use generic power management
Date:   Mon, 29 Jun 2020 13:45:29 +0530
Message-Id: <20200629081531.214734-4-vaibhavgupta40@gmail.com>
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
device_wakeup_disable() instead.

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/misc/tifm_7xx1.c | 30 ++++++++----------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/tifm_7xx1.c b/drivers/misc/tifm_7xx1.c
index e6b40aa8fb42..228f2eb1d476 100644
--- a/drivers/misc/tifm_7xx1.c
+++ b/drivers/misc/tifm_7xx1.c
@@ -207,10 +207,9 @@ static void tifm_7xx1_switch_media(struct work_struct *work)
 	spin_unlock_irqrestore(&fm->lock, flags);
 }
 
-#ifdef CONFIG_PM
-
-static int tifm_7xx1_suspend(struct pci_dev *dev, pm_message_t state)
+static int __maybe_unused tifm_7xx1_suspend(struct device *dev_d)
 {
+	struct pci_dev *dev = to_pci_dev(dev_d);
 	struct tifm_adapter *fm = pci_get_drvdata(dev);
 	int cnt;
 
@@ -221,15 +220,13 @@ static int tifm_7xx1_suspend(struct pci_dev *dev, pm_message_t state)
 			tifm_7xx1_sock_power_off(fm->sockets[cnt]->addr);
 	}
 
-	pci_save_state(dev);
-	pci_enable_wake(dev, pci_choose_state(dev, state), 0);
-	pci_disable_device(dev);
-	pci_set_power_state(dev, pci_choose_state(dev, state));
+	device_wakeup_disable(dev_d);
 	return 0;
 }
 
-static int tifm_7xx1_resume(struct pci_dev *dev)
+static int __maybe_unused tifm_7xx1_resume(struct device *dev_d)
 {
+	struct pci_dev *dev = to_pci_dev(dev_d);
 	struct tifm_adapter *fm = pci_get_drvdata(dev);
 	int rc;
 	unsigned long timeout;
@@ -242,11 +239,6 @@ static int tifm_7xx1_resume(struct pci_dev *dev)
 	if (WARN_ON(fm->num_sockets > ARRAY_SIZE(new_ids)))
 		return -ENXIO;
 
-	pci_set_power_state(dev, PCI_D0);
-	pci_restore_state(dev);
-	rc = pci_enable_device(dev);
-	if (rc)
-		return rc;
 	pci_set_master(dev);
 
 	dev_dbg(&dev->dev, "resuming host\n");
@@ -297,13 +289,6 @@ static int tifm_7xx1_resume(struct pci_dev *dev)
 	return 0;
 }
 
-#else
-
-#define tifm_7xx1_suspend NULL
-#define tifm_7xx1_resume NULL
-
-#endif /* CONFIG_PM */
-
 static int tifm_7xx1_dummy_has_ms_pif(struct tifm_adapter *fm,
 				      struct tifm_dev *sock)
 {
@@ -424,13 +409,14 @@ static const struct pci_device_id tifm_7xx1_pci_tbl[] = {
 	{ }
 };
 
+static SIMPLE_DEV_PM_OPS(tifm_7xx1_pm_ops, tifm_7xx1_suspend, tifm_7xx1_resume);
+
 static struct pci_driver tifm_7xx1_driver = {
 	.name = DRIVER_NAME,
 	.id_table = tifm_7xx1_pci_tbl,
 	.probe = tifm_7xx1_probe,
 	.remove = tifm_7xx1_remove,
-	.suspend = tifm_7xx1_suspend,
-	.resume = tifm_7xx1_resume,
+	.driver.pm = &tifm_7xx1_pm_ops,
 };
 
 module_pci_driver(tifm_7xx1_driver);
-- 
2.27.0

