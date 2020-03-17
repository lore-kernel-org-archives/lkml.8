Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C16C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7C4720663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443855;
	bh=dfpeeN7DSvHful1o+mzS+Yln2lqJERTsioAlBm8IlR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zTLDaAqk+nDyVFCXab/zJLERes86sjLWRR8jHHJ6Se/D1DWvkDuya4D1YZY0c2Dox
	 8woFNBGykGsij3mB01UzC1j8HHtKBX3jRalCU1jr8ITjfWD6bd5yqJsdQURMFdaJTh
	 ihsFp429QyKMYRfTzTlBGPdwuos7zQeI9Z0EiXbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgCQLRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:17:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728725AbgCQLHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:07:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAA12206EC;
        Tue, 17 Mar 2020 11:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443223;
        bh=dfpeeN7DSvHful1o+mzS+Yln2lqJERTsioAlBm8IlR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yKdL46D1pPRpOo+qPrXtsj+9dKTDQiCv1KARl//DbATp13sOgEqyhObzc8/N6lOT0
         OE6DzJGtUPR7UjLF1s8cdxygodyOB55qNLKq29A/SAESrJEtxlYCJewlfp5wsD/Lye
         eqgC1DjXyurvupA52Dl4+JKtV6F/UdW72oKltvH4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 004/151] ALSA: hda/realtek - Fixed one of HP ALC671 platform Headset Mic supported
Date:   Tue, 17 Mar 2020 11:53:34 +0100
Message-Id: <20200317103326.839152125@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

[ Upstream commit f2adbae0cb20c8eaf06914b2187043ea944b0aff ]

HP want to keep BIOS verb table for release platform.
So, it need to add 0x19 pin for quirk.

Fixes: 5af29028fd6d ("ALSA: hda/realtek - Add Headset Mic supported for HP cPC")
Signed-off-by: Kailang Yang <kailang@realtek.com>
Link: https://lore.kernel.org/r/74636ccb700a4cbda24c58a99dc430ce@realtek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 25d0013abcb0e..835af7d2bbd4d 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9140,6 +9140,7 @@ static const struct snd_hda_pin_quirk alc662_pin_fixup_tbl[] = {
 	SND_HDA_PIN_QUIRK(0x10ec0671, 0x103c, "HP cPC", ALC671_FIXUP_HP_HEADSET_MIC2,
 		{0x14, 0x01014010},
 		{0x17, 0x90170150},
+		{0x19, 0x02a11060},
 		{0x1b, 0x01813030},
 		{0x21, 0x02211020}),
 	SND_HDA_PIN_QUIRK(0x10ec0671, 0x103c, "HP cPC", ALC671_FIXUP_HP_HEADSET_MIC2,
-- 
2.20.1



