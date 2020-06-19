Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB5FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EA3B2158C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592577836;
	bh=d9zKPQGRM6WNnUeRxiEl6bU9G95v89PXKZSFUxaLP+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h79NHrN16OzKwNnEMF7s3+qMMVYY4nwG0K1BYyWifwe2EQvEzsMq1HrUgWqpBnmy7
	 hVXzWKHhH5r4HPukWUPCU+vnsG31wRY6kVjTSgeYBFFfx/QmRFa2ifBXv2FzPtR5yb
	 mc5gMalx+3iVbLMw37bWz4mfqZC0L7mLhrDQBwFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388512AbgFSOnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:34972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387946AbgFSOnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:43:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A5B121556;
        Fri, 19 Jun 2020 14:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577827;
        bh=d9zKPQGRM6WNnUeRxiEl6bU9G95v89PXKZSFUxaLP+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QB/pSwMu7EdYXbFT1YyZlghY3hPhgy/7V1nI4zdFHdY9D0IGiCa2xu/PIim0RLYq+
         rqAavo4MLwM6Tkky7XJGzROaLVlszAh0456eHmny28+NyRj/qAubHk4eMUQ7P8B+jr
         Yv0ssa95JHtUWMZiwEqOwqqnwUTx6ww0bTT/w+EM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4.9 106/128] PCI: Program MPS for RCiEP devices
Date:   Fri, 19 Jun 2020 16:33:20 +0200
Message-Id: <20200619141625.752300209@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141620.148019466@linuxfoundation.org>
References: <20200619141620.148019466@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashok Raj <ashok.raj@intel.com>

commit aa0ce96d72dd2e1b0dfd0fb868f82876e7790878 upstream.

Root Complex Integrated Endpoints (RCiEPs) do not have an upstream bridge,
so pci_configure_mps() previously ignored them, which may result in reduced
performance.

Instead, program the Max_Payload_Size of RCiEPs to the maximum supported
value (unless it is limited for the PCIE_BUS_PEER2PEER case).  This also
affects the subsequent programming of Max_Read_Request_Size because Linux
programs MRRS based on the MPS value.

Fixes: 9dae3a97297f ("PCI: Move MPS configuration check to pci_configure_device()")
Link: https://lore.kernel.org/r/1585343775-4019-1-git-send-email-ashok.raj@intel.com
Tested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/probe.c |   22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1360,13 +1360,33 @@ static void pci_configure_mps(struct pci
 	struct pci_dev *bridge = pci_upstream_bridge(dev);
 	int mps, p_mps, rc;
 
-	if (!pci_is_pcie(dev) || !bridge || !pci_is_pcie(bridge))
+	if (!pci_is_pcie(dev))
 		return;
 
 	/* MPS and MRRS fields are of type 'RsvdP' for VFs, short-circuit out */
 	if (dev->is_virtfn)
 		return;
 
+	/*
+	 * For Root Complex Integrated Endpoints, program the maximum
+	 * supported value unless limited by the PCIE_BUS_PEER2PEER case.
+	 */
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) {
+		if (pcie_bus_config == PCIE_BUS_PEER2PEER)
+			mps = 128;
+		else
+			mps = 128 << dev->pcie_mpss;
+		rc = pcie_set_mps(dev, mps);
+		if (rc) {
+			pci_warn(dev, "can't set Max Payload Size to %d; if necessary, use \"pci=pcie_bus_safe\" and report a bug\n",
+				 mps);
+		}
+		return;
+	}
+
+	if (!bridge || !pci_is_pcie(bridge))
+		return;
+
 	mps = pcie_get_mps(dev);
 	p_mps = pcie_get_mps(bridge);
 


