Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F92C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3495320715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589824965;
	bh=HkR9eIszkiD1ualvNk8GTE0CLQxQ7QDWTDtJRxTZNl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tuPEpaed+ascNUi2OkvvHB6i9hJuSqPb3b1PsZjiIrMAUkmOK40aKZbiTW6lgKet7
	 mK5NpRpabqmxQpdcg8dJJGyjJaQmN5sbLOMAcKxaVytwenNiRSdZF0ZvipRFTXPEVR
	 kUTlGxcnRt1zro8/pvMktrhUV2VQGA19omPVo8VQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732567AbgERSCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732531AbgERSCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:02:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AF372168B;
        Mon, 18 May 2020 18:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589824956;
        bh=HkR9eIszkiD1ualvNk8GTE0CLQxQ7QDWTDtJRxTZNl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dtrWqtK/zvcz27wZjY8CWcg3wHbzV95UTo98n63CTuAafF6tGWVioHD+BxhKP/e+G
         kjX8KPgcyEEuH08cC4QjC75/bEAuSYs+bYX6jstLKgUqCp+GbqVT7ZtqBGv5z6tac1
         bXOUvKtuzDteh3CAAT4DLl2GcOOjBmt/JXh0mRvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 070/194] ALSA: hda/realtek - Fix S3 pop noise on Dell Wyse
Date:   Mon, 18 May 2020 19:36:00 +0200
Message-Id: <20200518173537.596244733@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

[ Upstream commit 52e4e36807aeac1cdd07b14e509c8a64101e1a09 ]

Commit 317d9313925c ("ALSA: hda/realtek - Set default power save node to
0") makes the ALC225 have pop noise on S3 resume and cold boot.

The previous fix enable power save node universally for ALC225, however
it makes some ALC225 systems unable to produce any sound.

So let's only enable power save node for the affected Dell Wyse
platform.

Fixes: 317d9313925c ("ALSA: hda/realtek - Set default power save node to 0")
BugLink: https://bugs.launchpad.net/bugs/1866357
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Link: https://lore.kernel.org/r/20200503152449.22761-2-kai.heng.feng@canonical.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index da4863d7f7f24..611498270c5e6 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5743,6 +5743,15 @@ static void alc233_alc662_fixup_lenovo_dual_codecs(struct hda_codec *codec,
 	}
 }
 
+static void alc225_fixup_s3_pop_noise(struct hda_codec *codec,
+				      const struct hda_fixup *fix, int action)
+{
+	if (action != HDA_FIXUP_ACT_PRE_PROBE)
+		return;
+
+	codec->power_save_node = 1;
+}
+
 /* Forcibly assign NID 0x03 to HP/LO while NID 0x02 to SPK for EQ */
 static void alc274_fixup_bind_dacs(struct hda_codec *codec,
 				    const struct hda_fixup *fix, int action)
@@ -5932,6 +5941,7 @@ enum {
 	ALC233_FIXUP_ACER_HEADSET_MIC,
 	ALC294_FIXUP_LENOVO_MIC_LOCATION,
 	ALC225_FIXUP_DELL_WYSE_MIC_NO_PRESENCE,
+	ALC225_FIXUP_S3_POP_NOISE,
 	ALC700_FIXUP_INTEL_REFERENCE,
 	ALC274_FIXUP_DELL_BIND_DACS,
 	ALC274_FIXUP_DELL_AIO_LINEOUT_VERB,
@@ -6817,6 +6827,12 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ }
 		},
 		.chained = true,
+		.chain_id = ALC225_FIXUP_S3_POP_NOISE
+	},
+	[ALC225_FIXUP_S3_POP_NOISE] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc225_fixup_s3_pop_noise,
+		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MODE_NO_HP_MIC
 	},
 	[ALC700_FIXUP_INTEL_REFERENCE] = {
-- 
2.20.1



