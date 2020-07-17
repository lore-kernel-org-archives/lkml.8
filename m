Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87581C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FA9F21741
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7uBE6cD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgGQD7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgGQD64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:58:56 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0796C061755;
        Thu, 16 Jul 2020 20:58:56 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x8so4860958plm.10;
        Thu, 16 Jul 2020 20:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DRaWMxjlA+y9G9x8PTReSZmOggDcJdYbq3Dmt0Z1Wlg=;
        b=L7uBE6cDRVMj0gHPJGOHTDiheKAZMJIZrfqbe00VOVr73uD1dK32hSHLBzu75ld5A+
         Ai5h0vpfZWBpdF4SA7BpWBHNdDJdwXGXaH74ccr49lkrPvAjHPLRynhdvE264lupkpx0
         uOy4IgUC98Eea9OqYKG7WdHC3U25kORnT7fwiIbjHv6DMpYc9oHkzsiSv2xSoPV32QNW
         RCowtyc3gssZ40NB14OMin2AG3R5MK3JRGYAaUNeDoNrDyH62j/Mwb/uQ1zs9Sf01NaP
         sPebEiexTuE+hAmVvTA2+QZi+dJRN/FcXKpRY5VaWvxlmopInSontbSzsOF/Q+Cvpk1v
         2ClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DRaWMxjlA+y9G9x8PTReSZmOggDcJdYbq3Dmt0Z1Wlg=;
        b=aieHs8hFBdDJnJB0cjFLaMVPvVuEXx1fMbDn1b8jejNLDdf5+spyhQzEki+WZapFbm
         /T1ziD3HsMJh6/v228aB7rV4/t8OFUMIylu+Q6tciw4r2aEVXRCuNqYaeZOSGCI0YMSn
         l+PKXFbbXmAB6ZOS8B88GwzXf+LaPIh3YE0soNSBA8MTqdG6GD4XxKto5sdZnKdPubbR
         Lh055M/he0ThqO412pj92tZu3whvVkgVBsErseV65ZW3+vu+OZIJY9Uj6k8gl9ClSMk5
         PgKkeBuZLTbAEozUq5NidA25QydM7B+bUHPwKWV7G+u/G/8NhES4Kqd4m8RFaVT6fuDn
         aN5w==
X-Gm-Message-State: AOAM5307qo6liv1J0YKn7YXqymlkPE2eZbSsxI7a7jICr5QSPfAHXmCH
        hcIiDwbyJnNw3m43cA6i7BY=
X-Google-Smtp-Source: ABdhPJz9RWNqG7kqo+L+MFtbo2hzekR4x6yLSqYQDRE2NFenzzMNtalvwVlrAFC3Z8cmn2EAqPWygQ==
X-Received: by 2002:a17:90a:cc0f:: with SMTP id b15mr7949017pju.83.1594958336419;
        Thu, 16 Jul 2020 20:58:56 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id v11sm6227907pgs.22.2020.07.16.20.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 20:58:55 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 6/6] tw68: use generic power management
Date:   Fri, 17 Jul 2020 09:26:08 +0530
Message-Id: <20200717035608.97254-7-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717035608.97254-1-vaibhavgupta40@gmail.com>
References: <20200717035608.97254-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With legacy PM, drivers themselves were responsible for managing the
device's power states and takes care of register states.

After upgrading to the generic structure, PCI core will take care of
required tasks and drivers should do only device-specific operations.

The driver was invoking PCI helper functions like pci_save/restore_state()
which is not recommended.

Compile-Tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/media/pci/tw68/tw68-core.c | 30 +++++++++++-------------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/media/pci/tw68/tw68-core.c b/drivers/media/pci/tw68/tw68-core.c
index b45f3ffa3de5..065420b09250 100644
--- a/drivers/media/pci/tw68/tw68-core.c
+++ b/drivers/media/pci/tw68/tw68-core.c
@@ -359,10 +359,9 @@ static void tw68_finidev(struct pci_dev *pci_dev)
 	v4l2_device_unregister(&dev->v4l2_dev);
 }
 
-#ifdef CONFIG_PM
-
-static int tw68_suspend(struct pci_dev *pci_dev , pm_message_t state)
+static int __maybe_unused tw68_suspend(struct device *dev_d)
 {
+	struct pci_dev *pci_dev = to_pci_dev(dev_d);
 	struct v4l2_device *v4l2_dev = pci_get_drvdata(pci_dev);
 	struct tw68_dev *dev = container_of(v4l2_dev,
 				struct tw68_dev, v4l2_dev);
@@ -373,24 +372,19 @@ static int tw68_suspend(struct pci_dev *pci_dev , pm_message_t state)
 
 	synchronize_irq(pci_dev->irq);
 
-	pci_save_state(pci_dev);
-	pci_set_power_state(pci_dev, pci_choose_state(pci_dev, state));
 	vb2_discard_done(&dev->vidq);
 
 	return 0;
 }
 
-static int tw68_resume(struct pci_dev *pci_dev)
+static int __maybe_unused tw68_resume(struct device *dev_d)
 {
-	struct v4l2_device *v4l2_dev = pci_get_drvdata(pci_dev);
+	struct v4l2_device *v4l2_dev = dev_get_drvdata(dev_d);
 	struct tw68_dev *dev = container_of(v4l2_dev,
 					    struct tw68_dev, v4l2_dev);
 	struct tw68_buf *buf;
 	unsigned long flags;
 
-	pci_set_power_state(pci_dev, PCI_D0);
-	pci_restore_state(pci_dev);
-
 	/* Do things that are done in tw68_initdev ,
 		except of initializing memory structures.*/
 
@@ -408,19 +402,17 @@ static int tw68_resume(struct pci_dev *pci_dev)
 
 	return 0;
 }
-#endif
 
 /* ----------------------------------------------------------- */
 
+static SIMPLE_DEV_PM_OPS(tw68_pm_ops, tw68_suspend, tw68_resume);
+
 static struct pci_driver tw68_pci_driver = {
-	.name	  = "tw68",
-	.id_table = tw68_pci_tbl,
-	.probe	  = tw68_initdev,
-	.remove	  = tw68_finidev,
-#ifdef CONFIG_PM
-	.suspend  = tw68_suspend,
-	.resume   = tw68_resume
-#endif
+	.name	   = "tw68",
+	.id_table  = tw68_pci_tbl,
+	.probe	   = tw68_initdev,
+	.remove	   = tw68_finidev,
+	.driver.pm = &tw68_pm_ops,
 };
 
 module_pci_driver(tw68_pci_driver);
-- 
2.27.0

