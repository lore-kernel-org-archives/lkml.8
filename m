Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C569C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E75320768
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/9XZbf8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgIGHEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgIGHEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:04:39 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38283C061573;
        Mon,  7 Sep 2020 00:04:39 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s2so6029684pjr.4;
        Mon, 07 Sep 2020 00:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=otRXxNiL4gSVNa6K+8BQSdss/DJNJyTyG/m0dhQQX4E=;
        b=d/9XZbf8zBLic3hhAGLncVNdyG0TwyTfynJpAld5tq79kmX0SOkdpmDyqAIBL30wlb
         aULzdbdV+lJvW3nEfzrmlVWkA4YIJSOLrTeUmi7aQQ+pkVLgEw7OqOud1NeumKrId6N1
         Ktk/DAsQYVBQBGoHTyk86gZhkQ2SV0/Mdws9Y01qnoAjNYevPWVql7n9do/M7CNK7bsS
         wELmhMdL4kmdkrd20bytyRPo/+a6+7Y/Q/uQ0Tydn7kRdbN1czFETmusI44MhYF8LVe9
         yPF8mMXcwIgwj8uZgI4wf02cvNF3JsfJBpcahHN9JslE2567YXvYEZDZ3UZkT51MoviL
         3hdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=otRXxNiL4gSVNa6K+8BQSdss/DJNJyTyG/m0dhQQX4E=;
        b=ZSnEoOzfWaWOMxkiGwaR4HdWTB1XlKIw/6iqq5pGZ8ivx61HGGotT9mEreUQb1CDGT
         Q4I8TxKBa10OQnts4s93eUuuugT5NSXbCXJaKysGaAHMuAlPifBmkdA8P6uqiuFMEnfB
         yuBAYFLTL2r16j6ae76qb2fEcxD5BHbYZGXDeEk3gTaFyzu8TbZ1ioXCPdU0ZbdBohSk
         ANWKgHVn6UhU+MoOkMRxi9Q5K/PzZsuQXc9wjyMvGIb9qLc7js+pcgibZWQz/YHXG8+G
         rncqT34QeieAeHZOyeZ5cxZpQgwH0LcrjlR/6SO0bXA7CwzQ5ms+0w3+pwM1roRmnejq
         5wDg==
X-Gm-Message-State: AOAM531KE5bRktysq5U+cTXzItscpoHm2lsyaAw27+dEMy5huIJDMd7g
        sA4c2ipZsvFr5Ry497ojgjE=
X-Google-Smtp-Source: ABdhPJziIj0PK6yoiJ5wRQoy70TbrlXD62vEEh0t/EONVWa+t0n3CsaU5tuooBUNzIBa8VXeI3MeXA==
X-Received: by 2002:a17:902:ac8b:b029:d0:89f4:6220 with SMTP id h11-20020a170902ac8bb02900d089f46220mr16867680plr.8.1599462278714;
        Mon, 07 Sep 2020 00:04:38 -0700 (PDT)
Received: from varodek.localdomain ([106.201.26.241])
        by smtp.gmail.com with ESMTPSA id 204sm6804733pfc.200.2020.09.07.00.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 00:04:38 -0700 (PDT)
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
Date:   Mon,  7 Sep 2020 12:32:21 +0530
Message-Id: <20200907070221.29938-3-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907070221.29938-1-vaibhavgupta40@gmail.com>
References: <20200907070221.29938-1-vaibhavgupta40@gmail.com>
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

