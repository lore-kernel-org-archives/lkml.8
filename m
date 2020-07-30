Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E841C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F26E52074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 08:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596096940;
	bh=3skWiDVPUpQL4qr7FPevZfmE+/vdlGPFeS71okyenxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MJGh1xZWq2AZpgNXcpg3HVNcnGIEICCtZnFOwalnoseSITTaJqZl3Mt2wIB+5D5Kn
	 0zhGaNRtx4GQXjDBUaVyjPWYakwH7vUIGH69hEf1kCjpDdT7nTrg+dpCAqvBEaHqf0
	 FMrdJmE5Ng6RMLY/IPcPCR92OVSIgx+Tq+RGvqSU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgG3IPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 04:15:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729981AbgG3ILn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 04:11:43 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA89720838;
        Thu, 30 Jul 2020 08:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596096702;
        bh=3skWiDVPUpQL4qr7FPevZfmE+/vdlGPFeS71okyenxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p2m8QS22WGHv8YRi+WIxlMKvsajEVAmzhtZ4UgI2z0LSsEu+J2jDRndWGSOx5l4jj
         i+bVLIVdU09VHzaos1l0dTxFnkDXJcXmcnn5PVq102B7vr2DbfPoYs51qcVDRqKhVr
         GcwubHZlV7FhlK6C/hW3oMQ0w0AUDAyqokmsWWeg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rustam Kovhaev <rkovhaev@gmail.com>,
        syzbot+c2a1fa67c02faa0de723@syzkaller.appspotmail.com
Subject: [PATCH 4.4 27/54] staging: wlan-ng: properly check endpoint types
Date:   Thu, 30 Jul 2020 10:05:06 +0200
Message-Id: <20200730074422.510568876@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730074421.203879987@linuxfoundation.org>
References: <20200730074421.203879987@linuxfoundation.org>
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
@@ -60,11 +60,25 @@ static int prism2sta_probe_usb(struct us
 			       const struct usb_device_id *id)
 {
 	struct usb_device *dev;
-
+	const struct usb_endpoint_descriptor *epd;
+	const struct usb_host_interface *iface_desc = interface->cur_altsetting;
 	wlandevice_t *wlandev = NULL;
 	hfa384x_t *hw = NULL;
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
 	if (wlandev == NULL) {


