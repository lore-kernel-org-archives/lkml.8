Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C218C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CD8207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580222657;
	bh=SxGtbT3Mgaz87pgcrFF12+gJMlFhmqiX1e0apsW2To0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GA/6a5K6KDAoJcr8HpCcJw9FCdetFEn9nsdt7rrBAEAeeSCK8uchm+AlwsUhiI7IW
	 8KYPYh9tCj6eXeqrLLWqqpByxXVo6Tw5+hpMUJmvI9ywqWIzcIWwyprTYkwpqjMHzs
	 CxEkzfsp39P+xgkYMmnuhaoTKPqqkR2h1+D/+DBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgA1OK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:10:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:59274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgA1OKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:10:24 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE43824685;
        Tue, 28 Jan 2020 14:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220624;
        bh=SxGtbT3Mgaz87pgcrFF12+gJMlFhmqiX1e0apsW2To0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fiC+wWv2XfEbUzDDmoJPRGM3eLuy9FqzONLdHezHgI3KDSwRVDIOLvGOOwpcz8h7I
         aMUV7AInvn3e/6NhXkaDT2QDrKIcKkUro/rdFYzTIeC4MT8nawbX/tLHQx8mA7GKrB
         unPa//xfXRq+4hvBZ+gbrSZvhtwyPdJm4MQvvxek=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 082/183] ALSA: usb-audio: Handle the error from snd_usb_mixer_apply_create_quirk()
Date:   Tue, 28 Jan 2020 15:05:01 +0100
Message-Id: <20200128135838.117920239@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135829.486060649@linuxfoundation.org>
References: <20200128135829.486060649@linuxfoundation.org>
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
index 1b81f18010d25..73149b9be29c9 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2552,7 +2552,9 @@ int snd_usb_create_mixer(struct snd_usb_audio *chip, int ctrlif,
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



