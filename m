Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A9EC4332E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1878F2098B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584564911;
	bh=XBgTFlX9YXtui+urJgbxobj6L9lBEdzNQiE1J9yXk+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=scE2GJlqvMc7c+LXRWAerz+2G2VOw0AniHXAiV6Fg1AQr1I8xIdngEmj8I0+xwpZD
	 x74v+zB16ZfBV9CaNlZAfTLsJNHWdnVtE587Ro8IkWpeIhezgjbBOqNxG5YRjHsKuj
	 h+Kw67RK9zbszNkot3bgY//2g5Bl8NThiTRdHUj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbgCRUzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728189AbgCRUzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:55:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47BFB2098B;
        Wed, 18 Mar 2020 20:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584564905;
        bh=XBgTFlX9YXtui+urJgbxobj6L9lBEdzNQiE1J9yXk+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q7u/QirphnINASAo0xmnOL3SrLXd0rrOrbkHtahdFJp+b8ItBchgga8IW6CnP2dEe
         dhXKG+YRyXbkvMc0tblbWN6DzvrR31/PsoCtQFhcR23aXQZsL85BBMHJy9t1Qmg2Ii
         d6sW1hevZch0rTcQv9PFmu30WKEDTIFRydxoWkH0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Drake <drake@endlessm.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.4 71/73] iommu/vt-d: Ignore devices with out-of-spec domain number
Date:   Wed, 18 Mar 2020 16:53:35 -0400
Message-Id: <20200318205337.16279-71-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205337.16279-1-sashal@kernel.org>
References: <20200318205337.16279-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Drake <drake@endlessm.com>

[ Upstream commit da72a379b2ec0bad3eb265787f7008bead0b040c ]

VMD subdevices are created with a PCI domain ID of 0x10000 or
higher.

These subdevices are also handled like all other PCI devices by
dmar_pci_bus_notifier().

However, when dmar_alloc_pci_notify_info() take records of such devices,
it will truncate the domain ID to a u16 value (in info->seg).
The device at (e.g.) 10000:00:02.0 is then treated by the DMAR code as if
it is 0000:00:02.0.

In the unlucky event that a real device also exists at 0000:00:02.0 and
also has a device-specific entry in the DMAR table,
dmar_insert_dev_scope() will crash on:
   BUG_ON(i >= devices_cnt);

That's basically a sanity check that only one PCI device matches a
single DMAR entry; in this case we seem to have two matching devices.

Fix this by ignoring devices that have a domain number higher than
what can be looked up in the DMAR table.

This problem was carefully diagnosed by Jian-Hong Pan.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Fixes: 59ce0515cdaf3 ("iommu/vt-d: Update DRHD/RMRR/ATSR device scope caches when PCI hotplug happens")
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/dmar.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
index aa15155b9401f..34e705d3b6bb6 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/iommu.h>
 #include <linux/numa.h>
+#include <linux/limits.h>
 #include <asm/irq_remapping.h>
 #include <asm/iommu_table.h>
 
@@ -128,6 +129,13 @@ dmar_alloc_pci_notify_info(struct pci_dev *dev, unsigned long event)
 
 	BUG_ON(dev->is_virtfn);
 
+	/*
+	 * Ignore devices that have a domain number higher than what can
+	 * be looked up in DMAR, e.g. VMD subdevices with domain 0x10000
+	 */
+	if (pci_domain_nr(dev->bus) > U16_MAX)
+		return NULL;
+
 	/* Only generate path[] for device addition event */
 	if (event == BUS_NOTIFY_ADD_DEVICE)
 		for (tmp = dev; tmp; tmp = tmp->bus->self)
-- 
2.20.1

