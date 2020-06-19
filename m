Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 574F7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28A082168B
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592583490;
	bh=71QOEYd4mBZicWPn2Biybt/GmESDda4rHMGH7Q1BeRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TxxtZjJC3iBydDUdO87vhCjCrR7IJOn9g5YPLKG6En8KVxm2KVlal5+JFrniHTFAL
	 TpVRzkokRCtxjRoeBGmZzE3gD685R/6BYrzHKuBxYdFNgoBWZ0ZQn3HJH50h5QM+lp
	 8LGUhbHJfboIHMfviYQfT6Y5hvbUogdmbfwlfpZk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394562AbgFSQSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 12:18:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390787AbgFSPCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:02:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3574E2186A;
        Fri, 19 Jun 2020 15:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592578925;
        bh=71QOEYd4mBZicWPn2Biybt/GmESDda4rHMGH7Q1BeRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CJwE6hoxDZGud0h4vQrUsAz7UH8fEgV0Sb3s71K1Mt0lTK8zKVzPWPGS7yPrAs+Sq
         +cfqaKA0DelKQt5kl96XsCL4ZrWns0S+FYHcjYFUw95GE0EqSuS4tI/Jb0bt1U5zDU
         70wmf3ZbA6pxAgWdnAPahSatdTzmIDqWeX3Ph7Jw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thinh Nguyen <thinhn@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 209/267] PCI: Move Synopsys HAPS platform device IDs
Date:   Fri, 19 Jun 2020 16:33:14 +0200
Message-Id: <20200619141658.760043050@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thinh Nguyen <thinh.nguyen@synopsys.com>

[ Upstream commit b6061b1e566d70c7686d194a6c47dc6ffa665c77 ]

Move Synopsys HAPS platform device IDs to pci_ids.h so that both
drivers/pci/quirks.c and dwc3-haps driver can reference these IDs.

Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/dwc3-haps.c | 4 ----
 include/linux/pci_ids.h      | 3 +++
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-haps.c b/drivers/usb/dwc3/dwc3-haps.c
index c9cc33881bef..02d57d98ef9b 100644
--- a/drivers/usb/dwc3/dwc3-haps.c
+++ b/drivers/usb/dwc3/dwc3-haps.c
@@ -15,10 +15,6 @@
 #include <linux/platform_device.h>
 #include <linux/property.h>
 
-#define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3		0xabcd
-#define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI	0xabce
-#define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB31	0xabcf
-
 /**
  * struct dwc3_haps - Driver private structure
  * @dwc3: child dwc3 platform_device
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 2792bca03088..05705d0b5689 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2361,6 +2361,9 @@
 #define PCI_DEVICE_ID_CENATEK_IDE	0x0001
 
 #define PCI_VENDOR_ID_SYNOPSYS		0x16c3
+#define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3		0xabcd
+#define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB3_AXI	0xabce
+#define PCI_DEVICE_ID_SYNOPSYS_HAPSUSB31	0xabcf
 
 #define PCI_VENDOR_ID_USR		0x16ec
 
-- 
2.25.1



