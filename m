Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABB8C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1CF620776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520786;
	bh=JnivCYcVOZ73WwbFWkQucbsHSKqUdGvKU95EX62tYBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LUDP8j/uYH3d/MUGANRNmabtIUQ2vgINZ0oUDl3hKW/3hRBpDUALLaRJUP5h0RRnc
	 qqBh6uT9Dgelww6aq/IxqOmlekNoWy02J8M6xB59Rah8TsljnR7N2rfbNA64S+z2Nh
	 AjQw5+rP7Ii/Ci/PriZnBuPf3SiuqV7Z9Qo5+6B8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392447AbgEZTTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:19:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391105AbgEZTNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:13:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75E2A208B3;
        Tue, 26 May 2020 19:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520391;
        bh=JnivCYcVOZ73WwbFWkQucbsHSKqUdGvKU95EX62tYBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7qir3FY50EPyVp7/ezp5gJtoAMC3PwO8VDwgnVk16rwzP3QKk77iu6GEPd32Odt1
         8N4/L5MyrfIjgE6EfMTSCZ6xdFXyLUDgzv0D4kY1/pATEWXh1GbAhyAxKEa8gdQCD6
         sR71T1Xdgx+XsZCf3EA2Qi4BjFhjmaPcmORI/tzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian-Hong Pan <jian-hong@endlessm.com>,
        Daniel Drake <drake@endlessm.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 060/126] ALSA: hda/realtek - Enable headset mic of ASUS UX550GE with ALC295
Date:   Tue, 26 May 2020 20:53:17 +0200
Message-Id: <20200526183943.184664767@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian-Hong Pan <jian-hong@endlessm.com>

[ Upstream commit ad97d667854c2fbce05a004e107f358ef4b04cf6 ]

The ASUS laptop UX550GE with ALC295 can't detect the headset microphone
until ALC295_FIXUP_ASUS_MIC_NO_PRESENCE quirk applied.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Signed-off-by: Daniel Drake <drake@endlessm.com>
Link: https://lore.kernel.org/r/20200512061525.133985-2-jian-hong@endlessm.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f92cd420e98d..ece762d0c714 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -8050,6 +8050,10 @@ static const struct snd_hda_pin_quirk alc269_pin_fixup_tbl[] = {
 		{0x12, 0x90a60130},
 		{0x17, 0x90170110},
 		{0x21, 0x03211020}),
+	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1043, "ASUS", ALC295_FIXUP_ASUS_MIC_NO_PRESENCE,
+		{0x12, 0x90a60120},
+		{0x17, 0x90170110},
+		{0x21, 0x04211030}),
 	SND_HDA_PIN_QUIRK(0x10ec0295, 0x1043, "ASUS", ALC295_FIXUP_ASUS_MIC_NO_PRESENCE,
 		{0x12, 0x90a60130},
 		{0x17, 0x90170110},
-- 
2.25.1



