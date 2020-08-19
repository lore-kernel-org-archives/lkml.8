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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABCDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB468207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GBeCzwqs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgHSS7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbgHSS7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:59:38 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1824BC061757;
        Wed, 19 Aug 2020 11:59:38 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mw10so1542717pjb.2;
        Wed, 19 Aug 2020 11:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y37/kWCMTqf8s6gGg+tFqzxGakyiseEA9ztTG8nsWho=;
        b=GBeCzwqsj3ZeAG74990Ziv0CxhO+QUcVbRxtOQdnSuDF8Xd/VnUz5QxKLks73a+wlE
         I3OGimKyk9cSa/lBnn4kd1nyJRsjzY02fzxxQYbU3guQZlb4da/uEN+0w41Ot3pmLQm8
         hBEnNN6EeeE0ga+okEUo5FzQOg9mFkBHJX+7klIRlyRh10z8SsLYJjpcu/osxTH5hBw5
         tKkljVmCg4GRroOUVuylmDgLevEi7xkVHqpvx93iQ20yqvBVADCyrI8zp+FmzNDm4Ykw
         W8Gb8koZylQcLmDFo0FWKtI9AiD2HB1HZBEodXiRMyDWBhMMps8jWV7sGQc+Q4488DUx
         LNwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y37/kWCMTqf8s6gGg+tFqzxGakyiseEA9ztTG8nsWho=;
        b=LUL6wXU6FWRGb+sf+oMAHHaASMG2MrRtMw0JebahPaaIj52zn5Arf7L1KpzPJOMDP9
         Sv2iTanWjZmfksf3Fh60deK8fr7IQK6jw4Gd/aeww+XuwahNzzlN/fAv8KOSdg8ifucx
         RdjBrLIVVzk9zglZxsU5H7691cLlPp/3NU+oIf+QBjM5ZrYwoEbcHOuO2zlUtAS3jFtB
         lRU0nRm1M5YSJ1wO9erEZc4Y6UsC3/vLfUo6i6jlgY4jLWs+zM7kttyDHx6PfVgOBXth
         MhGzDi3mIvfq/5LJqVP/H2/3dzXGRjKecHssrkwCQ47Du4vbhCrZV0z2OfD5aIOejf25
         K+ow==
X-Gm-Message-State: AOAM5334qBPuqKWeHB7DD7Sa924MWC1c+WSsUu/NhSs+BhIm1q0QETAJ
        u+qVZYQFrPBQybq2ngJ6GV6td/IbHFub16e2
X-Google-Smtp-Source: ABdhPJy4l+YIe+ysFdNOKW6pXx+49Pe57xxd6fOaE3aQbos/QLIyW+ybtU24lNhwcVloGHIxkAaIpA==
X-Received: by 2002:a17:902:9307:: with SMTP id bc7mr367517plb.213.1597863577593;
        Wed, 19 Aug 2020 11:59:37 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id o134sm29149305pfg.200.2020.08.19.11.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 11:59:37 -0700 (PDT)
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
Subject: [PATCH v3 06/12] fbdev: nvidia: use generic power management
Date:   Thu, 20 Aug 2020 00:26:48 +0530
Message-Id: <20200819185654.151170-7-vaibhavgupta40@gmail.com>
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
- nvidiafb_suspend() had a "pm_message_t" type parameter as per legacy
  PCI PM framework that got deprecated in generic.
- Rename the callback as nvidiafb_suspend_late() and preserve the
  parameter.
- Define 3 new callbacks as:
        * nvidiafb_suspend()
        * nvidiafb_freeze()
        * nvidiafb_hibernate()
  which in turn call nvidiafb_suspend_late() by passing appropriate value
  for "pm_message_t" type parameter.
- Bind the callbacks in "struct dev_pm_ops" type variable
  "nvidiafb_pm_ops".

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
2.28.0

