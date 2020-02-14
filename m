Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4B5C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B49B206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702344;
	bh=ZcUzQxygeVJz1o5yxME7aj3M2UwDiUg43GIMxLnHJpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NifSmFm+b++WW7LBYkNPaUuzf7J1Jyzci+0sQw8sogg+lj1R53BVD+ULBJ/6YK3Bt
	 t6sjBikIXXRaMJMgOmZZqFE6OPGyCn+QkKu34y2silfPJIPv2dHrCUBMSzD13m64Pi
	 5e3hJ+LbFnvMOF/1bKXoEUcELyqaWspM+2rk7Vl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389408AbgBNQCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:02:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:48622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388718AbgBNQCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:02:21 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14EC4217F4;
        Fri, 14 Feb 2020 16:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696140;
        bh=ZcUzQxygeVJz1o5yxME7aj3M2UwDiUg43GIMxLnHJpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K5GbgXrlkT/MmX85YyButZFDsVZBZs0vWVSs+Hg88MMqXID0gxuipTx7etbiTa5gB
         /VxllhZKNSPh5VZbSAG752y77NPkR/Ve0LRGdxEp4u1+IfCQSsr3wTkddCuNMvWOgv
         Xc2Y4FIxMRMGtCXHWzObdFuOIxIdX/k6JtgmD80g=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Sewart <jamessewart@arista.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 022/459] PCI: Fix pci_add_dma_alias() bitmask size
Date:   Fri, 14 Feb 2020 10:54:32 -0500
Message-Id: <20200214160149.11681-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Sewart <jamessewart@arista.com>

[ Upstream commit f8bf2aeb651b3460a4b36fd7ba1ba1d31777d35c ]

The number of possible devfns is 256, but pci_add_dma_alias() allocated a
bitmap of size 255.  Fix this off-by-one error.

This fixes commits 338c3149a221 ("PCI: Add support for multiple DMA
aliases") and c6635792737b ("PCI: Allocate dma_alias_mask with
bitmap_zalloc()"), but I doubt it was possible to see a problem because
it takes 4 64-bit longs (or 8 32-bit longs) to hold 255 bits, and
bitmap_zalloc() doesn't save the 255-bit size anywhere.

[bhelgaas: commit log, move #define to drivers/pci/pci.h, include loop
limit fix from Qian Cai:
https://lore.kernel.org/r/20191218170004.5297-1-cai@lca.pw]
Signed-off-by: James Sewart <jamessewart@arista.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c    | 2 +-
 drivers/pci/pci.h    | 3 +++
 drivers/pci/search.c | 4 ++--
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index fcfaadc774eef..cbf3d3889874c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5894,7 +5894,7 @@ EXPORT_SYMBOL_GPL(pci_pr3_present);
 void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
 {
 	if (!dev->dma_alias_mask)
-		dev->dma_alias_mask = bitmap_zalloc(U8_MAX, GFP_KERNEL);
+		dev->dma_alias_mask = bitmap_zalloc(MAX_NR_DEVFNS, GFP_KERNEL);
 	if (!dev->dma_alias_mask) {
 		pci_warn(dev, "Unable to allocate DMA alias mask\n");
 		return;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3f6947ee3324a..273d60cb0762d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -4,6 +4,9 @@
 
 #include <linux/pci.h>
 
+/* Number of possible devfns: 0.0 to 1f.7 inclusive */
+#define MAX_NR_DEVFNS 256
+
 #define PCI_FIND_CAP_TTL	48
 
 #define PCI_VSEC_ID_INTEL_TBT	0x1234	/* Thunderbolt */
diff --git a/drivers/pci/search.c b/drivers/pci/search.c
index bade14002fd8a..e4dbdef5aef05 100644
--- a/drivers/pci/search.c
+++ b/drivers/pci/search.c
@@ -41,9 +41,9 @@ int pci_for_each_dma_alias(struct pci_dev *pdev,
 	 * DMA, iterate over that too.
 	 */
 	if (unlikely(pdev->dma_alias_mask)) {
-		u8 devfn;
+		unsigned int devfn;
 
-		for_each_set_bit(devfn, pdev->dma_alias_mask, U8_MAX) {
+		for_each_set_bit(devfn, pdev->dma_alias_mask, MAX_NR_DEVFNS) {
 			ret = fn(pdev, PCI_DEVID(pdev->bus->number, devfn),
 				 data);
 			if (ret)
-- 
2.20.1

