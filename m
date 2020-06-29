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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C925C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2381D20720
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dlx0UwC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731262AbgF2VAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731216AbgF2TM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201CAC014A73
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:17:42 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id b92so7702562pjc.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rqvwsn3zKVSYtQI3W9Dp3plnfUTHaA+z2ZGTb8aVlbU=;
        b=Dlx0UwC3kYeJgxeEwQAj3b/6RGb5GbiAsuc7KMAmV2cD4pYManJXgnL7YtesPkh36B
         Kqp5iQI1OSR8AJ0hTIi0NOr5wTSYaEJwR0j+7BeklgBn5zBDCzXqA+2pwiJfPARqVRVh
         Nn8xqTdsGwWAwJ5lhIkvdDREPxW1VWlXbHBrtYj6N2LRGzs26tYOVD/xULhRjClRV0lF
         OxbXgKuqP8RnfSy26NLfYj/dVj2PrdaTIxIMpxO4aMT4kktpPpA/mqBV/B5MUIiKEXeQ
         jbgb2X8r19TOoiPVRoCRalAAu03ETaiqW77lghO3OkJxxJPeq1+W419gtSdyQLXtih1b
         T5gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rqvwsn3zKVSYtQI3W9Dp3plnfUTHaA+z2ZGTb8aVlbU=;
        b=hx2P5mv28a3O6VRjXgy/jOJsXO4fDIsCQwF6qFNozXhZX/frfPEoOS5ICmZKgwcz97
         4CcXZBAZNB09J5dkbC59jEytBQ7x5WOIr4dTT4PrZZ65HPPLxFMp7hUrBO8MtqM0PmeW
         aWFelpwllO5ijtC6W5enb+kLIjUQzHCy9o8NfQYMrJek2XjwKMRUGTJzE6TenjXwT+pf
         62P2OqOlFnF2iaXIH6V6iP1LbHbu8JaScWsxV2d4YU/EHA1vgvSSbsI1XWw2fXwMRV/b
         V0Fz+O9ZNhji7oVgBPfwfHhUJJbOEyegPO0g48StQwfUXCVyLkOWB/6TpsTm/zFuoC0Q
         JAXA==
X-Gm-Message-State: AOAM531aURV09kEQYW1ZSBR+SZaMrQJdGMlPNv4UmFZbUjTHvHtBSblm
        tARGHLPXJUYnZSSgBUfUyj4=
X-Google-Smtp-Source: ABdhPJx8PaH2DnmEhNBkeLM9D17iH5gA7L/GLMxi1RyXKTMPo6/qJ076tWUlqdFu6m7l/qvvhQDTMQ==
X-Received: by 2002:a17:90a:982:: with SMTP id 2mr823366pjo.34.1593418661628;
        Mon, 29 Jun 2020 01:17:41 -0700 (PDT)
Received: from varodek.localdomain ([106.210.40.90])
        by smtp.gmail.com with ESMTPSA id co1sm3345154pjb.34.2020.06.29.01.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 01:17:41 -0700 (PDT)
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
Subject: [PATCH v1 4/5] misc/phantom.c: use generic power management
Date:   Mon, 29 Jun 2020 13:45:30 +0530
Message-Id: <20200629081531.214734-5-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200629081531.214734-1-vaibhavgupta40@gmail.com>
References: <20200629081531.214734-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the support of generic PM callbacks, drivers no longer need to use
legacy .suspend() and .resume() in which they had to maintain PCI states
changes and device's power state themselves. All required operations are
done by PCI core.

Driver needs to do only device-specific operations.

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/misc/phantom.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/phantom.c b/drivers/misc/phantom.c
index 6a5ed0e25ff1..ce72e46a2e73 100644
--- a/drivers/misc/phantom.c
+++ b/drivers/misc/phantom.c
@@ -457,31 +457,26 @@ static void phantom_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
-#ifdef CONFIG_PM
-static int phantom_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused phantom_suspend(struct device *dev_d)
 {
-	struct phantom_device *dev = pci_get_drvdata(pdev);
+	struct phantom_device *dev = dev_get_drvdata(dev_d);
 
 	iowrite32(0, dev->caddr + PHN_IRQCTL);
 	ioread32(dev->caddr + PHN_IRQCTL); /* PCI posting */
 
-	synchronize_irq(pdev->irq);
+	synchronize_irq(to_pci_dev(dev_d)->irq);
 
 	return 0;
 }
 
-static int phantom_resume(struct pci_dev *pdev)
+static int __maybe_unused phantom_resume(struct device *dev_d)
 {
-	struct phantom_device *dev = pci_get_drvdata(pdev);
+	struct phantom_device *dev = dev_get_drvdata(dev_d);
 
 	iowrite32(0, dev->caddr + PHN_IRQCTL);
 
 	return 0;
 }
-#else
-#define phantom_suspend	NULL
-#define phantom_resume	NULL
-#endif
 
 static struct pci_device_id phantom_pci_tbl[] = {
 	{ .vendor = PCI_VENDOR_ID_PLX, .device = PCI_DEVICE_ID_PLX_9050,
@@ -491,13 +486,14 @@ static struct pci_device_id phantom_pci_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pci, phantom_pci_tbl);
 
+static SIMPLE_DEV_PM_OPS(phantom_pm_ops, phantom_suspend, phantom_resume);
+
 static struct pci_driver phantom_pci_driver = {
 	.name = "phantom",
 	.id_table = phantom_pci_tbl,
 	.probe = phantom_probe,
 	.remove = phantom_remove,
-	.suspend = phantom_suspend,
-	.resume = phantom_resume
+	.driver.pm = &phantom_pm_ops,
 };
 
 static CLASS_ATTR_STRING(version, 0444, PHANTOM_VERSION);
-- 
2.27.0

