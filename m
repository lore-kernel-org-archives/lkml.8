Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80D5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A853B2465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579686838;
	bh=K88eFO0gZvTi7Q0tnhqHBPO9ATbtplrOKROOFSFdn1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nxhz+V6z0zThlDWXbvi8PGdYP5oqUNxvv71oPfWGR38e9+/CVIR2PsnVPVjUg/32X
	 GWFcKipeul1rbhIopjL5PXkAZ0HVJyTQ1+vjI6fmJZ1ctQVXQ2AXH+qa40V16UVeVd
	 JqSLPfNsv3kxRrLBIHiGame65otWvR2ewIvOHiKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbgAVJx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:53:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:49204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730249AbgAVJei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:34:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B92A24672;
        Wed, 22 Jan 2020 09:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685677;
        bh=K88eFO0gZvTi7Q0tnhqHBPO9ATbtplrOKROOFSFdn1Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EPG4AMzTr4s74GXAGPLgwDtDByQqxX8Puvpn+J6DYbEniyOG7SsVsYX6HnT9jy5d5
         Awmes0uOMQtG23Zl6JzQEkXlw8lY4yJJz7wIqr2zrUY/WC5o4+gtN7kq0IOqnqzwQr
         h2pPROALnE6iQzDcefIyvAstAsZqjZsmrKMB/oU8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver OHalloran <oohall@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.9 34/97] powerpc/powernv: Disable native PCIe port management
Date:   Wed, 22 Jan 2020 10:28:38 +0100
Message-Id: <20200122092801.991898907@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
References: <20200122092755.678349497@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oliver O'Halloran <oohall@gmail.com>

commit 9d72dcef891030545f39ad386a30cf91df517fb2 upstream.

On PowerNV the PCIe topology is (currently) managed by the powernv platform
code in Linux in cooperation with the platform firmware. Linux's native
PCIe port service drivers operate independently of both and this can cause
problems.

The main issue is that the portbus driver will conflict with the platform
specific hotplug driver (pnv_php) over ownership of the MSI used to notify
the host when a hotplug event occurs. The portbus driver claims this MSI on
behalf of the individual port services because the same interrupt is used
for hotplug events, PMEs (on root ports), and link bandwidth change
notifications. The portbus driver will always claim the interrupt even if
the individual port service drivers, such as pciehp, are compiled out.

The second, bigger, problem is that the hotplug port service driver
fundamentally does not work on PowerNV. The platform assumes that all
PCI devices have a corresponding arch-specific handle derived from the DT
node for the device (pci_dn) and without one the platform will not allow
a PCI device to be enabled. This problem is largely due to historical
baggage, but it can't be resolved without significant re-factoring of the
platform PCI support.

We can fix these problems in the interim by setting the
"pcie_ports_disabled" flag during platform initialisation. The flag
indicates the platform owns the PCIe ports which stops the portbus driver
from being registered.

This does have the side effect of disabling all port services drivers
that is: AER, PME, BW notifications, hotplug, and DPC. However, this is
not a huge disadvantage on PowerNV since these services are either unused
or handled through other means.

Fixes: 66725152fb9f ("PCI/hotplug: PowerPC PowerNV PCI hotplug driver")
Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/r/20191118065553.30362-1-oohall@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/platforms/powernv/pci.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -923,6 +923,23 @@ void __init pnv_pci_init(void)
 	if (!firmware_has_feature(FW_FEATURE_OPAL))
 		return;
 
+#ifdef CONFIG_PCIEPORTBUS
+	/*
+	 * On PowerNV PCIe devices are (currently) managed in cooperation
+	 * with firmware. This isn't *strictly* required, but there's enough
+	 * assumptions baked into both firmware and the platform code that
+	 * it's unwise to allow the portbus services to be used.
+	 *
+	 * We need to fix this eventually, but for now set this flag to disable
+	 * the portbus driver. The AER service isn't required since that AER
+	 * events are handled via EEH. The pciehp hotplug driver can't work
+	 * without kernel changes (and portbus binding breaks pnv_php). The
+	 * other services also require some thinking about how we're going
+	 * to integrate them.
+	 */
+	pcie_ports_disabled = true;
+#endif
+
 	/* Look for IODA IO-Hubs. */
 	for_each_compatible_node(np, NULL, "ibm,ioda-hub") {
 		pnv_pci_init_ioda_hub(np);


