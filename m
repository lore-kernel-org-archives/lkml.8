Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1C3BC54E4B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAF8720736
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 06:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="OnGZ+FXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgELGQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 02:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725536AbgELGQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:16:31 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36AFC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 23:16:31 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m7so4948653plt.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 23:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BM7WTJ+qHi8yY8b7KAWbv88JG8UJulCC8C6JMceeobc=;
        b=OnGZ+FXckmCHP2iepPXFweAerr9YMNBlumuTJaRywQvBwbdOtLbtj0PPEACD6JWAs6
         vVXEBeHISJxaMuaExta6ea+wem+0QLiTV2CwpegD8snEpn3t8O67B0g+FLWuToNrGzvj
         7RSZomgqFPsshdznuwTfbqlUe+nh5/vEk6fTjOKVrCGxwBmc4FS1aALzByLaLaLFqEKY
         CY4BaS7T4BSwm//cL3yi/R5njWkny+i17MJtmwgVbHflewTa3N3LspbacGRvhGUdtnY3
         USidUjuMHhcNPeF9a2tLOKucWnzfb0F7FDHwTXvg8UhBnbXtGPLLC84aASK4jsv/z1Hy
         j2qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BM7WTJ+qHi8yY8b7KAWbv88JG8UJulCC8C6JMceeobc=;
        b=bcFqaQZVtqbaP+i8m+h5otjxo+E9pysqvQX/aYwdp+oRWQuZG//UB8n8yUeQaPv36o
         KcWy6xqRZ+496jxQGrUJWy7Udz6dH3BGTto4mDEoBvrzmU/I68ERsahpyOWHeVLcam49
         BVI/AkjDfhnOkZtj3o2UlMXGiw4b9PhUBB0KmeEphW2CrkH8iGNSfEXQQ+h5XxbiznRF
         p2WDdY4rFbBM4lo0jMX5WqtAuIq5a6baUht9aIzis5V4IwNdcrcJw2yqXCFIUoQ4cFBZ
         YEA2fTSKclsbtb+A55NEROf10oZ/G3LPH2VBd9vxCUGVlyBAkJLSTywl2piFRuPP38Qc
         ESPg==
X-Gm-Message-State: AGi0PuadSlg0AN5UYUn7Bix0wsXU62H9kaFm39WnwXMgbbNTo+gvAnwX
        1863IlG6WpmMoHQPy5GQEVomuw==
X-Google-Smtp-Source: APiQypJKwmiLgVWYFf4sho+PNadq3B0a3bAhRqtGKBEw3BL0rkIRCDS+bdoD7Qc6nFhDvIt8bPuwQQ==
X-Received: by 2002:a17:90a:2fc8:: with SMTP id n8mr27720360pjm.159.1589264191146;
        Mon, 11 May 2020 23:16:31 -0700 (PDT)
Received: from starnight.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id m14sm9660554pgk.56.2020.05.11.23.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 23:16:30 -0700 (PDT)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com, Chris Chiu <chiu@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH 1/3] ALSA: hda/realtek - Enable headset mic of ASUS GL503VM with ALC295
Date:   Tue, 12 May 2020 14:15:24 +0800
Message-Id: <20200512061525.133985-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Chiu <chiu@endlessm.com>

The ASUS laptop GL503VM with ALC295 can't detect the headset microphone.
The headset microphone does not work until pin 0x19 is enabled for it.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
---
 sound/pci/hda/patch_realtek.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index c16f63957c5a..6c996df16201 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6083,6 +6083,7 @@ enum {
 	ALC285_FIXUP_HP_GPIO_LED,
 	ALC285_FIXUP_HP_MUTE_LED,
 	ALC236_FIXUP_HP_MUTE_LED,
+	ALC295_FIXUP_ASUS_MIC_NO_PRESENCE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -7216,6 +7217,15 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc236_fixup_hp_mute_led,
 	},
+	[ALC295_FIXUP_ASUS_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x01a1913c }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC269_FIXUP_HEADSET_MODE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7993,6 +8003,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x12, 0x90a60130},
 		{0x17, 0x90170110},
 		{0x21, 0x03211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1043, "ASUS", ALC295_FIXUP_ASUS_MIC_NO_PRESENCE,
+		{0x12, 0x90a60130},
+		{0x17, 0x90170110},
+		{0x21, 0x03211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1028, "Dell", ALC269_FIXUP_DELL4_MIC_NO_PRESENCE,
 		{0x14, 0x90170110},
 		{0x21, 0x04211020}),
-- 
2.26.2

