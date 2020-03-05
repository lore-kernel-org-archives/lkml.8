Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07531C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D436D2073B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 07:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgCEH2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 02:28:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60987 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725816AbgCEH2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 02:28:43 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1j9kvq-0003xu-83; Thu, 05 Mar 2020 07:28:34 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     gregkh@linuxfoundation.org
Cc:     mathias.nyman@intel.com, stern@rowland.harvard.edu,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] usb: core: Set port link to RxDetect if port is not enabled after resume
Date:   Thu,  5 Mar 2020 15:28:26 +0800
Message-Id: <20200305072826.23231-1-kai.heng.feng@canonical.com>
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

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---

P.S. This is and differnt (and should be more correct) approach to solve
https://lore.kernel.org/lkml/20191129174115.31683-1-kai.heng.feng@canonical.com/

 drivers/usb/core/hub.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 54cd8ef795ec..352e33c84d6a 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3537,12 +3537,24 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
 
 	/* Skip the initial Clear-Suspend step for a remote wakeup */
 	status = hub_port_status(hub, port1, &portstatus, &portchange);
-	if (status == 0 && !port_is_suspended(hub, portstatus)) {
+	if (status == 0 && !port_is_suspended(hub, portstatus)
+	    && (portstatus & USB_PORT_STAT_ENABLE)) {
 		if (portchange & USB_PORT_STAT_C_SUSPEND)
 			pm_wakeup_event(&udev->dev, 0);
 		goto SuspendCleared;
 	}
 
+	/* xHCI 4.19.1.2.1 */
+	if (hub_is_superspeed(hub->hdev)) {
+		if (!(portstatus & USB_PORT_STAT_ENABLE))
+			status = hub_set_port_link_state(hub, port1,
+							 USB_SS_PORT_LS_RX_DETECT);
+
+		if (status)
+			dev_dbg(&port_dev->dev,
+				"can't set to RxDetect, status %d\n", status);
+	}
+
 	/* see 7.1.7.7; affects power usage, but not budgeting */
 	if (hub_is_superspeed(hub->hdev))
 		status = hub_set_port_link_state(hub, port1, USB_SS_PORT_LS_U0);
-- 
2.17.1

