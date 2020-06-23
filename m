Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F16C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C1F20702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592946193;
	bh=49qIr2bme5VHBwoOnXrXG2s0Ld5QHMRUkftv5Yy7fkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r96nSwfijaRqTT+eYMb9Y3ULvvsN8oi6002n27uUaKREe4tYsXFHZG4axCCwj+jtK
	 23wrOwMAsev1/ajhQvbwI5mgfIgCGdK63S1hPtawhMhVubXe0ebvDDcrmabhHwe1HW
	 DhQusCUGbdoOsSb+sUvfLi1AnWUkdGbm1kpR8LaM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404293AbgFWVDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:03:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391992AbgFWUit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:38:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 527C0215A4;
        Tue, 23 Jun 2020 20:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944729;
        bh=49qIr2bme5VHBwoOnXrXG2s0Ld5QHMRUkftv5Yy7fkQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GKOOYh7sG8ziYVCWdlBb6vd38csc5JnkK4m2fwGQP6Gw3atY9f5o56J6qt6iia7lT
         QDBCKRessjcUXXhFtol8fVWTT7fUGqx6F8A5nz1liURIEUVwjEYNQabeZMRqS6f2vJ
         cPqZcXv2u8r042QqjSQJwXBgipZbrhgq0JcyXvGs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 103/206] PCI: dwc: Fix inner MSI IRQ domain registration
Date:   Tue, 23 Jun 2020 21:57:11 +0200
Message-Id: <20200623195322.005718151@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <maz@kernel.org>

[ Upstream commit 0414b93e78d87ecc24ae1a7e61fe97deb29fa2f4 ]

On a system that uses the internal DWC MSI widget, I get this
warning from debugfs when CONFIG_GENERIC_IRQ_DEBUGFS is selected:

  debugfs: File ':soc:pcie@fc000000' in directory 'domains' already present!

This is due to the fact that the DWC MSI code tries to register two
IRQ domains for the same firmware node, without telling the low
level code how to distinguish them (by setting a bus token). This
further confuses debugfs which tries to create corresponding
files for each domain.

Fix it by tagging the inner domain as DOMAIN_BUS_NEXUS, which is
the closest thing we have as to "generic MSI".

Link: https://lore.kernel.org/r/20200501113921.366597-1-maz@kernel.org
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Jingoo Han <jingoohan1@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 6d4ef0101ef68..be62f654c8eb7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -285,6 +285,8 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
 		return -ENOMEM;
 	}
 
+	irq_domain_update_bus_token(pp->irq_domain, DOMAIN_BUS_NEXUS);
+
 	pp->msi_domain = pci_msi_create_irq_domain(fwnode,
 						   &dw_pcie_msi_domain_info,
 						   pp->irq_domain);
-- 
2.25.1



