Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43EDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94B7820702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592946287;
	bh=e5olAQa2168Y12AwxA8wag4NGC2SyeuofjYAZkfcgpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lZx5Vf7p1RItFwwDe0GK3r6HCqmGdENtGHg4Zd4r9rCqNtbQEE60RontxepMOW83N
	 oSQH11cx3zG2KU8cy1zBapmqi3f2FOe9q6aMgTG9W7KJcsXhEx+2n0xMomj92hu287
	 pz5OErF4XfUS/0MwzYQYaHj23uRZRI6oqw+aWc1M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391887AbgFWUhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:37:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:32816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391869AbgFWUhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:37:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35DA92080C;
        Tue, 23 Jun 2020 20:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944654;
        bh=e5olAQa2168Y12AwxA8wag4NGC2SyeuofjYAZkfcgpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ui40uzQpDB/QIWVjIfr8/UgAAoJSGMK+cxfP8tmEZ74y3vEmiNmTkikLFMrgTCH5P
         mxLEJAzqIJFzZaa4PR3XKVtMOGHqkWE0Zaw9ba6jLhamP8lxUC+ly5Q29enOc7okUh
         OurQq1lgfrnYlfVh7C/lJgfIAx+ukUiqv9yvf8Ts=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 074/206] PCI/ASPM: Allow ASPM on links to PCIe-to-PCI/PCI-X Bridges
Date:   Tue, 23 Jun 2020 21:56:42 +0200
Message-Id: <20200623195320.585211060@linuxfoundation.org>
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
index db2efa219028c..6e50f84733b75 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -633,16 +633,6 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 
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



