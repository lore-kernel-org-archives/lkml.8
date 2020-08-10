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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9DBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C42D20782
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ef7/XI6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbgHJTAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgHJTAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:00:49 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6240EC061756;
        Mon, 10 Aug 2020 12:00:49 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x25so2775304pff.4;
        Mon, 10 Aug 2020 12:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vUB+rA3wMgyIGCTgDMTDExS1DTdL7k930vthzu2b58I=;
        b=Ef7/XI6fXp2PdOxr7kRX47309hXJcNbM4NqFwiRvuciUILVKoTxZjSAF4uICpm6euz
         2BN5Vy5ogfx/lcIwuk8Ue20WASNEkJXthoHnQ3FgGXtdTO/d8FWdxfLIbrWwO038bdL7
         h/CykS470RoIf8oW7CJOk0IycTobYDdd3MDciM39KC7SPyQSgEpKavf3vLL2EILk01/E
         okP9VZFtNxIS6Abu5JVjtxtvx5/9uFBGhizqpC7SGjDi4/ECicadSN1GHRuu8hKC6KJ/
         Q4/n/ov/5jioDN+gpDIra1uQadVW0eS9VVsYGeka0qL9LRbSkOUHHoixo0+glJ4RvhLS
         IfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vUB+rA3wMgyIGCTgDMTDExS1DTdL7k930vthzu2b58I=;
        b=PUX+4qBya3pegTRZkxxY3tJToVcsM1p4QpF6ldLuFsy1yguJWcEviSAMOSJqwl1Lao
         NjoUWtKSeSkA+d5/em8vOi2U3csq2qmVSRrUUCdo6/gcTpxI/AvNq3MnKZhXyP66zVBO
         yMZZ/ooT4EHOOMuSssQKITfmOsq3xAMib2xRTQhATL9cV7uiBKT6HNGzpoqaK1959JOV
         VglKTc/tvZwW3wEJLjfQKjrRZw80Smu3Nt3FpOhF6PGhkerryrfowkCsB6tCXZRHw4mf
         RC0x5R5E74bvslHf3ZiS2wideBMeaI+lMIvWCXUJ7DUj8gxvRuRDOpj06sLz+dSOrJa5
         T+ZQ==
X-Gm-Message-State: AOAM530VItBtt78awkBuP1qdixzb79TMvB1a/1cnwr2WiRuEq+Zy6y7B
        UXXRg/ZfniKnMdQzcb94zUM=
X-Google-Smtp-Source: ABdhPJxEmlFDCZfhZX0GJe9P/FvsH260+WSzBurbLHgA3ag3KBCOkHuX9/WWHwNw2rTdcLEYiEeGvQ==
X-Received: by 2002:a62:1a49:: with SMTP id a70mr2488335pfa.297.1597086048906;
        Mon, 10 Aug 2020 12:00:48 -0700 (PDT)
Received: from varodek.localdomain ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id f27sm22683547pfk.217.2020.08.10.12.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 12:00:48 -0700 (PDT)
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
Subject: [PATCH v2 12/12] fbdev: arkfb: use generic power management
Date:   Tue, 11 Aug 2020 00:27:23 +0530
Message-Id: <20200810185723.15540-13-vaibhavgupta40@gmail.com>
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

