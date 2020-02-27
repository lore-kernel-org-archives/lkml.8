Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AA0C35E17
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C22421D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813630;
	bh=ZY1iDZKCiMk23xFTVQl9UMqSJynqVb1zbUgUTPGQCV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JvsbRIEt03m3o/XMHvEcrXH3vPIxZt1HqAm3Yh9wmNt/88GEn7OKcnWUH/3Rp0G1L
	 9RA1n6DHQ4T0+3y0B5I5NPk/Shy/gCJrW+gvGfMitklc/8uGRMG2CvorP2n9aCNn9d
	 KJr2TGtC0uZU+OiChCokXiKrnwS5RfCFq9+zhGv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388900AbgB0O1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:27:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:47114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388359AbgB0OJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:09:12 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 473F724656;
        Thu, 27 Feb 2020 14:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812551;
        bh=ZY1iDZKCiMk23xFTVQl9UMqSJynqVb1zbUgUTPGQCV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dWla4Yr81OO+kOZpJxUdlEKRQg+YOr3uIPi9RqdJD7YbpP14PEA4Qkbq0pBU+H9Rf
         ewicUkWKaMursYRsLPYqtoJJqrjbIUrMtHjNOhSJyLHv3iCla2h7krFm0rE+G1UjTO
         LCcQY3zwFnFi3wD3Sh6A37eGFKX9HHAXiUNr1wIo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 5.4 024/135] xhci: fix runtime pm enabling for quirky Intel hosts
Date:   Thu, 27 Feb 2020 14:36:04 +0100
Message-Id: <20200227132232.836031603@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132228.710492098@linuxfoundation.org>
References: <20200227132228.710492098@linuxfoundation.org>
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
@@ -302,6 +302,9 @@ static int xhci_pci_setup(struct usb_hcd
 	if (!usb_hcd_is_primary_hcd(hcd))
 		return 0;
 
+	if (xhci->quirks & XHCI_PME_STUCK_QUIRK)
+		xhci_pme_acpi_rtd3_enable(pdev);
+
 	xhci_dbg(xhci, "Got SBRN %u\n", (unsigned int) xhci->sbrn);
 
 	/* Find any debug ports */
@@ -359,9 +362,6 @@ static int xhci_pci_probe(struct pci_dev
 			HCC_MAX_PSA(xhci->hcc_params) >= 4)
 		xhci->shared_hcd->can_do_streams = 1;
 
-	if (xhci->quirks & XHCI_PME_STUCK_QUIRK)
-		xhci_pme_acpi_rtd3_enable(dev);
-
 	/* USB-2 and USB-3 roothubs initialized, allow runtime pm suspend */
 	pm_runtime_put_noidle(&dev->dev);
 


