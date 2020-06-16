Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF50C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00699208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323820;
	bh=LHf8gDm6CCyZh1htR8UAvbQLFNdi/dqQI5P0jwFwD2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j4fX6SVX7HZvN7PbvU0Qm3esJe60kfXmuqy1o8kGhVOAybDqTvqu3u32AaulOfam7
	 iPbSDSDQA9l22NFWgcjgzVRUwdZ05S6Y8kddST3dSOghFkV7gYt29PJnzls9dTQBlJ
	 ODssRDIOStLxlwykzAwOAcriU88e1L6baQP+t3Bw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgFPQKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 12:10:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:35158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731996AbgFPPok (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:44:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7BD9121534;
        Tue, 16 Jun 2020 15:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322280;
        bh=LHf8gDm6CCyZh1htR8UAvbQLFNdi/dqQI5P0jwFwD2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0m8yJdlzvojBACriFCNxQ5UuTQts015aC+EPveYYIquK1B4IYbH9SpkjmWmOvVrvv
         TvT4F6XDePOBZUfkFRtssD8AVy8UMAQfoobOs8YZtw23/PlR9oqOImRvg/VKBYnxC5
         xDhBODuH6SHZmE7d5r2G8JSgpKtSC1XhTzMNYiNU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.7 071/163] ALSA: usb-audio: Add vendor, product and profile name for HP Thunderbolt Dock
Date:   Tue, 16 Jun 2020 17:34:05 +0200
Message-Id: <20200616153110.248840190@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 0c5086f5699906ec8e31ea6509239489f060f2dc upstream.

The HP Thunderbolt Dock has two separate USB devices, one is for speaker
and one is for headset. Add names for them so userspace can apply UCM
settings.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200608062630.10806-1-kai.heng.feng@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/usb/quirks-table.h |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -25,6 +25,26 @@
 	.idProduct = prod, \
 	.bInterfaceClass = USB_CLASS_VENDOR_SPEC
 
+/* HP Thunderbolt Dock Audio Headset */
+{
+	USB_DEVICE(0x03f0, 0x0269),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "HP",
+		.product_name = "Thunderbolt Dock Audio Headset",
+		.profile_name = "HP-Thunderbolt-Dock-Audio-Headset",
+		.ifnum = QUIRK_NO_INTERFACE
+	}
+},
+/* HP Thunderbolt Dock Audio Module */
+{
+	USB_DEVICE(0x03f0, 0x0567),
+	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
+		.vendor_name = "HP",
+		.product_name = "Thunderbolt Dock Audio Module",
+		.profile_name = "HP-Thunderbolt-Dock-Audio-Module",
+		.ifnum = QUIRK_NO_INTERFACE
+	}
+},
 /* FTDI devices */
 {
 	USB_DEVICE(0x0403, 0xb8d8),


