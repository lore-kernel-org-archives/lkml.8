Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F775C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E12B520828
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgCINAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:00:25 -0400
Received: from v6.sk ([167.172.42.174]:34444 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgCINAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:00:25 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id A96E260EEE;
        Mon,  9 Mar 2020 13:00:23 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 1/2] USB: EHCI: ehci-mv: switch the HSIC HCI to HSIC mode
Date:   Mon,  9 Mar 2020 14:00:13 +0100
Message-Id: <20200309130014.548168-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Turns out the undocumented and reserved bits of port status/control
register of the root port need to be set to use the HCI in HSIC mode.

Typically the firmware does this, but that is not always good enough,
because the bits get lost if the HSIC clock is disabled (e.g. when
ehci-mv is build as a module).

This supplements commit 7b104f890ade ("USB: EHCI: ehci-mv: add HSIC
support").

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/usb/host/ehci-mv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index bd4f6ef534d96..ddb668963955f 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -110,6 +110,7 @@ static int mv_ehci_probe(struct platform_device *pdev)
 	struct resource *r;
 	int retval = -ENODEV;
 	u32 offset;
+	u32 status;
 
 	if (usb_disabled())
 		return -ENODEV;
@@ -213,6 +214,14 @@ static int mv_ehci_probe(struct platform_device *pdev)
 		device_wakeup_enable(hcd->self.controller);
 	}
 
+	if (of_usb_get_phy_mode(pdev->dev.of_node) == USBPHY_INTERFACE_MODE_HSIC) {
+		status = ehci_readl(ehci, &ehci->regs->port_status[0]);
+		/* These "reserved" bits actually enable HSIC mode. */
+		status |= BIT(25);
+		status &= ~GENMASK(31, 30);
+		ehci_writel(ehci, status, &ehci->regs->port_status[0]);
+	}
+
 	dev_info(&pdev->dev,
 		 "successful find EHCI device with regs 0x%p irq %d"
 		 " working in %s mode\n", hcd->regs, hcd->irq,
-- 
2.25.1

