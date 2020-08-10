Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00275C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2AA822B47
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073211;
	bh=wb0gAeh4Sp7AWD1vPOJ+O1RCM93uPmnjKx27jOZ44a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PorDCqaKYa98zaNPQ35xjig02Op13oSs7Ql7ztUWR64Rjod3HZCiO08e5xUi2k6Fj
	 Rx9seglkTzjK9SsQlTpmbkOcfdxAX8vztwJxR57+wz6yynf0VX0ggiLJ/gpX9MSE72
	 qh+KhNss92KSkBv7WJorUpYcbP9jq3KPgcLjYz38=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728677AbgHJP0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:60820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbgHJP0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:26:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69B7E22B47;
        Mon, 10 Aug 2020 15:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073206;
        bh=wb0gAeh4Sp7AWD1vPOJ+O1RCM93uPmnjKx27jOZ44a8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jw++vdXkrEjjbRCc1JISIjZiaOnJgVvaBjKMblyW2FdrRkvUojuZ9920Go46/6AdR
         rgB4My/wvlSp9vwU2KCSk0MalQ6h2zlvYLbMTZohynEAmAvkRY4HQmq2Clkeo+QvXa
         Ueuh0UUhR4gpYQD8kyaLHIeT7M1hm5iBG0bgwW/Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Forest Crossman <cyrozap@gmail.com>
Subject: [PATCH 5.4 05/67] usb: xhci: Fix ASMedia ASM1142 DMA addressing
Date:   Mon, 10 Aug 2020 17:20:52 +0200
Message-Id: <20200810151809.698289146@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151809.438685785@linuxfoundation.org>
References: <20200810151809.438685785@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Forest Crossman <cyrozap@gmail.com>

commit ec37198acca7b4c17b96247697406e47aafe0605 upstream.

I've confirmed that the ASMedia ASM1142 has the same problem as the
ASM2142/ASM3142, in that it too reports that it supports 64-bit DMA
addresses when in fact it does not. As with the ASM2142/ASM3142, this
can cause problems on systems where the upper bits matter, and adding
the XHCI_NO_64BIT_SUPPORT quirk completely fixes the issue.

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Forest Crossman <cyrozap@gmail.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200728042408.180529-3-cyrozap@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-pci.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -57,6 +57,7 @@
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_1			0x43bc
 #define PCI_DEVICE_ID_ASMEDIA_1042_XHCI			0x1042
 #define PCI_DEVICE_ID_ASMEDIA_1042A_XHCI		0x1142
+#define PCI_DEVICE_ID_ASMEDIA_1142_XHCI			0x1242
 #define PCI_DEVICE_ID_ASMEDIA_2142_XHCI			0x2142
 
 static const char hcd_name[] = "xhci_hcd";
@@ -253,7 +254,8 @@ static void xhci_pci_quirks(struct devic
 		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042A_XHCI)
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
-		pdev->device == PCI_DEVICE_ID_ASMEDIA_2142_XHCI)
+	    (pdev->device == PCI_DEVICE_ID_ASMEDIA_1142_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_ASMEDIA_2142_XHCI))
 		xhci->quirks |= XHCI_NO_64BIT_SUPPORT;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&


