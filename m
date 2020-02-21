Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F3DC35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCD924689
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273162;
	bh=GgJwrUCWdPGyw1CTN1/A7IZ7q3flXT5Vd3XYZc9nzVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0G7bI9FauELSFk1K6kPKgpVPqy9b5AfIGVPrgu+eG6Nm89xCckc5RDD3DNCh8vd26
	 /TKX9COo513uTQ3JSUERrBcWmkq36/QPRSVMAMFhpfC83massS0vJTwaasonXKZ0Db
	 nkcj0xyNQHPvwlJQZwOlwtQISwR176HltJcnraoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387994AbgBUITV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:19:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:57626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733032AbgBUITR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:19:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A38C24692;
        Fri, 21 Feb 2020 08:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582273155;
        bh=GgJwrUCWdPGyw1CTN1/A7IZ7q3flXT5Vd3XYZc9nzVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TCE1gIqBlBoaKuWfLGhDFUegpNqT/xzF5/98fXK51GO0rFDwi0hEtk9yIAM32Uaxd
         H4GtlMYRpQrxeBE6JJqaUsifYohZwcmx1tcW+2kaKPpM9zMu337CNVcn9YMJcaKUUM
         FxkQDW8pnP+qXCfSLtZtKrkBLYPqBz62IjWKrCFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Drake <drake@endlessm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 066/191] PCI: Add generic quirk for increasing D3hot delay
Date:   Fri, 21 Feb 2020 08:40:39 +0100
Message-Id: <20200221072259.310486656@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072250.732482588@linuxfoundation.org>
References: <20200221072250.732482588@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Drake <drake@endlessm.com>

[ Upstream commit 62fe23df067715a21c4aef44068efe7ceaa8f627 ]

Separate the D3 delay increase functionality out of quirk_radeon_pm() into
its own function so that it can be shared with other quirks, including the
AMD Ryzen XHCI quirk that will be introduced in a followup commit.

Tweak the function name and message to indicate more clearly that the delay
relates to a D3hot-to-D0 transition.

Link: https://lore.kernel.org/r/20191127053836.31624-1-drake@endlessm.com
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 84f10cda539ea..798d46a266037 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1848,16 +1848,21 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x2609, quirk_intel_pcie_pm);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260a, quirk_intel_pcie_pm);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x260b, quirk_intel_pcie_pm);
 
+static void quirk_d3hot_delay(struct pci_dev *dev, unsigned int delay)
+{
+	if (dev->d3_delay >= delay)
+		return;
+
+	dev->d3_delay = delay;
+	pci_info(dev, "extending delay after power-on from D3hot to %d msec\n",
+		 dev->d3_delay);
+}
+
 static void quirk_radeon_pm(struct pci_dev *dev)
 {
 	if (dev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
-	    dev->subsystem_device == 0x00e2) {
-		if (dev->d3_delay < 20) {
-			dev->d3_delay = 20;
-			pci_info(dev, "extending delay after power-on from D3 to %d msec\n",
-				 dev->d3_delay);
-		}
-	}
+	    dev->subsystem_device == 0x00e2)
+		quirk_d3hot_delay(dev, 20);
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6741, quirk_radeon_pm);
 
-- 
2.20.1



