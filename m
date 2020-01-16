Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B820FC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 894F0214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579198132;
	bh=vGBL1imLSbmqR+6eJCLZvfNMR/2j+V+YokWAhVLP25k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JKOLQZvQf06tLmU2biAS+gCREDuUgg2I9qtlu1USElj+D1ATmEWPkYqamsaVB12sz
	 w4rBAUm+WUiRATLrckYjF84uPxezV9ntQMGkG6hZ5U+wGmVUlpWxA4GaqhbccTv4ft
	 5efJixuFVSiByv67hyj/ns5SFw+UX5J/N/mDK7RU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395052AbgAPSIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:08:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405078AbgAPRih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:38:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11883246F2;
        Thu, 16 Jan 2020 17:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196317;
        bh=vGBL1imLSbmqR+6eJCLZvfNMR/2j+V+YokWAhVLP25k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JacH2PLqUQIcVeoTub7XQiu88hqQlkqGLWepO6RJ6LkBDKlds9HWv8gcY+TtyZJc0
         jTkU64Z7hanQmbMtS9S+sacAOnox7Cm0JjzIjcSvkfaUzQFcaO6GWMbW3Vxu6UPW/Z
         O19BqKinhMqzx/LdIE9bE9HC5ObyMYiAB6jjFMK0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.9 122/251] ALSA: usb-audio: Handle the error from snd_usb_mixer_apply_create_quirk()
Date:   Thu, 16 Jan 2020 12:34:31 -0500
Message-Id: <20200116173641.22137-82-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 64fa1bbf0acb..54011f8543a7 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2626,7 +2626,9 @@ int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
 	    (err = snd_usb_mixer_status_create(mixer)) < 0)
 		goto _error;
 
-	snd_usb_mixer_apply_create_quirk(mixer);
+	err = snd_usb_mixer_apply_create_quirk(mixer);
+	if (err < 0)
+		goto _error;
 
 	err = snd_device_new(chip->card, SNDRV_DEV_CODEC, mixer, &dev_ops);
 	if (err < 0)
-- 
2.20.1

