Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F67C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DB6F2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 06:43:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgFJGm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 02:42:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51362 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFJGm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 02:42:57 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jiuRd-0001Sn-96; Wed, 10 Jun 2020 06:42:42 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     mathias.nyman@intel.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Qi Zhou <atmgnd@outlook.com>,
        Hardik Gajjar <hgajjar@de.adit-jv.com>,
        Keiya Nobuta <nobuta.keiya@fujitsu.com>,
        Jason Yan <yanaijie@huawei.com>,
        David Heinzelmann <heinzelmann.david@gmail.com>,
        linux-usb@vger.kernel.org (open list:USB SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] USB: hub: Suspend and resume port with LPM enabled
Date:   Wed, 10 Jun 2020 14:42:31 +0800
Message-Id: <20200610064231.9454-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200610064231.9454-1-kai.heng.feng@canonical.com>
References: <20200610064231.9454-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

USB2 devices with LPM enabled may interrupt the system suspend:
[  932.510475] usb 1-7: usb suspend, wakeup 0
[  932.510549] hub 1-0:1.0: hub_suspend
[  932.510581] usb usb1: bus suspend, wakeup 0
[  932.510590] xhci_hcd 0000:00:14.0: port 9 not suspended
[  932.510593] xhci_hcd 0000:00:14.0: port 8 not suspended
..
[  932.520323] xhci_hcd 0000:00:14.0: Port change event, 1-7, id 7, portsc: 0x400e03
..
[  932.591405] PM: pci_pm_suspend(): hcd_pci_suspend+0x0/0x30 returns -16
[  932.591414] PM: dpm_run_callback(): pci_pm_suspend+0x0/0x160 returns -16
[  932.591418] PM: Device 0000:00:14.0 failed to suspend async: error -16

During system suspend, USB core will let HC suspends the device if it
doesn't have remote wakeup enabled and doesn't have any children.
However, from the log above we can see that the usb 1-7 doesn't get bus
suspended due to not in U0, because it requires a longer period for
disabling LPM. After a while the port finished its U2 -> U0 transition,
interrupts the suspend process.

Though PLC shouldn't be set for U2 -> U0 case, we can avoid all that by
directly put the port from U0/U1/U2 to U3, and solves this issue.

Suggested-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/core/hub.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index b1e14beaac5f..882b54df6ef5 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3285,9 +3285,6 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
 		}
 	}
 
-	/* disable USB2 hardware LPM */
-	usb_disable_usb2_hardware_lpm(udev);
-
 	if (usb_disable_ltm(udev)) {
 		dev_err(&udev->dev, "Failed to disable LTM before suspend\n");
 		status = -ENOMEM;
@@ -3323,9 +3320,6 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
 		/* Try to enable USB3 LTM again */
 		usb_enable_ltm(udev);
  err_ltm:
-		/* Try to enable USB2 hardware LPM again */
-		usb_enable_usb2_hardware_lpm(udev);
-
 		if (udev->do_remote_wakeup)
 			(void) usb_disable_remote_wakeup(udev);
  err_wakeup:
@@ -3606,9 +3600,6 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
 		dev_dbg(&udev->dev, "can't resume, status %d\n", status);
 		hub_port_logical_disconnect(hub, port1);
 	} else  {
-		/* Try to enable USB2 hardware LPM */
-		usb_enable_usb2_hardware_lpm(udev);
-
 		/* Try to enable USB3 LTM */
 		usb_enable_ltm(udev);
 	}
-- 
2.17.1

