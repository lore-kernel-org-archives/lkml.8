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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF04C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1822B20663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkt6Q0Tc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730994AbgF2UxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731335AbgF2TNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:23 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60EBC014A54
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:17:28 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id u8so7444003pje.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LQbv/kqpYIFMU5rUjcmTQLBycdHYItEePq3QI83n7qo=;
        b=bkt6Q0TcR4n/l+mBmN3Mq3o4JTW33uWez2KZwEhui6jpKMAK6feYaJ/p7yeSgj4aY8
         kouegoT4XvMfelGTNnqistuNTIYK0t8iaSds1Pwd2GZMmd5rBVVJ07daijT0XaBJUnEZ
         huI6yAjhoYtjnoILtfsweJszvd+SVsGObGcmRijmR0F/99YERXlh8J2C7XijVX84ug3X
         A8rc5/SzoItUpTkhGwagy++k7o26fx818Ghi67KkbBgbw9wr6AWxkn+YggKBedaRgVE3
         jeQ6KrvJETk967RjT7Sm3t5pYOy2SS3u7uz2WvHOOjVhDAfWuprvBxD2NWUePlkMuVop
         f7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LQbv/kqpYIFMU5rUjcmTQLBycdHYItEePq3QI83n7qo=;
        b=uk1S1lEdAdhjma1gPvWGOclvvMxLYHuS7zeRCpMuyQfT93YnoAE/O4yRXJ1f7mIqJa
         plgDk7WhUBCb89gnDGEYdruvqnpMSMnqXVNBmxkbVYgoebmJgDYw7bav4lyx8SBwjB3t
         Q+Ptw/xMrRwwOGiClxzfz+JKYyNcOGxAXOsvvEm9XlJnPZAVL23ZvuWbr/W9HcSELtWf
         zfjpxODDvdvYuslZZA7mNDxo9OU8xOBMA/iw2xIT4XjXya7k9PbHSkDJRPyRX05LoAoC
         uVPfOtp8hD9EW9sV2q4EFk4rPXMcvkJLxU4GjPrKir2aNngKe8XpIURv6+fXtxC/bDiS
         29KQ==
X-Gm-Message-State: AOAM533lwMiSK8ae4KFHgG2DxVsuJghdpCQ+6Gze7g8QI3FHNGGoVdt7
        v6TCDUE1XXktmsG1ue22y3o=
X-Google-Smtp-Source: ABdhPJwQKm/0wvFfLPrzBSGZOAhguhAg7eyU3UUCTNgvWuQvPS/qYbNuIbd2IYrNGNfKtDUf0maWYw==
X-Received: by 2002:a17:902:b714:: with SMTP id d20mr2645461pls.318.1593418648402;
        Mon, 29 Jun 2020 01:17:28 -0700 (PDT)
Received: from varodek.localdomain ([106.210.40.90])
        by smtp.gmail.com with ESMTPSA id co1sm3345154pjb.34.2020.06.29.01.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 01:17:27 -0700 (PDT)
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
Subject: [PATCH v1 2/5] cardreader/rtsx_pcr.c: use generic power management
Date:   Mon, 29 Jun 2020 13:45:28 +0530
Message-Id: <20200629081531.214734-3-vaibhavgupta40@gmail.com>
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

With generic PM, all essentials will be handled by the  PCI core. Driver
needs to do only device-specific operations.

The driver was also using pci_enable_wake(...,..., 0) to disable wake. Use
device_wakeup_disable() instead.

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/misc/cardreader/rtsx_pcr.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 0d5928bc1b6d..ca5212cba1c0 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1604,10 +1604,9 @@ static void rtsx_pci_remove(struct pci_dev *pcidev)
 		pci_name(pcidev), (int)pcidev->vendor, (int)pcidev->device);
 }
 
-#ifdef CONFIG_PM
-
-static int rtsx_pci_suspend(struct pci_dev *pcidev, pm_message_t state)
+static int __maybe_unused rtsx_pci_suspend(struct device *dev_d)
 {
+	struct pci_dev *pcidev = to_pci_dev(dev_d);
 	struct pcr_handle *handle;
 	struct rtsx_pcr *pcr;
 
@@ -1623,17 +1622,15 @@ static int rtsx_pci_suspend(struct pci_dev *pcidev, pm_message_t state)
 
 	rtsx_pci_power_off(pcr, HOST_ENTER_S3);
 
-	pci_save_state(pcidev);
-	pci_enable_wake(pcidev, pci_choose_state(pcidev, state), 0);
-	pci_disable_device(pcidev);
-	pci_set_power_state(pcidev, pci_choose_state(pcidev, state));
+	device_wakeup_disable(dev_d);
 
 	mutex_unlock(&pcr->pcr_mutex);
 	return 0;
 }
 
-static int rtsx_pci_resume(struct pci_dev *pcidev)
+static int __maybe_unused rtsx_pci_resume(struct device *dev_d)
 {
+	struct pci_dev *pcidev = to_pci_dev(dev_d);
 	struct pcr_handle *handle;
 	struct rtsx_pcr *pcr;
 	int ret = 0;
@@ -1645,11 +1642,6 @@ static int rtsx_pci_resume(struct pci_dev *pcidev)
 
 	mutex_lock(&pcr->pcr_mutex);
 
-	pci_set_power_state(pcidev, PCI_D0);
-	pci_restore_state(pcidev);
-	ret = pci_enable_device(pcidev);
-	if (ret)
-		goto out;
 	pci_set_master(pcidev);
 
 	ret = rtsx_pci_write_register(pcr, HOST_SLEEP_STATE, 0x03, 0x00);
@@ -1667,6 +1659,8 @@ static int rtsx_pci_resume(struct pci_dev *pcidev)
 	return ret;
 }
 
+#ifdef CONFIG_PM
+
 static void rtsx_pci_shutdown(struct pci_dev *pcidev)
 {
 	struct pcr_handle *handle;
@@ -1686,19 +1680,18 @@ static void rtsx_pci_shutdown(struct pci_dev *pcidev)
 
 #else /* CONFIG_PM */
 
-#define rtsx_pci_suspend NULL
-#define rtsx_pci_resume NULL
 #define rtsx_pci_shutdown NULL
 
 #endif /* CONFIG_PM */
 
+static SIMPLE_DEV_PM_OPS(rtsx_pci_pm_ops, rtsx_pci_suspend, rtsx_pci_resume);
+
 static struct pci_driver rtsx_pci_driver = {
 	.name = DRV_NAME_RTSX_PCI,
 	.id_table = rtsx_pci_ids,
 	.probe = rtsx_pci_probe,
 	.remove = rtsx_pci_remove,
-	.suspend = rtsx_pci_suspend,
-	.resume = rtsx_pci_resume,
+	.driver.pm = &rtsx_pci_pm_ops,
 	.shutdown = rtsx_pci_shutdown,
 };
 module_pci_driver(rtsx_pci_driver);
-- 
2.27.0

