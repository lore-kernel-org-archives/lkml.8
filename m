Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBC2C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5AF020730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588099026;
	bh=Xy0Pb3mWqIHhg/PXjixWdwwLdI7XClHMTohy2S+A2Ic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EILD7uNAr/ChHNfHi3POzlcXEZjc+Aq01vKH6BGljHU/jm2pGjThNcOF4snkw35W2
	 STOQImL4ZVWYqxbcR6NPQYIm+M2Iw2899zNGB/vdqnqYJq+H7WIrR1hNxkma+8y6ol
	 OVA/g1ANzcSIeF67a1rIYZ8ApKziuk/rz5KgHaJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgD1ShF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:37:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729011AbgD1ShB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:37:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5D8C20730;
        Tue, 28 Apr 2020 18:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588099021;
        bh=Xy0Pb3mWqIHhg/PXjixWdwwLdI7XClHMTohy2S+A2Ic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LxXSyKWiM64tXy3xMw8j17mvfzhq/9tPVjpEyVKQ9rg4Swoy2+fE3OVvVmgtbBNWk
         ik7j1Wfe8Rkq/fKhUBOCKROXfUB5pUowTnl4IT1U23Y1Zy9n37bf2MCBZu1ZhPkVEL
         pRZuguzDQ+p/OF6LTa+bbwyMmVuLi5tsM+PcdcmY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonathan Cox <jonathan@jdcox.net>
Subject: [PATCH 4.19 086/131] USB: Add USB_QUIRK_DELAY_CTRL_MSG and USB_QUIRK_DELAY_INIT for Corsair K70 RGB RAPIDFIRE
Date:   Tue, 28 Apr 2020 20:24:58 +0200
Message-Id: <20200428182235.759008665@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200428182224.822179290@linuxfoundation.org>
References: <20200428182224.822179290@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Cox <jonathan@jdcox.net>

commit be34a5854b4606bd7a160ad3cb43415d623596c7 upstream.

The Corsair K70 RGB RAPIDFIRE needs the USB_QUIRK_DELAY_INIT and
USB_QUIRK_DELAY_CTRL_MSG to function or it will randomly not
respond on boot, just like other Corsair keyboards

Signed-off-by: Jonathan Cox <jonathan@jdcox.net>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200410212427.2886-1-jonathan@jdcox.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/quirks.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -430,6 +430,10 @@ static const struct usb_device_id usb_qu
 	/* Corsair K70 LUX */
 	{ USB_DEVICE(0x1b1c, 0x1b36), .driver_info = USB_QUIRK_DELAY_INIT },
 
+	/* Corsair K70 RGB RAPDIFIRE */
+	{ USB_DEVICE(0x1b1c, 0x1b38), .driver_info = USB_QUIRK_DELAY_INIT |
+	  USB_QUIRK_DELAY_CTRL_MSG },
+
 	/* MIDI keyboard WORLDE MINI */
 	{ USB_DEVICE(0x1c75, 0x0204), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },


