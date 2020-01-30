Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDC9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2568A2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580409728;
	bh=1M0YF0+4pADEq3v0NcUXt1p5XFbnlgw9zdlVcdV/OZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X8a4uMgGjXwDLpGSABuU4CoK5e+AN/M2tU6vZEjuAloTCTXo++GiUr9BW5gkqCYcE
	 14Bad5JgxINA4/FVaxO86oqgcg6L5xx8Dm8KvOeVoJtRupPzOdUmzgl5DOhEEqO11v
	 1g2+h/QJSIDMhlmdZiExKyXM8LEUUHPt0zB8c2HY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbgA3SmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:42:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730303AbgA3SmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:42:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A25120CC7;
        Thu, 30 Jan 2020 18:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409722;
        bh=1M0YF0+4pADEq3v0NcUXt1p5XFbnlgw9zdlVcdV/OZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E0k2XNu2wki/cbh6MsSs4vBD91AOW+1hxySFrgtY1eAU3o+lf9e1e2AScnXfWRkas
         7JisrN1B3qJlvTBSF+SomH/iSQ3AOffqDx36Cta9PLjUQ/rZCKt1shrYP/30wkahNB
         xRJjs19GDB0IfiFtKYNYOL0fJntzQJa++fPsEgJE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arend van Spriel <arend@broadcom.com>,
        Johan Hovold <johan@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.5 33/56] brcmfmac: fix interface sanity check
Date:   Thu, 30 Jan 2020 19:38:50 +0100
Message-Id: <20200130183615.067958605@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183608.849023566@linuxfoundation.org>
References: <20200130183608.849023566@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 3428fbcd6e6c0850b1a8b2a12082b7b2aabb3da3 upstream.

Make sure to use the current alternate setting when verifying the
interface descriptors to avoid binding to an invalid interface.

Failing to do so could cause the driver to misbehave or trigger a WARN()
in usb_submit_urb() that kernels with panic_on_warn set would choke on.

Fixes: 71bb244ba2fd ("brcm80211: fmac: add USB support for bcm43235/6/8 chipsets")
Cc: stable <stable@vger.kernel.org>     # 3.4
Cc: Arend van Spriel <arend@broadcom.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/usb.c
@@ -1348,7 +1348,7 @@ brcmf_usb_probe(struct usb_interface *in
 		goto fail;
 	}
 
-	desc = &intf->altsetting[0].desc;
+	desc = &intf->cur_altsetting->desc;
 	if ((desc->bInterfaceClass != USB_CLASS_VENDOR_SPEC) ||
 	    (desc->bInterfaceSubClass != 2) ||
 	    (desc->bInterfaceProtocol != 0xff)) {
@@ -1361,7 +1361,7 @@ brcmf_usb_probe(struct usb_interface *in
 
 	num_of_eps = desc->bNumEndpoints;
 	for (ep = 0; ep < num_of_eps; ep++) {
-		endpoint = &intf->altsetting[0].endpoint[ep].desc;
+		endpoint = &intf->cur_altsetting->endpoint[ep].desc;
 		endpoint_num = usb_endpoint_num(endpoint);
 		if (!usb_endpoint_xfer_bulk(endpoint))
 			continue;


