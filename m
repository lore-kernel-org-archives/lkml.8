Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02752C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39142077D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585265104;
	bh=kPWJ+BaEWuRs5UqHZpXyj4OWe/1BZNryumcu0upnbzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hNMy6GN5nrJ8jqV1bCnVyDqFMiME3ZQcDcYSzdCxiqfAyeZGe1Wm/kU9fYzJsmz9a
	 /EAbrNsCOTYLroDIA9MaumfTtRfh0GroEnYrvwpq8UGHMPjsgJoTxEmdGQ8ie37jmu
	 Yq2jlmdz2sUJInnNez835Nei5+ai5ND0kFXW4b0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgCZXZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:25:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728147AbgCZXY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:24:59 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAD36214D8;
        Thu, 26 Mar 2020 23:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585265099;
        bh=kPWJ+BaEWuRs5UqHZpXyj4OWe/1BZNryumcu0upnbzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UeZbcDid9MuLSeFJJBdtRySpn1ixolRPbfEEIc0QDvyaLLiU5l0jNkoRd1CoSEv7D
         1BdVePQZkMsso8LJHEGLKXf+cTrLfllK/aiY7JlHq9iqekEuWyJZuD7EpKZddG9EeK
         cpOkWD8KlbBzfZKWg5WFUdXbUNL0cNIs9OrvtCFs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 03/15] ALSA: hda/realtek: Fix pop noise on ALC225
Date:   Thu, 26 Mar 2020 19:24:43 -0400
Message-Id: <20200326232455.8029-3-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326232455.8029-1-sashal@kernel.org>
References: <20200326232455.8029-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 3b36b13d5e69d6f51ff1c55d1b404a74646c9757 ]

Commit 317d9313925c ("ALSA: hda/realtek - Set default power save node to
0") makes the ALC225 have pop noise on S3 resume and cold boot.

So partially revert this commit for ALC225 to fix the regression.

Fixes: 317d9313925c ("ALSA: hda/realtek - Set default power save node to 0")
BugLink: https://bugs.launchpad.net/bugs/1866357
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Link: https://lore.kernel.org/r/20200311061328.17614-1-kai.heng.feng@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 86ab022f386ec..23aab2fdac468 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7828,6 +7828,8 @@ static int patch_alc269(struct hda_codec *codec)
 		spec->gen.mixer_nid = 0;
 		break;
 	case 0x10ec0225:
+		codec->power_save_node = 1;
+		/* fall through */
 	case 0x10ec0295:
 	case 0x10ec0299:
 		spec->codec_variant = ALC269_TYPE_ALC225;
-- 
2.20.1

