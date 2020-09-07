Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08818C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA4421481
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 15:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599494021;
	bh=MDm/x39065SOo01K6qZuV7PZJI+UXbxgaHzoKWMO8tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EvG71c9GiwecXrOL2p6/SYfAihkdpdZrUBKkU0Wl8J2CTBg7vBDHgmH1NMv5V41VG
	 c5ZgTZAO2EvI2mweWFUoX1uAzlO+P17HMvtK/8CnidllBbpyFXOl+I+XlveSLP0y7G
	 hkhYqA0EIfFZXAjaydfpqMkWyQ49jP6exm1O0Wrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgIGPxj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 11:53:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:58522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729974AbgIGOvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:51:10 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AEA12177B;
        Mon,  7 Sep 2020 14:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599490269;
        bh=MDm/x39065SOo01K6qZuV7PZJI+UXbxgaHzoKWMO8tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tNZrtEWO45CRF+E/OrbMnOHpLv6PCX/TNkRXj1BARuZF1Ju9YXW3C/eh95H133hvx
         TZEBI66qkmXv8rHm5cCT1r2WvSZ70JTVlrj+0rsnHajlpnOJ5/cd2KH0SbUel4og6U
         cfnz8gsno2H98HW+mHktnzmjDSF9q4uQwOFl+ISo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org
Cc:     perex@perex.cz, tiwai@suse.com, stern@rowland.harvard.ed,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Tsoy <alexander@tsoy.me>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v2 11/11] ALSA: remove calls to usb_pipe_type_check for control endpoints
Date:   Mon,  7 Sep 2020 16:51:08 +0200
Message-Id: <20200907145108.3766613-12-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907145108.3766613-1-gregkh@linuxfoundation.org>
References: <20200907145108.3766613-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A USB device will always haev a bi-directional endpoint 0, that's just
how the devices work, so no need to check for that in a few quirk tests
as it will always pass.

Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: Alexander Tsoy <alexander@tsoy.me>
Cc: alsa-devel@alsa-project.org
Reported-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2:
 - new patch, was not in v1 series, suggested by Alan.

 sound/usb/quirks.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index fc3aab04a0bc..35da4aa918c7 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -875,8 +875,6 @@ static int snd_usb_nativeinstruments_boot_quirk(struct usb_device *dev)
 {
 	int ret;
 
-	if (usb_pipe_type_check(dev, usb_sndctrlpipe(dev, 0)))
-		return -EINVAL;
 	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
 				  0xaf, USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 				  1, 0, NULL, 0, 1000);
@@ -984,8 +982,6 @@ static int snd_usb_axefx3_boot_quirk(struct usb_device *dev)
 
 	dev_dbg(&dev->dev, "Waiting for Axe-Fx III to boot up...\n");
 
-	if (usb_pipe_type_check(dev, usb_sndctrlpipe(dev, 0)))
-		return -EINVAL;
 	/* If the Axe-Fx III has not fully booted, it will timeout when trying
 	 * to enable the audio streaming interface. A more generous timeout is
 	 * used here to detect when the Axe-Fx III has finished booting as the
@@ -1117,8 +1113,6 @@ static int snd_usb_motu_m_series_boot_quirk(struct usb_device *dev)
 {
 	int ret;
 
-	if (usb_pipe_type_check(dev, usb_sndctrlpipe(dev, 0)))
-		return -EINVAL;
 	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
 			      1, USB_TYPE_VENDOR | USB_RECIP_DEVICE,
 			      0x0, 0, NULL, 0, 1000);
-- 
2.28.0

