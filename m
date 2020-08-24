Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D12C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE6B20738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 17:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598289723;
	bh=1N7E8jTdaJiP5AS0s7ssZc9dpyomkdQrUUBLpq3o5w0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z1KTVLAqjs3Rc8PThJKpRatmV575ux9zIvenmHORMG5rOiEc8PgURIdySCw6j3hOV
	 97d2pnH+ClwiAB/QjAQwSL+/LJpf3hNnRLiGrI+nh7L6jQclknyIxw6soWyJ7Dz0zC
	 5Ib7O4yPsxM3qm+pyCr58GzxkCU8AvcQPFqk9Zrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgHXRV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 13:21:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728281AbgHXQfx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:35:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 110C522D00;
        Mon, 24 Aug 2020 16:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598286952;
        bh=1N7E8jTdaJiP5AS0s7ssZc9dpyomkdQrUUBLpq3o5w0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0uKurwG2PO6KzP9T/F/HxSxhSxAxGAkjReZu+emy3kFWpqYLhPycM/5yi2h10zdD8
         yKLpq8uXvNwsqrJmiwDYIpaVh8xzEx+74v2L8U+hw3AOIxZWGGwGEH6NibMz3u4h15
         6L9AmYR20rDVTFugJDnrul9TdLi0vQxXuH3O3xP0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tom Yan <tom.ty89@gmail.com>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.8 36/63] ALSA: usb-audio: ignore broken processing/extension unit
Date:   Mon, 24 Aug 2020 12:34:36 -0400
Message-Id: <20200824163504.605538-36-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163504.605538-1-sashal@kernel.org>
References: <20200824163504.605538-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Yan <tom.ty89@gmail.com>

[ Upstream commit d8d0db7bb358ef65d60726a61bfcd08eccff0bc0 ]

Some devices have broken extension unit where getting current value
doesn't work. Attempt that once when creating mixer control for it. If
it fails, just ignore it, so that it won't cripple the device entirely
(and/or make the error floods).

Signed-off-by: Tom Yan <tom.ty89@gmail.com>
Link: https://lore.kernel.org/r/5f3abc52.1c69fb81.9cf2.fe91@mx.google.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index eab0fd4fd7c33..e0b7174c10430 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -2367,7 +2367,7 @@ static int build_audio_procunit(struct mixer_build *state, int unitid,
 	int num_ins;
 	struct usb_mixer_elem_info *cval;
 	struct snd_kcontrol *kctl;
-	int i, err, nameid, type, len;
+	int i, err, nameid, type, len, val;
 	const struct procunit_info *info;
 	const struct procunit_value_info *valinfo;
 	const struct usbmix_name_map *map;
@@ -2470,6 +2470,12 @@ static int build_audio_procunit(struct mixer_build *state, int unitid,
 			break;
 		}
 
+		err = get_cur_ctl_value(cval, cval->control << 8, &val);
+		if (err < 0) {
+			usb_mixer_elem_info_free(cval);
+			return -EINVAL;
+		}
+
 		kctl = snd_ctl_new1(&mixer_procunit_ctl, cval);
 		if (!kctl) {
 			usb_mixer_elem_info_free(cval);
-- 
2.25.1

