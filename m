Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5D8C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F972468C
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996374;
	bh=+PI48K9XTvgjwsMAYb2zfC9iKKt9NZ6/WaU3LZy+OyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X8EtUwnj4Is3+K72WJALA74ISOHD9q7nfLOO9wnv/kk+PqNxbJEVPJFcSz6UK90Zt
	 i2fpl5Wh4GRQ9ct/EQYlXnRhGL9rKrQGGUVP7JQG79OVoBbH/hBoMc1qGdzHuOV5Ij
	 ICa3mcmvAQV/Vj4rmGnUsTqk+2JIAFny5RQJglSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbgANKGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:06:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:35002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729654AbgANKGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:06:10 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 257CA2467A;
        Tue, 14 Jan 2020 10:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996370;
        bh=+PI48K9XTvgjwsMAYb2zfC9iKKt9NZ6/WaU3LZy+OyI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S729PkJU6iy3Rqi4jeCXbfDpA53C5GimcIMSf2Ju0iXfFwG3TATHn5AOZbSHJmdRI
         NvlZa0Jbjdld1BkFEkJFtm373Q7VwBW7/wjJxsxBl7DQDnE5+lqsMbTVgJ2Nl7kNSY
         RU5SsKVkJa9lqQwBMXQKDRalDXBFHP96e0RIclK4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Roger Whittaker <Roger.Whittaker@suse.com>
Subject: [PATCH 5.4 73/78] USB: Fix: Dont skip endpoint descriptors with maxpacket=0
Date:   Tue, 14 Jan 2020 11:01:47 +0100
Message-Id: <20200114094403.165941697@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094352.428808181@linuxfoundation.org>
References: <20200114094352.428808181@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

commit 2548288b4fb059b2da9ceada172ef763077e8a59 upstream.

It turns out that even though endpoints with a maxpacket length of 0
aren't useful for data transfer, the descriptors do serve other
purposes.  In particular, skipping them will also skip over other
class-specific descriptors for classes such as UVC.  This unexpected
side effect has caused some UVC cameras to stop working.

In addition, the USB spec requires that when isochronous endpoint
descriptors are present in an interface's altsetting 0 (which is true
on some devices), the maxpacket size _must_ be set to 0.  Warning
about such things seems like a bad idea.

This patch updates an earlier commit which would log a warning and
skip these endpoint descriptors.  Now we only log a warning, and we
don't even do that for isochronous endpoints in altsetting 0.

We don't need to worry about preventing endpoints with maxpacket = 0
from ever being used for data transfers; usb_submit_urb() already
checks for this.

Reported-and-tested-by: Roger Whittaker <Roger.Whittaker@suse.com>
Fixes: d482c7bb0541 ("USB: Skip endpoints with 0 maxpacket length")
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://marc.info/?l=linux-usb&m=157790377329882&w=2
Link: https://lore.kernel.org/r/Pine.LNX.4.44L0.2001061040270.1514-100000@iolanthe.rowland.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/config.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -392,12 +392,16 @@ static int usb_parse_endpoint(struct dev
 			endpoint->desc.wMaxPacketSize = cpu_to_le16(8);
 	}
 
-	/* Validate the wMaxPacketSize field */
+	/*
+	 * Validate the wMaxPacketSize field.
+	 * Some devices have isochronous endpoints in altsetting 0;
+	 * the USB-2 spec requires such endpoints to have wMaxPacketSize = 0
+	 * (see the end of section 5.6.3), so don't warn about them.
+	 */
 	maxp = usb_endpoint_maxp(&endpoint->desc);
-	if (maxp == 0) {
-		dev_warn(ddev, "config %d interface %d altsetting %d endpoint 0x%X has wMaxPacketSize 0, skipping\n",
+	if (maxp == 0 && !(usb_endpoint_xfer_isoc(d) && asnum == 0)) {
+		dev_warn(ddev, "config %d interface %d altsetting %d endpoint 0x%X has invalid wMaxPacketSize 0\n",
 		    cfgno, inum, asnum, d->bEndpointAddress);
-		goto skip_to_next_endpoint_or_interface_descriptor;
 	}
 
 	/* Find the highest legal maxpacket size for this endpoint */


