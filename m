Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07B2C52D38
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AFE624656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812295;
	bh=tkX7IT/camgFM6jbO3GLdfGBeihm6AXHJgh2WLvr+38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PuOHRUeos42ZbX9Oyn2VCVzyfyG/kJSHnbweEtTlPIdW5jeHtrNKq57oVyQv0qgbk
	 QWpE5SPxpSotVGj/8hHgXG11JfAX5Ja1iAe10/rF5NqAddh7Rgyugq2gaB6WK9uKRn
	 ouOzAyaQnkHWxfM6CZ17iNh7budMArKEz6aFr/+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387653AbgB0OEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:04:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:40974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387566AbgB0OEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:04:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73F5920578;
        Thu, 27 Feb 2020 14:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812275;
        bh=tkX7IT/camgFM6jbO3GLdfGBeihm6AXHJgh2WLvr+38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BRMTdgaeUSMiZfad1K4XNnhTJlgaArlXLLx+U7q8beRUbqkjMJ/V4gWNgtuEje7BF
         rgQpsvrlK3nC0c9E82jcQRAjTlhoWQIXWYcBE52jq/gW1Xcv6897/CRLwZkGoMXNOC
         2xUzN6hYew+FDixi9DaI/ygoq7z5OQfEiTs83zWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.19 51/97] xhci: apply XHCI_PME_STUCK_QUIRK to Intel Comet Lake platforms
Date:   Thu, 27 Feb 2020 14:36:59 +0100
Message-Id: <20200227132222.924216246@linuxfoundation.org>
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

commit a3ae87dce3a5abe0b57c811bab02b2564b574106 upstream.

Intel Comet Lake based platform require the XHCI_PME_STUCK_QUIRK
quirk as well. Without this xHC can not enter D3 in runtime suspend.

Cc: stable@vger.kernel.org
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20200210134553.9144-5-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-pci.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -41,6 +41,7 @@
 #define PCI_DEVICE_ID_INTEL_BROXTON_B_XHCI		0x1aa8
 #define PCI_DEVICE_ID_INTEL_APL_XHCI			0x5aa8
 #define PCI_DEVICE_ID_INTEL_DNV_XHCI			0x19d0
+#define PCI_DEVICE_ID_INTEL_CML_XHCI			0xa3af
 
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_4			0x43b9
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_3			0x43ba
@@ -179,7 +180,8 @@ static void xhci_pci_quirks(struct devic
 		 pdev->device == PCI_DEVICE_ID_INTEL_BROXTON_M_XHCI ||
 		 pdev->device == PCI_DEVICE_ID_INTEL_BROXTON_B_XHCI ||
 		 pdev->device == PCI_DEVICE_ID_INTEL_APL_XHCI ||
-		 pdev->device == PCI_DEVICE_ID_INTEL_DNV_XHCI)) {
+		 pdev->device == PCI_DEVICE_ID_INTEL_DNV_XHCI ||
+		 pdev->device == PCI_DEVICE_ID_INTEL_CML_XHCI)) {
 		xhci->quirks |= XHCI_PME_STUCK_QUIRK;
 	}
 	if (pdev->vendor == PCI_VENDOR_ID_INTEL &&


