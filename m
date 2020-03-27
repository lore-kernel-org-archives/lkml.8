Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA412C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B2F520714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Bj1az3Qg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbgC0JmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:42:13 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:44242 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726027AbgC0JmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 05:42:13 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 651E9C0F9C;
        Fri, 27 Mar 2020 09:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1585302132; bh=NWAeJc+FAl9dC27fp2efai9R07gAZkuqfeVwWFD9/2c=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=Bj1az3Qgo0XxaMG7ROBqHJa79VMpOiNuNjYui97ruBpQNfq1X+/9Z4ZgIYfeuvW+q
         xbpvhS+cvwJ06tz4RZdslM4Zwrbnv20Q2celtcsvYjM3rjWBOMpn10F/hbMkI01XHJ
         M/iPXTx70ZK4veQmxvzUeAzeCv2NJDUH1OrF1dFLaMP8dWMH9blPexBvXl47dcGS9O
         8WUmB5lomJ0eRzaTSb0sKUFpdFAryKp9Nss8W63f2SpA0mys5tevN3N/GehkZHNk6O
         DOeUf+0FeQqD46hsMHdEdV8TZUX3geRVERxhgy6e2qakC5bAIEhyTTXUWZXXRVteGM
         9+SSgXM6zv4kA==
Received: from tejas-VirtualBox (joglekar-e7480.internal.synopsys.com [10.146.16.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPSA id ED7D8A005C;
        Fri, 27 Mar 2020 09:42:08 +0000 (UTC)
Received: by tejas-VirtualBox (sSMTP sendmail emulation); Fri, 27 Mar 2020 15:12:06 +0530
Date:   Fri, 27 Mar 2020 15:12:06 +0530
Message-Id:
 <e3458b468d280a8d0cc6f3b49c63016e7b60586e.1585297723.git.joglekar@synopsys.com>
In-Reply-To: <cover.1585297723.git.joglekar@synopsys.com>
References: <cover.1585297723.git.joglekar@synopsys.com>
From:   Tejas Joglekar <Tejas.Joglekar@synopsys.com>
Subject: [RESENDING RFC PATCH 2/4] usb: xhci: Set quirk for XHCI_CONSOLIDATE_SG_LIST
To:     Tejas Joglekar <Tejas.Joglekar@synopsys.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>
Cc:     John Youn <John.Youn@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20200327094206.o-VDms92ZnuU1krxI4cJWNMRfjz-cn4_6CNZRocPR_o@z>

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

