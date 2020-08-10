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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A44C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:00:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA38A2224D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e09DB0UN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgHJTAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728215AbgHJTAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:00:20 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0728C061756;
        Mon, 10 Aug 2020 12:00:20 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 74so6112018pfx.13;
        Mon, 10 Aug 2020 12:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tUIX3oUq+BAamlZJBJ9IeD9BMm5oq8vVqQ2hIGTjUng=;
        b=e09DB0UN479Wa7sOUsksxC+y9mEDbv+QeRkQHDjr1Qt60svQT4MdFY5VxfTOAgjpMG
         L2+ffCpqK+8lUCtZBwah6ByxwCJKvDg2mHB/CgdkOGiaHT1wwuaTZ0nc5XZCeh/fVWSx
         CsbfQPYrnMT/pQioI2J0aYhe5Eh4n8J/QCY6CRT3l9DmE9u6qJ84s/nqRZuTDclF29cb
         pqV5FFy+FT7854Vmt9PpZM90yCBBxgKysyJTJlAibeexsE0L+cNlw07wHrNsPODw01jL
         YwohlLPyb0Gs8uCOGcM3IAUfCAOIYV4tGd4CUusvtfcXWq8W7hIcdaAt7pJq1yDPcpWA
         XcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tUIX3oUq+BAamlZJBJ9IeD9BMm5oq8vVqQ2hIGTjUng=;
        b=Cv7iN2Wqg3XUbuFzV2sJV3BASHEc/245oO+valm0Irkfjnj1w0lNDNFB4qD6RudVOm
         0+r6H8y138x5RAWZZlw1Xz1MuTT3wtXVurG8fRIPvEBTma1hVK0eVEQ90q9owUewRDf1
         jrbfcVdQ0sAEdWn6EAeGPZPWKqXvQIuWWEKXUOrfwjVSmPSodSEgOdmmhqHmOi0wINju
         OKlHygOqm3lJo+qADqEHgZOgLXd64CRRzhjd7niJbB8oTJI7IAv8MOHsXX10ac3Qvhui
         tYxQOZv/OKSOACExc4brT4hT0HvNdUYKRzlMpOecy/b6sCaeZCb/MMuYzo9DBjOvThfJ
         P1aQ==
X-Gm-Message-State: AOAM530V2Xq+eDtpDkVrs+t7JPSS0iRbGBWQv/oXB7pG0VYkHCfiII9B
        u2/AtyUmK7POVFdtid1FNYo=
X-Google-Smtp-Source: ABdhPJzqgUCaTLlwt9nMhPO/MyOHNOXTkAdRl1Eno3KtywE7hA2LRQfyZ5RFqehkSxqUE0saJ+h5Yw==
X-Received: by 2002:aa7:9a09:: with SMTP id w9mr2398983pfj.206.1597086020112;
        Mon, 10 Aug 2020 12:00:20 -0700 (PDT)
Received: from varodek.localdomain ([103.105.152.86])
        by smtp.gmail.com with ESMTPSA id f27sm22683547pfk.217.2020.08.10.12.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 12:00:19 -0700 (PDT)
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
Subject: [PATCH v2 08/12] fbdev: cyber2000fb: use generic power management
Date:   Tue, 11 Aug 2020 00:27:19 +0530
Message-Id: <20200810185723.15540-9-vaibhavgupta40@gmail.com>
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

Although the cyber2000fb driver does not have that extra load, we should
switch to the new generic framework by updating function signatures and
define a "struct dev_pm_ops" variable to bind PM callbacks so that we can
remove the legacy .suspend & .resume bindings.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/video/fbdev/cyber2000fb.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/cyber2000fb.c b/drivers/video/fbdev/cyber2000fb.c
index 42d37bed518a..d45355b9a58c 100644
--- a/drivers/video/fbdev/cyber2000fb.c
+++ b/drivers/video/fbdev/cyber2000fb.c
@@ -1810,7 +1810,7 @@ static void cyberpro_pci_remove(struct pci_dev *dev)
 	}
 }
 
-static int cyberpro_pci_suspend(struct pci_dev *dev, pm_message_t state)
+static int __maybe_unused cyberpro_pci_suspend(struct device *dev)
 {
 	return 0;
 }
@@ -1818,9 +1818,9 @@ static int cyberpro_pci_suspend(struct pci_dev *dev, pm_message_t state)
 /*
  * Re-initialise the CyberPro hardware
  */
-static int cyberpro_pci_resume(struct pci_dev *dev)
+static int __maybe_unused cyberpro_pci_resume(struct device *dev)
 {
-	struct cfb_info *cfb = pci_get_drvdata(dev);
+	struct cfb_info *cfb = dev_get_drvdata(dev);
 
 	if (cfb) {
 		cyberpro_pci_enable_mmio(cfb);
@@ -1846,12 +1846,15 @@ static struct pci_device_id cyberpro_pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, cyberpro_pci_table);
 
+static SIMPLE_DEV_PM_OPS(cyberpro_pci_pm_ops,
+			 cyberpro_pci_suspend,
+			 cyberpro_pci_resume);
+
 static struct pci_driver cyberpro_driver = {
 	.name		= "CyberPro",
 	.probe		= cyberpro_pci_probe,
 	.remove		= cyberpro_pci_remove,
-	.suspend	= cyberpro_pci_suspend,
-	.resume		= cyberpro_pci_resume,
+	.driver.pm	= &cyberpro_pci_pm_ops,
 	.id_table	= cyberpro_pci_table
 };
 
-- 
2.27.0

