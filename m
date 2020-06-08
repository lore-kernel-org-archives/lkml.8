Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96614C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7837921531
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658112;
	bh=5GzVTt+R+n0VqvXUNrg3imlRJK7rHOoKij++fVk9bF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=piZavAaVAgSaSXO8i6qtCDEPuxWwlBzikeARL5GoHimBxqSD+kQ90JaBpAWbtLzo7
	 beb62147DBTyEcmgXNGt7uA+l28CSTlAk0GFpHH8aObHzngK5DMwfaxbcxfcItwQBx
	 b1kYDsTvUA7hPfOJDuevClwJ8hnntP5sAx8+VgA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730002AbgFHXPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:60232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728058AbgFHXMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:12:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 291302100A;
        Mon,  8 Jun 2020 23:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657958;
        bh=5GzVTt+R+n0VqvXUNrg3imlRJK7rHOoKij++fVk9bF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SRpeiHzSdUnTi+nakwXHlOPjo1OJs61eIpulrbbFRDo1BzuOcW5ynlHAQOYxcTqM+
         afFF7p1r4MZaHaSpWj3OEMkyFzXxI7D3SA00+BZ624Mjg2Da3k17+PFc3Z8jzmEF8E
         1CRxMU3WjHHIHBEA0I7cx7PXs14eRqcZaIW6+xZE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.6 023/606] ALSA: hda/realtek - Add COEF workaround for ASUS ZenBook UX431DA
Date:   Mon,  8 Jun 2020 19:02:28 -0400
Message-Id: <20200608231211.3363633-23-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Takashi Iwai <tiwai@suse.de>

commit 1b94e59d30afecf18254ad413e953e7587645a20 upstream.

ASUS ZenBook UX431DA requires an additional COEF setup when booted
from the recent Windows 10, otherwise it produces the noisy output.
The quirk turns on COEF 0x1b bit 10 that has been cleared supposedly
due to the pop noise reduction.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207553
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://lore.kernel.org/r/20200512073203.14091-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_realtek.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e787792770be..d6bc39dce4cf 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5978,6 +5978,7 @@ enum {
 	ALC294_FIXUP_ASUS_DUAL_SPK,
 	ALC285_FIXUP_THINKPAD_HEADSET_JACK,
 	ALC294_FIXUP_ASUS_HPE,
+	ALC294_FIXUP_ASUS_COEF_1B,
 	ALC285_FIXUP_HP_GPIO_LED,
 };
 
@@ -7112,6 +7113,17 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC294_FIXUP_ASUS_HEADSET_MIC
 	},
+	[ALC294_FIXUP_ASUS_COEF_1B] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			/* Set bit 10 to correct noisy output after reboot from
+			 * Windows 10 (due to pop noise reduction?)
+			 */
+			{ 0x20, AC_VERB_SET_COEF_INDEX, 0x1b },
+			{ 0x20, AC_VERB_SET_PROC_COEF, 0x4e4b },
+			{ }
+		},
+	},
 	[ALC285_FIXUP_HP_GPIO_LED] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc285_fixup_hp_gpio_led,
@@ -7283,6 +7295,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x19ce, "ASUS B9450FA", ALC294_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x1a13, "Asus G73Jw", ALC269_FIXUP_ASUS_G73JW),
 	SND_PCI_QUIRK(0x1043, 0x1a30, "ASUS X705UD", ALC256_FIXUP_ASUS_MIC),
+	SND_PCI_QUIRK(0x1043, 0x1b11, "ASUS UX431DA", ALC294_FIXUP_ASUS_COEF_1B),
 	SND_PCI_QUIRK(0x1043, 0x1b13, "Asus U41SV", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x1043, 0x1bbd, "ASUS Z550MA", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1c23, "Asus X55U", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
-- 
2.25.1

