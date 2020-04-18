Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA89DC4CC77
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A236522251
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587219037;
	bh=cpAMGGfP/vuBzpkFWI/SKvrGzpquAnEwlNg3K7foEDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SST0d3FcjasxQqSYeYGiyEDSd8hhsCXbpZ0x4xAzUetwCEOQ6DsXQvKtfAIFhDPEY
	 E4t/uC3iaYcb/rExxZ0oa73K01sjwfPprGwPN8KtHpRG6EDNLLKaWBBjasdkA3Zrow
	 sdTqlrj22zdTmzd9tQ3gdnB0sS5bAdj4LTXbxPYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgDROKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:10:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbgDROKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:10:30 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 091FE21D79;
        Sat, 18 Apr 2020 14:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587219029;
        bh=cpAMGGfP/vuBzpkFWI/SKvrGzpquAnEwlNg3K7foEDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pFautUt7Oby/mErimggAA8IuixWmJ6ItMmCvK1Df5FfqGqyhB0/9dSBHVcEpYqRDO
         EtF/K4N1pyAwdpdoLjfQxbSpCY7C9LIJmw8ejRteujq/weGOYR3rPhdK6pRpXnG4HI
         1PSCoIxtG/VJJ4slHKO6zrOL2RDX0XOqgae82ZJo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.5 64/75] ALSA: hda/realtek - Add quirk for Lenovo Carbon X1 8th gen
Date:   Sat, 18 Apr 2020 10:08:59 -0400
Message-Id: <20200418140910.8280-64-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418140910.8280-1-sashal@kernel.org>
References: <20200418140910.8280-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit ca707b3f00b4f31a6e1eb37e8ae99f15f2bb1fe5 ]

The audio setup on the Lenovo Carbon X1 8th gen is the same as that on
the Lenovo Carbon X1 7th gen, as such it needs the same
ALC285_FIXUP_THINKPAD_HEADSET_JACK quirk.

This fixes volume control of the speaker not working among other things.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1820196
Cc: stable@vger.kernel.org
Suggested-by: Jaroslav Kysela <perex@perex.cz>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Jaroslav Kysela <perex@perex.cz>
Link: https://lore.kernel.org/r/20200402174311.238614-1-hdegoede@redhat.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 62eac992ebd55..e2c77d2ab26e9 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7300,6 +7300,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x225d, "Thinkpad T480", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x17aa, 0x2292, "Thinkpad X1 Yoga 7th", ALC285_FIXUP_THINKPAD_HEADSET_JACK),
 	SND_PCI_QUIRK(0x17aa, 0x2293, "Thinkpad X1 Carbon 7th", ALC285_FIXUP_THINKPAD_HEADSET_JACK),
+	SND_PCI_QUIRK(0x17aa, 0x22be, "Thinkpad X1 Carbon 8th", ALC285_FIXUP_THINKPAD_HEADSET_JACK),
 	SND_PCI_QUIRK(0x17aa, 0x30bb, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x30e2, "ThinkCentre AIO", ALC233_FIXUP_LENOVO_LINE2_MIC_HOTKEY),
 	SND_PCI_QUIRK(0x17aa, 0x310c, "ThinkCentre Station", ALC294_FIXUP_LENOVO_MIC_LOCATION),
-- 
2.20.1

