Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFDEC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DCAB20724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592945693;
	bh=ybiP8M4fMR9oG58tHh6mLgQOdzDSaNee0D+5nBiokzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qUXEni3zWY9JbcgVYawvz3vm/63VLjcLD92oigsaVtk5r+RYiM2Qo/id69J+qKQZx
	 oEapSsa0odcO3S/oveYyKs5D+Y4Y4L2jQKeBdWpV+NadgmgvKn/9EtBw4e/LLmM6Og
	 P8ONrmBR8kvfaknblcLMiEDVhRn/N+wdh+wN4SmQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392742AbgFWUpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:45:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:42826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392644AbgFWUpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:45:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDC552070E;
        Tue, 23 Jun 2020 20:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592945121;
        bh=ybiP8M4fMR9oG58tHh6mLgQOdzDSaNee0D+5nBiokzQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RAE81gDc66SlIU5SVt1/mVrMdhfcsLvPqrJZ+hRS0UsFdUTD2t37oMODXRQCUQG7t
         6NJQqJXrc9LIr6GFb/ZEJdQIXFaOmKQadUGvLpOda48aHokU2xUYFb4HGPSr47E5Db
         QHHkbjHjtbuVXlBmZPBCmALDNcqFuyAOKcsnFDrM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 048/136] PCI/ASPM: Allow ASPM on links to PCIe-to-PCI/PCI-X Bridges
Date:   Tue, 23 Jun 2020 21:58:24 +0200
Message-Id: <20200623195306.065604180@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195303.601828702@linuxfoundation.org>
References: <20200623195303.601828702@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 66ff14e59e8a30690755b08bc3042359703fb07a ]

7d715a6c1ae5 ("PCI: add PCI Express ASPM support") added the ability for
Linux to enable ASPM, but for some undocumented reason, it didn't enable
ASPM on links where the downstream component is a PCIe-to-PCI/PCI-X Bridge.

Remove this exclusion so we can enable ASPM on these links.

The Dell OptiPlex 7080 mentioned in the bugzilla has a TI XIO2001
PCIe-to-PCI Bridge.  Enabling ASPM on the link leading to it allows the
Intel SoC to enter deeper Package C-states, which is a significant power
savings.

[bhelgaas: commit log]
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207571
Link: https://lore.kernel.org/r/20200505173423.26968-1-kai.heng.feng@canonical.com
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aspm.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 400031622b761..04d5c62588b77 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -584,16 +584,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
 	/* Setup initial capable state. Will be updated later */
 	link->aspm_capable = link->aspm_support;
-	/*
-	 * If the downstream component has pci bridge function, don't
-	 * do ASPM for now.
-	 */
-	list_for_each_entry(child, &linkbus->devices, bus_list) {
-		if (pci_pcie_type(child) == PCI_EXP_TYPE_PCI_BRIDGE) {
-			link->aspm_disable = ASPM_STATE_ALL;
-			break;
-		}
-	}
 
 	/* Get and check endpoint acceptable latencies */
 	list_for_each_entry(child, &linkbus->devices, bus_list) {
-- 
2.25.1



