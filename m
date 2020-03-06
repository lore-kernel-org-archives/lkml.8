Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE1DC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CDBE2070A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:26:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbgCFJ0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:26:44 -0500
Received: from inva020.nxp.com ([92.121.34.13]:44054 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725951AbgCFJ0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:26:44 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 894241A0A78;
        Fri,  6 Mar 2020 10:26:42 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A44431A0A4A;
        Fri,  6 Mar 2020 10:26:38 +0100 (CET)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 85C4C402A0;
        Fri,  6 Mar 2020 17:26:33 +0800 (SGT)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Chen <peter.chen@nxp.com>, Jun Li <jun.li@nxp.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH] usb: host: xhci-plat: add a shutdown
Date:   Fri,  6 Mar 2020 17:23:28 +0800
Message-Id: <20200306092328.41253-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When loading new kernel via kexec, we need to shutdown host controller to
avoid any un-expected memory accessing during new kernel boot.

Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
Reviewed-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/usb/host/xhci-plat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index d90cd5e..315b455 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -445,6 +445,7 @@ MODULE_DEVICE_TABLE(acpi, usb_xhci_acpi_match);
 static struct platform_driver usb_xhci_driver = {
 	.probe	= xhci_plat_probe,
 	.remove	= xhci_plat_remove,
+	.shutdown = usb_hcd_platform_shutdown,
 	.driver	= {
 		.name = "xhci-hcd",
 		.pm = &xhci_plat_pm_ops,
-- 
2.7.4

