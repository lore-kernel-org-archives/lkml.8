Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699DAC3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 13:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 395862054F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 13:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587217788;
	bh=hVGd1XVXIQixtTCRrA9xVPLTqm8xr2yA0JSWE2QJe5Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wwTu3etKb/e8iTvUM6lBIyiTU+1BJ6+xGeUnd/Nm+5drhr5an9xqSSf9cvZYiL/x7
	 rKv2kelOt1djnCdUv4cCTcKbYJX8HzTOfBMPicZbECiLYspOZ3df9ieTCufMzitvqZ
	 W+O1RjA7PrMwh2iR8VCP/M81GwAaYSSdlMi3JV3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgDRNtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 09:49:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbgDRNtn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 09:49:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFAB722261;
        Sat, 18 Apr 2020 13:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587217782;
        bh=hVGd1XVXIQixtTCRrA9xVPLTqm8xr2yA0JSWE2QJe5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y/6dBpLm9OBzVrbHVw8Xinn/2zO+XOZp7L/DHYBWuuNdbhesKYazONWDNWIQ1yYgI
         llPWttrdApYI3eCJ7vtLJ/otxRQ8fu/wUopvPKa7+P1zPJr2WgZToDSpc4iLpGrx3/
         vmmD/da/ADFtArqAYXpAsK0cm/QT5WEtEAZBT6Kw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 70/73] xhci: Ensure link state is U3 after setting USB_SS_PORT_LS_U3
Date:   Sat, 18 Apr 2020 09:48:12 -0400
Message-Id: <20200418134815.6519-70-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418134815.6519-1-sashal@kernel.org>
References: <20200418134815.6519-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit eb002726fac7cefb98ff39ddb89e150a1c24fe85 ]

The xHCI spec doesn't specify the upper bound of U3 transition time. For
some devices 20ms is not enough, so we need to make sure the link state
is in U3 before further actions.

I've tried to use U3 Entry Capability by setting U3 Entry Enable in
config register, however the port change event for U3 transition
interrupts the system suspend process.

For now let's use the less ideal method by polling PLS.

[use usleep_range(), and shorten the delay time while polling -Mathias]
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20200312144517.1593-7-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/xhci-hub.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-hub.c b/drivers/usb/host/xhci-hub.c
index af92b2576fe91..712cd44f05ace 100644
--- a/drivers/usb/host/xhci-hub.c
+++ b/drivers/usb/host/xhci-hub.c
@@ -1322,7 +1322,16 @@ int xhci_hub_control(struct usb_hcd *hcd, u16 typeReq, u16 wValue,
 			xhci_set_link_state(xhci, ports[wIndex], link_state);
 
 			spin_unlock_irqrestore(&xhci->lock, flags);
-			msleep(20); /* wait device to enter */
+			if (link_state == USB_SS_PORT_LS_U3) {
+				int retries = 16;
+
+				while (retries--) {
+					usleep_range(4000, 8000);
+					temp = readl(ports[wIndex]->addr);
+					if ((temp & PORT_PLS_MASK) == XDEV_U3)
+						break;
+				}
+			}
 			spin_lock_irqsave(&xhci->lock, flags);
 
 			temp = readl(ports[wIndex]->addr);
-- 
2.20.1

