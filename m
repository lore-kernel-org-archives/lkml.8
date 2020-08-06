Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7174C38154
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A0B6204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCwl2xDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgHFH3J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 03:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbgHFH2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 03:28:54 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE43C061574;
        Thu,  6 Aug 2020 00:28:54 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t10so21719912plz.10;
        Thu, 06 Aug 2020 00:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=otRXxNiL4gSVNa6K+8BQSdss/DJNJyTyG/m0dhQQX4E=;
        b=OCwl2xDwvE1snTQ5bo+L1m2eYeuMLJAcfBA+IBsEjQA1yyteEZ5hUzzWYUYFSVs7yE
         gv135n4/e7GmIEGn47sKsk9WnNJbuZ+k3vITt26kDjAl1GLIjI3Jh9/7qWuXNXiBd30x
         aJWw5cjXnaS7Kt0AqQxYk0THyVlQruYmNozroghu8a0R+afmWWOW9tfpoKoKfqCN8W6f
         i+6cS6P5NhQwUQtP7SQaW7tou6klf4XncZYLp8DmdAq+EQklaNt7Zg073W60d+2c5bc1
         QMixkQAb4VlmD5hRMbPN71xHotttPfZ0oCIgX8NsVgvUcZSkv7Zjh5D0H3kHWsNCGe+F
         jiqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=otRXxNiL4gSVNa6K+8BQSdss/DJNJyTyG/m0dhQQX4E=;
        b=TDvn9lag5LJJU7joOjOcT4f4C9JKkrO3cBQhNs044rkFpEQt/73n2cReUheflAoJSV
         b9kRN57ldGnq4uIQ3rPdkP1Y+clz7XzHczKXlo9ZuOaB4Nfeq59qfRCpY7c0RFX1vKfZ
         WTAlqRszVDjPW69y51sUEfaP5Yi+pl5Tjp20ZnjAZyyffbQlCYzfBbW0OTS8EAVfVQft
         NEN5k10m4u1gYmv0OJsIAPpCSmSO7abdPEU0/yHg4bRZNHHFBFO/Sa7SZ12790/C5cAw
         wiw3mL1crcdYxeg6t0KDy0i3suvzRFy+Mm6GMlsupKGEllNZ5GTGNENgoCaYMaDnBsl0
         lilA==
X-Gm-Message-State: AOAM530z+r2YJpqW+eTJsp684RQxJM3kCNf1X/08IyUsTDndcpxdmBOD
        f5bs2WBo/Z79cswZFlb+uTE=
X-Google-Smtp-Source: ABdhPJxB33J8in6hVmRJzWA2XAc3HXbCnIXx134loDG2q0NXHME3BjsXKW01wmOFkf7S9wmJfTzxPg==
X-Received: by 2002:a17:902:9a94:: with SMTP id w20mr6975803plp.59.1596698933892;
        Thu, 06 Aug 2020 00:28:53 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id e125sm6654646pfh.69.2020.08.06.00.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 00:28:53 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v1 2/2] fbdev: radeonfb:use generic power management
Date:   Thu,  6 Aug 2020 12:56:58 +0530
Message-Id: <20200806072658.592444-3-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200806072658.592444-1-vaibhavgupta40@gmail.com>
References: <20200806072256.585705-1-vaibhavgupta40@gmail.com>
 <20200806072658.592444-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers using legacy PCI power management .suspend()/.resume() callbacks
have to manage PCI states and device's PM states themselves. They also
need to take care of standard configuration registers.

Switch to generic power management framework using a "struct dev_pm_ops"
variable to take the unnecessary load from the driver.
This also avoids the need for the driver to directly call most of the PCI
helper functions and device power state control functions, as through
the generic framework PCI Core takes care of the necessary operations,
and drivers are required to do only device-specific jobs.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/video/fbdev/aty/radeon_base.c | 10 +++++---
 drivers/video/fbdev/aty/radeon_pm.c   | 36 +++++++++++++++++++++------
 drivers/video/fbdev/aty/radeonfb.h    |  3 +--
 3 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index e116a3f9ad56..232dbe154666 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -2559,16 +2559,18 @@ static void radeonfb_pci_unregister(struct pci_dev *pdev)
         framebuffer_release(info);
 }
 
+#ifdef CONFIG_PM
+#define RADEONFB_PCI_PM_OPS (&radeonfb_pci_pm_ops)
+#else
+#define RADEONFB_PCI_PM_OPS NULL
+#endif
 
 static struct pci_driver radeonfb_driver = {
 	.name		= "radeonfb",
 	.id_table	= radeonfb_pci_table,
 	.probe		= radeonfb_pci_register,
 	.remove		= radeonfb_pci_unregister,
-#ifdef CONFIG_PM
-	.suspend       	= radeonfb_pci_suspend,
-	.resume		= radeonfb_pci_resume,
-#endif /* CONFIG_PM */
+	.driver.pm	= RADEONFB_PCI_PM_OPS,
 };
 
 #ifndef MODULE
diff --git a/drivers/video/fbdev/aty/radeon_pm.c b/drivers/video/fbdev/aty/radeon_pm.c
index b9af70bd656a..352d0bb4773a 100644
--- a/drivers/video/fbdev/aty/radeon_pm.c
+++ b/drivers/video/fbdev/aty/radeon_pm.c
@@ -2611,8 +2611,9 @@ static void radeon_set_suspend(struct radeonfb_info *rinfo, int suspend)
 	}
 }
 
-int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t mesg)
+static int radeonfb_pci_suspend_late(struct device *dev, pm_message_t mesg)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
         struct fb_info *info = pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo = info->par;
 
@@ -2660,11 +2661,6 @@ int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t mesg)
 	pmac_suspend_agp_for_card(pdev);
 #endif /* CONFIG_PPC_PMAC */
 
-	/* It's unclear whether or when the generic code will do that, so let's
-	 * do it ourselves. We save state before we do any power management
-	 */
-	pci_save_state(pdev);
-
 	/* If we support wakeup from poweroff, we save all regs we can including cfg
 	 * space
 	 */
@@ -2689,7 +2685,6 @@ int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t mesg)
 			msleep(20);
 			OUTREG(LVDS_GEN_CNTL, INREG(LVDS_GEN_CNTL) & ~(LVDS_DIGON));
 		}
-		pci_disable_device(pdev);
 	}
 	/* If we support D2, we go to it (should be fixed later with a flag forcing
 	 * D3 only for some laptops)
@@ -2705,6 +2700,21 @@ int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t mesg)
 	return 0;
 }
 
+static int radeonfb_pci_suspend(struct device *dev)
+{
+	return radeonfb_pci_suspend_late(dev, PMSG_SUSPEND);
+}
+
+static int radeonfb_pci_hibernate(struct device *dev)
+{
+	return radeonfb_pci_suspend_late(dev, PMSG_HIBERNATE);
+}
+
+static int radeonfb_pci_freeze(struct device *dev)
+{
+	return radeonfb_pci_suspend_late(dev, PMSG_FREEZE);
+}
+
 static int radeon_check_power_loss(struct radeonfb_info *rinfo)
 {
 	return rinfo->save_regs[4] != INPLL(CLK_PIN_CNTL) ||
@@ -2712,8 +2722,9 @@ static int radeon_check_power_loss(struct radeonfb_info *rinfo)
 	       rinfo->save_regs[3] != INPLL(SCLK_CNTL);
 }
 
-int radeonfb_pci_resume(struct pci_dev *pdev)
+static int radeonfb_pci_resume(struct device *dev)
 {
+	struct pci_dev *pdev = to_pci_dev(dev);
         struct fb_info *info = pci_get_drvdata(pdev);
         struct radeonfb_info *rinfo = info->par;
 	int rc = 0;
@@ -2795,6 +2806,15 @@ int radeonfb_pci_resume(struct pci_dev *pdev)
 	return rc;
 }
 
+const struct dev_pm_ops radeonfb_pci_pm_ops = {
+	.suspend	= radeonfb_pci_suspend,
+	.resume		= radeonfb_pci_resume,
+	.freeze		= radeonfb_pci_freeze,
+	.thaw		= radeonfb_pci_resume,
+	.poweroff	= radeonfb_pci_hibernate,
+	.restore	= radeonfb_pci_resume,
+};
+
 #ifdef CONFIG_PPC__disabled
 static void radeonfb_early_resume(void *data)
 {
diff --git a/drivers/video/fbdev/aty/radeonfb.h b/drivers/video/fbdev/aty/radeonfb.h
index 131b34dd65af..93f403cbb415 100644
--- a/drivers/video/fbdev/aty/radeonfb.h
+++ b/drivers/video/fbdev/aty/radeonfb.h
@@ -483,8 +483,7 @@ extern void radeon_delete_i2c_busses(struct radeonfb_info *rinfo);
 extern int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn, u8 **out_edid);
 
 /* PM Functions */
-extern int radeonfb_pci_suspend(struct pci_dev *pdev, pm_message_t state);
-extern int radeonfb_pci_resume(struct pci_dev *pdev);
+extern const struct dev_pm_ops radeonfb_pci_pm_ops;
 extern void radeonfb_pm_init(struct radeonfb_info *rinfo, int dynclk, int ignore_devlist, int force_sleep);
 extern void radeonfb_pm_exit(struct radeonfb_info *rinfo);
 
-- 
2.27.0

