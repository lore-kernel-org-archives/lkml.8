Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B23C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F88205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597681726;
	bh=kk+CrH7IOe1p7H2iMl5KzGkfjkMVBGSOCBuhbgPNHqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n3QvtjVHKt8WLxa3R5CvhiGZ7TrlnP7l3RSu3klrcKP/5tjYTBKF8y9r0lLELS4u5
	 NXt48v1MIZCBcZW77icu8Lhuq71JX8XD7PXJ26CmWiN31uHnRMK2dDD6jMByMOw8d7
	 8w2zWEXtVhb0T4Ebu2sLEmjYrET7JIRLVz67u3Pc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388810AbgHQQ2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:28:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387853AbgHQPw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:52:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 377FC20729;
        Mon, 17 Aug 2020 15:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679548;
        bh=kk+CrH7IOe1p7H2iMl5KzGkfjkMVBGSOCBuhbgPNHqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NjWO2/uj83AGbIMkaHpsJsCoUYrHMzH6nVTJSHVaCo779aYeHb29xUHDCWOTWMmFA
         92+irDbp4PrgRsW1wWlBbFr+JTHEZT5HRDGdZa0fdNOFdf7BTBKBgNRMET7z53uBcx
         hlPNo1+hDqmWmpE5NvbbmLnLdj2EYQ4rWSGSN2ps=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 250/393] PCI: cadence: Fix cdns_pcie_{host|ep}_setup() error path
Date:   Mon, 17 Aug 2020 17:15:00 +0200
Message-Id: <20200817143831.747611942@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kishon Vijay Abraham I <kishon@ti.com>

[ Upstream commit 19abcd790b51b26d775e1170ba2ac086823cceeb ]

commit bd22885aa188 ("PCI: cadence: Refactor driver to use as a core
library") while refactoring the Cadence PCIe driver to be used as
library, removed pm_runtime_get_sync() from cdns_pcie_ep_setup()
and cdns_pcie_host_setup() but missed to remove the corresponding
pm_runtime_put_sync() in the error path. Fix it here.

Link: https://lore.kernel.org/r/20200722110317.4744-3-kishon@ti.com
Fixes: bd22885aa188 ("PCI: cadence: Refactor driver to use as a core library")
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/cadence/pcie-cadence-ep.c   | 9 ++-------
 drivers/pci/controller/cadence/pcie-cadence-host.c | 6 +-----
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
index 1c173dad67d1d..1fdae37843eff 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
@@ -8,7 +8,6 @@
 #include <linux/of.h>
 #include <linux/pci-epc.h>
 #include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
 #include <linux/sizes.h>
 
 #include "pcie-cadence.h"
@@ -440,8 +439,7 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 	epc = devm_pci_epc_create(dev, &cdns_pcie_epc_ops);
 	if (IS_ERR(epc)) {
 		dev_err(dev, "failed to create epc device\n");
-		ret = PTR_ERR(epc);
-		goto err_init;
+		return PTR_ERR(epc);
 	}
 
 	epc_set_drvdata(epc, ep);
@@ -453,7 +451,7 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 			       resource_size(pcie->mem_res));
 	if (ret < 0) {
 		dev_err(dev, "failed to initialize the memory space\n");
-		goto err_init;
+		return ret;
 	}
 
 	ep->irq_cpu_addr = pci_epc_mem_alloc_addr(epc, &ep->irq_phys_addr,
@@ -472,8 +470,5 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
  free_epc_mem:
 	pci_epc_mem_exit(epc);
 
- err_init:
-	pm_runtime_put_sync(dev);
-
 	return ret;
 }
diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
index 9b1c3966414b1..11eb81da0233f 100644
--- a/drivers/pci/controller/cadence/pcie-cadence-host.c
+++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
@@ -7,7 +7,6 @@
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
 
 #include "pcie-cadence.h"
 
@@ -256,7 +255,7 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 
 	ret = cdns_pcie_host_init(dev, &resources, rc);
 	if (ret)
-		goto err_init;
+		return ret;
 
 	list_splice_init(&resources, &bridge->windows);
 	bridge->dev.parent = dev;
@@ -274,8 +273,5 @@ int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
  err_host_probe:
 	pci_free_resource_list(&resources);
 
- err_init:
-	pm_runtime_put_sync(dev);
-
 	return ret;
 }
-- 
2.25.1



