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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252A6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF0F62080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:59:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZZ5T60t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgHJS7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 14:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgHJS7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:59:33 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6502C061756;
        Mon, 10 Aug 2020 11:59:33 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o13so5461349pgf.0;
        Mon, 10 Aug 2020 11:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7LL2LyOuD9BBiMNUCCPwJGjjmVKfT+kRnyt53U08dq8=;
        b=dZZ5T60tKK68ZrPUUOgfYhPYNT6E6QERQQUaIyjxHPTQOzlRjvqdvmUQA/7xq+1WbY
         gXGtSHaYELmBxPiZD/ppA/iHYCPpqsp3/rNo3v732JIG1ubwOWpOQ7fkfIojzD6Ll+ZR
         9pJdzs3bWrFs253Fruem9jY/3tzX6XN5Vf1KjvJBme0Rq0JRpIYDMgR3AnQ7tLLhIHPu
         I5DPWSej7OpE9HghJ7W8KrfeL5pNypjL4EtdTwC5Ta17kbw2go1iz/Faa5XahiKtl2OW
         09rXzdr1XVxLRhb30oFypNZi6ol3jbmIKk2OLzyNbmT3PG7xOPmkk6x0coi3jLlW0jWG
         nwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7LL2LyOuD9BBiMNUCCPwJGjjmVKfT+kRnyt53U08dq8=;
        b=unT5b5sd01u/VWkmxF9z3zf0P3KxA6HdscSYLS9FfZQEqXqvLkJq1C4V3Eq5y1r8gy
         zTpJ/c5GCgCPyOqniRFu1QKiJCLPvnGjVpSl2hmQ0Wv6p2M2HtuggkHxcplnMPfnqSvu
         dPAmDZimjh3/povqFoSwkJ2YAjqLCrAjku/cmKFuRX22JkMcIcVXXV+paLKPnCAy/fl/
         K5r/61Zmz1Sv63/HnttDSERhTDlo7dCOmIcxe4eWwaMXLiqUzHlZcnu22e9hMb3EdHB4
         DvGoDEYjkYwvTG2//PpadLuV8SEcqnBz9IYwOddFJxCh8YyN+OxEnajpkk9g7YAOOTrk
         TZkw==
X-Gm-Message-State: AOAM532v8xnzBXJGpDUl5P9hWZxG5xew4aldCcOcKYLY1GOx45eDvo1Y
        QqSti39Bh1rrYmmCgw08kJ0=
X-Google-Smtp-Source: ABdhPJwPvn+kvK/gns3Whv4sQsTiMduUlR4YiI00HOpf/zYlTeDDJAM8NpG5n2Gt4G5nrch27cWxLQ==
X-Received: by 2002:a63:d812:: with SMTP id b18mr11090977pgh.353.1597085973216;
        Mon, 10 Aug 2020 11:59:33 -0700 (PDT)
Received: from varodek.localdomain ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id f27sm22683547pfk.217.2020.08.10.11.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 11:59:32 -0700 (PDT)
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
Subject: [PATCH v2 02/12] fbdev: lxfb: use generic power management
Date:   Tue, 11 Aug 2020 00:27:13 +0530
Message-Id: <20200810185723.15540-3-vaibhavgupta40@gmail.com>
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

Although the lxfb driver does not have that extra load, we should switch to
the new generic framework by updating function signatures and define a
"struct dev_pm_ops" variable to bind PM callbacks so that we can remove
the legacy .suspend & .resume bindings. Additionally, this helps us to
remove the unnecessary call to lxfb_suspend() in the event of Freeze and
Hibernate, as the function does nothing in their case.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/video/fbdev/geode/lxfb.h      |  5 ----
 drivers/video/fbdev/geode/lxfb_core.c | 37 +++++++++++++++------------
 drivers/video/fbdev/geode/lxfb_ops.c  |  4 ---
 3 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/video/fbdev/geode/lxfb.h b/drivers/video/fbdev/geode/lxfb.h
index ef24bf6d49dc..d37b32dbcd68 100644
--- a/drivers/video/fbdev/geode/lxfb.h
+++ b/drivers/video/fbdev/geode/lxfb.h
@@ -29,7 +29,6 @@ struct lxfb_par {
 	void __iomem *gp_regs;
 	void __iomem *dc_regs;
 	void __iomem *vp_regs;
-#ifdef CONFIG_PM
 	int powered_down;
 
 	/* register state, for power mgmt functionality */
@@ -50,7 +49,6 @@ struct lxfb_par {
 	uint32_t hcoeff[DC_HFILT_COUNT * 2];
 	uint32_t vcoeff[DC_VFILT_COUNT];
 	uint32_t vp_coeff[VP_COEFF_SIZE / 4];
-#endif
 };
 
 static inline unsigned int lx_get_pitch(unsigned int xres, int bpp)
@@ -64,11 +62,8 @@ int lx_blank_display(struct fb_info *, int);
 void lx_set_palette_reg(struct fb_info *, unsigned int, unsigned int,
 			unsigned int, unsigned int);
 
-#ifdef CONFIG_PM
 int lx_powerdown(struct fb_info *info);
 int lx_powerup(struct fb_info *info);
-#endif
-
 
 /* Graphics Processor registers (table 6-29 from the data book) */
 enum gp_registers {
diff --git a/drivers/video/fbdev/geode/lxfb_core.c b/drivers/video/fbdev/geode/lxfb_core.c
index adc2d9c2395e..66c81262d18f 100644
--- a/drivers/video/fbdev/geode/lxfb_core.c
+++ b/drivers/video/fbdev/geode/lxfb_core.c
@@ -443,17 +443,14 @@ static struct fb_info *lxfb_init_fbinfo(struct device *dev)
 	return info;
 }
 
-#ifdef CONFIG_PM
-static int lxfb_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused lxfb_suspend(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(pdev);
+	struct fb_info *info = dev_get_drvdata(dev);
 
-	if (state.event == PM_EVENT_SUSPEND) {
-		console_lock();
-		lx_powerdown(info);
-		fb_set_suspend(info, 1);
-		console_unlock();
-	}
+	console_lock();
+	lx_powerdown(info);
+	fb_set_suspend(info, 1);
+	console_unlock();
 
 	/* there's no point in setting PCI states; we emulate PCI, so
 	 * we don't end up getting power savings anyways */
@@ -461,9 +458,9 @@ static int lxfb_suspend(struct pci_dev *pdev, pm_message_t state)
 	return 0;
 }
 
-static int lxfb_resume(struct pci_dev *pdev)
+static int __maybe_unused lxfb_resume(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(pdev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	int ret;
 
 	console_lock();
@@ -477,10 +474,6 @@ static int lxfb_resume(struct pci_dev *pdev)
 	console_unlock();
 	return 0;
 }
-#else
-#define lxfb_suspend NULL
-#define lxfb_resume NULL
-#endif
 
 static int lxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
@@ -600,13 +593,23 @@ static struct pci_device_id lxfb_id_table[] = {
 
 MODULE_DEVICE_TABLE(pci, lxfb_id_table);
 
+static const struct dev_pm_ops lxfb_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend	= lxfb_suspend,
+	.resume		= lxfb_resume,
+	.freeze		= NULL,
+	.thaw		= lxfb_resume,
+	.poweroff	= NULL,
+	.restore	= lxfb_resume,
+#endif
+};
+
 static struct pci_driver lxfb_driver = {
 	.name		= "lxfb",
 	.id_table	= lxfb_id_table,
 	.probe		= lxfb_probe,
 	.remove		= lxfb_remove,
-	.suspend	= lxfb_suspend,
-	.resume		= lxfb_resume,
+	.driver.pm	= &lxfb_pm_ops,
 };
 
 #ifndef MODULE
diff --git a/drivers/video/fbdev/geode/lxfb_ops.c b/drivers/video/fbdev/geode/lxfb_ops.c
index 5be8bc62844c..b3a041fce570 100644
--- a/drivers/video/fbdev/geode/lxfb_ops.c
+++ b/drivers/video/fbdev/geode/lxfb_ops.c
@@ -580,8 +580,6 @@ int lx_blank_display(struct fb_info *info, int blank_mode)
 	return 0;
 }
 
-#ifdef CONFIG_PM
-
 static void lx_save_regs(struct lxfb_par *par)
 {
 	uint32_t filt;
@@ -837,5 +835,3 @@ int lx_powerup(struct fb_info *info)
 	par->powered_down = 0;
 	return 0;
 }
-
-#endif
-- 
2.27.0

