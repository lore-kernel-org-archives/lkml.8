Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CEFC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14787207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200205;
	bh=fkPfx7FBP+Ggj32Xsgs2UkYwvKmzcZG3lQhFWilS1Hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iRQ17Wdktl0mMJf2qAncO8zBUGILXGQ4471pDdIIojDry/1w/UjpgbnCFiGToMkp9
	 MhloDdPjgSUChoqDxYQ85OnfmwRmp9y9h0dlLgzzKF5jT4r6axmSNgUYwV4oXurO/a
	 58lQq0R4c7/9w4sw9R1vI0QmE2Gu5ixktn783c/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390199AbgAPRLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:11:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:51282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390177AbgAPRLM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:11:12 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3E1F21D56;
        Thu, 16 Jan 2020 17:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194671;
        bh=fkPfx7FBP+Ggj32Xsgs2UkYwvKmzcZG3lQhFWilS1Hg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bhyCWdP9qV45F3A6lcAqietBQ8h3rR/Al/Kn50zj/VPBhmPyx6/BpbnSlhu4cAOFp
         W9ShKEAfkSSmsrnOTabwRK1Dkq3KBphkK6Uo6b99NiFxbFUgB8NCHLUcVOybkHamFA
         qSvuYsaoFTEVytxrNWg6SxhNT/CQQuzrUkaYhKV8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dexuan Cui <decui@microsoft.com>, Lili Deng <v-lide@microsoft.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 519/671] irqdomain: Add the missing assignment of domain->fwnode for named fwnode
Date:   Thu, 16 Jan 2020 12:02:37 -0500
Message-Id: <20200116170509.12787-256-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>

[ Upstream commit 711419e504ebd68c8f03656616829c8ad7829389 ]

Recently device pass-through stops working for Linux VM running on Hyper-V.

git-bisect shows the regression is caused by the recent commit
467a3bb97432 ("PCI: hv: Allocate a named fwnode ..."), but the root cause
is that the commit d59f6617eef0 forgets to set the domain->fwnode for
IRQCHIP_FWNODE_NAMED*, and as a result:

1. The domain->fwnode remains to be NULL.

2. irq_find_matching_fwspec() returns NULL since "h->fwnode == fwnode" is
false, and pci_set_bus_msi_domain() sets the Hyper-V PCI root bus's
msi_domain to NULL.

3. When the device is added onto the root bus, the device's dev->msi_domain
is set to NULL in pci_set_msi_domain().

4. When a device driver tries to enable MSI-X, pci_msi_setup_msi_irqs()
calls arch_setup_msi_irqs(), which uses the native MSI chip (i.e.
arch/x86/kernel/apic/msi.c: pci_msi_controller) to set up the irqs, but
actually pci_msi_setup_msi_irqs() is supposed to call
msi_domain_alloc_irqs() with the hbus->irq_domain, which is created in
hv_pcie_init_irq_domain() and is associated with the Hyper-V chip
hv_msi_irq_chip. Consequently, the irq line is not properly set up, and
the device driver can not receive any interrupt.

Fixes: d59f6617eef0 ("genirq: Allow fwnode to carry name information only")
Fixes: 467a3bb97432 ("PCI: hv: Allocate a named fwnode instead of an address-based one")
Reported-by: Lili Deng <v-lide@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/PU1P153MB01694D9AF625AC335C600C5FBFBE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/irq/irqdomain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 0b90be360724..6e8520a81dd8 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -148,6 +148,7 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, int size,
 		switch (fwid->type) {
 		case IRQCHIP_FWNODE_NAMED:
 		case IRQCHIP_FWNODE_NAMED_ID:
+			domain->fwnode = fwnode;
 			domain->name = kstrdup(fwid->name, GFP_KERNEL);
 			if (!domain->name) {
 				kfree(domain);
-- 
2.20.1

