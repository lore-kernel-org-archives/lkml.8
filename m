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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6781C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5DE420704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rVE0X2HT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgGQHvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgGQHvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:51:37 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E841AC061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 00:51:36 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o1so5122222plk.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 00:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cWqo/1iGGhIfGKCAu2qJyy90N6APTvXdwVB6pQxCcg0=;
        b=rVE0X2HTdehxwlgLKfFZNc2cCb/5/HluVTLh895T6EIOW9altfl3qdh4EQ+IXSzCWE
         XF2HTtZPy2Nu/IFQHuAfm5Wsa5gG3onbgQAc6U/PPxSQfoYQvK+BS0qFPN+OuPVWVhYh
         RtARknXTxz05y1CdfNR+Ymi8omU/rIxrrYZL+YKsuBWNCz2K8L3jpiMr8IOmBXomz1xs
         AEPz5fOnFqzQQzKSHEf5emk3lBjENVjkGaQLItuM0oV5DuVAdTM1K4CyO8r/UlLIhGYP
         b8QZW2JOPC0te8A9HAkdpYK03GFI1yujrC8AZ3uVebT7gAf5OGEDWVkMVgQVol5gMALR
         BKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cWqo/1iGGhIfGKCAu2qJyy90N6APTvXdwVB6pQxCcg0=;
        b=FFHZ/EFfsABQcHUeFDtYszCElCAfxsov8xxqViSEKuxd0RENZAzjlXwZ4ax3NUDS4u
         VoGTnVOJcri1wIhFnW0YoZnnMEZvBNiq7W2kT2Mt5D5rryT1kokcBaa413unI+6fwHPa
         C43UI6y5tbkJI0f0pw+BQTR+/tVDHxnF30qovTsY+nOoZV1kBy9DtujIMnjjB/keZghq
         74hsfXp2UhAcVI9WTVxwV57aadn7k8YwiqVxWJiTI0Sj3g6OCL05I3vVQcS6wDoHsBqf
         yALUgpj89y3R2cDnO9dekc/Dyq8+lLTLjjDLKjaRPFqAxXsnGpRsfRknr8RXWitWs3fp
         mAcg==
X-Gm-Message-State: AOAM532RpAfxHTuuoxPK/8Mwn6Yl87jT+jyzbo9nPUU9C1QR2uqYni4A
        XjqQi3EGzQFOeAqCJfVQWoYowR+S0oCc5g==
X-Google-Smtp-Source: ABdhPJySEEEQ5UYc975TUV8nc4RCp7vrGbxiujqH0R+l12ZmCuOCbDd4oFs7dKBTa48Rm1ACHE6dEA==
X-Received: by 2002:a17:902:a389:: with SMTP id x9mr6633756pla.63.1594972296470;
        Fri, 17 Jul 2020 00:51:36 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id s68sm1924332pjb.38.2020.07.17.00.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 00:51:36 -0700 (PDT)
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
Subject: [PATCH v1 2/3] sis-agp: use generic power management
Date:   Fri, 17 Jul 2020 13:19:36 +0530
Message-Id: <20200717074937.296192-3-vaibhavgupta40@gmail.com>
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
 drivers/char/agp/sis-agp.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/char/agp/sis-agp.c b/drivers/char/agp/sis-agp.c
index 14909fc5d767..e2e62d5a8914 100644
--- a/drivers/char/agp/sis-agp.c
+++ b/drivers/char/agp/sis-agp.c
@@ -217,26 +217,14 @@ static void agp_sis_remove(struct pci_dev *pdev)
 	agp_put_bridge(bridge);
 }
 
-#ifdef CONFIG_PM
+#define agp_sis_suspend NULL
 
-static int agp_sis_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused agp_sis_resume(
+	__attribute__((unused)) struct device *dev)
 {
-	pci_save_state(pdev);
-	pci_set_power_state(pdev, pci_choose_state(pdev, state));
-
-	return 0;
-}
-
-static int agp_sis_resume(struct pci_dev *pdev)
-{
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
-
 	return sis_driver.configure();
 }
 
-#endif /* CONFIG_PM */
-
 static const struct pci_device_id agp_sis_pci_table[] = {
 	{
 		.class		= (PCI_CLASS_BRIDGE_HOST << 8),
@@ -419,15 +407,14 @@ static const struct pci_device_id agp_sis_pci_table[] = {
 
 MODULE_DEVICE_TABLE(pci, agp_sis_pci_table);
 
+static SIMPLE_DEV_PM_OPS(agp_sis_pm_ops, agp_sis_suspend, agp_sis_resume);
+
 static struct pci_driver agp_sis_pci_driver = {
 	.name		= "agpgart-sis",
 	.id_table	= agp_sis_pci_table,
 	.probe		= agp_sis_probe,
 	.remove		= agp_sis_remove,
-#ifdef CONFIG_PM
-	.suspend	= agp_sis_suspend,
-	.resume		= agp_sis_resume,
-#endif
+	.driver.pm	= &agp_sis_pm_ops,
 };
 
 static int __init agp_sis_init(void)
-- 
2.27.0

