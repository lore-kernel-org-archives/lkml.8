Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44333C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7DC20675
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583847347;
	bh=Vn8MA2JWAlQXOEu/9651uZO4QlqIhBvCV5/tHIIYK8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2EeOdbUxzy2vFvVxieVd9UonJl6kRt26Wu+jKw4uYvYb4WRTxVi4m2YmWCqWMthdq
	 6WUn+j3eK08bRYn9VpiVi4w69V77QRZb4aBavy959CWHMjUczgzFJbyxDTk7SJJZDl
	 wJPArqSFd+XglMKWrTjWbYfCkqZhlv5Ng1zXw4Wo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbgCJMoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:44:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbgCJMnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:43:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8799524693;
        Tue, 10 Mar 2020 12:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844235;
        bh=Vn8MA2JWAlQXOEu/9651uZO4QlqIhBvCV5/tHIIYK8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PpZAmcRymKAH4ZXl6fU1m4cITo8J0rl1ltxG1C5m/OooUZodnyvY5inmE6JSoXFNB
         2oEhZR3YZrH8UEIc9kZT6vD4H4lGEGQ7TEu+dbtkmDX0iMeiGK0kVWtYqmUrDUQm7q
         f8ZTEqjy39d/t0Wdyji5TofdJx2EyZHPonczPCWA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Lazewatsky <dlaz@chromium.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>
Subject: [PATCH 4.4 52/72] usb: quirks: add NO_LPM quirk for Logitech Screen Share
Date:   Tue, 10 Mar 2020 13:39:05 +0100
Message-Id: <20200310123614.129457987@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123601.053680753@linuxfoundation.org>
References: <20200310123601.053680753@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Lazewatsky <dlaz@chromium.org>

commit b96ed52d781a2026d0c0daa5787c6f3d45415862 upstream.

LPM on the device appears to cause xHCI host controllers to claim
that there isn't enough bandwidth to support additional devices.

Signed-off-by: Dan Lazewatsky <dlaz@chromium.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.com>
Link: https://lore.kernel.org/r/20200226143438.1445-1-gustavo.padovan@collabora.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/quirks.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -86,6 +86,9 @@ static const struct usb_device_id usb_qu
 	/* Logitech PTZ Pro Camera */
 	{ USB_DEVICE(0x046d, 0x0853), .driver_info = USB_QUIRK_DELAY_INIT },
 
+	/* Logitech Screen Share */
+	{ USB_DEVICE(0x046d, 0x086c), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Logitech Quickcam Fusion */
 	{ USB_DEVICE(0x046d, 0x08c1), .driver_info = USB_QUIRK_RESET_RESUME },
 


