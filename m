Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1133C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F40420719
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860654;
	bh=5MbtI0ihvkEoxI9SWcTbrLH2vIzaHkcSMuxKD1ckyRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rA/Vu6AJjwVhBnYAbONxm6Ka5+OCK1CZMb96A+WeCGzJXQFeYoFTb2C4TSugtikq+
	 kD207VgkrlMX/UTb7FDykHGRKNoztBZuPsCQY+SawnMHtpbasmPZIAa8ZDDV4841vC
	 oI6uk2e+GkdEfEfM+I96jlDWs2cf7wNJtbi3PIkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732957AbgG0Ohd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:37:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730207AbgG0OMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:12:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4E472083E;
        Mon, 27 Jul 2020 14:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859150;
        bh=5MbtI0ihvkEoxI9SWcTbrLH2vIzaHkcSMuxKD1ckyRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y2oCgmDBuruF3efKtxjRZuLaM0VzEEigoN07TioAXvwipStmSN5WU2GBPzBa5bWNs
         FuCzyfooVupvcPnDz6FBhBX8OqLv6jSjaVrFrHoijTYd3b3ypxlEy+Y/yTyYVxh6eF
         wW3HDaCZZeyuAfnsdPFzRsvFcxAzjq7JcZZlDfb8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rustam Kovhaev <rkovhaev@gmail.com>,
        syzbot+c2a1fa67c02faa0de723@syzkaller.appspotmail.com
Subject: [PATCH 4.19 65/86] staging: wlan-ng: properly check endpoint types
Date:   Mon, 27 Jul 2020 16:04:39 +0200
Message-Id: <20200727134917.687322916@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134914.312934924@linuxfoundation.org>
References: <20200727134914.312934924@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rustam Kovhaev <rkovhaev@gmail.com>

commit faaff9765664009c1c7c65551d32e9ed3b1dda8f upstream.

As syzkaller detected, wlan-ng driver does not do sanity check of
endpoints in prism2sta_probe_usb(), add check for xfer direction and type

Reported-and-tested-by: syzbot+c2a1fa67c02faa0de723@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=c2a1fa67c02faa0de723
Signed-off-by: Rustam Kovhaev <rkovhaev@gmail.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200722161052.999754-1-rkovhaev@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/wlan-ng/prism2usb.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- a/drivers/staging/wlan-ng/prism2usb.c
+++ b/drivers/staging/wlan-ng/prism2usb.c
@@ -61,11 +61,25 @@ static int prism2sta_probe_usb(struct us
 			       const struct usb_device_id *id)
 {
 	struct usb_device *dev;
-
+	const struct usb_endpoint_descriptor *epd;
+	const struct usb_host_interface *iface_desc = interface->cur_altsetting;
 	struct wlandevice *wlandev = NULL;
 	struct hfa384x *hw = NULL;
 	int result = 0;
 
+	if (iface_desc->desc.bNumEndpoints != 2) {
+		result = -ENODEV;
+		goto failed;
+	}
+
+	result = -EINVAL;
+	epd = &iface_desc->endpoint[1].desc;
+	if (!usb_endpoint_is_bulk_in(epd))
+		goto failed;
+	epd = &iface_desc->endpoint[2].desc;
+	if (!usb_endpoint_is_bulk_out(epd))
+		goto failed;
+
 	dev = interface_to_usbdev(interface);
 	wlandev = create_wlan();
 	if (!wlandev) {


