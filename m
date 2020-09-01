Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335B3C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A1D204EC
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598976805;
	bh=oohKm4wA5PeEduUAWRlKUhWqsHa0F45uQylFxb/AJN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SMfo/BaBJrVfVqXet59oTnUR8qeS6dPw5/t314QdwX21GEO8K5IS9ppte82fdyglJ
	 ro89miJezR/03gl7hJ9EpylMCNlQpwh1JX+QI7WhUmXjfXghnNW60Vp59jVt3SAL87
	 i/j6m+JhD0jEClP7QJo21Xed9a2MKLuhVQh/50ow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbgIAPgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:36:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728213AbgIAPe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:34:59 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C97D720E65;
        Tue,  1 Sep 2020 15:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974498;
        bh=oohKm4wA5PeEduUAWRlKUhWqsHa0F45uQylFxb/AJN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0KwcEFepcnVTi5UhliVJOxWO9nlF2fSfsj7TbL8o4bTuaElrTpSB1rMMgG7/WEoH7
         HIHPOQMArhkxdMptXMKXD36NP08U2wG105wsj+oXVcr3yVBCHAi2QHk3RhEYkubc7H
         D8l1gtJOH5gFOngVgiq3aCqwr8m/XtwSo98FSs4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Jean-Christophe Barnoud <jcbarnoud@gmail.com>
Subject: [PATCH 5.4 192/214] USB: quirks: Ignore duplicate endpoint on Sound Devices MixPre-D
Date:   Tue,  1 Sep 2020 17:11:12 +0200
Message-Id: <20200901151002.146235652@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

commit 068834a2773b6a12805105cfadbb3d4229fc6e0a upstream.

The Sound Devices MixPre-D audio card suffers from the same defect
as the Sound Devices USBPre2: an endpoint shared between a normal
audio interface and a vendor-specific interface, in violation of the
USB spec.  Since the USB core now treats duplicated endpoints as bugs
and ignores them, the audio endpoint isn't available and the card
can't be used for audio capture.

Along the same lines as commit bdd1b147b802 ("USB: quirks: blacklist
duplicate ep on Sound Devices USBPre2"), this patch adds a quirks
entry saying to ignore ep5in for interface 1, leaving it available for
use with standard audio interface 2.

Reported-and-tested-by: Jean-Christophe Barnoud <jcbarnoud@gmail.com>
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: <stable@vger.kernel.org>
Fixes: 3e4f8e21c4f2 ("USB: core: fix check for duplicate endpoints")
Link: https://lore.kernel.org/r/20200826194624.GA412633@rowland.harvard.edu
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/quirks.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -370,6 +370,10 @@ static const struct usb_device_id usb_qu
 	{ USB_DEVICE(0x0926, 0x0202), .driver_info =
 			USB_QUIRK_ENDPOINT_BLACKLIST },
 
+	/* Sound Devices MixPre-D */
+	{ USB_DEVICE(0x0926, 0x0208), .driver_info =
+			USB_QUIRK_ENDPOINT_BLACKLIST },
+
 	/* Keytouch QWERTY Panel keyboard */
 	{ USB_DEVICE(0x0926, 0x3333), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
@@ -511,6 +515,7 @@ static const struct usb_device_id usb_am
  */
 static const struct usb_device_id usb_endpoint_blacklist[] = {
 	{ USB_DEVICE_INTERFACE_NUMBER(0x0926, 0x0202, 1), .driver_info = 0x85 },
+	{ USB_DEVICE_INTERFACE_NUMBER(0x0926, 0x0208, 1), .driver_info = 0x85 },
 	{ }
 };
 


