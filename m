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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CED2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A69D22CBB
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:13:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVGNkW+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgHESNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 14:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729166AbgHESKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 14:10:06 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C83C0617A0;
        Wed,  5 Aug 2020 11:09:22 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so24946219pgf.0;
        Wed, 05 Aug 2020 11:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=goKFB3UsILeJxx7SbinyIOCk3WJ4RQXLgNSmHzEzFg0=;
        b=NVGNkW+ZXLtdHwLu46TZ/riLS/HvA74czJyfph8hFG9UnSG/U/gPT5WUjbdzrGJhjH
         280VZ6JK0j9dVEg6sHoi9vExunqfho41gWUFf/rNaCKzy5io8cEUg07QUkmeJPZ6yGNh
         nsJqM2SMAYmy8P1PI5BaRxwt9Wyrxk3Mj+v/mTQ45S/DkRqRz5UTWkc04tr4YdTOxCvZ
         zsPm5rB4PiU78uV8iZF5asrfAEIOwj9kFrbgkeZc/woz8R3bCy9c+lmgCFq5xGgL50GI
         eOiFYEM9fOJEcOwM5tjQj7DQSibKgPFfxAIIuQvlte1W6PYGjzSxUrmSMhwovZgGgKMZ
         9I+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=goKFB3UsILeJxx7SbinyIOCk3WJ4RQXLgNSmHzEzFg0=;
        b=aJhDNIfVvDx/0PTpngBLAccuq/Ug/3MVon8gDnww34asU1OY0Jkd024KZEwaZoerjY
         4tTdw5bL7apttO1Hn3nFI4Lwc5czwNi0ClgKDxdqNKRDuh+U1S96j41wtGSAvuMDzUkZ
         RbqKBSn7xL4yXhMGWRzenqYrDttYSw8MEloVbMOaLnhKMwbPBnIzL3VW6+W+oJKkAb+I
         dAY3zl99NCNVdxDH8JCuILrt+I5vqsnivuJioc0ThtzQLLTzOuLnHjFKBzn4iR5nwm7X
         pDeQicSYETA0e/nEz9PeK5vvxmzWGrBYkHR/PVJxDJ/afzJuTDeJ2hIQnBRXaNxrjvxh
         H8Ug==
X-Gm-Message-State: AOAM530m2sd6NjN/fmCI9M6M9oP0lmaDdGvxa/8bWHlDfmu3V+QyWPPe
        +S5gZhyHwtF7cB+6vJkNgG8=
X-Google-Smtp-Source: ABdhPJx3hE5uVNv4BONTmX+VDrTp/RXEW0dAcBn31h92ynjHWVIactZM+viyyXxL90OZNJ+NijpCKQ==
X-Received: by 2002:aa7:9341:: with SMTP id 1mr4609542pfn.40.1596650962166;
        Wed, 05 Aug 2020 11:09:22 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id t63sm4977510pfb.210.2020.08.05.11.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 11:09:21 -0700 (PDT)
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
Subject: [PATCH v1 01/12] fbdev: gxfb: use generic power management
Date:   Wed,  5 Aug 2020 23:37:11 +0530
Message-Id: <20200805180722.244008-2-vaibhavgupta40@gmail.com>
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
 drivers/video/fbdev/geode/gxfb.h       |  5 ----
 drivers/video/fbdev/geode/gxfb_core.c  | 36 ++++++++++++++------------
 drivers/video/fbdev/geode/suspend_gx.c |  4 ---
 3 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/video/fbdev/geode/gxfb.h b/drivers/video/fbdev/geode/gxfb.h
index d2e9c5c8e294..792c111c21e4 100644
--- a/drivers/video/fbdev/geode/gxfb.h
+++ b/drivers/video/fbdev/geode/gxfb.h
@@ -21,7 +21,6 @@ struct gxfb_par {
 	void __iomem *dc_regs;
 	void __iomem *vid_regs;
 	void __iomem *gp_regs;
-#ifdef CONFIG_PM
 	int powered_down;
 
 	/* register state, for power management functionality */
@@ -36,7 +35,6 @@ struct gxfb_par {
 	uint64_t fp[FP_REG_COUNT];
 
 	uint32_t pal[DC_PAL_COUNT];
-#endif
 };
 
 unsigned int gx_frame_buffer_size(void);
@@ -49,11 +47,8 @@ void gx_set_dclk_frequency(struct fb_info *info);
 void gx_configure_display(struct fb_info *info);
 int gx_blank_display(struct fb_info *info, int blank_mode);
 
-#ifdef CONFIG_PM
 int gx_powerdown(struct fb_info *info);
 int gx_powerup(struct fb_info *info);
-#endif
-
 
 /* Graphics Processor registers (table 6-23 from the data book) */
 enum gp_registers {
diff --git a/drivers/video/fbdev/geode/gxfb_core.c b/drivers/video/fbdev/geode/gxfb_core.c
index d38a148d4746..44089b331f91 100644
--- a/drivers/video/fbdev/geode/gxfb_core.c
+++ b/drivers/video/fbdev/geode/gxfb_core.c
@@ -322,17 +322,14 @@ static struct fb_info *gxfb_init_fbinfo(struct device *dev)
 	return info;
 }
 
-#ifdef CONFIG_PM
-static int gxfb_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused gxfb_suspend(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(pdev);
+	struct fb_info *info = dev_get_drvdata(dev);
 
-	if (state.event == PM_EVENT_SUSPEND) {
-		console_lock();
-		gx_powerdown(info);
-		fb_set_suspend(info, 1);
-		console_unlock();
-	}
+	console_lock();
+	gx_powerdown(info);
+	fb_set_suspend(info, 1);
+	console_unlock();
 
 	/* there's no point in setting PCI states; we emulate PCI, so
 	 * we don't end up getting power savings anyways */
@@ -340,9 +337,9 @@ static int gxfb_suspend(struct pci_dev *pdev, pm_message_t state)
 	return 0;
 }
 
-static int gxfb_resume(struct pci_dev *pdev)
+static int __maybe_unused gxfb_resume(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(pdev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	int ret;
 
 	console_lock();
@@ -356,7 +353,6 @@ static int gxfb_resume(struct pci_dev *pdev)
 	console_unlock();
 	return 0;
 }
-#endif
 
 static int gxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
@@ -467,15 +463,23 @@ static const struct pci_device_id gxfb_id_table[] = {
 
 MODULE_DEVICE_TABLE(pci, gxfb_id_table);
 
+static const struct dev_pm_ops gxfb_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend	= gxfb_suspend,
+	.resume		= gxfb_resume,
+	.freeze		= NULL,
+	.thaw		= gxfb_resume,
+	.poweroff	= NULL,
+	.restore	= gxfb_resume,
+#endif
+};
+
 static struct pci_driver gxfb_driver = {
 	.name		= "gxfb",
 	.id_table	= gxfb_id_table,
 	.probe		= gxfb_probe,
 	.remove		= gxfb_remove,
-#ifdef CONFIG_PM
-	.suspend	= gxfb_suspend,
-	.resume		= gxfb_resume,
-#endif
+	.driver.pm	= &gxfb_pm_ops,
 };
 
 #ifndef MODULE
diff --git a/drivers/video/fbdev/geode/suspend_gx.c b/drivers/video/fbdev/geode/suspend_gx.c
index 1110a527c35c..8c49d4e98772 100644
--- a/drivers/video/fbdev/geode/suspend_gx.c
+++ b/drivers/video/fbdev/geode/suspend_gx.c
@@ -11,8 +11,6 @@
 
 #include "gxfb.h"
 
-#ifdef CONFIG_PM
-
 static void gx_save_regs(struct gxfb_par *par)
 {
 	int i;
@@ -259,5 +257,3 @@ int gx_powerup(struct fb_info *info)
 	par->powered_down  = 0;
 	return 0;
 }
-
-#endif
-- 
2.27.0

