Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31700C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9ED9206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598979135;
	bh=oohKm4wA5PeEduUAWRlKUhWqsHa0F45uQylFxb/AJN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=p5gk9vL4x334m5BOkxbKJnJWWdGT+AhRaDoaimmD8ml5zwA0S4OpVzMGi+3JRVKdv
	 Av4WAjhnUUqOFWD6MZikx4IG0eb+OQU2WloGU0lKIC/07gH9lU1Woy7NMaGhuKorqy
	 CMO4vTcTK7n8yfAsczEhxD4D8CiOPFIxJsWGPWkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgIAQwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:52:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbgIAPZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:25:48 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02ACF20FC3;
        Tue,  1 Sep 2020 15:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973947;
        bh=oohKm4wA5PeEduUAWRlKUhWqsHa0F45uQylFxb/AJN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aACI3m8X5wp+oNGWQ9IeBOZ7Xsql6JJY/N1LXBG4x+JwnkP3HultT0nnxz5LnaXLs
         tu1ValWzGHAhava8Gw+G0yJ3ZAJmYtZ5aonlQjqAeS14xpYYFqcviHQ9DsZKUDme75
         RQStWRYIBmUAlyaFpBPgRhNhUFlQf7cAJ+rLuRSY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Jean-Christophe Barnoud <jcbarnoud@gmail.com>
Subject: [PATCH 4.19 111/125] USB: quirks: Ignore duplicate endpoint on Sound Devices MixPre-D
Date:   Tue,  1 Sep 2020 17:11:06 +0200
Message-Id: <20200901150940.052570716@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
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
 


