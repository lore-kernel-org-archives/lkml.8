Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC520C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B098720760
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593467458;
	bh=hzkKtFgSEYFIiPa3IGNswtmW/A5ZusfTPARTOvKVHxU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pWpG2a9DnK9oCDjHxa0VaJmF5c89dU9so6ms4N85+f0L1YU0mO03cyERxPi2SZXLR
	 cjNxpvaeZmB4VjvWYKTgkst37CjUefILuIzaKtXhx0Zc4e/mB5mWg9Guf2w5YMueTl
	 0ldttMOw9da0OWhzljMdhjCk8A8vFEN/miZGx1uk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404509AbgF2Vu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:50:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbgF2Sfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:40 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C1B62465D;
        Mon, 29 Jun 2020 15:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593443972;
        bh=hzkKtFgSEYFIiPa3IGNswtmW/A5ZusfTPARTOvKVHxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hhKqkA7LEVgpoKrNg7rONAGPyO9reJAwZw0WlqDZ1dxNWBndVQWrVRdJyyoIL2hjY
         E3q37Oqa0EVQJgu+Gd7EVc4ObSh+QxrIwx98y7FMijEY9aXTDp81aEys1akFGzY4TT
         z9RWv3lI1dtqWhENc5NSaTC7RX6qh3kDU1AQCi8Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Chihhao Chen <chihhao.chen@mediatek.com>,
        Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.7 076/265] ALSA: usb-audio: add quirk for Samsung USBC Headset (AKG)
Date:   Mon, 29 Jun 2020 11:15:09 -0400
Message-Id: <20200629151818.2493727-77-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Macpaul Lin <macpaul.lin@mediatek.com>

commit a32a1fc99807244d920d274adc46ba04b538cc8a upstream.

We've found Samsung USBC Headset (AKG) (VID: 0x04e8, PID: 0xa051)
need a tiny delay after each class compliant request.
Otherwise the device might not be able to be recognized each times.

Signed-off-by: Chihhao Chen <chihhao.chen@mediatek.com>
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/1592910203-24035-1-git-send-email-macpaul.lin@mediatek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/quirks.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index b5e9fe0486189..d7d900ebcf37f 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1647,6 +1647,14 @@ void snd_usb_ctl_msg_quirk(struct usb_device *dev, unsigned int pipe,
 	     chip->usb_id == USB_ID(0x0951, 0x16ad)) &&
 	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
 		usleep_range(1000, 2000);
+
+	/*
+	 * Samsung USBC Headset (AKG) need a tiny delay after each
+	 * class compliant request. (Model number: AAM625R or AAM627R)
+	 */
+	if (chip->usb_id == USB_ID(0x04e8, 0xa051) &&
+	    (requesttype & USB_TYPE_MASK) == USB_TYPE_CLASS)
+		usleep_range(5000, 6000);
 }
 
 /*
-- 
2.25.1

