Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135F8C35280
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 03:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2FB620746
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 03:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t0l7prVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgEJDbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 23:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726067AbgEJDbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 23:31:47 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236E9C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 20:31:47 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 145so3040714pfw.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 20:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4f/clxlilFuIydMRrGudVTp6YYwPxAbh7kCsQ3vkYa8=;
        b=t0l7prVwlEnbr1oApHJznJ8IXBo7EqYNw5LC/qWeeEiUUt/f1TQArV2Py/kzCmpfMh
         BYIpg9VZtjNgm+4uZLo+3coQ3s4gHezzhe9iQv418IqZDIWf+uP91Y2XQMjAAnpSLii1
         lEfOoeStisezK+epg2fvwCR7+joJ/m8aA3xmmPr0RLXBcW++aLzt/HpO4kyVjAzswoc3
         mEcdVE3exs77C4AHMuB+eHS1wRKDLgeCM49fvLQrijIVkSx+dXIQfmImxRMLrG07Sthi
         yL4RxiVJDBtmWrrb8gmZEAil1ay2wu4KZsY8tjHzwySSdReFVfZ9dTn0EKJO8b4YryJ/
         crzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4f/clxlilFuIydMRrGudVTp6YYwPxAbh7kCsQ3vkYa8=;
        b=kJ0Rh0IGMAESFjassrvRULvuRZhvSlnvkGdxFx5JKJ5SysLUVVXmpThvBwjgEuP00b
         BSoHpmKXbnIfGGmPOP9CEyCgkqT0yxKK6SfWcjFVe2mp/IfinrfGfBIFooB7i2DXalRw
         fNpwO922w9qrGp65KPsJEz4pF5aIcnLB7fY0OCcD1Zcus9HhRp5jPRCKcamiu4bnam7w
         6xGzPNifZSHaezXIEt/uskjQjiCWtsI20forV0k4gkEzYo4gHXCqVFTdOJZYNhyuPut6
         x1TwNLhxMA1pe1RiU8SF+aSveFD6eK1QTXmvTiFD4b0sStLpXokMoadRsXiqXMuyvvag
         SC0w==
X-Gm-Message-State: AGi0PuY3hKTDylyymr1tb3lnUMd3en7Al9sZO+gUL7w7w8k9iPEq47em
        93zfqW8tx2KiHoLiP0mIxwb0sDAAvwKXRQ==
X-Google-Smtp-Source: APiQypLz1OxFU4SEHCrEEdHTNeTU4UGxH1nTvxgQ1jPIGJanZTFV2hjQaPmMHWKxUtJ+pt4ES7giRQ==
X-Received: by 2002:a63:3603:: with SMTP id d3mr9313359pga.101.1589081506381;
        Sat, 09 May 2020 20:31:46 -0700 (PDT)
Received: from localhost.localdomain (68-123-15-75.lightspeed.sntcca.sbcglobal.net. [68.123.15.75])
        by smtp.googlemail.com with ESMTPSA id b24sm5726350pfi.4.2020.05.09.20.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 20:31:46 -0700 (PDT)
From:   Mike Pozulp <pozulp.kernel@gmail.com>
Cc:     Mike Pozulp <pozulp.kernel@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Hui Wang <hui.wang@canonical.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Tomas Espeleta <tomas.espeleta@gmail.com>,
        Sergey Bostandzhyan <jin@mediatomb.cc>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Chris Chiu <chiu@endlessm.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Samsung Notebook
Date:   Sat,  9 May 2020 20:28:37 -0700
Message-Id: <20200510032838.1989130-1-pozulp.kernel@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some models of the Samsung Notebook 9 have very quiet and distorted
headphone output. This quirk changes the VREF value of the ALC298
codec NID 0x1a from default HIZ to new 100.

Signed-off-by: Mike Pozulp <pozulp.kernel@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 63e1a56f705b..9b14ed5c75d7 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -5923,6 +5923,7 @@ enum {
 	ALC294_FIXUP_ASUS_DUAL_SPK,
 	ALC285_FIXUP_THINKPAD_HEADSET_JACK,
 	ALC294_FIXUP_ASUS_HPE,
+	ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET,
 };
 
 static const struct hda_fixup alc269_fixups[] = {
@@ -7061,6 +7062,13 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC294_FIXUP_ASUS_HEADSET_MIC
 	},
+	[ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET] = {
+		.type = HDA_FIXUP_VERBS,
+		.v.verbs = (const struct hda_verb[]) {
+			{ 0x1a, AC_VERB_SET_PIN_WIDGET_CONTROL, 0xc5 },
+			{ }
+		},
+	},
 };
 
 static const struct snd_pci_quirk alc269_fixup_tbl[] = {
@@ -7336,6 +7344,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1b7d, 0xa831, "Ordissimo EVE2 ", ALC269VB_FIXUP_ORDISSIMO_EVE2), /* Also known as Malata PC-B1303 */
 	SND_PCI_QUIRK(0x1d72, 0x1901, "RedmiBook 14", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x10ec, 0x118c, "Medion EE4254 MD62100", ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE),
+	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
+	SND_PCI_QUIRK(0x144d, 0xc176, "Samsung Notebook 9 Pro (NP930MBE-K04US)", ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET),
 
 #if 0
 	/* Below is a quirk table taken from the old code.
-- 
2.24.1

