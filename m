Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EB1C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0A3B222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272359;
	bh=FsDCGFXutCMRdUwir8BJRRaQZlwlI0XCDXOKRaP7r9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ulaH83pJKq+1lv8NTUlYqaQ/xl4CnJFlHl/hbESqeN698Mziv8dBn3BX7v8nfA+mW
	 bKS/A+YPNpRnCVedOMKvkXS+XDqsxoVFupfMN4cN8nE7KS3UmsffU4c8TlMtIkb2DC
	 UTp3alKmZ0PcMN7qM5jVRsSw+ZxqZJIvWTvjMqsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731890AbgBUIF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:05:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731870AbgBUIFu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:05:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75DBB20578;
        Fri, 21 Feb 2020 08:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272348;
        bh=FsDCGFXutCMRdUwir8BJRRaQZlwlI0XCDXOKRaP7r9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KcxN6DC9VBBiZieYOHphWC0MzV2hyxMTXskzSchmyeSGgQ3KzYpFv6F90MiYdPpnY
         cCMMSNKXztmMPY1cBn/AH7wwwwTDZfNZ9UBHpf9GDrUdPKzWt0k8yuCualsJcOt7Et
         EHZDR9EEXzq1eFmerNfHZ0PUHrMJwqWoRCH1P6IU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver OHalloran <oohall@gmail.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 073/344] powerpc/iov: Move VF pdev fixup into pcibios_fixup_iov()
Date:   Fri, 21 Feb 2020 08:37:52 +0100
Message-Id: <20200221072355.632124230@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver O'Halloran <oohall@gmail.com>

[ Upstream commit 965c94f309be58fbcc6c8d3e4f123376c5970d79 ]

An ioda_pe for each VF is allocated in pnv_pci_sriov_enable() before
the pci_dev for the VF is created. We need to set the pe->pdev pointer
at some point after the pci_dev is created. Currently we do that in:

pcibios_bus_add_device()
	pnv_pci_dma_dev_setup() (via phb->ops.dma_dev_setup)
		/* fixup is done here */
		pnv_pci_ioda_dma_dev_setup() (via pnv_phb->dma_dev_setup)

The fixup needs to be done before setting up DMA for for the VF's PE,
but there's no real reason to delay it until this point. Move the
fixup into pnv_pci_ioda_fixup_iov() so the ordering is:

	pcibios_add_device()
		pnv_pci_ioda_fixup_iov() (via ppc_md.pcibios_fixup_sriov)

	pcibios_bus_add_device()
		...

This isn't strictly required, but it's a slightly more logical place
to do the fixup and it simplifies pnv_pci_dma_dev_setup().

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20200110070207.439-4-oohall@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 29 +++++++++++++++++++----
 arch/powerpc/platforms/powernv/pci.c      | 14 -----------
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 59de6a5bc41c2..058223233088e 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2900,9 +2900,6 @@ static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
 	struct pci_dn *pdn;
 	int mul, total_vfs;
 
-	if (!pdev->is_physfn || pci_dev_is_added(pdev))
-		return;
-
 	pdn = pci_get_pdn(pdev);
 	pdn->vfs_expanded = 0;
 	pdn->m64_single_mode = false;
@@ -2977,6 +2974,30 @@ truncate_iov:
 		res->end = res->start - 1;
 	}
 }
+
+static void pnv_pci_ioda_fixup_iov(struct pci_dev *pdev)
+{
+	if (WARN_ON(pci_dev_is_added(pdev)))
+		return;
+
+	if (pdev->is_virtfn) {
+		struct pnv_ioda_pe *pe = pnv_ioda_get_pe(pdev);
+
+		/*
+		 * VF PEs are single-device PEs so their pdev pointer needs to
+		 * be set. The pdev doesn't exist when the PE is allocated (in
+		 * (pcibios_sriov_enable()) so we fix it up here.
+		 */
+		pe->pdev = pdev;
+		WARN_ON(!(pe->flags & PNV_IODA_PE_VF));
+	} else if (pdev->is_physfn) {
+		/*
+		 * For PFs adjust their allocated IOV resources to match what
+		 * the PHB can support using it's M64 BAR table.
+		 */
+		pnv_pci_ioda_fixup_iov_resources(pdev);
+	}
+}
 #endif /* CONFIG_PCI_IOV */
 
 static void pnv_ioda_setup_pe_res(struct pnv_ioda_pe *pe,
@@ -3873,7 +3894,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	ppc_md.pcibios_default_alignment = pnv_pci_default_alignment;
 
 #ifdef CONFIG_PCI_IOV
-	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_iov_resources;
+	ppc_md.pcibios_fixup_sriov = pnv_pci_ioda_fixup_iov;
 	ppc_md.pcibios_iov_resource_alignment = pnv_pci_iov_resource_alignment;
 	ppc_md.pcibios_sriov_enable = pnv_pcibios_sriov_enable;
 	ppc_md.pcibios_sriov_disable = pnv_pcibios_sriov_disable;
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index e8e58a2cccddf..8307e1f4086cb 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -814,20 +814,6 @@ void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
 	struct pnv_phb *phb = hose->private_data;
-#ifdef CONFIG_PCI_IOV
-	struct pnv_ioda_pe *pe;
-
-	/* Fix the VF pdn PE number */
-	if (pdev->is_virtfn) {
-		list_for_each_entry(pe, &phb->ioda.pe_list, list) {
-			if (pe->rid == ((pdev->bus->number << 8) |
-			    (pdev->devfn & 0xff))) {
-				pe->pdev = pdev;
-				break;
-			}
-		}
-	}
-#endif /* CONFIG_PCI_IOV */
 
 	if (phb && phb->dma_dev_setup)
 		phb->dma_dev_setup(phb, pdev);
-- 
2.20.1



