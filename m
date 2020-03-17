Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0EDC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36208205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584442794;
	bh=UDa2qWXHYHGSlYmI++u0oX+jPfDfyrUcCkVb2ISSQnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f0yuGkg+q/0DHE6NGuC0jzHtrtGgI4BlwB+Z37k4xOXvkRdNWAr74Wanf0vRIf+zf
	 lKywSYLLl6hJb+j3bo3B4lCCVTlmAMmDoagf6J0IRMuCFuhYAkeuuZ1fkRGirsj3O0
	 +ZgutxiOCVAokgM7AiIlwjbYaFKHx6CZ9eTk8sDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgCQK7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:59:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgCQK7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:59:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A07F20658;
        Tue, 17 Mar 2020 10:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584442789;
        bh=UDa2qWXHYHGSlYmI++u0oX+jPfDfyrUcCkVb2ISSQnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=v4U4mfRLgv3/mlyL+G2U2cLqKdRR14HjtEQXyWK4wGhzS6nWexwW04SxP4IFIRqSV
         /HbOcLkyOb35aA8aU+km9uxD7AswgFEYXhpgxI6vnJQ95NqMlaGv5jwtrxAJph2gGK
         ZLumCiFKotPT9rx2p0gEevgIBd0WATQpIqJCw5qo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Daniel Drake <drake@endlessm.com>,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 4.19 83/89] iommu/vt-d: Ignore devices with out-of-spec domain number
Date:   Tue, 17 Mar 2020 11:55:32 +0100
Message-Id: <20200317103309.636095095@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103259.744774526@linuxfoundation.org>
References: <20200317103259.744774526@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Drake <drake@endlessm.com>

commit da72a379b2ec0bad3eb265787f7008bead0b040c upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/iommu/dmar.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/dmar.c
@@ -39,6 +39,7 @@
 #include <linux/dmi.h>
 #include <linux/slab.h>
 #include <linux/iommu.h>
+#include <linux/limits.h>
 #include <asm/irq_remapping.h>
 #include <asm/iommu_table.h>
 
@@ -139,6 +140,13 @@ dmar_alloc_pci_notify_info(struct pci_de
 
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


