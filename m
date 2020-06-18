Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0447C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78DFF21532
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592445670;
	bh=HXKLX0jkNW57FsNBXYExfJvymlWJBuJcGtHzUpPWnTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DfCaBsopLZH6JL9OedCURNxOoG23P2L4+Tc5XADxEDLj1+MDa70cN/wppd4cG0f6G
	 HPAxmX/WJRrmZ6v+z38bi9/SGLNYP6taseI53p7VkCH7y/KlPr1RBiKsIEs9neqiI5
	 1bSUr4zawPUnXWDZAieQyBXw9qSzcJzPf65FFFzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733284AbgFRCBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:01:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731143AbgFRBYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:24:12 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAC4721D82;
        Thu, 18 Jun 2020 01:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443452;
        bh=HXKLX0jkNW57FsNBXYExfJvymlWJBuJcGtHzUpPWnTI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0oKLxFhaEM2B/ozVOIFurgtfBdXS5y35tFSBMkbvsgGvMWT3u09A02oPF7cdmX1if
         71tnUv/ehCwxyT2mgzCV9mN/08l4NC+fBgSttl2p/g8m4elJrvztjxEg7n0S5GSc2V
         qDVOYdgXKU9UN+kW/ea9zgrRo1Ulj1afkDXLdA54=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>,
        linux-pci@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 087/172] PCI: Fix pci_register_host_bridge() device_register() error handling
Date:   Wed, 17 Jun 2020 21:20:53 -0400
Message-Id: <20200618012218.607130-87-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Herring <robh@kernel.org>

[ Upstream commit 1b54ae8327a4d630111c8d88ba7906483ec6010b ]

If device_register() has an error, we should bail out of
pci_register_host_bridge() rather than continuing on.

Fixes: 37d6a0a6f470 ("PCI: Add pci_register_host_bridge() interface")
Link: https://lore.kernel.org/r/20200513223859.11295-1-robh@kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/probe.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index fa4c386c8cd8..b6f72f09442f 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -818,9 +818,10 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 		goto free;
 
 	err = device_register(&bridge->dev);
-	if (err)
+	if (err) {
 		put_device(&bridge->dev);
-
+		goto free;
+	}
 	bus->bridge = get_device(&bridge->dev);
 	device_enable_async_suspend(bus->bridge);
 	pci_set_bus_of_node(bus);
-- 
2.25.1

