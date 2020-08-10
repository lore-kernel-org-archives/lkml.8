Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372D0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13BB0207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KO+/AjBT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgHJTAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgHJTAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:00:13 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F13C061756;
        Mon, 10 Aug 2020 12:00:12 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id f5so1565289plr.9;
        Mon, 10 Aug 2020 12:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3mzrXpDqX5i6vQZwjLr9S3RbpzEaKALa8Egnl+iixcM=;
        b=KO+/AjBTIwJEYPClBBf++vl71rCcmJ6mVDRfCXBJWqjCIwlWBlZVjNwoLJDK0XKw0J
         KN1e/UyOXJAsM2VUeFpXLMM6ud22P/z6v/vYXN+O/LKJNGBk0AC3l3TrCiFw8SnHFVP4
         gt4CE3k7Nr6fBjXgtRPWoRJwEcxY2BW1c6b3pMvhoti86z0RlVEVUsvrnkIfuFuS8LmU
         KsoXacgTEcozPBXOnWR8DAo5Rp1vbsr0KhvWKeEEVJKceJUHj4bVB48DCjeILPxd6jvo
         GRIfTX7Sw0nNtnZ3Ji6MoDu0fbhjq20+lgDqGpNl/CNSxN9QBCnJ66NGElsHEFDpBZt2
         yUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3mzrXpDqX5i6vQZwjLr9S3RbpzEaKALa8Egnl+iixcM=;
        b=br38+rARLgBS1NT+5NYKzL9FFKhhVMfMFbpq49/YpkabZHQ3ujUiRS0lpNMchv9OS2
         1kS/rUvbI3dCM7SIXbIggQS/8vOgqQ4a4oGWwrVQ3MijPiDoqEXjOxGxnUGGj8OEMe7u
         O59Xc53iyNu1MP8X2BTbeY7irsx1TYOQnvoap+kg81RywzeENMLowJ6LMJRvYDF1SUmE
         XsJiI/WKvMgNyILXW1+wl796I8UjAAqpeoAq0dWbyLRRUGpPjIdule2DCPtk7lOA+GrW
         WcGL99RXIkE3Uqe4GzOQz4/GhpLrrc5m3cv2xMdn29N+Bv6ORKL9e3Y499OkX1dGkp3F
         E8uA==
X-Gm-Message-State: AOAM533SRGm5Zr/kRLeHo/CBahUgUC4vqNnDdNrCe7dOWHFwYFjE2kSh
        WikS6w1wluf80TyDj2rxxhw=
X-Google-Smtp-Source: ABdhPJw0ejL2XMFYue6TPVCj5nsTa/sv61cNxlaGSOGH2vUT0Pg61qnaVXZudCp2WQgRwKmPh13J1Q==
X-Received: by 2002:a17:90a:f98e:: with SMTP id cq14mr719824pjb.51.1597086012300;
        Mon, 10 Aug 2020 12:00:12 -0700 (PDT)
Received: from varodek.localdomain ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id f27sm22683547pfk.217.2020.08.10.12.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 12:00:11 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Paul Mackerras <paulus@samba.org>,
        Russell King <linux@armlinux.org.uk>,
        Andres Salomon <dilinger@queued.net>,
        Antonino Daplas <adaplas@gmail.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-geode@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v2 07/12] fbdev: savagefb: use generic power management
Date:   Tue, 11 Aug 2020 00:27:18 +0530
Message-Id: <20200810185723.15540-8-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200810185723.15540-1-vaibhavgupta40@gmail.com>
References: <20200810165458.GA292825@ravnborg.org>
 <20200810185723.15540-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers should do only device-specific jobs. But in general, drivers using
legacy PCI PM framework for .suspend()/.resume() have to manage many PCI
PM-related tasks themselves which can be done by PCI Core itself. This
brings extra load on the driver and it directly calls PCI helper functions
to handle them.

Switch to the new generic framework by updating function signatures and
define a "struct dev_pm_ops" variable to bind PM callbacks. Also, remove
unnecessary calls to the PCI Helper functions along with the legacy
.suspend & .resume bindings.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/video/fbdev/savage/savagefb_driver.c | 52 ++++++++++++--------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index 3c8ae87f0ea7..d6aae759e90f 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -2346,9 +2346,9 @@ static void savagefb_remove(struct pci_dev *dev)
 	}
 }
 
-static int savagefb_suspend(struct pci_dev *dev, pm_message_t mesg)
+static int savagefb_suspend_late(struct device *dev, pm_message_t mesg)
 {
-	struct fb_info *info = pci_get_drvdata(dev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct savagefb_par *par = info->par;
 
 	DBG("savagefb_suspend");
@@ -2356,7 +2356,7 @@ static int savagefb_suspend(struct pci_dev *dev, pm_message_t mesg)
 	if (mesg.event == PM_EVENT_PRETHAW)
 		mesg.event = PM_EVENT_FREEZE;
 	par->pm_state = mesg.event;
-	dev->dev.power.power_state = mesg;
+	dev->power.power_state = mesg;
 
 	/*
 	 * For PM_EVENT_FREEZE, do not power down so the console
@@ -2374,17 +2374,29 @@ static int savagefb_suspend(struct pci_dev *dev, pm_message_t mesg)
 	savagefb_blank(FB_BLANK_POWERDOWN, info);
 	savage_set_default_par(par, &par->save);
 	savage_disable_mmio(par);
-	pci_save_state(dev);
-	pci_disable_device(dev);
-	pci_set_power_state(dev, pci_choose_state(dev, mesg));
 	console_unlock();
 
 	return 0;
 }
 
-static int savagefb_resume(struct pci_dev* dev)
+static int __maybe_unused savagefb_suspend(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(dev);
+	return savagefb_suspend_late(dev, PMSG_SUSPEND);
+}
+
+static int __maybe_unused savagefb_hibernate(struct device *dev)
+{
+	return savagefb_suspend_late(dev, PMSG_HIBERNATE);
+}
+
+static int __maybe_unused savagefb_freeze(struct device *dev)
+{
+	return savagefb_suspend_late(dev, PMSG_FREEZE);
+}
+
+static int __maybe_unused savagefb_resume(struct device *dev)
+{
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct savagefb_par *par = info->par;
 	int cur_state = par->pm_state;
 
@@ -2396,20 +2408,11 @@ static int savagefb_resume(struct pci_dev* dev)
 	 * The adapter was not powered down coming back from a
 	 * PM_EVENT_FREEZE.
 	 */
-	if (cur_state == PM_EVENT_FREEZE) {
-		pci_set_power_state(dev, PCI_D0);
+	if (cur_state == PM_EVENT_FREEZE)
 		return 0;
-	}
 
 	console_lock();
 
-	pci_set_power_state(dev, PCI_D0);
-	pci_restore_state(dev);
-
-	if (pci_enable_device(dev))
-		DBG("err");
-
-	pci_set_master(dev);
 	savage_enable_mmio(par);
 	savage_init_hw(par);
 	savagefb_set_par(info);
@@ -2420,6 +2423,16 @@ static int savagefb_resume(struct pci_dev* dev)
 	return 0;
 }
 
+static const struct dev_pm_ops savagefb_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend	= savagefb_suspend,
+	.resume		= savagefb_resume,
+	.freeze		= savagefb_freeze,
+	.thaw		= savagefb_resume,
+	.poweroff	= savagefb_hibernate,
+	.restore	= savagefb_resume,
+#endif
+};
 
 static const struct pci_device_id savagefb_devices[] = {
 	{PCI_VENDOR_ID_S3, PCI_CHIP_SUPSAV_MX128,
@@ -2500,8 +2513,7 @@ static struct pci_driver savagefb_driver = {
 	.name =     "savagefb",
 	.id_table = savagefb_devices,
 	.probe =    savagefb_probe,
-	.suspend =  savagefb_suspend,
-	.resume =   savagefb_resume,
+	.driver.pm = &savagefb_pm_ops,
 	.remove =   savagefb_remove,
 };
 
-- 
2.27.0

