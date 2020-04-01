Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A609EC2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D422063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759841;
	bh=AemugzAZy1ghfV7RsZpaY/J/vZW9fAqxWNHOVoSlAJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v8FEi5m5kFY3pMcQx9iwPb6fLJWdl6yhdtf1NVKjTMEX+OTfrzS7QEDs1Eh+Ltc/h
	 um/4c5MlRGPsCmCayKmAnRIuEvVBFSKmE/0cl7gJzOLA3suN45zC7/BslQBXdwevga
	 HCxT3xXofb2wOC2c5BiI53aBgGrpA4/LZQs5yZQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388688AbgDAQje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:39:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388932AbgDAQjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:39:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6359A20719;
        Wed,  1 Apr 2020 16:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759171;
        bh=AemugzAZy1ghfV7RsZpaY/J/vZW9fAqxWNHOVoSlAJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QDDYP0HvqpA2DyeHs7N/B3Y7f2wLUnrqKIXbFLw2mAeQedtU6OG5BlZWdkNzxuDrR
         5LEL5xUgke4ksDhQnpmw/ujlXQRvNc38bdNc5YK27RJdEFtP4yGJsN09aI0GbuNCjG
         MyMr7wkqTImJpXR8B42GQDezNO+W8ytrF9oW5KE8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Larry Finger <Larry.Finger@lwfinger.net>,
        kovi <zraetn@gmail.com>
Subject: [PATCH 4.9 082/102] staging: rtl8188eu: Add ASUS USB-N10 Nano B1 to device table
Date:   Wed,  1 Apr 2020 18:18:25 +0200
Message-Id: <20200401161546.250014045@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161530.451355388@linuxfoundation.org>
References: <20200401161530.451355388@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Larry Finger <Larry.Finger@lwfinger.net>

commit 38ef48f7d4b7342f145a1b4f96023bde99aeb245 upstream.

The ASUS USB-N10 Nano B1 has been reported as a new RTL8188EU device.
Add it to the device tables.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
Reported-by: kovi <zraetn@gmail.com>
Cc: Stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200321180011.26153-1-Larry.Finger@lwfinger.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/staging/rtl8188eu/os_dep/usb_intf.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
@@ -40,6 +40,7 @@ static struct usb_device_id rtw_usb_id_t
 	/****** 8188EUS ********/
 	{USB_DEVICE(0x056e, 0x4008)}, /* Elecom WDC-150SU2M */
 	{USB_DEVICE(0x07b8, 0x8179)}, /* Abocom - Abocom */
+	{USB_DEVICE(0x0B05, 0x18F0)}, /* ASUS USB-N10 Nano B1 */
 	{USB_DEVICE(0x2001, 0x330F)}, /* DLink DWA-125 REV D1 */
 	{USB_DEVICE(0x2001, 0x3310)}, /* Dlink DWA-123 REV D1 */
 	{USB_DEVICE(0x2001, 0x3311)}, /* DLink GO-USB-N150 REV B1 */


