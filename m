Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25122C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 029A3208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBcnrI+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgHSS7P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgHSS7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:59:12 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A6DC061757;
        Wed, 19 Aug 2020 11:59:11 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u20so12153645pfn.0;
        Wed, 19 Aug 2020 11:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EueH97o6VIVtEIiLMj1CkjU5GKTUR/PQiOa7YU1wTr0=;
        b=NBcnrI+ILjh3jELjrGG+qDgvlGLTfpZWaAD8dfjOYKDeId+yC5B/nedpjjEDPs7MJt
         ibC4avtU4xcpmoE5ULoOcJAmmYq4qNB7MUEmgYPubcHq2yGCcKTDG+yTvrs6xY1+duLn
         MJoV/YDWfMQJJ8xM1MvvfzlICMUDpBWEKZyOkmSI0S6rGlGxJwU4BMhwzeeaBJLpAhWn
         Y/q7sMI+06WGFnSR1Jku2olJy2n4ROcztnPEXC78DSlVZPg1TDbD1jchPUnoa6BdHZR+
         S0WZ/lmNZ5AcpUf6QP4Im7SBijhLCA2/2VprKYFChPl+VrA5wp86Ko3I6BpmT9eL2O6M
         kGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EueH97o6VIVtEIiLMj1CkjU5GKTUR/PQiOa7YU1wTr0=;
        b=Mt3dr8zvL2rmIxofgRZbDf1Y+1vWuEjUYXYL2Y/HjHH4GXBe7nz2IGt3cynJ7uPTOX
         UKIzLPwEGvAXV36okEbwVRAOTG7STVK/re1G0qJttH7tQoO5UtuKbEs/hlS3d2EsKUXN
         TvaInNTxO4Ez5Mjvqhu93BjNtTH4luxjTppLT+67LebCf05PFQGkJ/1GGQG8umSKMV7r
         707CefXc88IeRQ9bEgvQMhutk8t6sgGs7peEjfif82JIJM0ZfljccxyCdEmcQDGfC/zU
         QRpNP5IF7iox7Qu/3igjPRdA8346EgGY4YrgblvMLaEo9cyqFt26L3YUrX5+gKumOTeD
         CmJA==
X-Gm-Message-State: AOAM530qhUK3eLbFtj00RFeXMzcVN2Na5Pu78D5trr03KpL7CUUFXTNF
        y+/BiGOsjvMFjy6yGd4liNk=
X-Google-Smtp-Source: ABdhPJzycF9YEJOQ5XOCi+2XKILR/b07UiFGPGDk2y6A/OtI9ObJBJksHh+9i+w9mHTz6yRi1btLzQ==
X-Received: by 2002:a63:de4e:: with SMTP id y14mr18144996pgi.106.1597863551453;
        Wed, 19 Aug 2020 11:59:11 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id o134sm29149305pfg.200.2020.08.19.11.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 11:59:11 -0700 (PDT)
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
Subject: [PATCH v3 02/12] fbdev: lxfb: use generic power management
Date:   Thu, 20 Aug 2020 00:26:44 +0530
Message-Id: <20200819185654.151170-3-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819185654.151170-1-vaibhavgupta40@gmail.com>
References: <20200819185654.151170-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to the new generic framework by updating function signatures and
define a "struct dev_pm_ops" variable to bind PM callbacks. This way we can
remove the legacy .suspend & .resume bindings from "lxfb_driver".

The lxfb_suspend() is designed to function only in the case of Suspend.
Thus, the code was kept inside "if (state.event == PM_EVENT_SUSPEND)"
container. This is because, in the legacy framework, this callback was
invoked even in the event of Freeze and Hibernate. Hence, added the load of
unnecessary function-calls.

The goal can be achieved by binding the callback with only
"lxfb_pm_ops.suspend" in the new framework. This also avoids the step of
checking "if (state.event == PM_EVENT_SUSPEND)" every time the callback is
invoked.

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
2.28.0

