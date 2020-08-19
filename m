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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6023C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A70B207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlyEM40X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgHSTAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgHSTAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:00:15 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF84C061757;
        Wed, 19 Aug 2020 12:00:14 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 189so11198396pgg.13;
        Wed, 19 Aug 2020 12:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Gdix+uPKbEr2q1rAkmQ4/zXt/qoiwYZqyXTLXnmDDk=;
        b=XlyEM40XfAobLwrCnJxZ+PpEMMRq+xMolyrVrj2Tww7bjz1hZdQsPVecl2oXGO2qAP
         Q8Oq7jWKduW4VFOrONqraQQKRNouWLsvhjGuFErzhO9S5d5F2F/LoY+IivVJja8W2rVz
         G0H9ILJHMA16FuIjSL/G3o8gHb32786BH7x3EkMOnGeBgqiczEFCZTDuIt7Re78Zyo11
         dorsoAnyjfy+je/HYLmnVCi5njPmKRQa/icsPmDmqBYtF5I2TOYrIg4gQfkxUE2Eah8l
         +sM0imdXocGmRkbXfFZh4hyoamEY3SxoIce9Zk0IRNLN6x0XdYQgCr5VLk0+/xltYYtI
         OXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Gdix+uPKbEr2q1rAkmQ4/zXt/qoiwYZqyXTLXnmDDk=;
        b=B0eMigUuNQqWLxEQeOG+1Crz0EJ9YehmjLn2k39gidfdIn9cjMPnPXLr5JyETMId5n
         wLKpyo6Rt1AMm9/AgVXfaq/OL8eW7ATCl2BiAD+l2EfSmIBZND2AE2r8MWfSr7rYEfle
         P8/9Bv4sWR8pNJ6mrHhf5vRBtQEHqrV98Z0nf5tDNR5I1jxnmTJ2WvGjyRrcjP3LcYdR
         yFSqrUhOBsz1uzYcLuogzk6GeftjGO0JWFx4pa8EOSZvCnTnaZTIa8Fz7FOmNMGUjn9b
         8ozbGxhm3V1jQX7O+xu9CTgTaywiNuNXf7pzFjVjkcczZtXLQZhHhSVF8AUjvAP5ucfa
         6aIQ==
X-Gm-Message-State: AOAM533Ja2TJmbOfEA0Aj99GHQN2Lv6SwJKKwI0JlfSLrbjDamdJ0FYU
        buFpnZlVZKX8+fjckonnlaM=
X-Google-Smtp-Source: ABdhPJwNjXe8tcUGVq2N5g8hi4ZArg84gR7x1vh/f1D6Q037+6BQVLbl9UZX8Prk6wIYdvu218PL0A==
X-Received: by 2002:a63:1342:: with SMTP id 2mr17049990pgt.214.1597863614285;
        Wed, 19 Aug 2020 12:00:14 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id o134sm29149305pfg.200.2020.08.19.12.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 12:00:13 -0700 (PDT)
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
Subject: [PATCH v3 12/12] fbdev: arkfb: use generic power management
Date:   Thu, 20 Aug 2020 00:26:54 +0530
Message-Id: <20200819185654.151170-13-vaibhavgupta40@gmail.com>
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

The ark_pci_suspend() is not designed to function in the case of Freeze.
Thus, the code checked for "if (state.event == PM_EVENT_FREEZE....)". This
is because, in the legacy framework, this callback was invoked even in the
event of Freeze. Hence, added the load of unnecessary function-call.

The goal can be achieved by binding the callback with only ".suspend" and
".poweroff" in the "ark_pci_pm_ops" const variable. This also avoids the
step of checking "state.event == PM_EVENT_FREEZE" every time the callback
is invoked.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/video/fbdev/arkfb.c | 41 +++++++++++++++----------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
index 11ab9a153860..edf169d0816e 100644
--- a/drivers/video/fbdev/arkfb.c
+++ b/drivers/video/fbdev/arkfb.c
@@ -1085,12 +1085,11 @@ static void ark_pci_remove(struct pci_dev *dev)
 }
 
 
-#ifdef CONFIG_PM
 /* PCI suspend */
 
-static int ark_pci_suspend (struct pci_dev* dev, pm_message_t state)
+static int __maybe_unused ark_pci_suspend(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(dev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct arkfb_info *par = info->par;
 
 	dev_info(info->device, "suspend\n");
@@ -1098,7 +1097,7 @@ static int ark_pci_suspend (struct pci_dev* dev, pm_message_t state)
 	console_lock();
 	mutex_lock(&(par->open_lock));
 
-	if ((state.event == PM_EVENT_FREEZE) || (par->ref_count == 0)) {
+	if (par->ref_count == 0) {
 		mutex_unlock(&(par->open_lock));
 		console_unlock();
 		return 0;
@@ -1106,10 +1105,6 @@ static int ark_pci_suspend (struct pci_dev* dev, pm_message_t state)
 
 	fb_set_suspend(info, 1);
 
-	pci_save_state(dev);
-	pci_disable_device(dev);
-	pci_set_power_state(dev, pci_choose_state(dev, state));
-
 	mutex_unlock(&(par->open_lock));
 	console_unlock();
 
@@ -1119,9 +1114,9 @@ static int ark_pci_suspend (struct pci_dev* dev, pm_message_t state)
 
 /* PCI resume */
 
-static int ark_pci_resume (struct pci_dev* dev)
+static int __maybe_unused ark_pci_resume(struct device *dev)
 {
-	struct fb_info *info = pci_get_drvdata(dev);
+	struct fb_info *info = dev_get_drvdata(dev);
 	struct arkfb_info *par = info->par;
 
 	dev_info(info->device, "resume\n");
@@ -1132,14 +1127,6 @@ static int ark_pci_resume (struct pci_dev* dev)
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
 	arkfb_set_par(info);
 	fb_set_suspend(info, 0);
 
@@ -1148,10 +1135,17 @@ static int ark_pci_resume (struct pci_dev* dev)
 	console_unlock();
 	return 0;
 }
-#else
-#define ark_pci_suspend NULL
-#define ark_pci_resume NULL
-#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops ark_pci_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend	= ark_pci_suspend,
+	.resume		= ark_pci_resume,
+	.freeze		= NULL,
+	.thaw		= ark_pci_resume,
+	.poweroff	= ark_pci_suspend,
+	.restore	= ark_pci_resume,
+#endif
+};
 
 /* List of boards that we are trying to support */
 
@@ -1168,8 +1162,7 @@ static struct pci_driver arkfb_pci_driver = {
 	.id_table	= ark_devices,
 	.probe		= ark_pci_probe,
 	.remove		= ark_pci_remove,
-	.suspend	= ark_pci_suspend,
-	.resume		= ark_pci_resume,
+	.driver.pm	= &ark_pci_pm_ops,
 };
 
 /* Cleanup */
-- 
2.28.0

