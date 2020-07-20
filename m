Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B231C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24459207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595261553;
	bh=+1yT4wI9uogjUjYhbmoxtxt/qG1w8c71JnCiYCEauSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qW+3ejIc2Xn89/NO9n0p47vaNZc/BPapDkQg9M2EMvmYzabCWIOe4EWao8ofHYbBA
	 uc8C4pSrL6Fxy0PhxC6eTtfJXxJuhsvjPex5yTZ/pTvdb7UgKleYKpSzYmtHD0XmHs
	 g1j0GAxEFB2OkQA8IE+yGh/QdHE+Vd2HS4xG5rQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387971AbgGTQMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:12:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:52054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387958AbgGTQM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:12:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A88922CBE;
        Mon, 20 Jul 2020 16:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595261547;
        bh=+1yT4wI9uogjUjYhbmoxtxt/qG1w8c71JnCiYCEauSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ws1KOZ96toHRpnkSiQ/kHKGRd4ksKV+hZtBHmmOd0esHyztC3maGEuSHIB6LjTYVW
         FCOQlGNxJ7gqKxesM/Bmjw3GI0lT1VgQorR6bH51c+l66cfhNlrEienEf9VAX3u53i
         a6T8Fy7RQ6KgDUqG1IGE2N6pRyf4ESZrKHIxydhI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jian-Hong Pan <jian-hong@endlessm.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.7 156/244] ALSA: hda/realtek: Enable headset mic of Acer TravelMate B311R-31 with ALC256
Date:   Mon, 20 Jul 2020 17:37:07 +0200
Message-Id: <20200720152833.273695772@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152825.863040590@linuxfoundation.org>
References: <20200720152825.863040590@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jian-Hong Pan <jian-hong@endlessm.com>

commit f50a121d2f32bccc1d6b94df925a1ce44ea7eff7 upstream.

The Acer TravelMate B311R-31 laptop's audio (1025:1430) with ALC256
cannot detect the headset microphone until
ALC256_FIXUP_ACER_MIC_NO_PRESENCE quirk maps the NID 0x19 as the headset
mic pin.

Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200713060421.62435-1-jian-hong@endlessm.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6118,6 +6118,7 @@ enum {
 	ALC269VC_FIXUP_ACER_HEADSET_MIC,
 	ALC269VC_FIXUP_ACER_MIC_NO_PRESENCE,
 	ALC289_FIXUP_ASUS_G401,
+	ALC256_FIXUP_ACER_MIC_NO_PRESENCE,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -7332,6 +7333,15 @@ static const struct hda_fixup alc269_fix
 			{ }
 		},
 	},
+	[ALC256_FIXUP_ACER_MIC_NO_PRESENCE] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x02a11120 }, /* use as headset mic, without its own jack detect */
+			{ }
+		},
+		.chained = true,
+		.chain_id = ALC256_FIXUP_ASUS_HEADSET_MODE
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7360,6 +7370,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1025, 0x1308, "Acer Aspire Z24-890", ALC286_FIXUP_ACER_AIO_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x132a, "Acer TravelMate B114-21", ALC233_FIXUP_ACER_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1025, 0x1330, "Acer TravelMate X514-51T", ALC255_FIXUP_ACER_HEADSET_MIC),
+	SND_PCI_QUIRK(0x1025, 0x1430, "Acer TravelMate B311R-31", ALC256_FIXUP_ACER_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1028, 0x0470, "Dell M101z", ALC269_FIXUP_DELL_M101Z),
 	SND_PCI_QUIRK(0x1028, 0x054b, "Dell XPS one 2710", ALC275_FIXUP_DELL_XPS),
 	SND_PCI_QUIRK(0x1028, 0x05bd, "Dell Latitude E6440", ALC292_FIXUP_DELL_E7X),


