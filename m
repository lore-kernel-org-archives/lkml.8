Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C50C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1A092186A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592579586;
	bh=dPcaarCTYjvPeBVoPTkeNd1BKWObyV8DX2VYAcMUTc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JNxOcvJSoPhi7kH/Lm/QKdab9CYcpBjyX/GMkWWnvT7z5bcM4hV3ngPB/CKXXyWrO
	 6FF9CTb1MX1x7iTigw0Ozy0Xp9JhyAk1RMcO0A3wowEET6DwG2fKS9Zi3S82lz3Jln
	 yO/U16muCpFUagi3xL0xZt0LUs6IsMnZn57V891Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392218AbgFSPNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:13:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392175AbgFSPMx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:12:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B027321582;
        Fri, 19 Jun 2020 15:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579571;
        bh=dPcaarCTYjvPeBVoPTkeNd1BKWObyV8DX2VYAcMUTc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e15ggPfCRIWn+W9nZXFjkX740g6zVatd3FAibq74sV5liK0lOFG70hFouV4g7q3kA
         FUuy0vDOv3bAFktXEnXIvRfX9rtF1KnX/vF41B31O5EapPSqDPqIsCUzklotngr6k9
         Go8L8cQxlGvM/vOWz0t4VzydYFWf2lPbOjgcSO5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 184/261] PCI: Avoid Pericom USB controller OHCI/EHCI PME# defect
Date:   Fri, 19 Jun 2020 16:33:15 +0200
Message-Id: <20200619141658.733979161@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141649.878808811@linuxfoundation.org>
References: <20200619141649.878808811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 68f5fc4ea9ddf9f77720d568144219c4e6452cde ]

Both Pericom OHCI and EHCI devices advertise PME# support from all power
states:

  06:00.0 USB controller [0c03]: Pericom Semiconductor PI7C9X442SL USB OHCI Controller [12d8:400e] (rev 01) (prog-if 10 [OHCI])
    Subsystem: Pericom Semiconductor PI7C9X442SL USB OHCI Controller [12d8:400e]
    Capabilities: [80] Power Management version 3
      Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)

  06:00.2 USB controller [0c03]: Pericom Semiconductor PI7C9X442SL USB EHCI Controller [12d8:400f] (rev 01) (prog-if 20 [EHCI])
    Subsystem: Pericom Semiconductor PI7C9X442SL USB EHCI Controller [12d8:400f]
    Capabilities: [80] Power Management version 3
      Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)

But testing shows that it's unreliable: there is a 20% chance PME# won't be
asserted when a USB device is plugged.

Remove PME support for both devices to make USB plugging work reliably.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205981
Link: https://lore.kernel.org/r/20200508065343.32751-2-kai.heng.feng@canonical.com
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/quirks.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 798e52051ecc..2e50eec41dc4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5551,6 +5551,19 @@ static void pci_fixup_no_d0_pme(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x2142, pci_fixup_no_d0_pme);
 
+/*
+ * Device [12d8:0x400e] and [12d8:0x400f]
+ * These devices advertise PME# support in all power states but don't
+ * reliably assert it.
+ */
+static void pci_fixup_no_pme(struct pci_dev *dev)
+{
+	pci_info(dev, "PME# is unreliable, disabling it\n");
+	dev->pme_support = 0;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400e, pci_fixup_no_pme);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400f, pci_fixup_no_pme);
+
 static void apex_pci_fixup_class(struct pci_dev *pdev)
 {
 	pdev->class = (PCI_CLASS_SYSTEM_OTHER << 8) | pdev->class;
-- 
2.25.1



