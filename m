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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26793C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F346D206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:15:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EM50zi3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729161AbgHESPb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 14:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728825AbgHESLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 14:11:50 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1874C06138E;
        Wed,  5 Aug 2020 11:10:34 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t11so5909559plr.5;
        Wed, 05 Aug 2020 11:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=W6aecVxekaowOTfMHhyO+xffxTL+ymIKSU0xNgUeoV0=;
        b=EM50zi3o/DdIAOuqWSipMAPdCqA2ApiWqP8PdNNhM0QzRDFyReNx3T7Uq15CyvkA8j
         hJPKu2viSbGd+f6r9bsli/+WrKKGJ6XwRZJq4eJREAYfshIKN3LcbnP8aun/VFpmYHj6
         xwWTyz7spz8TLQmojSA8B5IXVYf7AnyFaE5AU/Kx7iGuzAjYlNbMEEeJiRPCxA7iHlHT
         FMtHOwNAiJOQP3/Gs9hNQjX2kOvyqxU1R7EQDUfSE5yaBTgZxkdXxiJQnmVj1WEOoXy7
         4Rx+hqCZiZWg28pD0LK+hTTS6LFsy3YZoWG8/1C+VU42kQ9m+ZpxaHV0WRccIhCct892
         b1KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W6aecVxekaowOTfMHhyO+xffxTL+ymIKSU0xNgUeoV0=;
        b=tmhwxl+uPpKfT9pL/Z3aSdWjip+Egjf5ZWP+vpzJ6INU6KVqs4dFxyPPAnQPIwjfOI
         vLoLJv+kPrgv6ed0RubhuzTKueKJXr3fzOwmbda/09ZA98xBZ8ZIKevNUvQujQiAFGYx
         xV+LcPPRtz14n/qbNNssPq4X7VnJvtLZf56H1UIC6FJw2ZfUDxJ6tgEEpHq3QbLtQijV
         F9FT42qWj0411i1thQSb51cL4MWoNLjot3t2hlac8XUjwLR/YLsgQMH1bTThz41rmDJt
         CNUqXDaSdNY/HfSDei5KnycmuphHGlip/7KlUwdGi0cak46Jc6ZwPWSaBc09YqHxHDpE
         3HJQ==
X-Gm-Message-State: AOAM533euiN+L+YMq1srlT0hxzSdyyVSz0E6YXj31O+oPoO50lvAX9hh
        3OM6kXhIq0A1t9sjaHRLQnM=
X-Google-Smtp-Source: ABdhPJzV4HkXnpkCYDEKEkF0Olu1tfd/UZIZOk1v9/CkMJ2NxIPq4OJGNRQY7r0kXlYQzcVkwSxQbA==
X-Received: by 2002:a17:902:b417:: with SMTP id x23mr3962646plr.231.1596651034481;
        Wed, 05 Aug 2020 11:10:34 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id t63sm4977510pfb.210.2020.08.05.11.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 11:10:34 -0700 (PDT)
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
Subject: [PATCH v1 12/12] fbdev: arkfb: use generic power management
Date:   Wed,  5 Aug 2020 23:37:22 +0530
Message-Id: <20200805180722.244008-13-vaibhavgupta40@gmail.com>
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
 drivers/video/fbdev/arkfb.c | 41 +++++++++++++++----------------------
 1 file changed, 17 insertions(+), 24 deletions(-)

diff --git a/drivers/video/fbdev/arkfb.c b/drivers/video/fbdev/arkfb.c
index 11ab9a153860..6a4114db0dfd 100644
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
+	.freeze		= ark_pci_suspend,
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
2.27.0

