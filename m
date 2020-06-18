Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B48C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC8B720853
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446585;
	bh=8JyAkH6qXlEWTgDmDyyoHedmSsQIwvlwfRUXETdFmJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NVPJfA+HU05XsVkglUZIIKKPMO5zrBxHbyNkQs4Dy7RaZAGans7N4l9nyu20Q6G0w
	 P6Sj6NY8BN21TjsWhs7Vwno9lkJ0nFC/4+Q+UvstQ9W2WGICLRVke1T+yxJsXm6ZI1
	 Iwm2rRowSvwFwnCRZu1JslyKefI1qhNV769sTVbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbgFRCQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:16:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728847AbgFRBUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:20:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03FAD214DB;
        Thu, 18 Jun 2020 01:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443218;
        bh=8JyAkH6qXlEWTgDmDyyoHedmSsQIwvlwfRUXETdFmJo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gsQOL5DcnJjp6p2K1eAJO/20Yy1E1fCnp4RyHVJpBRFnoT33FZYU92j93xd/vst1y
         z+9wgiwsyu0ru9H3EWJ08iqWUPzkelCMpau9CuO/92oq4+GiM4Dvt0z7w3fCDD3JyU
         LoXJ/x1IwGZjcqc5fV6J7TS47gcZbU04ZEhZz0LQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 174/266] PCI: dwc: Fix inner MSI IRQ domain registration
Date:   Wed, 17 Jun 2020 21:14:59 -0400
Message-Id: <20200618011631.604574-174-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 8615f1548882..fbcb211cceb4 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -263,6 +263,8 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
 		return -ENOMEM;
 	}
 
+	irq_domain_update_bus_token(pp->irq_domain, DOMAIN_BUS_NEXUS);
+
 	pp->msi_domain = pci_msi_create_irq_domain(fwnode,
 						   &dw_pcie_msi_domain_info,
 						   pp->irq_domain);
-- 
2.25.1

