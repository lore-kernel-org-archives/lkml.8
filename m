Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5ADC3F366
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9313D20801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811423;
	bh=HtAG5vx0XxlLPxikWyk1WQUN7ToYBvFZZsIYLvAV38E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jRJ9DHas0UwHwE129wWJIPJspq59GEwHDFUE/VZul9m1Ktu45IDW2UjxpmuMgKZ0d
	 xxFsq2I6SlHS1p/tNHpuZchcAvQxkLgaI7otdkAOJkqAXxGlVNYZuQwZMfXcVHJQbl
	 ZYuX2MOqQfViptvt72K879wuRxpN4d1KRr6Oto2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731211AbgB0NuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:50:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:48116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731194AbgB0NuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:50:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A2E43246A0;
        Thu, 27 Feb 2020 13:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811417;
        bh=HtAG5vx0XxlLPxikWyk1WQUN7ToYBvFZZsIYLvAV38E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aq+T2Vg6WR7+kFvaKP5lvLLmLqFitziomrFfgJ7LD0GmSDFs17Chv3eITbO4chdDy
         XBJpk401JJKkvpnUj7dWauPbsMviGGt4Xp16Da5vVvwKM6+NrsPeKq7k5nIyIF3XRD
         4sxA/5YjqvpG8Ax0H49Gu4zti7EpWME6wP2LYppU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rene D Obermueller <cmdrrdo@gmail.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: [PATCH 4.9 123/165] xhci: Force Maximum Packet size for Full-speed bulk devices to valid range.
Date:   Thu, 27 Feb 2020 14:36:37 +0100
Message-Id: <20200227132249.074144952@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias Nyman <mathias.nyman@linux.intel.com>

commit f148b9f402ef002b57bcff3964d45abc8ffb6c3f upstream.

A Full-speed bulk USB audio device (DJ-Tech CTRL) with a invalid Maximum
Packet Size of 4 causes a xHC "Parameter Error" at enumeration.

This is because valid Maximum packet sizes for Full-speed bulk endpoints
are 8, 16, 32 and 64 bytes. Hosts are not required to support other values
than these. See usb 2 specs section 5.8.3 for details.

The device starts working after forcing the maximum packet size to 8.
This is most likely the case with other devices as well, so force the
maximum packet size to a valid range.

Cc: stable@vger.kernel.org
Reported-by: Rene D Obermueller <cmdrrdo@gmail.com>
Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Link: https://lore.kernel.org/r/20200210134553.9144-2-mathias.nyman@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/host/xhci-mem.c |   12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1532,9 +1532,15 @@ int xhci_endpoint_init(struct xhci_hcd *
 	/* Allow 3 retries for everything but isoc, set CErr = 3 */
 	if (!usb_endpoint_xfer_isoc(&ep->desc))
 		err_count = 3;
-	/* Some devices get this wrong */
-	if (usb_endpoint_xfer_bulk(&ep->desc) && udev->speed == USB_SPEED_HIGH)
-		max_packet = 512;
+	/* HS bulk max packet should be 512, FS bulk supports 8, 16, 32 or 64 */
+	if (usb_endpoint_xfer_bulk(&ep->desc)) {
+		if (udev->speed == USB_SPEED_HIGH)
+			max_packet = 512;
+		if (udev->speed == USB_SPEED_FULL) {
+			max_packet = rounddown_pow_of_two(max_packet);
+			max_packet = clamp_val(max_packet, 8, 64);
+		}
+	}
 	/* xHCI 1.0 and 1.1 indicates that ctrl ep avg TRB Length should be 8 */
 	if (usb_endpoint_xfer_control(&ep->desc) && xhci->hci_version >= 0x100)
 		avg_trb_len = 8;


