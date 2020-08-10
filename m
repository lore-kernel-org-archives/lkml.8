Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF8BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 788E920782
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Juf/h3g2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgHJTAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgHJTAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:00:35 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB1CC061756;
        Mon, 10 Aug 2020 12:00:35 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g19so5544350plq.0;
        Mon, 10 Aug 2020 12:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qwdaUknL4rdvB5HTQUho7uy432BpLxYt1hCirGV4hmw=;
        b=Juf/h3g26+XnrEKNZVz5n2n2pGUKaCW5O6qMuYdXpvdf23cJyXEckJMPEt+gpWketC
         rDn/Hxe/6IQYtsEILl9PY+Jr5goiPi8e9ku73qjjWiorN9MFfbja/CIPoEDSFIapfuqf
         wD/c6i3A0ZL0IFLwRgmLXAYm+507s7O4STHpWEbbD6hCwmgkEszEWlrx/c0qkgBOXilT
         Gnf16CtVgclX54qUUdDuhkrHrCktTBchID8s8WVIygrYCEZtQ9m2j2GgApQAqqUERgwS
         R+I4Mxb85zRfSv47BJ8LJ3gSUVlS5/pubJGO5qzwa/CPCob1uiyoUbYi/36v5/SwaSUX
         +1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qwdaUknL4rdvB5HTQUho7uy432BpLxYt1hCirGV4hmw=;
        b=MGCya9PKnreg8FLEIxmP1Cqlzjla3Vt3jDjx5JJY7wbMbZQo5X/N5QNrknJHlUK2lO
         3FvgxsA1f+rSuz/0Gd6kCZMOubDxk0K4x1ypBBGap7Gxtt0wY1mR/uoazJr8W5N/w44p
         wqHxd8ERzTrQc0d0N70vZyN0g8BFNPkrN1ie3RPDmWN/GrMavHm9qIlFqSk7bgPUcM1X
         GBbKK2NDhwRqrBiBqChwWfI/N/6IQaJWmpfXyazUav6kNDGGQXkjmJcv15hH45jA+5Sm
         6xD1YtceQjO6WP+KaujRyl7KeWUvZ8/V2zzY6Y4xUd/ZXq0fqL1KylVjf+gTVBzRg1bv
         Wuwg==
X-Gm-Message-State: AOAM532UFvFugf43cpn9aD8uwdNzMniiizaYXJBKmFwHgWyYTPdjsYD4
        T8R3t4nxn/pZS4v3oiKNjDA=
X-Google-Smtp-Source: ABdhPJxUZto4jhAY9RUX8TuzBPuP1R5uRzCd/R3dOVFRaOOdjRibdkKzuIEL8aM1uQvu+sRJ5sDbAg==
X-Received: by 2002:a17:90b:23c8:: with SMTP id md8mr771000pjb.176.1597086034896;
        Mon, 10 Aug 2020 12:00:34 -0700 (PDT)
Received: from varodek.localdomain ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id f27sm22683547pfk.217.2020.08.10.12.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 12:00:34 -0700 (PDT)
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
Subject: [PATCH v2 10/12] fbdev: vt8623fb: use generic power management
Date:   Tue, 11 Aug 2020 00:27:21 +0530
Message-Id: <20200810185723.15540-11-vaibhavgupta40@gmail.com>
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
 drivers/video/fbdev/vt8623fb.c | 41 ++++++++++++++--------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/video/fbdev/vt8623fb.c b/drivers/video/fbdev/vt8623fb.c
index 7b3eef1b893f..c488e0117758 100644
--- a/drivers/video/fbdev/vt8623fb.c
+++ b/drivers/video/fbdev/vt8623fb.c
@@ -815,12 +815,11 @@ static void vt8623_pci_remove(struct pci_dev *dev)
 }
 
 
-#ifdef CONFIG_PM
 /* PCI suspend */
 
-static int vt8623_pci_suspend(struct pci_dev* dev, pm_message_t state)
+static int __maybe_unused vt8623_pci_suspend(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(dev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct vt8623fb_info *par = info->par;
 
 	dev_info(info->device, "suspend\n");
@@ -828,7 +827,7 @@ static int vt8623_pci_suspend(struct pci_dev* dev, pm_message_t state)
 	console_lock();
 	mutex_lock(&(par->open_lock));
 
-	if ((state.event == PM_EVENT_FREEZE) || (par->ref_count == 0)) {
+	if (par->ref_count == 0) {
 		mutex_unlock(&(par->open_lock));
 		console_unlock();
 		return 0;
@@ -836,10 +835,6 @@ static int vt8623_pci_suspend(struct pci_dev* dev, pm_message_t state)
 
 	fb_set_suspend(info, 1);
 
-	pci_save_state(dev);
-	pci_disable_device(dev);
-	pci_set_power_state(dev, pci_choose_state(dev, state));
-
 	mutex_unlock(&(par->open_lock));
 	console_unlock();
 
@@ -849,9 +844,9 @@ static int vt8623_pci_suspend(struct pci_dev* dev, pm_message_t state)
 
 /* PCI resume */
 
-static int vt8623_pci_resume(struct pci_dev* dev)
+static int __maybe_unused vt8623_pci_resume(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(dev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct vt8623fb_info *par = info->par;
 
 	dev_info(info->device, "resume\n");
@@ -862,14 +857,6 @@ static int vt8623_pci_resume(struct pci_dev* dev)
 	if (par->ref_count == 0)
 		goto fail;
 
-	pci_set_power_state(dev, PCI_D0);
-	pci_restore_state(dev);
-
-	if (pci_enable_device(dev))
-		goto fail;
-
-	pci_set_master(dev);
-
 	vt8623fb_set_par(info);
 	fb_set_suspend(info, 0);
 
@@ -879,10 +866,17 @@ static int vt8623_pci_resume(struct pci_dev* dev)
 
 	return 0;
 }
-#else
-#define vt8623_pci_suspend NULL
-#define vt8623_pci_resume NULL
-#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops vt8623_pci_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend	= vt8623_pci_suspend,
+	.resume		= vt8623_pci_resume,
+	.freeze		= NULL,
+	.thaw		= vt8623_pci_resume,
+	.poweroff	= vt8623_pci_suspend,
+	.restore	= vt8623_pci_resume,
+#endif /* CONFIG_PM_SLEEP */
+};
 
 /* List of boards that we are trying to support */
 
@@ -898,8 +892,7 @@ static struct pci_driver vt8623fb_pci_driver = {
 	.id_table	= vt8623_devices,
 	.probe		= vt8623_pci_probe,
 	.remove		= vt8623_pci_remove,
-	.suspend	= vt8623_pci_suspend,
-	.resume		= vt8623_pci_resume,
+	.driver.pm	= &vt8623_pci_pm_ops,
 };
 
 /* Cleanup */
-- 
2.27.0

