Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156B1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D788E22D08
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597073397;
	bh=TU8KcSxgf0mh/aZ/qfkuGB8IhN9MgKoxul2BZV7PuG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n/ah3J545Ojn3U2o60qgRA1eDfJcH+cIDD5L61bGFJcrd/kaArFJDE8aeQZ66xyYB
	 9TVCX2jY7sxnHjd/21rsJBMcEp3SsYcmTRKPUeo+886lXVshmAYAX2wmhyxzUvb2Nc
	 dtPlR6Y4wbHcFi5707+QJTYIKddOHqIknRaW167M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729028AbgHJP34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:29:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:36482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729021AbgHJP3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:29:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C95322D07;
        Mon, 10 Aug 2020 15:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597073392;
        bh=TU8KcSxgf0mh/aZ/qfkuGB8IhN9MgKoxul2BZV7PuG0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U/0YWbgI9Tshv7X9qRmzvzWCPalehGsgWiT4BMamrA2STMtBc6C/BITKTxgs78mMU
         V2Cy6hcGSMMuH1EOOJy+jVjolkW8xxmxW9i9x6SW7hReSiTdRBCPXL07ge+q8i+Iay
         uZ2WogZR/M6miQOc3a7D85kQ4WorhEM4xX0/s/1I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Forest Crossman <cyrozap@gmail.com>
Subject: [PATCH 4.19 03/48] usb: xhci: define IDs for various ASMedia host controllers
Date:   Mon, 10 Aug 2020 17:21:25 +0200
Message-Id: <20200810151804.380935938@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810151804.199494191@linuxfoundation.org>
References: <20200810151804.199494191@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Forest Crossman <cyrozap@gmail.com>

commit 1841cb255da41e87bed9573915891d056f80e2e7 upstream.

Not all ASMedia host controllers have a device ID that matches its part
number. #define some of these IDs to make it clearer at a glance which
chips require what quirks.

Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Forest Crossman <cyrozap@gmail.com>
Link: https://lore.kernel.org/r/20200728042408.180529-2-cyrozap@gmail.com
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-pci.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -47,7 +47,9 @@
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_3			0x43ba
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_2			0x43bb
 #define PCI_DEVICE_ID_AMD_PROMONTORYA_1			0x43bc
+#define PCI_DEVICE_ID_ASMEDIA_1042_XHCI			0x1042
 #define PCI_DEVICE_ID_ASMEDIA_1042A_XHCI		0x1142
+#define PCI_DEVICE_ID_ASMEDIA_2142_XHCI			0x2142
 
 static const char hcd_name[] = "xhci_hcd";
 
@@ -226,13 +228,13 @@ static void xhci_pci_quirks(struct devic
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
-			pdev->device == 0x1042)
+		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI)
 		xhci->quirks |= XHCI_BROKEN_STREAMS;
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
-			pdev->device == 0x1142)
+		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042A_XHCI)
 		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
-			pdev->device == 0x2142)
+		pdev->device == PCI_DEVICE_ID_ASMEDIA_2142_XHCI)
 		xhci->quirks |= XHCI_NO_64BIT_SUPPORT;
 
 	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&


