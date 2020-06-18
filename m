Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BD9BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55DFC20776
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592448586;
	bh=l54CqOz0uSs8AddQVZzgNs0xuz84Etvn0zA6jW/HTAs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ASMtaF6OHSXMG8wVUF56gGaDrTXpv2Rw7wHD1OlqWDYFe6UZaME0vRB7paB10wD8v
	 H1xi7W1pie/s55yGDIyXHLf593c19QVvQs99ru3fhczmG1fXe6vVSsGCQTf3xtKDYJ
	 PmW/jiFWgvXanPPbz0px4MKqhxDEhGqywcpLM0uE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgFRCto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:49:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728212AbgFRBJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:09:33 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7402121D81;
        Thu, 18 Jun 2020 01:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442573;
        bh=l54CqOz0uSs8AddQVZzgNs0xuz84Etvn0zA6jW/HTAs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W4AQNv58ibtWAcdcNvfYwYwcK07oNEpefqeHEjNxa5YMW9FWGsEPXYuLemZkoWMmu
         5/jrIEobVCdSIGl2tOgrrr8k8XpCWF6o0xOggXEkOIg/oGmhtsnwkJPjfhsusf+l1s
         mZX/lRkYi4dIHuZAZUtY5l2CGp8sWRPcPyJFB3lo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jon Derrick <jonathan.derrick@intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 066/388] PCI: pci-bridge-emul: Fix PCIe bit conflicts
Date:   Wed, 17 Jun 2020 21:02:43 -0400
Message-Id: <20200618010805.600873-66-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jon Derrick <jonathan.derrick@intel.com>

[ Upstream commit c88d19181771bd189147681ef38fc1533ebeff4c ]

This patch fixes two bit conflicts in the pci-bridge-emul driver:

1. Bit 3 of Device Status (19 of Device Control) is marked as both
   Write-1-to-Clear and Read-Only. It should be Write-1-to-Clear.
   The Read-Only and Reserved bitmasks are shifted by 1 bit due to this
   error.

2. Bit 12 of Slot Control is marked as both Read-Write and Reserved.
   It should be Read-Write.

Link: https://lore.kernel.org/r/20200511162117.6674-2-jonathan.derrick@intel.com
Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci-bridge-emul.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-bridge-emul.c b/drivers/pci/pci-bridge-emul.c
index 4f4f54bc732e..faa414655f33 100644
--- a/drivers/pci/pci-bridge-emul.c
+++ b/drivers/pci/pci-bridge-emul.c
@@ -185,8 +185,8 @@ static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
 		 * RO, the rest is reserved
 		 */
 		.w1c = GENMASK(19, 16),
-		.ro = GENMASK(20, 19),
-		.rsvd = GENMASK(31, 21),
+		.ro = GENMASK(21, 20),
+		.rsvd = GENMASK(31, 22),
 	},
 
 	[PCI_EXP_LNKCAP / 4] = {
@@ -226,7 +226,7 @@ static const struct pci_bridge_reg_behavior pcie_cap_regs_behavior[] = {
 			PCI_EXP_SLTSTA_CC | PCI_EXP_SLTSTA_DLLSC) << 16,
 		.ro = (PCI_EXP_SLTSTA_MRLSS | PCI_EXP_SLTSTA_PDS |
 		       PCI_EXP_SLTSTA_EIS) << 16,
-		.rsvd = GENMASK(15, 12) | (GENMASK(15, 9) << 16),
+		.rsvd = GENMASK(15, 13) | (GENMASK(15, 9) << 16),
 	},
 
 	[PCI_EXP_RTCTL / 4] = {
-- 
2.25.1

