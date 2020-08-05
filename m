Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DD0C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1280A22CAD
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hf+eR422"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgHESYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 14:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbgHESLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 14:11:09 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D734C06174A;
        Wed,  5 Aug 2020 11:10:10 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u20so1247784pfn.0;
        Wed, 05 Aug 2020 11:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BIelC/rsG5LlfCfiRk2OK0We+ffRSIzCW8qbxQDXpBs=;
        b=hf+eR422jWMydn6U5vfGmRcr6WRiQRedOZ1+fXRaGmOLOA0QDcOVCKczD2IOQfnMUa
         DRWfaTJEcBBZ3Br/8mn3yAkuUoY6lTQbfumrxdiGRxYXQXH3M9O5gbsUxBp249ODISfq
         NlvL/NyyPy11GcV+dU8nAynEWgYDY6uVIWTk+VWVHvQNKmpXaAWghFjHScQ9N3e9Jcsb
         sNnUIGlLiKsdsk1WWudgPEkWLiPoclIlPbY9fS8f6r9RSypbRICuC616VoLB/YajcYod
         l+XoEN11YMvw7ZnVAspjvjN2UsRb8j2bnhYKn6wcbDM8Ji01zcPUbDDcwkJ6STajEBnJ
         QdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BIelC/rsG5LlfCfiRk2OK0We+ffRSIzCW8qbxQDXpBs=;
        b=PzwbWE4ac9ApM54nQtTfLzgtxK8/tQLgQGSaSGcp2Rthd9eHMYuXgs29WQZWM3dnuz
         fG66D3AUz8jI5Ppm66Efnf2b289Vf9cGgm86B4bCQG8KGDJS7ae8S8hiar5oa6ZTvTKb
         gpWmNX9sZdgBdLMA34r9TA7msSvKxRSaoD0lR2cbrrM5meGfcun21Wmrk9/7+COumN+5
         vtmzTk3cAL4wlqZFVzR4/oWQMboFeE+eAxYPNlTC+tKJXIUlpKFy5XhBXJKk8oFtIv8U
         LrbCQtmBB5JpgFF6/b3aEbcOkpOpzjhstsJ/43zK7NDPWZ7v6Z8e0Shnxrfk358plP0S
         ++3A==
X-Gm-Message-State: AOAM530BoyxqepzOqyYx0blHa9gIjxxv/HQlRI65LfMGltBRlT2keoTY
        iPjmGwfCoTBu5YVAwFtt4lk=
X-Google-Smtp-Source: ABdhPJyClIjD3Alxk47jczZytSJA88FVc00EHEWRuyu4K0qCudUE+Tf0WljQP/05ghRXsy+HixMFsw==
X-Received: by 2002:a63:6945:: with SMTP id e66mr3926452pgc.177.1596651010103;
        Wed, 05 Aug 2020 11:10:10 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id t63sm4977510pfb.210.2020.08.05.11.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 11:10:09 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Andres Salomon <dilinger@queued.net>,
        Antonino Daplas <adaplas@gmail.com>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-geode@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v1 08/12] fbdev: cyber2000fb: use generic power management
Date:   Wed,  5 Aug 2020 23:37:18 +0530
Message-Id: <20200805180722.244008-9-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200805180722.244008-1-vaibhavgupta40@gmail.com>
References: <20200805180722.244008-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers using legacy power management .suspen()/.resume() callbacks
have to manage PCI states and device's PM states themselves. They also
need to take care of standard configuration registers.

Switch to generic power management framework using a single
"struct dev_pm_ops" variable to take the unnecessary load from the driver.
This also avoids the need for the driver to directly call most of the PCI
helper functions and device power state control functions, as through
the generic framework PCI Core takes care of the necessary operations,
and drivers are required to do only device-specific jobs.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/video/fbdev/cyber2000fb.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
index 42d37bed518a..d45355b9a58c 100644
--- a/drivers/video/fbdev/cyber2000fb.c
+++ b/drivers/video/fbdev/cyber2000fb.c
@@ -1810,7 +1810,7 @@ static void cyberpro_pci_remove(struct pci_dev *dev)
 	}
 }
 
-static int cyberpro_pci_suspend(struct pci_dev *dev, pm_message_t state)
+static int __maybe_unused cyberpro_pci_suspend(struct device *dev)
 {
 	return 0;
 }
@@ -1818,9 +1818,9 @@ static int cyberpro_pci_suspend(struct pci_dev *dev, pm_message_t state)
 /*
  * Re-initialise the CyberPro hardware
  */
-static int cyberpro_pci_resume(struct pci_dev *dev)
+static int __maybe_unused cyberpro_pci_resume(struct device *dev)
 {
-	struct cfb_info *cfb = pci_get_drvdata(dev);
+	struct cfb_info *cfb = dev_get_drvdata(dev);
 
 	if (cfb) {
 		cyberpro_pci_enable_mmio(cfb);
@@ -1846,12 +1846,15 @@ static struct pci_device_id cyberpro_pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, cyberpro_pci_table);
 
+static SIMPLE_DEV_PM_OPS(cyberpro_pci_pm_ops,
+			 cyberpro_pci_suspend,
+			 cyberpro_pci_resume);
+
 static struct pci_driver cyberpro_driver = {
 	.name		= "CyberPro",
 	.probe		= cyberpro_pci_probe,
 	.remove		= cyberpro_pci_remove,
-	.suspend	= cyberpro_pci_suspend,
-	.resume		= cyberpro_pci_resume,
+	.driver.pm	= &cyberpro_pci_pm_ops,
 	.id_table	= cyberpro_pci_table
 };
 
-- 
2.27.0

