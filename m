Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42174C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F0932168B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592583468;
	bh=6S2fDLxmDnfTFWydrz1jYnq7JRIpFlbNQ1c1RYxkUe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BQMC5nLsJryX1t6I4CiIw10eHOqqrKyxMS5VDOeddEW0bMuzt/kBtyprJzj21kM97
	 rCMRGH23BPOyvAy5vY0AdA611f49wBDjBTiOf0QUS1BTsacOdQZiHMGINDZvMNWD9J
	 lHeaLXPDPTWlzscrVZY+L0FwMndTnqGdSruyXvBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394525AbgFSQRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:17:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:58776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390809AbgFSPCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:02:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 744BB21D94;
        Fri, 19 Jun 2020 15:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578934;
        bh=6S2fDLxmDnfTFWydrz1jYnq7JRIpFlbNQ1c1RYxkUe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PoYGFP3EzjJSeDGAFjndIU0/fXyWFcHHyTd01c3ZHHA/FyfcnKvrI4yVy4qgLaViL
         12t5In3kYLqTjuZW9Q5Oqoen/oR+KgNYYj6wlWeop5m62S3OY7/wtL6ntb1mwoP5Li
         zzHjCBqqTieIgHnzTpzT5uGdunJEIORl8Tr8pHmI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 212/267] misc: pci_endpoint_test: Add support to test PCI EP in AM654x
Date:   Fri, 19 Jun 2020 16:33:17 +0200
Message-Id: <20200619141658.905037205@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

[ Upstream commit 5bb04b19230c02cc1b450b029856cbe093e09908 ]

TI's AM654x PCIe EP has a restriction that BAR_0 is mapped to
application registers. "PCIe Inbound Address Translation" section in
AM65x Sitara Processors TRM (SPRUID7 – April 2018) describes BAR0 as
reserved.

Configure pci_endpoint_test to use BAR_2 instead.

Also set alignment to 64K since "PCIe Subsystem Address Translation"
section in TRM indicates minimum ATU window size is 64K.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/pci_endpoint_test.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index 2b3d61d565f0..2c472f9cc135 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -75,6 +75,11 @@
 #define PCI_ENDPOINT_TEST_IRQ_TYPE		0x24
 #define PCI_ENDPOINT_TEST_IRQ_NUMBER		0x28
 
+#define PCI_DEVICE_ID_TI_AM654			0xb00c
+
+#define is_am654_pci_dev(pdev)		\
+		((pdev)->device == PCI_DEVICE_ID_TI_AM654)
+
 static DEFINE_IDA(pci_endpoint_test_ida);
 
 #define to_endpoint_test(priv) container_of((priv), struct pci_endpoint_test, \
@@ -593,6 +598,7 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 	int ret = -EINVAL;
 	enum pci_barno bar;
 	struct pci_endpoint_test *test = to_endpoint_test(file->private_data);
+	struct pci_dev *pdev = test->pdev;
 
 	mutex_lock(&test->mutex);
 	switch (cmd) {
@@ -600,6 +606,8 @@ static long pci_endpoint_test_ioctl(struct file *file, unsigned int cmd,
 		bar = arg;
 		if (bar < 0 || bar > 5)
 			goto ret;
+		if (is_am654_pci_dev(pdev) && bar == BAR_0)
+			goto ret;
 		ret = pci_endpoint_test_bar(test, bar);
 		break;
 	case PCITEST_LEGACY_IRQ:
@@ -792,11 +800,20 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
+static const struct pci_endpoint_test_data am654_data = {
+	.test_reg_bar = BAR_2,
+	.alignment = SZ_64K,
+	.irq_type = IRQ_TYPE_MSI,
+};
+
 static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x81c0) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_SYNOPSYS, 0xedda) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654),
+	  .driver_data = (kernel_ulong_t)&am654_data
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
-- 
2.25.1



