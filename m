Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F92C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1736822B4B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597072804;
	bh=3X7s2lFTfOUlpo3YbsSrxkM+p5Ee7qer5W9pPiGJ1Ks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bSMSSs0cKcXpkm42p7f80XW7K8oDyc3+xbFBmk4x3aLZETys+UCNzvRKkLwfoRzHx
	 TpxrnThnQXC5jU4Hkr4nOvGhSh+jbNpvvlh300TcXsvOMUcWn7rNnyIRiowv/w78dW
	 DZhCGGvDG5WpZUV64iozVdunGXujb6QJJp17WXN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgHJPUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:50068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727848AbgHJPTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:19:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AAA32075F;
        Mon, 10 Aug 2020 15:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597072794;
        bh=3X7s2lFTfOUlpo3YbsSrxkM+p5Ee7qer5W9pPiGJ1Ks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RzfvgDTP6fhBNF3A6uyz5BFsON7bjnuOdr4TYz74KvNncgLO/AfwImh+i61r8s/iw
         YkT9GQk9ig65gB0hQ5e6uOhU4jmp2IHa2ZXQt9srmiRnT7oI2OZ1CV+J+E52r/UNr3
         ObmErO0OcxrvZsTwh4BYwhPmiI7TjpkmEqunOdOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Forest Crossman <cyrozap@gmail.com>
Subject: [PATCH 5.8 05/38] usb: xhci: Fix ASMedia ASM1142 DMA addressing
Date:   Mon, 10 Aug 2020 17:18:55 +0200
Message-Id: <20200810151804.158216098@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151803.920113428@linuxfoundation.org>
References: <20200810151803.920113428@linuxfoundation.org>
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
@@ -59,6 +59,7 @@
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_1			0x43bc
 #define PCI_DEVICE_ID_ASMEDIA_1042_XHCI			0x1042
 #define PCI_DEVICE_ID_ASMEDIA_1042A_XHCI		0x1142
+#define PCI_DEVICE_ID_ASMEDIA_1142_XHCI			0x1242
 #define PCI_DEVICE_ID_ASMEDIA_2142_XHCI			0x2142
 
 static const char hcd_name[] = "xhci_hcd";
@@ -268,7 +269,8 @@ static void xhci_pci_quirks(struct devic
 		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042A_XHCI)
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
-		pdev->device == PCI_DEVICE_ID_ASMEDIA_2142_XHCI)
+	    (pdev->device == PCI_DEVICE_ID_ASMEDIA_1142_XHCI ||
+	     pdev->device == PCI_DEVICE_ID_ASMEDIA_2142_XHCI))
 		xhci->quirks |= XHCI_NO_64BIT_SUPPORT;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&


