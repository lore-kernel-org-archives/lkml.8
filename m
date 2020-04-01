Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B64C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A46C2137B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758621;
	bh=nApbZ80mXRy/+ibrdVc/TvjMd1UMq5jINCA6FxGD2T8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jEdFLEDA3qY5/xFcgdSXTQPcA86FvDKOHsFXpKanhSL5kBBgPyAkyNMmF9xjsxred
	 gU3g5nbVmJzI3zP2yzNCYZ/bxihk+3Tfa7A7CCPdR0/GEQVxBjITIb9RHW+OmLAs9F
	 waTELW23rOXA5PPRFgFClEn9Zw8Y+Xy6rJXLoRyc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388261AbgDAQaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:30:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:55982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387716AbgDAQaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:30:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFBEB212CC;
        Wed,  1 Apr 2020 16:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758609;
        bh=nApbZ80mXRy/+ibrdVc/TvjMd1UMq5jINCA6FxGD2T8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=quWgzVxmGRQjoxB/UREHrpWrIIl+xmetR0qDzVYTJkAC/T9eHffcADM0lqBg+o2yU
         Gsq4gl/gm3vx0bOxqoFJtz1+hTtKHXUrGjI0E442nzeAPG87n4gQ3/8V9akRA986W3
         URgWe8MikQOhhwWdL/w5nrP0NsCl1m0sK5KRY5qU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 4.4 08/91] USB: Disable LPM on WD19s Realtek Hub
Date:   Wed,  1 Apr 2020 18:17:04 +0200
Message-Id: <20200401161515.747019324@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161512.917494101@linuxfoundation.org>
References: <20200401161512.917494101@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit b63e48fb50e1ca71db301ca9082befa6f16c55c4 upstream.

Realtek Hub (0bda:0x0487) used in Dell Dock WD19 sometimes drops off the
bus when bringing underlying ports from U3 to U0.

Disabling LPM on the hub during setting link state is not enough, so
let's disable LPM completely for this hub.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200205112633.25995-3-kai.heng.feng@canonical.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/quirks.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -229,6 +229,9 @@ static const struct usb_device_id usb_qu
 	{ USB_DEVICE(0x0b05, 0x17e0), .driver_info =
 			USB_QUIRK_IGNORE_REMOTE_WAKEUP },
 
+	/* Realtek hub in Dell WD19 (Type-C) */
+	{ USB_DEVICE(0x0bda, 0x0487), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* Action Semiconductor flash disk */
 	{ USB_DEVICE(0x10d6, 0x2200), .driver_info =
 			USB_QUIRK_STRING_FETCH_255 },


