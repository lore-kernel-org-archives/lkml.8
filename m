Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E39C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B031A2173E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 20:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596053570;
	bh=RgPRubHtzRvlbRg9ogdDSG4+2iJx8zGLpUFQwbaUPYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=seVYPIbptGqutiHBeESxNl5d8jJdBzV9tBCL3oaftq1zf4+32Qr2ugyUjvKAzMcJi
	 c2t5kVYVLoCSoLYhitVMwLH/zwazH5jPSUnxgxmXrbv4/nFhtsTCcdzS+Vw4ICib6Q
	 6ZUfgHD0uE/7kCKH6XCfP2tRClMLN+HHW84FHarc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgG2UMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:12:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbgG2UMq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 16:12:46 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDDB822B47;
        Wed, 29 Jul 2020 20:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596053565;
        bh=RgPRubHtzRvlbRg9ogdDSG4+2iJx8zGLpUFQwbaUPYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XlWlQYXwB1vt7QspClm+mgF2fA6BZhV1oCWREAYW34EumXXV59Ww5QMIpGxWS1Cbz
         bjbtOpMmieydnLd+qeH3iYZVmXm5c1AyEb6IsJ3eOMZTA/5IecDp9SwUX5LWYefYXC
         s0ybHz2GmQa/CNao4gvnVKEx+2rtfl5mJqe1teng=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v3 3/6] PCI: hotplug: Fix kerneldoc
Date:   Wed, 29 Jul 2020 22:12:21 +0200
Message-Id: <20200729201224.26799-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729201224.26799-1-krzk@kernel.org>
References: <20200729201224.26799-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix W=1 compile warnings (invalid kerneldoc):

    drivers/pci/hotplug/acpi_pcihp.c:69: warning: Function parameter or member 'pdev' not described in 'acpi_get_hp_hw_control_from_firmware'
    drivers/pci/hotplug/acpi_pcihp.c:69: warning: Excess function parameter 'dev' description in 'acpi_get_hp_hw_control_from_firmware'
    drivers/pci/hotplug/acpi_pcihp.c:199: warning: Function parameter or member 'handle' not described in 'acpi_pci_detect_ejectable'
    drivers/pci/hotplug/pciehp_core.c:165: warning: Function parameter or member 'ctrl' not described in 'pciehp_check_presence'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pci/hotplug/acpi_pcihp.c  | 4 ++--
 drivers/pci/hotplug/pciehp_core.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/acpi_pcihp.c b/drivers/pci/hotplug/acpi_pcihp.c
index 6b7c1ed58e7e..2750a64cecd3 100644
--- a/drivers/pci/hotplug/acpi_pcihp.c
+++ b/drivers/pci/hotplug/acpi_pcihp.c
@@ -61,7 +61,7 @@ static acpi_status acpi_run_oshp(acpi_handle handle)
 
 /**
  * acpi_get_hp_hw_control_from_firmware
- * @dev: the pci_dev of the bridge that has a hotplug controller
+ * @pdev: the pci_dev of the bridge that has a hotplug controller
  *
  * Attempt to take hotplug control from firmware.
  */
@@ -191,7 +191,7 @@ check_hotplug(acpi_handle handle, u32 lvl, void *context, void **rv)
 
 /**
  * acpi_pci_detect_ejectable - check if the PCI bus has ejectable slots
- * @handle - handle of the PCI bus to scan
+ * @handle: handle of the PCI bus to scan
  *
  * Returns 1 if the PCI bus has ACPI based ejectable slots, 0 otherwise.
  */
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index bf779f291f15..ad3393930ecb 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -153,6 +153,7 @@ static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
 
 /**
  * pciehp_check_presence() - synthesize event if presence has changed
+ * @ctrl: controller to check
  *
  * On probe and resume, an explicit presence check is necessary to bring up an
  * occupied slot or bring down an unoccupied slot.  This can't be triggered by
-- 
2.17.1

