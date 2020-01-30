Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF17C35240
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B32E20702
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580410446;
	bh=JR1RwpBMjLTWErhKmNkJO3sfcrMLDq74tnVgsfQQTM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KpfdmIOD0Z+3CydaIno16NTwEH7H4GYorMar2b1KL6gQW49Hzp4jShdMiFJtsXpuu
	 qySmyRxTw0f4OyJ/bvqEhtKIIDfb2E1atNW2MD0igYA/6YcQEKfaa8BWYanUOu9MY9
	 megplPxgVi4i8NypGGg1prI+xIBPCDJE2t4T/QcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbgA3SyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:54:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730008AbgA3Skq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:40:46 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5B16214AF;
        Thu, 30 Jan 2020 18:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409646;
        bh=JR1RwpBMjLTWErhKmNkJO3sfcrMLDq74tnVgsfQQTM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h/vVAEWADN5gAAzF5mvVlkW8j9UIyo8lK3lqdO8hSuzLIPcyl+0uTnvM5Rdd5sePC
         gqHAqCP1NdCkoqj1Owr9Aq//mbJjTz0HrhMK7+9QItB4OtzvLKLYS97zA4O7RfBBGa
         +6MmKCqCzpwhr/9O2GkA2TRFHB6Jh3jGfu04QlcI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>
Subject: [PATCH 5.5 32/56] ath9k: fix storage endpoint lookup
Date:   Thu, 30 Jan 2020 19:38:49 +0100
Message-Id: <20200130183614.877209750@linuxfoundation.org>
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

commit 0ef332951e856efa89507cdd13ba8f4fb8d4db12 upstream.

Make sure to use the current alternate setting when verifying the
storage interface descriptors to avoid submitting an URB to an invalid
endpoint.

Failing to do so could cause the driver to misbehave or trigger a WARN()
in usb_submit_urb() that kernels with panic_on_warn set would choke on.

Fixes: 36bcce430657 ("ath9k_htc: Handle storage devices")
Cc: stable <stable@vger.kernel.org>     # 2.6.39
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/ath/ath9k/hif_usb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -1216,7 +1216,7 @@ err_fw:
 static int send_eject_command(struct usb_interface *interface)
 {
 	struct usb_device *udev = interface_to_usbdev(interface);
-	struct usb_host_interface *iface_desc = &interface->altsetting[0];
+	struct usb_host_interface *iface_desc = interface->cur_altsetting;
 	struct usb_endpoint_descriptor *endpoint;
 	unsigned char *cmd;
 	u8 bulk_out_ep;


