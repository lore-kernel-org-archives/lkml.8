Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A18EC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA932064C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218233;
	bh=CtoeY/iV094Q9xMkZINh314p/7c2W56mhxr/mjN84fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=es05lMB9la3A2/3/5vGbOJ5PjrBd/YReK3AO+BcdpBK464tJ6PwM32tFbtbqmJxkg
	 BneYicff/be+aIeICRZrVCxaiw6gKpa1jzykKdHHphW2p/vNOE+gPp7tzstFi6z6F3
	 SknobLopVEyDrWK8b32grnM311mYN9kEs485rjtw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391802AbgAPXnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:43:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:53800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388071AbgAPXYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:24:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A913E2072B;
        Thu, 16 Jan 2020 23:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217079;
        bh=CtoeY/iV094Q9xMkZINh314p/7c2W56mhxr/mjN84fA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NSrPPIBK6Vi7+PRM3HY5qAAw8/anWPn9MM3Vb3dNecaVRq1aW6dAdxK4aJPWRkgkp
         aeTyLAWyxnQQTqcYd7YFr1rceYaIFfmN43qMuFmlH/jxWALBosB+Ee0Y6jBgUxOQ7v
         6oYVCW6ADhAaAeCXwXnfSwrObIF/gtQ4ban8qhEY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.4 123/203] PCI: pciehp: Do not disable interrupt twice on suspend
Date:   Fri, 17 Jan 2020 00:17:20 +0100
Message-Id: <20200116231756.034414476@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 75fcc0ce72e5cea2e357cdde858216c5bad40442 upstream.

We try to keep PCIe hotplug ports runtime suspended when entering system
suspend. Because the PCIe portdrv sets the DPM_FLAG_NEVER_SKIP flag, the PM
core always calls system suspend/resume hooks even if the device is left
runtime suspended. Since PCIe hotplug driver re-used the same function for
both runtime suspend and system suspend, it ended up disabling hotplug
interrupt twice and the second time following was printed:

  pciehp 0000:03:01.0:pcie204: pcie_do_write_cmd: no response from device

Prevent this from happening by checking whether the device is already
runtime suspended when the system suspend hook is called.

Fixes: 9c62f0bfb832 ("PCI: pciehp: Implement runtime PM callbacks")
Link: https://lore.kernel.org/r/20191029170022.57528-1-mika.westerberg@linux.intel.com
Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/hotplug/pciehp_core.c |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -253,7 +253,7 @@ static bool pme_is_native(struct pcie_de
 	return pcie_ports_native || host->native_pme;
 }
 
-static int pciehp_suspend(struct pcie_device *dev)
+static void pciehp_disable_interrupt(struct pcie_device *dev)
 {
 	/*
 	 * Disable hotplug interrupt so that it does not trigger
@@ -261,7 +261,19 @@ static int pciehp_suspend(struct pcie_de
 	 */
 	if (pme_is_native(dev))
 		pcie_disable_interrupt(get_service_data(dev));
+}
 
+#ifdef CONFIG_PM_SLEEP
+static int pciehp_suspend(struct pcie_device *dev)
+{
+	/*
+	 * If the port is already runtime suspended we can keep it that
+	 * way.
+	 */
+	if (dev_pm_smart_suspend_and_suspended(&dev->port->dev))
+		return 0;
+
+	pciehp_disable_interrupt(dev);
 	return 0;
 }
 
@@ -279,6 +291,7 @@ static int pciehp_resume_noirq(struct pc
 
 	return 0;
 }
+#endif
 
 static int pciehp_resume(struct pcie_device *dev)
 {
@@ -292,6 +305,12 @@ static int pciehp_resume(struct pcie_dev
 	return 0;
 }
 
+static int pciehp_runtime_suspend(struct pcie_device *dev)
+{
+	pciehp_disable_interrupt(dev);
+	return 0;
+}
+
 static int pciehp_runtime_resume(struct pcie_device *dev)
 {
 	struct controller *ctrl = get_service_data(dev);
@@ -318,10 +337,12 @@ static struct pcie_port_service_driver h
 	.remove		= pciehp_remove,
 
 #ifdef	CONFIG_PM
+#ifdef	CONFIG_PM_SLEEP
 	.suspend	= pciehp_suspend,
 	.resume_noirq	= pciehp_resume_noirq,
 	.resume		= pciehp_resume,
-	.runtime_suspend = pciehp_suspend,
+#endif
+	.runtime_suspend = pciehp_runtime_suspend,
 	.runtime_resume	= pciehp_runtime_resume,
 #endif	/* PM */
 };


