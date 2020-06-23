Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AEEDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C45602072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948222;
	bh=PfoDjZcxUjZx5UEqy5DdFaGjmuvbOOHvh6MYV1tTNJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wyxR9Whax78R5fnY9sTBvR89iP21MmsRz5xbdNGsSQzJ7yZfwPYYDB2HIjVGSvYF6
	 TycGLI7VnVbRAlC4ss1WnAMkCzDNnnUKCv8v5U5ta37KTMUDS+ORGUwmw0FfBNCAHG
	 z+fhSWqO4Xt+5rUhd6ffpC+Vk38SDLDcMKhtKXJg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393640AbgFWVhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:37:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:50482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388709AbgFWUJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:09:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 44DC3206C3;
        Tue, 23 Jun 2020 20:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942963;
        bh=PfoDjZcxUjZx5UEqy5DdFaGjmuvbOOHvh6MYV1tTNJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GCEbSfe5kH0JVhb+7+3ERFgCCQKLxpGtE/71DOYgo8zCWgsVZl8ilosPsxzRPk8fP
         SfY2cRUFbQI0YZbH1no7dxsMvGsuqIf9bwd3k4/GTYY1koz06zO5Ij8h3D2LxDOCRr
         X70GisMgerjTdA4Q70WEZeYxLQeHhv5W+08U/6/M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 174/477] PCI/ASPM: Allow ASPM on links to PCIe-to-PCI/PCI-X Bridges
Date:   Tue, 23 Jun 2020 21:52:51 +0200
Message-Id: <20200623195415.809201245@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
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
index 2378ed6925346..b17e5ffd31b14 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -628,16 +628,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
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



