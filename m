Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEB9C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973B920705
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="hurRws/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgC0IfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:35:25 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:40788 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726217AbgC0IfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:35:25 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7FF93C0F99;
        Fri, 27 Mar 2020 08:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1585298124; bh=NWAeJc+FAl9dC27fp2efai9R07gAZkuqfeVwWFD9/2c=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=hurRws/lM5BOAKjYYXgmD6gZkhxdDaSY11DpazIyQXtzkhekPOG/fuPEXJNX/3+gc
         FsNEAK2uLFoAeWhTr9ui7snK2mWWHhHaZW+aBOtYfj/AQc+ss1g/VzJV+xg1P23Gqw
         +nRaVLq32FQN1k4hM+6jr7qCJf43Or3sTagMFeoviDWGX/KEg6sOymg1hSlcsfRomG
         wSquvSbuTPCSi6Qi0bXHwYbOi5nF68eHaZiGLwsdi7ocolQ1cGpc8r8h9UfM50AWy5
         gPH9lC9S//1kVYxh3DJrWljTUztZzVHfyJD7ZobTqQgY7cEZgECcc7q9sKfOzem9Sb
         RfGsaW0+jaq1w==
Received: from tejas-VirtualBox (joglekar-e7480.internal.synopsys.com [10.146.16.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id 475D2A005B;
        Fri, 27 Mar 2020 08:35:21 +0000 (UTC)
Received: by tejas-VirtualBox (sSMTP sendmail emulation); Fri, 27 Mar 2020 14:05:18 +0530
Date:   Fri, 27 Mar 2020 14:05:18 +0530
Message-Id: <e3458b468d280a8d0cc6f3b49c63016e7b60586e.1585297723.git.joglekar@synopsys.com>
In-Reply-To: <cover.1585297723.git.joglekar@synopsys.com>
References: <cover.1585297723.git.joglekar@synopsys.com>
From:   Tejas Joglekar <Tejas.Joglekar@synopsys.com>
Subject: [RFC PATCH 2/4] usb: xhci: Set quirk for XHCI_CONSOLIDATE_SG_LIST
To:     Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     John Youn <John.Youn@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit enables the quirk when the consolidate_trbs property is set
for the Synopsys xHC. This patch fixes the SNPS xHC hang issue
when the data is scattered across small buffers which does not make
atleast MPS size for given TRB cache size of SNPS xHC.

Signed-off-by: Tejas Joglekar <joglekar@synopsys.com>
---
 drivers/usb/host/xhci-pci.c  | 3 +++
 drivers/usb/host/xhci-plat.c | 3 +++
 drivers/usb/host/xhci.h      | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index 766b74723e64..cdda8e2de1c2 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -268,6 +268,9 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
 	     pdev->device == 0x9026)
 		xhci->quirks |= XHCI_RESET_PLL_ON_DISCONNECT;
 
+	if (pdev->vendor == PCI_VENDOR_ID_SYNOPSYS)
+		xhci->quirks |= XHCI_CONSOLIDATE_SG_LIST;
+
 	if (xhci->quirks & XHCI_RESET_ON_RESUME)
 		xhci_dbg_trace(xhci, trace_xhci_dbg_quirks,
 				"QUIRK: Resetting on resume");
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 315b4552693c..8333c78dcf03 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -289,6 +289,9 @@ static int xhci_plat_probe(struct platform_device *pdev)
 		if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
 			xhci->quirks |= XHCI_BROKEN_PORT_PED;
 
+		if (device_property_read_bool(tmpdev, "consolidate-sgl"))
+			xhci->quirks |= XHCI_CONSOLIDATE_SG_LIST;
+
 		device_property_read_u32(tmpdev, "imod-interval-ns",
 					 &xhci->imod_interval);
 	}
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 3289bb516201..a093eeaec70e 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1873,6 +1873,7 @@ struct xhci_hcd {
 #define XHCI_DEFAULT_PM_RUNTIME_ALLOW	BIT_ULL(33)
 #define XHCI_RESET_PLL_ON_DISCONNECT	BIT_ULL(34)
 #define XHCI_SNPS_BROKEN_SUSPEND    BIT_ULL(35)
+#define XHCI_CONSOLIDATE_SG_LIST    BIT_ULL(36)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
-- 
2.11.0

