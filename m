Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2766C32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 905D620708
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864446;
	bh=og2uotmDeRDjJTN/nd6do6PDfecSGLJOpdb1Cn5ICwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jBO0BrqhGJlxc3TnHn9r7gETE2gEfva53E4pYe/z0ZTc04g5LMkkrcD5Cq6f0whGV
	 qjGTfxRenk8aIa0/OlH5c8wwFZWWkwcG9zovilhBGQbkRm75ZS32QG1o2ipnxWWpOR
	 az5P7qbonnhvUt9nqQpljgBzH4IU6Iqm2SOmDtX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389495AbgAXLOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:14:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:50338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389365AbgAXLN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:13:58 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E790E20663;
        Fri, 24 Jan 2020 11:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864437;
        bh=og2uotmDeRDjJTN/nd6do6PDfecSGLJOpdb1Cn5ICwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VeYtTjWKHfPWJMUMgn9uN3A2Q2jF3GzpIfi9GQN6bFENKjyJUy1Y+CZgQU0taOtHl
         lcaBKhfVw/LcKI81rxR+T1+pG8aT9UrcOOnQmKxbOtNa+EtxNOUJomCCSBMvRe8YiG
         I0teoP4pA7W9KxM+y9iGJmKeo5aFYyuZR6Hl67CQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sinan Kaya <okaya@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 252/639] PCI: Fix "try" semantics of bus and slot reset
Date:   Fri, 24 Jan 2020 10:27:02 +0100
Message-Id: <20200124093118.296206844@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Williamson <alex.williamson@redhat.com>

[ Upstream commit ddefc033eecf23f1e8b81d0663c5db965adf5516 ]

The commit referenced below introduced device locking around save and
restore of state for each device during a PCI bus "try" reset, making it
decidely non-"try" and prone to deadlock in the event that a device is
already locked.  Restore __pci_reset_bus() and __pci_reset_slot() to their
advertised locking semantics by pushing the save and restore functions into
the branch where the entire tree is already locked.  Extend the helper
function names with "_locked" and update the comment to reflect this
calling requirement.

Fixes: b014e96d1abb ("PCI: Protect pci_error_handlers->reset_notify() usage with device_lock()")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Sinan Kaya <okaya@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.c | 54 +++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index c9f51fc24563c..57a87a001b4f4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5039,39 +5039,42 @@ unlock:
 	return 0;
 }
 
-/* Save and disable devices from the top of the tree down */
-static void pci_bus_save_and_disable(struct pci_bus *bus)
+/*
+ * Save and disable devices from the top of the tree down while holding
+ * the @dev mutex lock for the entire tree.
+ */
+static void pci_bus_save_and_disable_locked(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		pci_dev_lock(dev);
 		pci_dev_save_and_disable(dev);
-		pci_dev_unlock(dev);
 		if (dev->subordinate)
-			pci_bus_save_and_disable(dev->subordinate);
+			pci_bus_save_and_disable_locked(dev->subordinate);
 	}
 }
 
 /*
- * Restore devices from top of the tree down - parent bridges need to be
- * restored before we can get to subordinate devices.
+ * Restore devices from top of the tree down while holding @dev mutex lock
+ * for the entire tree.  Parent bridges need to be restored before we can
+ * get to subordinate devices.
  */
-static void pci_bus_restore(struct pci_bus *bus)
+static void pci_bus_restore_locked(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		pci_dev_lock(dev);
 		pci_dev_restore(dev);
-		pci_dev_unlock(dev);
 		if (dev->subordinate)
-			pci_bus_restore(dev->subordinate);
+			pci_bus_restore_locked(dev->subordinate);
 	}
 }
 
-/* Save and disable devices from the top of the tree down */
-static void pci_slot_save_and_disable(struct pci_slot *slot)
+/*
+ * Save and disable devices from the top of the tree down while holding
+ * the @dev mutex lock for the entire tree.
+ */
+static void pci_slot_save_and_disable_locked(struct pci_slot *slot)
 {
 	struct pci_dev *dev;
 
@@ -5080,26 +5083,25 @@ static void pci_slot_save_and_disable(struct pci_slot *slot)
 			continue;
 		pci_dev_save_and_disable(dev);
 		if (dev->subordinate)
-			pci_bus_save_and_disable(dev->subordinate);
+			pci_bus_save_and_disable_locked(dev->subordinate);
 	}
 }
 
 /*
- * Restore devices from top of the tree down - parent bridges need to be
- * restored before we can get to subordinate devices.
+ * Restore devices from top of the tree down while holding @dev mutex lock
+ * for the entire tree.  Parent bridges need to be restored before we can
+ * get to subordinate devices.
  */
-static void pci_slot_restore(struct pci_slot *slot)
+static void pci_slot_restore_locked(struct pci_slot *slot)
 {
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
 		if (!dev->slot || dev->slot != slot)
 			continue;
-		pci_dev_lock(dev);
 		pci_dev_restore(dev);
-		pci_dev_unlock(dev);
 		if (dev->subordinate)
-			pci_bus_restore(dev->subordinate);
+			pci_bus_restore_locked(dev->subordinate);
 	}
 }
 
@@ -5158,17 +5160,15 @@ static int __pci_reset_slot(struct pci_slot *slot)
 	if (rc)
 		return rc;
 
-	pci_slot_save_and_disable(slot);
-
 	if (pci_slot_trylock(slot)) {
+		pci_slot_save_and_disable_locked(slot);
 		might_sleep();
 		rc = pci_reset_hotplug_slot(slot->hotplug, 0);
+		pci_slot_restore_locked(slot);
 		pci_slot_unlock(slot);
 	} else
 		rc = -EAGAIN;
 
-	pci_slot_restore(slot);
-
 	return rc;
 }
 
@@ -5254,17 +5254,15 @@ static int __pci_reset_bus(struct pci_bus *bus)
 	if (rc)
 		return rc;
 
-	pci_bus_save_and_disable(bus);
-
 	if (pci_bus_trylock(bus)) {
+		pci_bus_save_and_disable_locked(bus);
 		might_sleep();
 		rc = pci_bridge_secondary_bus_reset(bus->self);
+		pci_bus_restore_locked(bus);
 		pci_bus_unlock(bus);
 	} else
 		rc = -EAGAIN;
 
-	pci_bus_restore(bus);
-
 	return rc;
 }
 
-- 
2.20.1



