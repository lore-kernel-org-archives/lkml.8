Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127B1C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A952083B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595858890;
	bh=8gpnCQXxrzuCe30fU4MKX30rljl7ytsstjVxo47e0UA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2bSC2VBH5GvJVxz3MWFHKywaIQLqsznrlIjJU2+YMpBSHt480dEJYKeZEjGD4BkpV
	 g6kmk3prpHXHV1JOVt3nRlHky046yfBJAA2cjo3gXnQoRjHAhTnTXckMHG8Nx5+7Vc
	 qPJ335VUExx96Cz6TR8aNeCebF6/oovwqC61A9cw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbgG0OIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:08:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:57282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbgG0OIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:08:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E1892073E;
        Mon, 27 Jul 2020 14:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595858885;
        bh=8gpnCQXxrzuCe30fU4MKX30rljl7ytsstjVxo47e0UA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0SPeffcUDa/gPWNhbThxnuGmHwmgKyx4x3tltR4+MUOvwxQI9ErlQVFkIjCTrG44o
         SXmoz25E63h62s5hUF+1TIdVwqOUdTvXOdQkP3XlsLJ12X1+1IExZP3vabeuWMbeeI
         eIRBkMwgEhiwzh85kz9IWimx7zk8mEsV8ucbeXro=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Forest Crossman <cyrozap@gmail.com>
Subject: [PATCH 4.14 48/64] usb: xhci: Fix ASM2142/ASM3142 DMA addressing
Date:   Mon, 27 Jul 2020 16:04:27 +0200
Message-Id: <20200727134913.561486112@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134911.020675249@linuxfoundation.org>
References: <20200727134911.020675249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Forest Crossman <cyrozap@gmail.com>

commit dbb0897e805f2ab1b8bc358f6c3d878a376b8897 upstream.

The ASM2142/ASM3142 (same PCI IDs) does not support full 64-bit DMA
addresses, which can cause silent memory corruption or IOMMU errors on
platforms that use the upper bits. Add the XHCI_NO_64BIT_SUPPORT quirk
to fix this issue.

Signed-off-by: Forest Crossman <cyrozap@gmail.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200717112734.328432-1-cyrozap@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-pci.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -235,6 +235,9 @@ static void xhci_pci_quirks(struct devic
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
 			pdev->device == 0x1142)
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
+	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
+			pdev->device == 0x2142)
+		xhci->quirks |= XHCI_NO_64BIT_SUPPORT;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
 		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042A_XHCI)


