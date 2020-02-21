Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F37FC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E74D120722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272537;
	bh=cZWF5B+oqnadoyrCckaRV5YoXWc4Oiv38tJwjPMVSmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zo11xsDVXBXKlaS3Tie9RhmZnaj2aT2sRS0m7R2znCpuReLeb89fhSQ+EXYij3fQG
	 iVQJHT4nd2cH6UBHyA/5SgXidQ/p7c/EyU/cbT+vHuhRjzvJXKQD7cKv5+882v3i50
	 jdPNok/MYNyDwihu0777iz2126EwlZSLzcpUw9fU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732276AbgBUIIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:08:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:43544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732265AbgBUIIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:08:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9C7420722;
        Fri, 21 Feb 2020 08:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272532;
        bh=cZWF5B+oqnadoyrCckaRV5YoXWc4Oiv38tJwjPMVSmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bNO2TZNjik01NfESDSa1YkrCgHlUnJsPxpn3t/oK8AiBIFSZutIfdu0tN/yB7vDVb
         PoeUuxFQdHtFJ1DLgen/zCrwxVijLowYCTFsI3uplsuaymvluDnwShn2xYk3KQ6wCS
         gul4MBhOz20j5Xx9qDpP1zaBqEXMY5Ee8aNsk4zg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 177/344] ALSA: hda/realtek - Apply mic mute LED quirk for Dell E7xx laptops, too
Date:   Fri, 21 Feb 2020 08:39:36 +0100
Message-Id: <20200221072405.051898397@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
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
index a66d4be3516e6..f162e607fc6c3 100644
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



