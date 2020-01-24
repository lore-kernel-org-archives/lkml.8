Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6034C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E50B2075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864674;
	bh=5vSBvmzXP7MA6SKWpfgL6W/TG8b+SIJiVZOoMEVSgNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z73BL+Myq7goYcJnxmy46AFmTOjT/cE4RqCV+CABC5UXxhEC1gVDtZqzx8FJN4R1p
	 aXhuNj0jIiDqzbo1tBXaslCSv+LGKFc3d7NtbajQaO/U37ART12wmclYUD1hInnvBc
	 Ta+KX6LaNkwlRdy9pU3BEw4kbp4Uk56Cd+UPIwkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390570AbgAXLRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:17:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:54850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390561AbgAXLRu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:17:50 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D427020708;
        Fri, 24 Jan 2020 11:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864669;
        bh=5vSBvmzXP7MA6SKWpfgL6W/TG8b+SIJiVZOoMEVSgNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=koMU/A3Bv7cy3ZuOomTvPiStWA6tgCq54llS3R5k8ovmvP3E8itYaeyeEPouokSDI
         AoQthE+qB0EwZDS0NkxnOsSI87Ex6cHUMeQJT0TaCL+1cEDLW97nf/yO1Bi7kTF8+Z
         AVVTlxsWXzcNObM9HU6Ervq1wOjpaOvYAWCZA6fk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 324/639] ALSA: usb-audio: Handle the error from snd_usb_mixer_apply_create_quirk()
Date:   Fri, 24 Jan 2020 10:28:14 +0100
Message-Id: <20200124093127.694171009@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 328e9f6973be2ee67862cb17bf6c0c5c5918cd72 ]

The error from snd_usb_mixer_apply_create_quirk() is ignored in the
current usb-audio driver code, which will continue the probing even
after the error.  Let's take it more serious.

Fixes: 7b1eda223deb ("ALSA: usb-mixer: factor out quirks")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index d7778f2bcbf86..6ac6a09801245 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -3480,7 +3480,9 @@ int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 	if (err < 0)
 		goto _error;
 
-	snd_usb_mixer_apply_create_quirk(mixer);
+	err = snd_usb_mixer_apply_create_quirk(mixer);
+	if (err < 0)
+		goto _error;
 
 	err = snd_device_new(chip->card, SNDRV_DEV_CODEC, mixer, &dev_ops);
 	if (err < 0)
-- 
2.20.1



