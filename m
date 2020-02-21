Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55B1C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03FF206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582274680;
	bh=3ODXTUeZ35UJmyvQ2p0iB2Y0ndy83nSr1LYsnmFOKuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nt0BUD8oSTV1/qzC44E2kLh8IBmaNE2zMCXg5VkvLRJe9iSvPasogY748C5YAkC8m
	 RqCLVXgXAPL+kX399iVY6XEF2kgZW0xj8h31j08YIDlHLYAIJkYDvuLOapIalyrk4v
	 UkHpacqwrK7+hYkeOvHepCZdKXfPBMuIlgg3nbGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731826AbgBUIof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:44:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729870AbgBUHwQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:52:16 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D03820578;
        Fri, 21 Feb 2020 07:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271535;
        bh=3ODXTUeZ35UJmyvQ2p0iB2Y0ndy83nSr1LYsnmFOKuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DvSoukyzBNMmKu0juXEbS64Cz7HHrf0Tpp0cQO95KVLmbWPBCYhcnIKnDjR/WVt54
         SqosxEv7xWJOnZDt8qnNSFHoya6iJQHAJTVjY0YX98XOU4PNli0JuD7WuYXVYr+C++
         BfNGJPYAQu91lLrs0w9XgO6z11v0zE7AuGaC2q6w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 204/399] ALSA: hda/realtek - Apply mic mute LED quirk for Dell E7xx laptops, too
Date:   Fri, 21 Feb 2020 08:38:49 +0100
Message-Id: <20200221072422.690520749@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 5fab5829674c279839a7408ab30c71c6dfe726b9 ]

Dell E7xx laptops have also mic mute LED that is driven by the
dell-laptop platform driver.  Bind it with the capture control as
already done for other models.

A caveat is that the fixup hook for the mic mute LED has to be applied
at last, otherwise it results in the invalid override of the callback.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=205529
Link: https://lore.kernel.org/r/20200105081119.21396-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 128d81b4140b3..c6b1581c6ffaa 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5852,6 +5852,7 @@ enum {
 	ALC288_FIXUP_DELL1_MIC_NO_PRESENCE,
 	ALC288_FIXUP_DELL_XPS_13,
 	ALC288_FIXUP_DISABLE_AAMIX,
+	ALC292_FIXUP_DELL_E7X_AAMIX,
 	ALC292_FIXUP_DELL_E7X,
 	ALC292_FIXUP_DISABLE_AAMIX,
 	ALC293_FIXUP_DISABLE_AAMIX_MULTIJACK,
@@ -6547,12 +6548,19 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC293_FIXUP_DELL1_MIC_NO_PRESENCE
 	},
-	[ALC292_FIXUP_DELL_E7X] = {
+	[ALC292_FIXUP_DELL_E7X_AAMIX] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_dell_xps13,
 		.chained = true,
 		.chain_id = ALC292_FIXUP_DISABLE_AAMIX
 	},
+	[ALC292_FIXUP_DELL_E7X] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = snd_hda_gen_fixup_micmute_led,
+		/* micmute fixup must be applied at last */
+		.chained_before = true,
+		.chain_id = ALC292_FIXUP_DELL_E7X_AAMIX,
+	},
 	[ALC298_FIXUP_ALIENWARE_MIC_NO_PRESENCE] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
-- 
2.20.1



