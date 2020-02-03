Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08EAC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E80720838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 16:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580747290;
	bh=12c1Cba7k9vHIdxb59e3M30I8y9BZKq3PODOf2RGwDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y5j1ptaz4Wg0GiNysEvlXc4f9zb8LPidsmmi51LxOxsw8NcRdaPUCfFTP/yMrfwno
	 BMYZoQgTkw1N20TQy5nTSyiCsm6C0fC2pqXJLoq1tePEZRdbppaXgJeSUKq/HO9mus
	 h5tSjid6V0h3q0rMbY0Ux18sGv1w4Lr0hepfiNyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgBCQ2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 11:28:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729500AbgBCQ15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 11:27:57 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E026620CC7;
        Mon,  3 Feb 2020 16:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580747277;
        bh=12c1Cba7k9vHIdxb59e3M30I8y9BZKq3PODOf2RGwDs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x0RfcUB46xyYIInTac6y/RNLo8VZG0ulCu23pRkF0ZC2OvV1Bk8N30EayKRj28ZIh
         Y+a6JUUu8lrX+NztA13WzL0WzPRGilLezPtOR+FqboQ+K2c5pPJxFDhOVd8QteiDsu
         URjI/Kfzb5BaIJR1eN4LdP8L0ZEz5OWHZiiNYpvA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 4.14 17/89] zd1211rw: fix storage endpoint lookup
Date:   Mon,  3 Feb 2020 16:19:02 +0000
Message-Id: <20200203161919.210447108@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203161916.847439465@linuxfoundation.org>
References: <20200203161916.847439465@linuxfoundation.org>
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
@@ -1272,7 +1272,7 @@ static void print_id(struct usb_device *
 static int eject_installer(struct usb_interface *intf)
 {
 	struct usb_device *udev = interface_to_usbdev(intf);
-	struct usb_host_interface *iface_desc = &intf->altsetting[0];
+	struct usb_host_interface *iface_desc = intf->cur_altsetting;
 	struct usb_endpoint_descriptor *endpoint;
 	unsigned char *cmd;
 	u8 bulk_out_ep;


