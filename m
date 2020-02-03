Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBB3C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B1621582
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747108;
	bh=1r2RCV8odKMtOoVyQndG4Ht3SLQtgRn6H9Rb97NQ3ZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fYJVQRGl0V5KDNQq0z0TZ5qQqMtjWFKoNregiIvownH4lVwT2jasY2ovGBCdpoX9n
	 +kTmm1m/yxZznQnYt/qA1xOjXi0ZaVrgvhOgyUwIvGDsz4XxhYRh5pviF+SmQuc24T
	 OUDgWVc6L7qoniSYVOz1xXAWSkgWWtRk0nu4lSvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgBCQZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:25:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:35682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbgBCQZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:25:05 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7705821582;
        Mon,  3 Feb 2020 16:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747104;
        bh=1r2RCV8odKMtOoVyQndG4Ht3SLQtgRn6H9Rb97NQ3ZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=02pPZrLr9qbmR2c3X6sSAWFV1fYpecIOthqOOksWoFcUuooi+VFw5wp0cpRGmW/6d
         PQ/nbxeVQKiSzghMvU1dA7Yyi2+9hJTyeYyAJhUJXz03wZSq8K4gIg05i7AvZNxfpS
         ObBl6WnKgKlEkoyh9s3iJF5CYMyXZHWDJB3hdWxM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arend van Spriel <arend@broadcom.com>,
        Johan Hovold <johan@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.9 14/68] brcmfmac: fix interface sanity check
Date:   Mon,  3 Feb 2020 16:19:10 +0000
Message-Id: <20200203161907.302939137@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161904.705434837@linuxfoundation.org>
References: <20200203161904.705434837@linuxfoundation.org>
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
@@ -1330,7 +1330,7 @@ brcmf_usb_probe(struct usb_interface *in
 		goto fail;
 	}
 
-	desc = &intf->altsetting[0].desc;
+	desc = &intf->cur_altsetting->desc;
 	if ((desc->bInterfaceClass != USB_CLASS_VENDOR_SPEC) ||
 	    (desc->bInterfaceSubClass != 2) ||
 	    (desc->bInterfaceProtocol != 0xff)) {
@@ -1343,7 +1343,7 @@ brcmf_usb_probe(struct usb_interface *in
 
 	num_of_eps = desc->bNumEndpoints;
 	for (ep = 0; ep < num_of_eps; ep++) {
-		endpoint = &intf->altsetting[0].endpoint[ep].desc;
+		endpoint = &intf->cur_altsetting->endpoint[ep].desc;
 		endpoint_num = usb_endpoint_num(endpoint);
 		if (!usb_endpoint_xfer_bulk(endpoint))
 			continue;


