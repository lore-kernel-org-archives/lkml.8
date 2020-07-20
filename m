Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30E0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7C5C2068F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:19:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+SAuNve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbgGTKTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 06:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728025AbgGTKTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 06:19:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29B9C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 03:19:37 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id l6so8476782plt.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 03:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uw12KCEbxaEVUpmwEUZh3Vc73Xt/78y5dWsYQGsjwSE=;
        b=C+SAuNve5q8758x7nw/tUYMoy5ksYjPm44RXGbm6g26eTpJbBBDY6jyj0v7oM8qv3t
         4aanmG/iRxS7/FWeYyl7arrpzdZ+7LE1Pk0tB1uWiDW96CDcD0fq+DCyAh8TVGSXYEeY
         /IH9pi/ikS94dz/XVZSC9uHYrlY9pM9VwNiiGr5RFWJpGBjvn6X847/zQCA1N06wUQ2O
         vmgy5yV4OEAbu6XnRyzA4wSs1VZu8LoVoqDmurAH+3rmC8H2LtYN3PIy6qCGqCD3A+1Y
         xPIBmqux55cPg2OecP9uogUbS7AEnq57fwe3LSZgJKMG0LCcK+c2uAo7Adb78SnYsmKw
         wALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uw12KCEbxaEVUpmwEUZh3Vc73Xt/78y5dWsYQGsjwSE=;
        b=TQB/3R02eMl9KbqQ4yvF3WdJUj9pVY7ku3U3+WIWIi9isARI5ko6RVe82pZYAmn7eO
         uy4UvvcKm6lGLYaEDiINubJomKiC5f0frjjAULQ2sRf04vIz9q0wFfAX3vy7KY/kGz7B
         OGExvTKIFZWubPqtlr95v8cNf1yWTIMWQUE0Tonk0WxYNnlXAihFQB/eCKBk159gmOnX
         ONzcwby/qpmCyjqXRsK6kWDjwm6FoXljXwIxRCl9NgK4waAAqgaeHEBqkOYWA+DU25qy
         m6D+N7SjjedXYhAK+x+mKaoa34MxIDCiPQGdlAAGMtEWGyUH7WWO4Vr1XQQBpkMQVngR
         zV8A==
X-Gm-Message-State: AOAM5309MYUWw/dORAY6oY35/U9oWbN4jnlczbyluPajmIUtsgOaSQeM
        pPDqjRXA3fwCnQUJyuLHXi0=
X-Google-Smtp-Source: ABdhPJwdPDo+9RE6DH2W2saAHqLQGFzMJDpz3VokXzCWGyfZMpznD5dilZTagO7S95m0jr7ggRmx5w==
X-Received: by 2002:a17:902:7241:: with SMTP id c1mr18153906pll.79.1595240377108;
        Mon, 20 Jul 2020 03:19:37 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id 22sm16019433pfh.157.2020.07.20.03.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 03:19:36 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v2] cardreader/rtsx_pcr.c: use generic power management
Date:   Mon, 20 Jul 2020 15:47:23 +0530
Message-Id: <20200720101722.145211-1-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
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
 drivers/misc/cardreader/rtsx_pcr.c | 33 ++++++++++--------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 0d5928bc1b6d..24474419bfc4 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1111,8 +1111,7 @@ static void rtsx_pci_idle_work(struct work_struct *work)
 	mutex_unlock(&pcr->pcr_mutex);
 }
 
-#ifdef CONFIG_PM
-static void rtsx_pci_power_off(struct rtsx_pcr *pcr, u8 pm_state)
+static void __maybe_unused rtsx_pci_power_off(struct rtsx_pcr *pcr, u8 pm_state)
 {
 	if (pcr->ops->turn_off_led)
 		pcr->ops->turn_off_led(pcr);
@@ -1126,7 +1125,6 @@ static void rtsx_pci_power_off(struct rtsx_pcr *pcr, u8 pm_state)
 	if (pcr->ops->force_power_down)
 		pcr->ops->force_power_down(pcr, pm_state);
 }
-#endif
 
 void rtsx_pci_enable_ocp(struct rtsx_pcr *pcr)
 {
@@ -1604,10 +1602,9 @@ static void rtsx_pci_remove(struct pci_dev *pcidev)
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
 
@@ -1623,17 +1620,15 @@ static int rtsx_pci_suspend(struct pci_dev *pcidev, pm_message_t state)
 
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
@@ -1645,13 +1640,6 @@ static int rtsx_pci_resume(struct pci_dev *pcidev)
 
 	mutex_lock(&pcr->pcr_mutex);
 
-	pci_set_power_state(pcidev, PCI_D0);
-	pci_restore_state(pcidev);
-	ret = pci_enable_device(pcidev);
-	if (ret)
-		goto out;
-	pci_set_master(pcidev);
-
 	ret = rtsx_pci_write_register(pcr, HOST_SLEEP_STATE, 0x03, 0x00);
 	if (ret)
 		goto out;
@@ -1667,6 +1655,8 @@ static int rtsx_pci_resume(struct pci_dev *pcidev)
 	return ret;
 }
 
+#ifdef CONFIG_PM
+
 static void rtsx_pci_shutdown(struct pci_dev *pcidev)
 {
 	struct pcr_handle *handle;
@@ -1686,19 +1676,18 @@ static void rtsx_pci_shutdown(struct pci_dev *pcidev)
 
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

