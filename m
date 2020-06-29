Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6BDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7253620656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593462198;
	bh=NINkKK4I3VffHpoat9TDm1EvXMkhuApXJRXDL/obqqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xWmuN9/9N/xXh/aI5YQmD5efucyMP4/bGhxcp92YExFSb5C91efV2KsXwMgBzW78x
	 fX406P3RTa+H5kI1YPLKyl9qo8cgeaO6OTrk4oQT18xZZeyjQTAnnlgotN8K2vduTq
	 3u00hsjdaRu9EkvR8psRIzf3jlrEvZNESzsca2Aw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387652AbgF2UXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:23:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732575AbgF2TZc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F15125448;
        Mon, 29 Jun 2020 15:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445399;
        bh=NINkKK4I3VffHpoat9TDm1EvXMkhuApXJRXDL/obqqw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sLD7spZU8KxAyfRcDA2K5E5EmTYKGyIshzyqjsud0ZqR/45ELVipvoBAKMa6yZZRw
         fYfTyy+O07XNL+4fcLiNbk2LIN4i+w8KgiEJrF/hBJV0YsEf7vZvx8aDPenfH5yk4n
         ++UGDcAHlaccbBDcJ7j20350WKIloK/pTk9yKdpw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Yick W. Tse" <y_w_tse@yahoo.com.hk>, Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.9 151/191] ALSA: usb-audio: add quirk for Denon DCD-1500RE
Date:   Mon, 29 Jun 2020 11:39:27 -0400
Message-Id: <20200629154007.2495120-152-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629154007.2495120-1-sashal@kernel.org>
References: <20200629154007.2495120-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Yick W. Tse" <y_w_tse@yahoo.com.hk>

commit c9808bbfed3cfc911ecb60fe8e80c0c27876c657 upstream.

fix error "clock source 41 is not valid, cannot use"

[] New USB device found, idVendor=154e, idProduct=1002, bcdDevice= 1.00
[] New USB device strings: Mfr=1, Product=2, SerialNumber=0
[] Product: DCD-1500RE
[] Manufacturer: D & M Holdings Inc.
[]
[] clock source 41 is not valid, cannot use
[] usbcore: registered new interface driver snd-usb-audio

Signed-off-by: Yick W. Tse <y_w_tse@yahoo.com.hk>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/1373857985.210365.1592048406997@mail.yahoo.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 0484a8d8a5bbe..486d27129ac39 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1162,6 +1162,7 @@ bool snd_usb_get_sample_rate_quirk(struct snd_usb_audio *chip)
 static bool is_itf_usb_dsd_2alts_dac(unsigned int id)
 {
 	switch (id) {
+	case USB_ID(0x154e, 0x1002): /* Denon DCD-1500RE */
 	case USB_ID(0x154e, 0x1003): /* Denon DA-300USB */
 	case USB_ID(0x154e, 0x3005): /* Marantz HD-DAC1 */
 	case USB_ID(0x154e, 0x3006): /* Marantz SA-14S1 */
-- 
2.25.1

