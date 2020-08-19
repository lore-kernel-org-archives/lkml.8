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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D1BC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8259B207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRI53D3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgHSS7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgHSS7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:59:19 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2192C061757;
        Wed, 19 Aug 2020 11:59:18 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t6so1548615pjr.0;
        Wed, 19 Aug 2020 11:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5gu1L1DJx3HZoPEqXvBU7h0G5D/PQrdVvm6X6301gs8=;
        b=XRI53D3hmlnwd6aCroLhIz21NDdW0P2mVstADmsVDG+e0ejag70GGABL3/HXR5kaPQ
         6AgnJQHVfgwQH1Y4r19MSJUL92/LvoOfdo6XIWEyAjIiIx4qlUZRSJppQfsSoF+igE3k
         gaj9S8c+4AQbPaSGREm0duechoKwcUIa1XeBWR61Ey2hbIeQLP6i9yO+pdeYdxoA1GwW
         w1BcEHxHCslecf14xvl5tXlj+my9yEBz3hXxzN2AOP67thiCRGsYSSFFB8dYCCjsKbxm
         v3jyeM13isALOM349gQTJWR5B+c6+x/8lw85ecktWMCTFLc+J+orIRcxchE1CrNAdcbi
         tuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5gu1L1DJx3HZoPEqXvBU7h0G5D/PQrdVvm6X6301gs8=;
        b=c2IZotq1sKQgAXd1rO1wJNIOzu2uC8mV5ILNp8J2rOy3bTd6PQWVU/Dvcn3dWshLX4
         ftA2zbnblpZ0b9S8YavfdcrudDn+HcqPoPmggvGptpP2DgwNgYaWGX/ee3wAS85uiGb4
         +bv8qoFqJEBhEHJZiBd+SlO1DCg9+bFmdamcWOHxw4Nc7F/6n5Os9NaJItEwPKJZC2Y9
         Q7MZVNu0nFEaLu7qYqyutxJrhJURKG9GWF6HarmhPp1BKZovMHZzpHP2HByJlAJL6dcn
         ExSSAQ9IdDiI7u/WgSJIAVRG+bAJS/R7XsIo0dzsDZmNMaZobv6n9vhaYL0fgnj+ov0p
         6b1g==
X-Gm-Message-State: AOAM533TS/u+Sg8+xtB68NMX6iuzL/JLZM+gHb+tjBWOzU789j0jqvpT
        FrHjx9bsVW8aUia/s989qtk=
X-Google-Smtp-Source: ABdhPJzRMuPqM05NiCBiCDG5w1q8EIlZqgTaIxB3DmIfl9PFQS4Xr6+hIyQiWWSHjmx/62qPjMtQNA==
X-Received: by 2002:a17:90b:368c:: with SMTP id mj12mr4711893pjb.152.1597863558293;
        Wed, 19 Aug 2020 11:59:18 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id o134sm29149305pfg.200.2020.08.19.11.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 11:59:17 -0700 (PDT)
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
Subject: [PATCH v3 03/12] fbdev: via-core: use generic power management
Date:   Thu, 20 Aug 2020 00:26:45 +0530
Message-Id: <20200819185654.151170-4-vaibhavgupta40@gmail.com>
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
define a "struct dev_pm_ops" variable to bind PM callbacks.

The via_suspend() is designed to function only in the case of Suspend.
Thus, the code checked for "if (state.event != PM_EVENT_SUSPEND)". This is
because, in the legacy framework, this callback was invoked even in the
event of Freeze and Hibernate. Hence, added the load of unnecessary
function-calls.

The goal can be achieved by binding the callback with only
"via_pm_ops.suspend" in the new framework. This also avoids the step of
checking "if (state.event != PM_EVENT_SUSPEND)" every time the callback is
invoked.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/video/fbdev/via/via-core.c | 39 ++++++++++++------------------
 include/linux/via-core.h           |  2 --
 2 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/video/fbdev/via/via-core.c b/drivers/video/fbdev/via/via-core.c
index 703ddee9a244..89d75079b730 100644
--- a/drivers/video/fbdev/via/via-core.c
+++ b/drivers/video/fbdev/via/via-core.c
@@ -558,9 +558,8 @@ static void via_teardown_subdevs(void)
 /*
  * Power management functions
  */
-#ifdef CONFIG_PM
-static LIST_HEAD(viafb_pm_hooks);
-static DEFINE_MUTEX(viafb_pm_hooks_lock);
+static __maybe_unused LIST_HEAD(viafb_pm_hooks);
+static __maybe_unused DEFINE_MUTEX(viafb_pm_hooks_lock);
 
 void viafb_pm_register(struct viafb_pm_hooks *hooks)
 {
@@ -580,12 +579,10 @@ void viafb_pm_unregister(struct viafb_pm_hooks *hooks)
 }
 EXPORT_SYMBOL_GPL(viafb_pm_unregister);
 
-static int via_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused via_suspend(struct device *dev)
 {
 	struct viafb_pm_hooks *hooks;
 
-	if (state.event != PM_EVENT_SUSPEND)
-		return 0;
 	/*
 	 * "I've occasionally hit a few drivers that caused suspend
 	 * failures, and each and every time it was a driver bug, and
@@ -600,24 +597,13 @@ static int via_suspend(struct pci_dev *pdev, pm_message_t state)
 		hooks->suspend(hooks->private);
 	mutex_unlock(&viafb_pm_hooks_lock);
 
-	pci_save_state(pdev);
-	pci_disable_device(pdev);
-	pci_set_power_state(pdev, pci_choose_state(pdev, state));
 	return 0;
 }
 
-static int via_resume(struct pci_dev *pdev)
+static int __maybe_unused via_resume(struct device *dev)
 {
 	struct viafb_pm_hooks *hooks;
 
-	/* Get the bus side powered up */
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-	if (pci_enable_device(pdev))
-		return 0;
-
-	pci_set_master(pdev);
-
 	/* Now bring back any subdevs */
 	mutex_lock(&viafb_pm_hooks_lock);
 	list_for_each_entry(hooks, &viafb_pm_hooks, list)
@@ -626,7 +612,6 @@ static int via_resume(struct pci_dev *pdev)
 
 	return 0;
 }
-#endif /* CONFIG_PM */
 
 static int via_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
@@ -712,15 +697,23 @@ static const struct pci_device_id via_pci_table[] = {
 };
 MODULE_DEVICE_TABLE(pci, via_pci_table);
 
+static const struct dev_pm_ops via_pm_ops = {
+#ifdef CONFIG_PM_SLEEP
+	.suspend	= via_suspend,
+	.resume		= via_resume,
+	.freeze		= NULL,
+	.thaw		= via_resume,
+	.poweroff	= NULL,
+	.restore	= via_resume,
+#endif
+};
+
 static struct pci_driver via_driver = {
 	.name		= "viafb",
 	.id_table	= via_pci_table,
 	.probe		= via_pci_probe,
 	.remove		= via_pci_remove,
-#ifdef CONFIG_PM
-	.suspend	= via_suspend,
-	.resume		= via_resume,
-#endif
+	.driver.pm	= &via_pm_ops,
 };
 
 static int __init via_core_init(void)
diff --git a/include/linux/via-core.h b/include/linux/via-core.h
index 9e802deedb2d..8737599b9148 100644
--- a/include/linux/via-core.h
+++ b/include/linux/via-core.h
@@ -47,7 +47,6 @@ struct via_port_cfg {
 /*
  * Allow subdevs to register suspend/resume hooks.
  */
-#ifdef CONFIG_PM
 struct viafb_pm_hooks {
 	struct list_head list;
 	int (*suspend)(void *private);
@@ -57,7 +56,6 @@ struct viafb_pm_hooks {
 
 void viafb_pm_register(struct viafb_pm_hooks *hooks);
 void viafb_pm_unregister(struct viafb_pm_hooks *hooks);
-#endif /* CONFIG_PM */
 
 /*
  * This is the global viafb "device" containing stuff needed by
-- 
2.28.0

