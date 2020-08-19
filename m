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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1142EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E04AC207DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:00:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPOdczkm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgHSTAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgHSTAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:00:09 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E23C061342;
        Wed, 19 Aug 2020 12:00:08 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f10so11259461plj.8;
        Wed, 19 Aug 2020 12:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XLfkemIewMnv6fWXsuoj50p89vkQ+fIdkZyVTqqSC0w=;
        b=NPOdczkm8lCaPc6hqEnbm8QT2k0i8mBDItJfr17oxdrZunK8ENFSzHEv5xVfidUNIW
         OGYdNBuVRARt7mJXqI17qIFiN9cWIVi81qrAlw/vJG5uvQ3F7dqO995Ht6gVR2pPiCRO
         P+LUHIR+gikF9BD2ZcOZdMZjZMtnQ2ho64gLApnObthVMxslDtsvrAOYL8BPlsVfpzTQ
         lQYbUGWLxU4ge5mmjlUoZIeeFP4540khThN3/5+2lC3IKQz/Fjbt1OGPhgPjTyCTB2h6
         E06FFPhYwUu/0p6gdqmVodpJjW5c1hBqnR1flrko5R54+pcTHV1SLiuCuUwks1eJ+d5s
         xgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XLfkemIewMnv6fWXsuoj50p89vkQ+fIdkZyVTqqSC0w=;
        b=TgpE8DXdZi71+znF6kb99DZFRENwZK8txRxpLlBiHkm3H2LXKP82DliEF3Hbx4EBsd
         HBbQJKCEJLvW9NgnRIlesaXAvtulnrIwySoX2TJwrqynbvBS/LFIys//+g9YH13Resqw
         HstKkGe/oVuvEeQStEzPwy1MgkxrhZFMv8+B2/NQ9GR2DITv8uHtCNuY/cbvzBJCmL3V
         y9yf7opmmwV3fWOggYOeYabpVK5xJJGr5HyyTrrEvZ9+wwuCzGx8R+wna+vMHOAUwYKC
         XifcnE7U/nDlIeyKcswTU6WAamZt97QHl92WG9hSxZBoEESXzdW9/U+EX1uyA9CobPQa
         Chwg==
X-Gm-Message-State: AOAM530XjbTMHeAj2Jj/xG/cP+lLhpPl7bOEyATd5WB9XIqU44DQRnbT
        I0dRIUuI+aapuYt8yhL1NGo=
X-Google-Smtp-Source: ABdhPJwUudB7IAaebcACVT0UwUwTEHj0ow63qmV1JZSDadWqM6xmOLbjCyJqGdDo7xDmGHtKh7qYLg==
X-Received: by 2002:a17:90a:9485:: with SMTP id s5mr1100437pjo.189.1597863608327;
        Wed, 19 Aug 2020 12:00:08 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id o134sm29149305pfg.200.2020.08.19.12.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 12:00:07 -0700 (PDT)
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
Subject: [PATCH v3 11/12] fbdev: s3fb: use generic power management
Date:   Thu, 20 Aug 2020 00:26:53 +0530
Message-Id: <20200819185654.151170-12-vaibhavgupta40@gmail.com>
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

The s3_pci_suspend() is not designed to function in the case of Freeze.
Thus, the code checked for "if (state.event == PM_EVENT_FREEZE....)". This
is because, in the legacy framework, this callback was invoked even in the
event of Freeze. Hence, added the load of unnecessary function-call.

The goal can be achieved by binding the callback with only ".suspend" and
".poweroff" in the "s3_pci_pm_ops" const variable. This also avoids the
step of checking "state.event == PM_EVENT_FREEZE" every time the callback
is invoked.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/video/fbdev/s3fb.c | 39 ++++++++++++++++----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/drivers/video/fbdev/s3fb.c b/drivers/video/fbdev/s3fb.c
index 60c424fae988..5c74253e7b2c 100644
--- a/drivers/video/fbdev/s3fb.c
+++ b/drivers/video/fbdev/s3fb.c
@@ -1410,9 +1410,9 @@ static void s3_pci_remove(struct pci_dev *dev)
 
 /* PCI suspend */
 
-static int s3_pci_suspend(struct pci_dev* dev, pm_message_t state)
+static int __maybe_unused s3_pci_suspend(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(dev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct s3fb_info *par = info->par;
 
 	dev_info(info->device, "suspend\n");
@@ -1420,7 +1420,7 @@ static int s3_pci_suspend(struct pci_dev* dev, pm_message_t state)
 	console_lock();
 	mutex_lock(&(par->open_lock));
 
-	if ((state.event == PM_EVENT_FREEZE) || (par->ref_count == 0)) {
+	if (par->ref_count == 0) {
 		mutex_unlock(&(par->open_lock));
 		console_unlock();
 		return 0;
@@ -1428,10 +1428,6 @@ static int s3_pci_suspend(struct pci_dev* dev, pm_message_t state)
 
 	fb_set_suspend(info, 1);
 
-	pci_save_state(dev);
-	pci_disable_device(dev);
-	pci_set_power_state(dev, pci_choose_state(dev, state));
-
 	mutex_unlock(&(par->open_lock));
 	console_unlock();
 
@@ -1441,11 +1437,10 @@ static int s3_pci_suspend(struct pci_dev* dev, pm_message_t state)
 
 /* PCI resume */
 
-static int s3_pci_resume(struct pci_dev* dev)
+static int __maybe_unused s3_pci_resume(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(dev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct s3fb_info *par = info->par;
-	int err;
 
 	dev_info(info->device, "resume\n");
 
@@ -1458,17 +1453,6 @@ static int s3_pci_resume(struct pci_dev* dev)
 		return 0;
 	}
 
-	pci_set_power_state(dev, PCI_D0);
-	pci_restore_state(dev);
-	err = pci_enable_device(dev);
-	if (err) {
-		mutex_unlock(&(par->open_lock));
-		console_unlock();
-		dev_err(info->device, "error %d enabling device for resume\n", err);
-		return err;
-	}
-	pci_set_master(dev);
-
 	s3fb_set_par(info);
 	fb_set_suspend(info, 0);
 
@@ -1478,6 +1462,16 @@ static int s3_pci_resume(struct pci_dev* dev)
 	return 0;
 }
 
+static const struct dev_pm_ops s3_pci_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend	= s3_pci_suspend,
+	.resume		= s3_pci_resume,
+	.freeze		= NULL,
+	.thaw		= s3_pci_resume,
+	.poweroff	= s3_pci_suspend,
+	.restore	= s3_pci_resume,
+#endif
+};
 
 /* List of boards that we are trying to support */
 
@@ -1510,8 +1504,7 @@ static struct pci_driver s3fb_pci_driver = {
 	.id_table	= s3_devices,
 	.probe		= s3_pci_probe,
 	.remove		= s3_pci_remove,
-	.suspend	= s3_pci_suspend,
-	.resume		= s3_pci_resume,
+	.driver.pm	= &s3_pci_pm_ops,
 };
 
 /* Parse user specified options */
-- 
2.28.0

