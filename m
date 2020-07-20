Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C405FC433F7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97A6D2176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595260946;
	bh=6TbSfa2y/8EXceWHAV40DoXSA3xriKUaaTKYitemB04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=10BwN5yK/9Yh15SYaAplW2pNu/CwTUqWQkzvrTSZLUQqSU4GS+PDEOwfYBPOZaFYd
	 2IB4CKySs62Hlezh6o0vOAmd1QozK7F8l/yZeCfuU/f2U25tixFg2XwB7+m3W85/X/
	 8KE47JQh4cvrUccdE7d1imPt3rdzO9jQ1n8XdSSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732665AbgGTQCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732650AbgGTQCV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:02:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C61C2176B;
        Mon, 20 Jul 2020 16:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260940;
        bh=6TbSfa2y/8EXceWHAV40DoXSA3xriKUaaTKYitemB04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RZLP4fahcZjukZWic+HSnwXRFicWEom0Hfitf0eS0kP5yCVXkxIZ4F7Yv1lrfz+S6
         xKw6R+ZPT77r2/D/MKzrb947OK+4TkjMPUHior97u3qNRpQq/2YucDUV59sDfOI1ZN
         BkdQXgElVjjcpWxfWSopGsyFJzJmPE/miu1NkeTs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Armas Spann <zappel@retarded.farm>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.4 151/215] ALSA: hda/realtek: enable headset mic of ASUS ROG Zephyrus G14(G401) series with ALC289
Date:   Mon, 20 Jul 2020 17:37:13 +0200
Message-Id: <20200720152827.375898403@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Armas Spann <zappel@retarded.farm>

commit ff53664daff2a65f4bf2479ac56dfb3e908deff0 upstream.

This patch adds support for headset mic to the ASUS ROG Zephyrus
G14(GA401) notebook series by adding the corresponding
vendor/pci_device id, as well as adding a new fixup for the used
realtek ALC289. The fixup stets the correct pin to get the headset mic
correctly recognized on audio-jack.

Signed-off-by: Armas Spann <zappel@retarded.farm>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200711110557.18681-1-zappel@retarded.farm
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -6117,6 +6117,7 @@ enum {
 	ALC269VC_FIXUP_ACER_VCOPPERBOX_PINS,
 	ALC269VC_FIXUP_ACER_HEADSET_MIC,
 	ALC269VC_FIXUP_ACER_MIC_NO_PRESENCE,
+	ALC289_FIXUP_ASUS_G401,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -7324,6 +7325,13 @@ static const struct hda_fixup alc269_fix
 		.chained = true,
 		.chain_id = ALC269_FIXUP_HEADSET_MIC
 	},
+	[ALC289_FIXUP_ASUS_G401] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x19, 0x03a11020 }, /* headset mic with jack detect */
+			{ }
+		},
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7504,6 +7512,7 @@ static const struct snd_pci_quirk alc269
 	SND_PCI_QUIRK(0x1043, 0x1bbd, "ASUS Z550MA", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1c23, "Asus X55U", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x1043, 0x1ccd, "ASUS X555UB", ALC256_FIXUP_ASUS_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1f11, "ASUS Zephyrus G14", ALC289_FIXUP_ASUS_G401),
 	SND_PCI_QUIRK(0x1043, 0x3030, "ASUS ZN270IE", ALC256_FIXUP_ASUS_AIO_GPIO2),
 	SND_PCI_QUIRK(0x1043, 0x831a, "ASUS P901", ALC269_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x834a, "ASUS S101", ALC269_FIXUP_STEREO_DMIC),


