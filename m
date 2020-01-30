Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6623C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8C12082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580410045;
	bh=w4eLji9sqIIGNFzqVjNSFcaL2LFvT7gV+thnRkoZ9Fw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KF+Ua5Cm1n4+b2NACZccNgpNDJZhyMe6NEZ458iFUzqqwCN82IJ6q9SkfyhBbLkLs
	 4sqU1pGgP8E8vQDM4uYfdUG8etXP72V57d8IVF93x6W2gJJUWhRQs2WpjTpSShWi2b
	 Rx5X4L/P2RTCBImi3gX8lAF5Yq4Kyrn58G2tOACE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731371AbgA3SrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:47:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:57842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731353AbgA3SrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:47:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1872220674;
        Thu, 30 Jan 2020 18:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580410037;
        bh=w4eLji9sqIIGNFzqVjNSFcaL2LFvT7gV+thnRkoZ9Fw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jvQm2eF4J8qM+AmhZAA9EXB4yABHO4lcJzLxv+s+O74K1KG/2gRnAaFRgPbuopYAE
         JknoFKdlFOAVDLzkdhnmUpmtXXLoXOhot4UcjqvGm7dxq+TGgYTdHqpU7gZJI2rfY1
         98i3mwW5wcNCvOasRO9OEMeSNYmcUOMw7bqx0djE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.19 22/55] zd1211rw: fix storage endpoint lookup
Date:   Thu, 30 Jan 2020 19:39:03 +0100
Message-Id: <20200130183612.869441958@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183608.563083888@linuxfoundation.org>
References: <20200130183608.563083888@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

commit 2d68bb2687abb747558b933e80845ff31570a49c upstream.

Make sure to use the current alternate setting when verifying the
storage interface descriptors to avoid submitting an URB to an invalid
endpoint.

Failing to do so could cause the driver to misbehave or trigger a WARN()
in usb_submit_urb() that kernels with panic_on_warn set would choke on.

Fixes: a1030e92c150 ("[PATCH] zd1211rw: Convert installer CDROM device into WLAN device")
Cc: stable <stable@vger.kernel.org>     # 2.6.19
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/zydas/zd1211rw/zd_usb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
+++ b/drivers/net/wireless/zydas/zd1211rw/zd_usb.c
@@ -1275,7 +1275,7 @@ static void print_id(struct usb_device *
 static int eject_installer(struct usb_interface *intf)
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
-	struct usb_host_interface *iface_desc = &intf->altsetting[0];
+	struct usb_host_interface *iface_desc = intf->cur_altsetting;
 	struct usb_endpoint_descriptor *endpoint;
 	unsigned char *cmd;
 	u8 bulk_out_ep;


