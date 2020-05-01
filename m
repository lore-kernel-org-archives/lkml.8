Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC66C47258
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E3F9216FD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340359;
	bh=e7spcapCw09yWb/xBhsKXLncxrnPQacqV3xX+cpc1f4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VDu64Yz5/mVezgNC3oCoVmGS12NWD57rss8XQLWKYRR73M9tTp+5PwqmOhiDlF/8K
	 QCss/KldXjsfz6DXfEqc+rYnqU44arBBrbdtyOpHlpKKmhSLmg8msK+C4RZTBU+iY8
	 BwkuXH5nDFH1oHwIH8GcmZxLOHqdOL2KgHlMPdAU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731166AbgEANjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:39:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:38818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730856AbgEANjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:39:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CC22208DB;
        Fri,  1 May 2020 13:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340351;
        bh=e7spcapCw09yWb/xBhsKXLncxrnPQacqV3xX+cpc1f4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V+E928I3Ndi2ttS2ZZ7LCzh7qlDrgDV+QzYyY+iCDmuCQ/JKHbao9V3biTX+DX+xn
         Jw5RkOAAnwof+LUhxULi64uHZ2X5aCS+c6jMfWNC7F9me0bT/0OctK2enSFfDkkmdI
         6+rc7fFWEUhecOriktYkVGsm8K6dAu7oO3fX93kY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 5.4 30/83] PCI: Avoid ASMedia XHCI USB PME# from D0 defect
Date:   Fri,  1 May 2020 15:23:09 +0200
Message-Id: <20200501131531.459830348@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131524.004332640@linuxfoundation.org>
References: <20200501131524.004332640@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 2880325bda8d53566dcb9725abc929eec871608e upstream.

The ASMedia USB XHCI Controller claims to support generating PME# while
in D0:

  01:00.0 USB controller: ASMedia Technology Inc. Device 2142 (prog-if 30 [XHCI])
    Subsystem: SUNIX Co., Ltd. Device 312b
    Capabilities: [78] Power Management version 3
      Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot-,D3cold-)
      Status: D0 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-

However PME# only gets asserted when plugging USB 2.0 or USB 1.1 devices,
but not for USB 3.0 devices.

Remove PCI_PM_CAP_PME_D0 to avoid using PME under D0.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205919
Link: https://lore.kernel.org/r/20191219192006.16270-1-kai.heng.feng@canonical.com
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/quirks.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5490,3 +5490,14 @@ out_disable:
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
 			      PCI_CLASS_DISPLAY_VGA, 8,
 			      quirk_reset_lenovo_thinkpad_p50_nvgpu);
+
+/*
+ * Device [1b21:2142]
+ * When in D0, PME# doesn't get asserted when plugging USB 3.0 device.
+ */
+static void pci_fixup_no_d0_pme(struct pci_dev *dev)
+{
+	pci_info(dev, "PME# does not work under D0, disabling it\n");
+	dev->pme_support &= ~(PCI_PM_CAP_PME_D0 >> PCI_PM_CAP_PME_SHIFT);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x2142, pci_fixup_no_d0_pme);


