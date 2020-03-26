Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6F2C2D0E7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6F822083E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 23:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585265201;
	bh=ORzXPbp3VM8lb9h+iz/TPGdw1+ZcuJaGaxN0L9Kj41U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g8/vxEo7Kwaxu1vsNii2SHCNkmq2mUE1YO7U2FTQKT0A4yqD9h2rDTLmB2Xz92a8i
	 7XKkBefJPUnNtShOSJo8AeAAzNf1PBd0q9+8OZAzbhYs/pweLIMH8ohS8OuSKQvzaD
	 rPugqLyjJ4sL2sg4wiiuWetRGKY0WGTG2JpfBsB0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgCZX0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 19:26:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727443AbgCZXZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 19:25:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF25320774;
        Thu, 26 Mar 2020 23:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585265116;
        bh=ORzXPbp3VM8lb9h+iz/TPGdw1+ZcuJaGaxN0L9Kj41U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q6YjCfunvnCF5g5jMZaJ7WK037qdXnJnfnLv41VZZorIAf2HsaFPdaSYZKKvYIeZx
         OYFvHEu6xJp6ZdV8gq97zA0wo4gw+9G7P6APWEpHRgVGbhaHf1i2QLkAMOiTjwbnJx
         FixMv6x+a0TNmuPIdbV8SbDrMhP8UAQRjUJk78jQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.14 02/10] ALSA: hda/realtek: Fix pop noise on ALC225
Date:   Thu, 26 Mar 2020 19:25:05 -0400
Message-Id: <20200326232513.8212-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326232513.8212-1-sashal@kernel.org>
References: <20200326232513.8212-1-sashal@kernel.org>
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
index 5a7afbeb612d5..e5d4765a182b5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7265,6 +7265,8 @@ static int patch_alc269(struct hda_codec *codec)
 		spec->gen.mixer_nid = 0;
 		break;
 	case 0x10ec0225:
+		codec->power_save_node = 1;
+		/* fall through */
 	case 0x10ec0295:
 		spec->codec_variant = ALC269_TYPE_ALC225;
 		spec->gen.mixer_nid = 0; /* no loopback on ALC225 ALC295 */
-- 
2.20.1

