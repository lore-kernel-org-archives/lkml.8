Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BC5C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9982B20784
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 23:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgDWXHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 19:07:01 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:49262 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728316AbgDWXGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 19:06:41 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1jRkvQ-0004fo-5u; Fri, 24 Apr 2020 00:06:32 +0100
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1jRkvO-00E6me-JQ; Fri, 24 Apr 2020 00:06:30 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Mathias Nyman" <mathias.nyman@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Ard Biesheuvel" <ardb@kernel.org>,
        "Eli Billauer" <eli.billauer@gmail.com>
Date:   Fri, 24 Apr 2020 00:05:22 +0100
Message-ID: <lsq.1587683028.129466344@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 095/245] xhci: handle some XHCI_TRUST_TX_LENGTH
 quirks cases as default behaviour.
In-Reply-To: <lsq.1587683027.831233700@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.83-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit 7ff11162808cc2ec66353fc012c58bb449c892c3 upstream.

xhci driver claims it needs XHCI_TRUST_TX_LENGTH quirk for both
Broadcom/Cavium and a Renesas xHC controllers.

The quirk was inteded for handling false "success" complete event for
transfers that had data left untransferred.
These transfers should complete with "short packet" events instead.

In these two new cases the false "success" completion is reported
after a "short packet" if the TD consists of several TRBs.
xHCI specs 4.10.1.1.2 say remaining TRBs should report "short packet"
as well after the first short packet in a TD, but this issue seems so
common it doesn't make sense to add the quirk for all vendors.

Turn these events into short packets automatically instead.

This gets rid of the  "The WARN Successful completion on short TX for
slot 1 ep 1: needs XHCI_TRUST_TX_LENGTH quirk" warning in many cases.

Reported-by: Eli Billauer <eli.billauer@gmail.com>
Reported-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Eli Billauer <eli.billauer@gmail.com>
Tested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20191211142007.8847-6-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/host/xhci-ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2345,7 +2345,8 @@ static int handle_tx_event(struct xhci_h
 	case COMP_SUCCESS:
 		if (EVENT_TRB_LEN(le32_to_cpu(event->transfer_len)) == 0)
 			break;
-		if (xhci->quirks & XHCI_TRUST_TX_LENGTH)
+		if (xhci->quirks & XHCI_TRUST_TX_LENGTH ||
+		    ep_ring->last_td_was_short)
 			trb_comp_code = COMP_SHORT_TX;
 		else
 			xhci_warn_ratelimited(xhci,

