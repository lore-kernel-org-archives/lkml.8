Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85030C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5891C2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSsPXgdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgHSS7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbgHSS7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:59:25 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E742C061383;
        Wed, 19 Aug 2020 11:59:25 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d22so12149191pfn.5;
        Wed, 19 Aug 2020 11:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6SwW9DvsaTVzEe8rYytiBA176ZEm49NeUyegN/TvZxk=;
        b=YSsPXgdbsE6HMZQBWbvHa516SeqorDSP49+EHMEd67zIXPQeYtQtmOAjF56GHZ4ENC
         Xes44b5QftvrU0bHvqmBY/RJBqIT/mqJOJMuwq5oR550n1Dt39WkwKAtb56Jp/BNpapU
         n5xcaM+eXqCMXR11855GweHH4jxNv8qQVFzY8PxtYAY32anTsYLwg42iteXgiQv3cVoH
         jyaR9706HrP9cwbBlREmMl7vs9xrggzmsyU2mJgfjvc/r1XVeumsdfG61K8EDi+P9Vx0
         xOhdUfcyDgzEOOsSKCza8JUml+9+kIoZ2cc/CG4h5ByYWhQfiFmQ0so34lSoaOfYBJV1
         kbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6SwW9DvsaTVzEe8rYytiBA176ZEm49NeUyegN/TvZxk=;
        b=lHOrWcdOh/uzZJ90aKi+Yf1Y5/bdDZzDRE1yqtRL56AatqK2Y7HdPqwXoWNS7Wi8lZ
         nZ6iV0/Nc/ScPKjs7jLjM3VuL3KibT1f52sYxon1IRvQArnnYfoCLXztwCqBpgdIsHxR
         16H+J2rriqM8O4ydhTRQOkgsd/zdA4kiFoq3adplIMMjv3nnMM8QtbWenqCUtPd1Xdav
         wFi9SfAV3ZKiNyDx9a2ln6+Ztv+0Yqo2/4H8nz1e5ErK5U92x4fpXjSMWjCI8n76TP8c
         sYc9dSBKzZo2s8OeZ+GETmdwr2K1+SaW2AToTvW/TOozi8xW2FhPPRA96nndFLNftwK1
         xx6g==
X-Gm-Message-State: AOAM532/8rSaQqMtEqkBr1Fg7gd9grpylW7bPSddUp0XpQW6kP/y5aY3
        P12uhvms89Bf/TMlgorcn+0=
X-Google-Smtp-Source: ABdhPJzlZoB9mX9uX/0f4umZ3wploRhwn9d7X9NR1Pk93n4y87Cd9Zl8KupRYvEiMnjWyJTmoxrHHQ==
X-Received: by 2002:aa7:8757:: with SMTP id g23mr20042724pfo.283.1597863564965;
        Wed, 19 Aug 2020 11:59:24 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id o134sm29149305pfg.200.2020.08.19.11.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 11:59:24 -0700 (PDT)
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
Subject: [PATCH v3 04/12] fbdev: aty: use generic power management
Date:   Thu, 20 Aug 2020 00:26:46 +0530
Message-Id: <20200819185654.151170-5-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819185654.151170-1-vaibhavgupta40@gmail.com>
References: <20200819185654.151170-1-vaibhavgupta40@gmail.com>
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

Now,
- atyfb_pci_suspend() had a "pm_message_t" type parameter as per legacy
  PCI PM framework, that got deprecated in generic.
- Rename the callback as atyfb_pci_suspend_late() and preserve the
  parameter.
- Define 3 new callbacks as:
        * atyfb_pci_suspend()
        * atyfb_pci_freeze()
        * atyfb_pci_hibernate()
  which in turn call atyfb_pci_suspend_late() by passing appropriate
  value for "pm_message_t" type parameter.
- Bind the callbacks in "struct dev_pm_ops" type variable
  "atyfb_pci_pm_ops".

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/video/fbdev/aty/atyfb_base.c | 50 ++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index b0ac895e5ac9..a24d5bf6ade1 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -132,8 +132,8 @@
 #define PRINTKI(fmt, args...)	printk(KERN_INFO "atyfb: " fmt, ## args)
 #define PRINTKE(fmt, args...)	printk(KERN_ERR "atyfb: " fmt, ## args)
 
-#if defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || \
-defined (CONFIG_FB_ATY_GENERIC_LCD) || defined(CONFIG_FB_ATY_BACKLIGHT)
+#if defined(CONFIG_PMAC_BACKLIGHT) || defined(CONFIG_FB_ATY_GENERIC_LCD) || \
+defined(CONFIG_FB_ATY_BACKLIGHT)
 static const u32 lt_lcd_regs[] = {
 	CNFG_PANEL_LG,
 	LCD_GEN_CNTL_LG,
@@ -175,7 +175,7 @@ u32 aty_ld_lcd(int index, const struct atyfb_par *par)
 		return aty_ld_le32(LCD_DATA, par);
 	}
 }
-#endif /* defined(CONFIG_PM) || defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) */
+#endif /* defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) */
 
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
 /*
@@ -1994,7 +1994,7 @@ static int atyfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
 
 
 
-#if defined(CONFIG_PM) && defined(CONFIG_PCI)
+#if defined(CONFIG_PCI)
 
 #ifdef CONFIG_PPC_PMAC
 /* Power management routines. Those are used for PowerBook sleep.
@@ -2055,8 +2055,9 @@ static int aty_power_mgmt(int sleep, struct atyfb_par *par)
 }
 #endif /* CONFIG_PPC_PMAC */
 
-static int atyfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
+static int atyfb_pci_suspend_late(struct device *dev, pm_message_t state)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 
@@ -2082,7 +2083,6 @@ static int atyfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	 * first save the config space content so the core can
 	 * restore it properly on resume.
 	 */
-	pci_save_state(pdev);
 
 #ifdef CONFIG_PPC_PMAC
 	/* Set chip to "suspend" mode */
@@ -2094,8 +2094,6 @@ static int atyfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 		console_unlock();
 		return -EIO;
 	}
-#else
-	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 #endif
 
 	console_unlock();
@@ -2105,6 +2103,21 @@ static int atyfb_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	return 0;
 }
 
+static int __maybe_unused atyfb_pci_suspend(struct device *dev)
+{
+	return atyfb_pci_suspend_late(dev, PMSG_SUSPEND);
+}
+
+static int __maybe_unused atyfb_pci_hibernate(struct device *dev)
+{
+	return atyfb_pci_suspend_late(dev, PMSG_HIBERNATE);
+}
+
+static int __maybe_unused atyfb_pci_freeze(struct device *dev)
+{
+	return atyfb_pci_suspend_late(dev, PMSG_FREEZE);
+}
+
 static void aty_resume_chip(struct fb_info *info)
 {
 	struct atyfb_par *par = info->par;
@@ -2119,8 +2132,9 @@ static void aty_resume_chip(struct fb_info *info)
 			aty_ld_le32(BUS_CNTL, par) | BUS_APER_REG_DIS, par);
 }
 
-static int atyfb_pci_resume(struct pci_dev *pdev)
+static int __maybe_unused atyfb_pci_resume(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
 	struct fb_info *info = pci_get_drvdata(pdev);
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 
@@ -2162,7 +2176,18 @@ static int atyfb_pci_resume(struct pci_dev *pdev)
 	return 0;
 }
 
-#endif /*  defined(CONFIG_PM) && defined(CONFIG_PCI) */
+static const struct dev_pm_ops atyfb_pci_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend	= atyfb_pci_suspend,
+	.resume		= atyfb_pci_resume,
+	.freeze		= atyfb_pci_freeze,
+	.thaw		= atyfb_pci_resume,
+	.poweroff	= atyfb_pci_hibernate,
+	.restore	= atyfb_pci_resume,
+#endif /* CONFIG_PM_SLEEP */
+};
+
+#endif /*  defined(CONFIG_PCI) */
 
 /* Backlight */
 #ifdef CONFIG_FB_ATY_BACKLIGHT
@@ -3801,10 +3826,7 @@ static struct pci_driver atyfb_driver = {
 	.id_table	= atyfb_pci_tbl,
 	.probe		= atyfb_pci_probe,
 	.remove		= atyfb_pci_remove,
-#ifdef CONFIG_PM
-	.suspend	= atyfb_pci_suspend,
-	.resume		= atyfb_pci_resume,
-#endif /* CONFIG_PM */
+	.driver.pm	= &atyfb_pci_pm_ops,
 };
 
 #endif /* CONFIG_PCI */
-- 
2.28.0

