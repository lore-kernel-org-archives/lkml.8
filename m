Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD65C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE4D5207ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgFLQr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:47:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:59068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgFLQr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:47:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3C117ACCF;
        Fri, 12 Jun 2020 16:47:29 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     mbrugger@suse.com, u-boot@lists.denx.de, bmeng.cn@gmail.com,
        marex@denx.de, linux-kernel@vger.kernel.org
Cc:     sjg@chromium.org, m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        mark.kettenis@xs4all.nl,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v4 4/5] dm: pci: Assign controller device node to root bridge
Date:   Fri, 12 Jun 2020 18:46:32 +0200
Message-Id: <20200612164632.25648-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200612164632.25648-1-nsaenzjulienne@suse.de>
References: <20200612164632.25648-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no distinction in DT between the PCI controller device and the
root bridge, whereas such distinction exists from dm's perspective. Make
sure the root bridge ofnode is assigned to the controller's platform
device node.

This permits setups like this to work correctly:

	pcie {
		compatible = "...";
		...
		dev {
			reg = <0 0 0 0 0>;
			...
		};
	};

Without this the dev node is assigned to the root bridge and the
actual device search starts one level lower than expected.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/pci/pci-uclass.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-uclass.c b/drivers/pci/pci-uclass.c
index 9ab3539a49..ea27e78465 100644
--- a/drivers/pci/pci-uclass.c
+++ b/drivers/pci/pci-uclass.c
@@ -762,7 +762,20 @@ static int pci_find_and_bind_driver(struct udevice *parent,
 	str = strdup(name);
 	if (!str)
 		return -ENOMEM;
-	drv = bridge ? "pci_bridge_drv" : "pci_generic_drv";
+
+	if (bridge) {
+		drv = "pci_bridge_drv";
+
+		/*
+		 * If we're dealing with the root bridge pass the parent device
+		 * node, as there isn't a distinction in device tree between
+		 * that and the actual controller platform device.
+		 */
+		if (!PCI_MASK_BUS(bdf))
+			node = parent->node;
+	} else {
+		drv = "pci_generic_drv";
+	}
 
 	ret = device_bind_driver_to_node(parent, drv, str, node, devp);
 	if (ret) {
-- 
2.26.2

