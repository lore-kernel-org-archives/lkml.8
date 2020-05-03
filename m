Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F95EC28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 15:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E58DE206E9
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 15:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgECPZU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 11:25:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36640 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbgECPZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 11:25:19 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jVGUF-0004b3-Ls; Sun, 03 May 2020 15:25:00 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     David_chen7@dell.com, Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Tomas Espeleta <tomas.espeleta@gmail.com>,
        Thomas Hebb <tommyhebb@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] Revert "ALSA: hda/realtek: Fix pop noise on ALC225"
Date:   Sun,  3 May 2020 23:24:46 +0800
Message-Id: <20200503152449.22761-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 3b36b13d5e69d6f51ff1c55d1b404a74646c9757.

Enable power save node breaks some systems with ACL225. Revert the patch
and use a platform specific quirk for the original issue isntead.

Fixes: 3b36b13d5e69 ("ALSA: hda/realtek: Fix pop noise on ALC225")
BugLink: https://bugs.launchpad.net/bugs/1875916
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index b26f0acfd86e..dedf0c17f198 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8246,8 +8246,6 @@ static int patch_alc269(struct hda_codec *codec)
 		spec->gen.mixer_nid = 0;
 		break;
 	case 0x10ec0225:
-		codec->power_save_node = 1;
-		/* fall through */
 	case 0x10ec0295:
 	case 0x10ec0299:
 		spec->codec_variant = ALC269_TYPE_ALC225;
-- 
2.17.1

