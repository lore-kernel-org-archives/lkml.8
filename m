Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863DFC3F34B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518C920578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812218;
	bh=EPDAFOVc1LpxfvD1XJfeSxsCxC6P3t1+ahkagxs91kI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lg0KlQXqEDH6C3TFNegf1kL4PipALHG2OnA9WcSDTHGBYrVCZVVCCfFjvKLdpxVJR
	 q8oMTbHGC8B64jawiXzl0tSMXkXhjbkrd3KoRIccod0v9jHPVmHsbimeYOEgLiJEz8
	 qkZr9iC0u0lt5dvdl6KeaD/RaL0xnFsBwncGAeag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387451AbgB0ODh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:03:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:38828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387442AbgB0ODc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:03:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4C6B20578;
        Thu, 27 Feb 2020 14:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812211;
        bh=EPDAFOVc1LpxfvD1XJfeSxsCxC6P3t1+ahkagxs91kI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zN38amwVoyO5mgmuN/S7foCUtmlsUi1VjQ2ySQ6rprz02tx8CgoruBjHZcyf6CLoq
         bmJaGl4WIa8lSQNMnSjT4SC0Yz0KkidyvGTmYVjBx4N48udp0FxG79IFlezBkqWg0A
         S375/ey64xfd5pbUThGgMJqdV/DjxVZgYV/cTguY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.19 20/97] xhci: fix runtime pm enabling for quirky Intel hosts
Date:   Thu, 27 Feb 2020 14:36:28 +0100
Message-Id: <20200227132217.920667762@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132214.553656188@linuxfoundation.org>
References: <20200227132214.553656188@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit 024d411e9c5d49eb96c825af52a3ce2682895676 upstream.

Intel hosts that need the XHCI_PME_STUCK_QUIRK flag should enable
runtime pm by calling xhci_pme_acpi_rtd3_enable() before
usb_hcd_pci_probe() calls pci_dev_run_wake().
Otherwise usage count for the device won't be decreased, and runtime
suspend is prevented.

usb_hcd_pci_probe() only decreases the usage count if device can
generate run-time wake-up events, i.e. when pci_dev_run_wake()
returns true.

This issue was exposed by pci_dev_run_wake() change in
commit 8feaec33b986 ("PCI / PM: Always check PME wakeup capability for
runtime wakeup support")
and should be backported to kernels with that change

Cc: <stable@vger.kernel.org> # 4.13+
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20200210134553.9144-4-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-pci.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -283,6 +283,9 @@ static int xhci_pci_setup(struct usb_hcd
 	if (!usb_hcd_is_primary_hcd(hcd))
 		return 0;
 
+	if (xhci->quirks & XHCI_PME_STUCK_QUIRK)
+		xhci_pme_acpi_rtd3_enable(pdev);
+
 	xhci_dbg(xhci, "Got SBRN %u\n", (unsigned int) xhci->sbrn);
 
 	/* Find any debug ports */
@@ -340,9 +343,6 @@ static int xhci_pci_probe(struct pci_dev
 			HCC_MAX_PSA(xhci->hcc_params) >= 4)
 		xhci->shared_hcd->can_do_streams = 1;
 
-	if (xhci->quirks & XHCI_PME_STUCK_QUIRK)
-		xhci_pme_acpi_rtd3_enable(dev);
-
 	/* USB-2 and USB-3 roothubs initialized, allow runtime pm suspend */
 	pm_runtime_put_noidle(&dev->dev);
 


