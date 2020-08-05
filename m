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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2579C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEC4C22CA0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GooaC+Z/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbgHESXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 14:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729176AbgHESLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 14:11:09 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595ACC0617A9;
        Wed,  5 Aug 2020 11:09:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mw10so1056509pjb.2;
        Wed, 05 Aug 2020 11:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MGnCAdiaQS4lKXaU6CPlGVdYZqlXYf98yajQSydVzaY=;
        b=GooaC+Z/Sw51BwDbPFpNpXwlbG4AQ62EbZ7018uruKRN36yZ1iJ9IqmTmqMyx8zFh/
         YcgBT15dzPrtu7YWMy5QWQ3oLjABat8Ucgx9C8kx0LbrXNOKcGhMwdXg7HZbwYcWd9gm
         xb1aR+4ZZgdoIIJi9kSrnyn9/fSjkhLMeGDYWI9WKxqRzu4k2irQjc7WGQs/BZS+4agO
         cZ8ZSKy+GYM7fDIbbLfOhzFAe0ZtyacKCAmtX1uS/tH3rBLWu2nQfdJHqAcF6TjmiYVB
         qjUp1CtaErGkloLDzp3iDZ8azOKp2Xs5CrOrxIpirbNA3U/Wo+gPtrg4Ph/hfFrbH6d5
         3YqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MGnCAdiaQS4lKXaU6CPlGVdYZqlXYf98yajQSydVzaY=;
        b=C6MAXtebZ4v8cdBLVwsFHOV+slK98z4tr3f97t2tNDYi+JmrX7yaRBxGPvCVvYNCKd
         42qFd0/6cRoVVScGNbqfGl0wqTdRnpIlC4qffCkQjagrdR1hCbqNvHWziT54gPaJK8pO
         EUpYxCia5O57eOKbgM1HJobeWwgaCjGo13/Zl7nNLRdU5oMxXdli5O63nPxbRdP6FRIc
         suUFJYo0jmUhovq7uu9EzeTDDL6omQwNLfPLG8lM4LAm1WMu+1pD6/9iIdSxSU1AWd55
         IhYhXuZPaT+FTgN9YmSGf+vXktai7Ac8W1JxZVXk6N2LmXbi4WxWgz+Pi4j81DdWIZLF
         ExQQ==
X-Gm-Message-State: AOAM533pCJd9vPnF45Rzl4zuBa5nQc5knFUzR4irP16LvWhAHrR/wrh+
        VsVQiCwzN9Op8UBW4POta8c=
X-Google-Smtp-Source: ABdhPJwTLOvvBskyaMc51FE1majJByR7jO3rKr1iHORHuNjdrINFR+leYDEVFq8PYruaW+zKhoeO0A==
X-Received: by 2002:a17:90a:e986:: with SMTP id v6mr4767972pjy.88.1596650997864;
        Wed, 05 Aug 2020 11:09:57 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id t63sm4977510pfb.210.2020.08.05.11.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 11:09:57 -0700 (PDT)
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
Subject: [PATCH v1 06/12] fbdev: nvidia: use generic power management
Date:   Wed,  5 Aug 2020 23:37:16 +0530
Message-Id: <20200805180722.244008-7-vaibhavgupta40@gmail.com>
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
 drivers/video/fbdev/nvidia/nvidia.c | 64 ++++++++++++++++-------------
 1 file changed, 35 insertions(+), 29 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index c24de9107958..3a1a4330e0d3 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -1041,10 +1041,9 @@ static struct fb_ops nvidia_fb_ops = {
 	.fb_sync        = nvidiafb_sync,
 };
 
-#ifdef CONFIG_PM
-static int nvidiafb_suspend(struct pci_dev *dev, pm_message_t mesg)
+static int nvidiafb_suspend_late(struct device *dev, pm_message_t mesg)
 {
-	struct fb_info *info = pci_get_drvdata(dev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct nvidia_par *par = info->par;
 
 	if (mesg.event == PM_EVENT_PRETHAW)
@@ -1056,46 +1055,54 @@ static int nvidiafb_suspend(struct pci_dev *dev, pm_message_t mesg)
 		fb_set_suspend(info, 1);
 		nvidiafb_blank(FB_BLANK_POWERDOWN, info);
 		nvidia_write_regs(par, &par->SavedReg);
-		pci_save_state(dev);
-		pci_disable_device(dev);
-		pci_set_power_state(dev, pci_choose_state(dev, mesg));
 	}
-	dev->dev.power.power_state = mesg;
+	dev->power.power_state = mesg;
 
 	console_unlock();
 	return 0;
 }
 
-static int nvidiafb_resume(struct pci_dev *dev)
+static int __maybe_unused nvidiafb_suspend(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(dev);
-	struct nvidia_par *par = info->par;
+	return nvidiafb_suspend_late(dev, PMSG_SUSPEND);
+}
 
-	console_lock();
-	pci_set_power_state(dev, PCI_D0);
+static int __maybe_unused nvidiafb_hibernate(struct device *dev)
+{
+	return nvidiafb_suspend_late(dev, PMSG_HIBERNATE);
+}
 
-	if (par->pm_state != PM_EVENT_FREEZE) {
-		pci_restore_state(dev);
+static int __maybe_unused nvidiafb_freeze(struct device *dev)
+{
+	return nvidiafb_suspend_late(dev, PMSG_FREEZE);
+}
 
-		if (pci_enable_device(dev))
-			goto fail;
+static int __maybe_unused nvidiafb_resume(struct device *dev)
+{
+	struct fb_info *info = dev_get_drvdata(dev);
+	struct nvidia_par *par = info->par;
 
-		pci_set_master(dev);
-	}
+	console_lock();
 
 	par->pm_state = PM_EVENT_ON;
 	nvidiafb_set_par(info);
 	fb_set_suspend (info, 0);
 	nvidiafb_blank(FB_BLANK_UNBLANK, info);
 
-fail:
 	console_unlock();
 	return 0;
 }
-#else
-#define nvidiafb_suspend NULL
-#define nvidiafb_resume NULL
-#endif
+
+static const struct dev_pm_ops nvidiafb_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend	= nvidiafb_suspend,
+	.resume		= nvidiafb_resume,
+	.freeze		= nvidiafb_freeze,
+	.thaw		= nvidiafb_resume,
+	.poweroff	= nvidiafb_hibernate,
+	.restore	= nvidiafb_resume,
+#endif /* CONFIG_PM_SLEEP */
+};
 
 static int nvidia_set_fbinfo(struct fb_info *info)
 {
@@ -1496,12 +1503,11 @@ static int nvidiafb_setup(char *options)
 #endif				/* !MODULE */
 
 static struct pci_driver nvidiafb_driver = {
-	.name = "nvidiafb",
-	.id_table = nvidiafb_pci_tbl,
-	.probe    = nvidiafb_probe,
-	.suspend  = nvidiafb_suspend,
-	.resume   = nvidiafb_resume,
-	.remove   = nvidiafb_remove,
+	.name      = "nvidiafb",
+	.id_table  = nvidiafb_pci_tbl,
+	.probe     = nvidiafb_probe,
+	.driver.pm = &nvidiafb_pm_ops,
+	.remove    = nvidiafb_remove,
 };
 
 /* ------------------------------------------------------------------------- *
-- 
2.27.0

