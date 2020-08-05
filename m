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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EADC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58F8822CA0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrpYJEVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728937AbgHESW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 14:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbgHESLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 14:11:16 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC79FC0617AB;
        Wed,  5 Aug 2020 11:10:22 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z5so24937925pgb.6;
        Wed, 05 Aug 2020 11:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oVv4Wzhn3JTwGtZviwAnr4HC2ws5LBgl7lYKjJuNKZY=;
        b=BrpYJEVk8N/XVlt4jsasznf003BTu7lhnJ1yz6JbHpFcdbh0Jgwy5vrSZZzMMpXNuG
         rOCr8SOkoAUK5ZMGdgz4COUznIrU9pfS1GFtceCstYb8ZmuWiqwS9T01VCXsRcny3SD0
         8SK+j9Lv9xT4IBuOUEiGFY9p2ilme1znS6pOMaj//glr5nnDJI8CJUmOFiFQD0f7NoRF
         5Q7c1ON8o7dzq+Dq8i6ssclH+jsM/2vInABBoozfXimoPjvFEv1eGrBXTITf3ANqucbK
         e8MtS3enVGZa5I4TOXD50C2ibKk8cBoPjYGBQLEZSATPyhJDUErPbVmNDHEqOEa4M05x
         WhgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oVv4Wzhn3JTwGtZviwAnr4HC2ws5LBgl7lYKjJuNKZY=;
        b=WDKjX9J8hXytZZqjWaaYy9pvHueZmjCdY3+fA0hWVTr2OFAYnM8jDdIae5aOFj/M0Y
         POer1aqWnDtkrD2CSfS6df1LD37sT04INsRta0RqIVvN6cMKKlbQ+9m6rmYGjL75TpEB
         RCQMEFe76SBcyF9EYtRv0UVGZA9Zq3EixGik8HKz04WXVbab0xHdCkaTyYaLIErVeAyB
         5zBC+0p+PFQrGv58O/UuIUIdHctG2+EdaRbpBhuR8JlTapE5Phi0UauPF5haTWzjAkBN
         okJDDyM2afgbL4CEzUhHOeJumOszIw6wW1gHLCdUE/bUjDRmZmGs5MF9cDjHqX7+BWqJ
         N2lA==
X-Gm-Message-State: AOAM533DC2vPlFc/Dso1Py68HDwke9NwsmhqVrp+3COOauZce07Od1Rq
        s1ZHH2Teoo8FuWcEPzcRS1w=
X-Google-Smtp-Source: ABdhPJwDZAcI2ajtEzbJOnXXP2LJhU/UuVb3xTgiB80quyQR0y4N5pspuNUgpRuAZpoI77zZkWfobg==
X-Received: by 2002:a65:524b:: with SMTP id q11mr4075709pgp.372.1596651022278;
        Wed, 05 Aug 2020 11:10:22 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id t63sm4977510pfb.210.2020.08.05.11.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 11:10:21 -0700 (PDT)
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
Subject: [PATCH v1 10/12] fbdev: vt8623fb: use generic power management
Date:   Wed,  5 Aug 2020 23:37:20 +0530
Message-Id: <20200805180722.244008-11-vaibhavgupta40@gmail.com>
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
 drivers/video/fbdev/vt8623fb.c | 41 ++++++++++++++--------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/video/fbdev/vt8623fb.c b/drivers/video/fbdev/vt8623fb.c
index 7b3eef1b893f..c488e0117758 100644
--- a/drivers/video/fbdev/vt8623fb.c
+++ b/drivers/video/fbdev/vt8623fb.c
@@ -815,12 +815,11 @@ static void vt8623_pci_remove(struct pci_dev *dev)
 }
 
 
-#ifdef CONFIG_PM
 /* PCI suspend */
 
-static int vt8623_pci_suspend(struct pci_dev* dev, pm_message_t state)
+static int __maybe_unused vt8623_pci_suspend(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(dev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct vt8623fb_info *par = info->par;
 
 	dev_info(info->device, "suspend\n");
@@ -828,7 +827,7 @@ static int vt8623_pci_suspend(struct pci_dev* dev, pm_message_t state)
 	console_lock();
 	mutex_lock(&(par->open_lock));
 
-	if ((state.event == PM_EVENT_FREEZE) || (par->ref_count == 0)) {
+	if (par->ref_count == 0) {
 		mutex_unlock(&(par->open_lock));
 		console_unlock();
 		return 0;
@@ -836,10 +835,6 @@ static int vt8623_pci_suspend(struct pci_dev* dev, pm_message_t state)
 
 	fb_set_suspend(info, 1);
 
-	pci_save_state(dev);
-	pci_disable_device(dev);
-	pci_set_power_state(dev, pci_choose_state(dev, state));
-
 	mutex_unlock(&(par->open_lock));
 	console_unlock();
 
@@ -849,9 +844,9 @@ static int vt8623_pci_suspend(struct pci_dev* dev, pm_message_t state)
 
 /* PCI resume */
 
-static int vt8623_pci_resume(struct pci_dev* dev)
+static int __maybe_unused vt8623_pci_resume(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(dev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct vt8623fb_info *par = info->par;
 
 	dev_info(info->device, "resume\n");
@@ -862,14 +857,6 @@ static int vt8623_pci_resume(struct pci_dev* dev)
 	if (par->ref_count == 0)
 		goto fail;
 
-	pci_set_power_state(dev, PCI_D0);
-	pci_restore_state(dev);
-
-	if (pci_enable_device(dev))
-		goto fail;
-
-	pci_set_master(dev);
-
 	vt8623fb_set_par(info);
 	fb_set_suspend(info, 0);
 
@@ -879,10 +866,17 @@ static int vt8623_pci_resume(struct pci_dev* dev)
 
 	return 0;
 }
-#else
-#define vt8623_pci_suspend NULL
-#define vt8623_pci_resume NULL
-#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops vt8623_pci_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend	= vt8623_pci_suspend,
+	.resume		= vt8623_pci_resume,
+	.freeze		= NULL,
+	.thaw		= vt8623_pci_resume,
+	.poweroff	= vt8623_pci_suspend,
+	.restore	= vt8623_pci_resume,
+#endif /* CONFIG_PM_SLEEP */
+};
 
 /* List of boards that we are trying to support */
 
@@ -898,8 +892,7 @@ static struct pci_driver vt8623fb_pci_driver = {
 	.id_table	= vt8623_devices,
 	.probe		= vt8623_pci_probe,
 	.remove		= vt8623_pci_remove,
-	.suspend	= vt8623_pci_suspend,
-	.resume		= vt8623_pci_resume,
+	.driver.pm	= &vt8623_pci_pm_ops,
 };
 
 /* Cleanup */
-- 
2.27.0

