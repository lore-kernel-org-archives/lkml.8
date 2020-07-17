Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3535C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E9442076A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzTODCjH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgGQHvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgGQHvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:51:44 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A520C061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 00:51:44 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x9so5120751plr.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 00:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zNW9uGCCyuNVj0zzY42fxPcN6t0OrV/LrjNayMGPkQU=;
        b=VzTODCjH9JpZgBV2q+hOkDevdJ48kMuEhf5B5qyChStHn1ij1kJSK8BljZ+qDpoUkg
         yseIQ2cKFjHldhbr1a1xNxv8qm+ptqRBM+5M8oDrgls6NrRhnOIlRJ61cggS8/9e+Osg
         ndn4P+pguRaQCq6yzwISTb5S4n4xZnrSnZvPmseRt9vnoepDxQf/pjX4f/jG3i9pNgb/
         7Fm2LcV3R4xKnZ+bKXS0eLoolghiY+XtGVgUH7IoNuM7sdRjOcpXkvE84av/NPfKF8qW
         U8gMr5jhvOlOqhrOYQ0dyj37V2cSZqulhfQ4FOTW+g4hFoRcOgO62bcERyygoJsZ+xmp
         LQqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zNW9uGCCyuNVj0zzY42fxPcN6t0OrV/LrjNayMGPkQU=;
        b=S22ovbVc4uqPpSyjdrySdLrw5NbTlTGOyQJvfjbIsOIecp8Enc2n9fc/euIysu2yqA
         Vt5akG8YJHQTPKgfbpCziIq5DTDb7I2Rk799pmM5b/qdNHtB4/k78Shw5l/JihcNhT1T
         x+CNfiuWKlTD34RyHZIGGyNphqieiun3uxW4cfbjpooRth0xcoOphvn+Wh3wTavwO9n8
         ENloRdpNVMgV6oN5HTGfWg+iHe/YFw8eWAXMdZfw3SeFTBS5DGyJBppG1mj9RMu7riRf
         5ByGxbOdKQWBoX3etLEglRU+ofPA+FpGDshZy8OnL9RviSRfBr+RTbiwCWlK7bzlSQZR
         QZTg==
X-Gm-Message-State: AOAM532TnnU2tC5Ma3z5fXeVvlqfT0qy4h+SPxaXcu8k13IPgjYsgmu6
        uV8L8XXNE9njp+TDACCFLPI=
X-Google-Smtp-Source: ABdhPJwD1SfN9j2JmbPCc+Vz3/Y96fIz7igGol5/BhSuBVM/yI1O17VPNMnGuhY7TLfAdCilMOLyyg==
X-Received: by 2002:a17:902:10e:: with SMTP id 14mr6368688plb.297.1594972303853;
        Fri, 17 Jul 2020 00:51:43 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id s68sm1924332pjb.38.2020.07.17.00.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 00:51:43 -0700 (PDT)
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        David Airlie <airlied@linux.ie>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v1 3/3] via-agp: use generic power management
Date:   Fri, 17 Jul 2020 13:19:37 +0530
Message-Id: <20200717074937.296192-4-vaibhavgupta40@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200717074937.296192-1-vaibhavgupta40@gmail.com>
References: <20200717074937.296192-1-vaibhavgupta40@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers using legacy PM have to manage PCI states and device's PM states
themselves. They also need to take care of configuration registers.

With improved and powerful support of generic PM, PCI Core takes care of
above mentioned, device-independent, jobs.

This driver makes use of PCI helper functions like
pci_save/restore_state() and pci_set_power_state() to do required
operations. In generic mode, they are no longer needed.

Change function parameter in .resume() to "struct device*" type. Use
to_pci_dev() to get "struct pci_dev*" variable.

After upgrading, .suspend() became an empty-body function, hence defined as
NULL.

Compile-tested only.

Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
---
 drivers/char/agp/via-agp.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/drivers/char/agp/via-agp.c b/drivers/char/agp/via-agp.c
index 87a92a044570..afa941df7d44 100644
--- a/drivers/char/agp/via-agp.c
+++ b/drivers/char/agp/via-agp.c
@@ -492,22 +492,11 @@ static void agp_via_remove(struct pci_dev *pdev)
 	agp_put_bridge(bridge);
 }
 
-#ifdef CONFIG_PM
+#define agp_via_suspend NULL
 
-static int agp_via_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused agp_via_resume(struct device *dev)
 {
-	pci_save_state (pdev);
-	pci_set_power_state (pdev, PCI_D3hot);
-
-	return 0;
-}
-
-static int agp_via_resume(struct pci_dev *pdev)
-{
-	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
-
-	pci_set_power_state (pdev, PCI_D0);
-	pci_restore_state(pdev);
+	struct agp_bridge_data *bridge = dev_get_drvdata(dev);
 
 	if (bridge->driver == &via_agp3_driver)
 		return via_configure_agp3();
@@ -517,8 +506,6 @@ static int agp_via_resume(struct pci_dev *pdev)
 	return 0;
 }
 
-#endif /* CONFIG_PM */
-
 /* must be the same order as name table above */
 static const struct pci_device_id agp_via_pci_table[] = {
 #define ID(x) \
@@ -567,16 +554,14 @@ static const struct pci_device_id agp_via_pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, agp_via_pci_table);
 
+static SIMPLE_DEV_PM_OPS(agp_via_pm_ops, agp_via_suspend, agp_via_resume);
 
 static struct pci_driver agp_via_pci_driver = {
 	.name		= "agpgart-via",
 	.id_table	= agp_via_pci_table,
 	.probe		= agp_via_probe,
 	.remove		= agp_via_remove,
-#ifdef CONFIG_PM
-	.suspend	= agp_via_suspend,
-	.resume		= agp_via_resume,
-#endif
+	.driver.pm	= &agp_via_pm_ops,
 };
 
 
-- 
2.27.0

