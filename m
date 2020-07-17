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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493B4C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E5A820704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKMT7VO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgGQHv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgGQHv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:51:29 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47252C061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 00:51:29 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id s26so5012110pfm.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 00:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AXXHt8+DPkVprDBBChiV85baUHo9NZb8056HrL8z4ac=;
        b=nKMT7VO6DqHGKROxMl7G6Awn7bB9Hv3cpJRT/kPlkk+1G0DhgN8vtNQ1qhjhcHjxQ0
         ZbGgypqmXtMNPfPvqq4QsGqD2TqG/UA0hcpfwF3PWMy7bG+fhSquK2Pmvrajv4CjLliL
         PihP0mIMVYURhvFv0l65KGC6R69Zf12DnMOxQvE6pWQm4Q81sQAKuf6vlk90HUe1elU2
         wha201nheuDZyDHsAxID7VxaB4nQpqATrDgvOSnh211cDL69XkRbUc+E+zo3IFLmziRH
         yB7wla/1hGCR3rM6N5Djm0moL0xFen9Aj9pxON7ZEKQb9vxRfimxwPZp6PNeHBotDoRC
         yK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AXXHt8+DPkVprDBBChiV85baUHo9NZb8056HrL8z4ac=;
        b=DgI8NQdaKE2xdoM2VZ4yZdN+3iGaUrpL75N83KH5werZrVjqOKSql493kX4gXTJt0h
         EYGym6oiJp3oMuwstPAzH8UCamfwWkdQ286TChoHf8atMsyha27lzMRQlHuj5upRdEXz
         xURUySuzxx8lJbwRtqLcDaDaXyxSJumN9P+Lp8FD5iTYA2A/hpIjiOlNhSKrhtPmSIbi
         6YZfrvOo8YhQtJcn4bPTOP8x4AmxyKMrNylLhDsbRGjLLaAlLuqvG7c/AqlO51umpGmN
         qz0Im5V4YDckwcN8LumwZzi56i9qi5P5AZ+6gbBcriGV385MvlkcalYisPq4C0B7N6Ii
         Iwkg==
X-Gm-Message-State: AOAM532IwpqAOjZSOAhx6lDimU8uOgLNN6+tZ3SVDJwxhO4rSKZ9yWiw
        bU7vTAPWpgkZq7l9c8w6ordewA89XzInAQ==
X-Google-Smtp-Source: ABdhPJxAh8Qm+1I1c+dDYZJIfvbYs3crQxXI4y9cojL+rmjVpLRVyolyeVmejwHACXtBihNfuU8+/w==
X-Received: by 2002:a62:1c8b:: with SMTP id c133mr7245432pfc.134.1594972284059;
        Fri, 17 Jul 2020 00:51:24 -0700 (PDT)
Received: from varodek.iballbatonwifi.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id s68sm1924332pjb.38.2020.07.17.00.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 00:51:23 -0700 (PDT)
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
Subject: [PATCH v1 1/3] amd64-agp: use generic power management
Date:   Fri, 17 Jul 2020 13:19:35 +0530
Message-Id: <20200717074937.296192-2-vaibhavgupta40@gmail.com>
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
 drivers/char/agp/amd64-agp.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index b40edae32817..57fdcc61f88a 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -588,20 +588,11 @@ static void agp_amd64_remove(struct pci_dev *pdev)
 	agp_bridges_found--;
 }
 
-#ifdef CONFIG_PM
+#define agp_amd64_suspend NULL
 
-static int agp_amd64_suspend(struct pci_dev *pdev, pm_message_t state)
+static int __maybe_unused agp_amd64_resume(struct device *dev)
 {
-	pci_save_state(pdev);
-	pci_set_power_state(pdev, pci_choose_state(pdev, state));
-
-	return 0;
-}
-
-static int agp_amd64_resume(struct pci_dev *pdev)
-{
-	pci_set_power_state(pdev, PCI_D0);
-	pci_restore_state(pdev);
+	struct pci_dev *pdev = to_pci_dev(dev);
 
 	if (pdev->vendor == PCI_VENDOR_ID_NVIDIA)
 		nforce3_agp_init(pdev);
@@ -609,8 +600,6 @@ static int agp_amd64_resume(struct pci_dev *pdev)
 	return amd_8151_configure();
 }
 
-#endif /* CONFIG_PM */
-
 static const struct pci_device_id agp_amd64_pci_table[] = {
 	{
 	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
@@ -738,15 +727,14 @@ static const struct pci_device_id agp_amd64_pci_promisc_table[] = {
 	{ }
 };
 
+static SIMPLE_DEV_PM_OPS(agp_amd64_pm_ops, agp_amd64_suspend, agp_amd64_resume);
+
 static struct pci_driver agp_amd64_pci_driver = {
 	.name		= "agpgart-amd64",
 	.id_table	= agp_amd64_pci_table,
 	.probe		= agp_amd64_probe,
 	.remove		= agp_amd64_remove,
-#ifdef CONFIG_PM
-	.suspend	= agp_amd64_suspend,
-	.resume		= agp_amd64_resume,
-#endif
+	.driver.pm	= &agp_amd64_pm_ops,
 };
 
 
-- 
2.27.0

