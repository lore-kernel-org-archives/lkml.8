Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ADFC10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 04:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4450E21655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 04:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgCKEFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 00:05:09 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37535 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgCKEFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 00:05:08 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jBscC-0002ym-Ui; Wed, 11 Mar 2020 04:05:05 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     mathias.nyman@intel.com
Cc:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2] xhci: Set port link to RxDetect if port is not enabled after resume
Date:   Wed, 11 Mar 2020 12:04:56 +0800
Message-Id: <20200311040456.25851-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dell TB16, Realtek USB ethernet (r8152) connects to an SMSC hub which
then connects to ASMedia xHCI's root hub:

/:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 5000M
    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/7p, 5000M
            |__ Port 2: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M

Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 004 Device 002: ID 0424:5537 Standard Microsystems Corp. USB5537B
Bus 004 Device 003: ID 0bda:8153 Realtek Semiconductor Corp. RTL8153 Gigabit Ethernet Adapter

The port is disabled after resume:
xhci_hcd 0000:3f:00.0: Get port status 4-1 read: 0x280, return 0x280

According to xHCI 4.19.1.2.1, we should set link to RxDetect to transit
it from disabled state to disconnected state, which allows the port to
be set to U0 and completes the resume process.

My own test shows port can still resume when it's not enabled, as long
as its link is in U states. So constrain the new logic only when link is
not in any U state.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/host/xhci-hub.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index a9c87eb8951e..263f9a9237a1 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1776,6 +1776,14 @@ int xhci_bus_resume(struct usb_hcd *hcd)
 			clear_bit(port_index, &bus_state->bus_suspended);
 			continue;
 		}
+
+		/* 4.19.1.2.1 */
+		if (!(portsc & PORT_PE) && (portsc & PORT_PLS_MASK) > XDEV_U3) {
+			portsc = xhci_port_state_to_neutral(portsc);
+			portsc &= ~PORT_PLS_MASK;
+			portsc |= PORT_LINK_STROBE | XDEV_RXDETECT;
+		}
+
 		/* resume if we suspended the link, and it is still suspended */
 		if (test_bit(port_index, &bus_state->bus_suspended))
 			switch (portsc & PORT_PLS_MASK) {
-- 
2.17.1

