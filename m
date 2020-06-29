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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B39C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852A120720
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZKdu8bO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390102AbgF2VAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731215AbgF2TM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:59 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A0BAC014A4B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:17:22 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c1so444047pja.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4TjEWlxkCQ6jKCxDwmv47XB9uFr9TMvZOX5G8CmUuAM=;
        b=EZKdu8bOP57qq+jePoS28spu6jXDUcNKNX/SqDXKCfUs8XTvsWvvaNtuGhMo461lk8
         8aiEOOLQOfQQZjjdrS3fCnhBHwgQ0IfKCzscQILS+N8cn4a213SmONNRyXr8IWaqvSC1
         1+E/LTN3bLQVeASon4K2bizVn77Gx5msFa7EaVu+5UIUrctOyOmlWbHKIZZM5Obj/bY4
         eQcioLZ/eF8ImQQ/GfZAr7s8/VZ2yfaOpZLo4wthmacuL0PsdV43B9RhZtwpUcp4O2r+
         /iGOO5VqbkL30LC8Tv8O6rLTYEiGVf/UvJg3I+ygwajstoSEAEczB5j3dmdx+tWm44h9
         QSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4TjEWlxkCQ6jKCxDwmv47XB9uFr9TMvZOX5G8CmUuAM=;
        b=umZ4RYQa/eVNqXuYAgsISkfzNGHetIoDZs+tzO1lkJcsojPjAK2M6CkOkQpeBACRf3
         fcngPqcVAmkQq7DRStq6O50kXbCp5HuNPcWk+HGTSy/ny3Qd/tXoeyItnmifUWAaJMqu
         uJ+KyId87/2+8xkXtyYkHh4xa/w1rJ5zZqhq3tdqxpceQ1Pr1DEJC1yp8wgphutL4FSN
         +ZL4yFrigqxu0Yh2IDIOKZ/NB29teloL2Yii5VVW0J98iS3psEWELAwH4iXP9OJ1juEK
         Da5PNyFovoiE3HnvpfW89btRn2OLmd1bjOmQM9m+qLQA3MiJVFiMi5htL8iuL7ZfV/gw
         ZyjQ==
X-Gm-Message-State: AOAM532nFmgb275nTG+AR3JIvJt+xCR72NBkQgtpCyjd3KibjtAMYIHm
        /apfSKf6lGRAxMQzUMS9GMA=
X-Google-Smtp-Source: ABdhPJygQ8DmbhA4ifvNfZdy5+PSbPTWeeSFEQp1uqWB8k23uWji2yFChpuajG9uZYSsbsiBFQB8Cg==
X-Received: by 2002:a17:90a:c295:: with SMTP id f21mr3800489pjt.208.1593418641726;
        Mon, 29 Jun 2020 01:17:21 -0700 (PDT)
Received: from varodek.localdomain ([106.210.40.90])
        by smtp.gmail.com with ESMTPSA id co1sm3345154pjb.34.2020.06.29.01.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 01:17:21 -0700 (PDT)
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
Subject: [PATCH v1 1/5] cb710/core.c: use generic power management
Date:   Mon, 29 Jun 2020 13:45:27 +0530
Message-Id: <20200629081531.214734-2-vaibhavgupta40@gmail.com>
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

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/misc/cb710/core.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/misc/cb710/core.c b/drivers/misc/cb710/core.c
index b290bc2ee240..55b7ee0e8f93 100644
--- a/drivers/misc/cb710/core.c
+++ b/drivers/misc/cb710/core.c
@@ -166,37 +166,24 @@ void cb710_set_irq_handler(struct cb710_slot *slot,
 }
 EXPORT_SYMBOL_GPL(cb710_set_irq_handler);
 
-#ifdef CONFIG_PM
-
-static int cb710_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused cb710_suspend(struct device *dev_d)
 {
+	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct cb710_chip *chip = pci_get_drvdata(pdev);
 
 	devm_free_irq(&pdev->dev, pdev->irq, chip);
-	pci_save_state(pdev);
-	pci_disable_device(pdev);
-	if (state.event & PM_EVENT_SLEEP)
-		pci_set_power_state(pdev, PCI_D3hot);
 	return 0;
 }
 
-static int cb710_resume(struct pci_dev *pdev)
+static int __maybe_unused cb710_resume(struct device *dev_d)
 {
+	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct cb710_chip *chip = pci_get_drvdata(pdev);
-	int err;
-
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-	err = pcim_enable_device(pdev);
-	if (err)
-		return err;
 
 	return devm_request_irq(&pdev->dev, pdev->irq,
 		cb710_irq_handler, IRQF_SHARED, KBUILD_MODNAME, chip);
 }
 
-#endif /* CONFIG_PM */
-
 static int cb710_probe(struct pci_dev *pdev,
 	const struct pci_device_id *ent)
 {
@@ -312,15 +299,14 @@ static const struct pci_device_id cb710_pci_tbl[] = {
 	{ 0, }
 };
 
+static SIMPLE_DEV_PM_OPS(cb710_pm_ops, cb710_suspend, cb710_resume);
+
 static struct pci_driver cb710_driver = {
 	.name = KBUILD_MODNAME,
 	.id_table = cb710_pci_tbl,
 	.probe = cb710_probe,
 	.remove = cb710_remove_one,
-#ifdef CONFIG_PM
-	.suspend = cb710_suspend,
-	.resume = cb710_resume,
-#endif
+	.driver.pm = &cb710_pm_ops,
 };
 
 static int __init cb710_init_module(void)
-- 
2.27.0

