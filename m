Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687F0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49A5120738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfEif/1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgHYULm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgHYULW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:11:22 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75077C061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:21 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id p36so6643969qtd.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CK7w9dc4QEie3FM7RAdOzFBvSfRdAgHCNQ27lrrbOwc=;
        b=WfEif/1s1wQfKX0K3003AOn/g06TpEbch7S5cExqpsGTPF6AqIRGubrr0PaZApSwjr
         iZHE8eWRZKBf79M7xtGaLse3bY18ralBifMC7HzOvqZ5JUVYTXC3z8GkttBMrQ8sFBIU
         /swcSznR3mbIvuQiOEBc+RkZmJopRdLznTGJ9b3ikamAv+08G5Rl/c6m/rus/WAeDSxB
         j6rOXCusGzdsqBL4399j2rAQx/xii0/Pm9ELnczTo0zC+kTgeVoobx3jaT/JBgtanQ0k
         vwAnwBEMaoFoIvTY/DTUsLGYBM4S9BJwoVkTCCBHKt/TdHuOZTJxubfHA1Aw14qiuYDV
         hlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CK7w9dc4QEie3FM7RAdOzFBvSfRdAgHCNQ27lrrbOwc=;
        b=BGRFnub4dad1V+zDznFzZ+Xk8UbJ3pXFyiokVkp9SjJ8p8TZdwVt5Lq5KeZtNCMnnf
         5O7ArDRtbt4bCHgqaBboTNp0XC61fhSWDTsCozjqM1+Nme3mfgM5zQJ0xzhIKAm7MllF
         5aO5QSCRJ0VOSPNOjVsjMRrAnpVeD9JdI7inFchdhI/50a3VZiSXXTVXd3p2Hka/xXMU
         ZIZ10uPwzD7Y7Ykis5OYqP56nkP4kQDbi8m7OPLp0I45x0ZPopJ+x9ACr8N7Bzw5B/YI
         1Zk2N/Q5hNVZw1TDlQ9xSiKEhNGj6a5+8aJyvvgqZDutsi3KyxI52tajPZ6sz9lc2JbI
         UJNQ==
X-Gm-Message-State: AOAM5305IX0IBepEXoPsT+I3m7ElZ0JqZRx6Pzi4zNF4hq0dqF1RzLZe
        2CmZMC1vNHPbEicFFjF8Ce0=
X-Google-Smtp-Source: ABdhPJyvJM4iHOoReBTxyCWr9WSwa4ON8hLoyGqE+zrFQQmkldJAHqDDiTqX3ggU/xngnufmn//E7A==
X-Received: by 2002:ac8:4643:: with SMTP id f3mr11144298qto.128.1598386280785;
        Tue, 25 Aug 2020 13:11:20 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id n23sm12453459qkk.105.2020.08.25.13.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 13:11:20 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/20] ALSA: hda/ca0132 - Add SoundBlaster AE-7 pincfg.
Date:   Tue, 25 Aug 2020 16:10:30 -0400
Message-Id: <20200825201040.30339-12-conmanx360@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200825201040.30339-1-conmanx360@gmail.com>
References: <20200825201040.30339-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add AE-7 pincfg, based on the values set within Windows.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 284f63dc2749..6791aaf18e63 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1238,6 +1238,20 @@ static const struct hda_pintbl r3di_pincfgs[] = {
 	{}
 };
 
+static const struct hda_pintbl ae7_pincfgs[] = {
+	{ 0x0b, 0x01017010 },
+	{ 0x0c, 0x014510f0 },
+	{ 0x0d, 0x414510f0 },
+	{ 0x0e, 0x01c520f0 },
+	{ 0x0f, 0x01017114 },
+	{ 0x10, 0x01017011 },
+	{ 0x11, 0x018170ff },
+	{ 0x12, 0x01a170f0 },
+	{ 0x13, 0x908700f0 },
+	{ 0x18, 0x500000f0 },
+	{}
+};
+
 static const struct snd_pci_quirk ca0132_quirks[] = {
 	SND_PCI_QUIRK(0x1028, 0x057b, "Alienware M17x R4", QUIRK_ALIENWARE_M17XR4),
 	SND_PCI_QUIRK(0x1028, 0x0685, "Alienware 15 2015", QUIRK_ALIENWARE),
@@ -9105,6 +9119,10 @@ static void ca0132_config(struct hda_codec *codec)
 		codec_dbg(codec, "%s: QUIRK_AE5 applied.\n", __func__);
 		snd_hda_apply_pincfgs(codec, ae5_pincfgs);
 		break;
+	case QUIRK_AE7:
+		codec_dbg(codec, "%s: QUIRK_AE7 applied.\n", __func__);
+		snd_hda_apply_pincfgs(codec, ae7_pincfgs);
+		break;
 	default:
 		break;
 	}
@@ -9186,6 +9204,7 @@ static void ca0132_config(struct hda_codec *codec)
 		spec->dig_in = 0x09;
 		break;
 	case QUIRK_AE5:
+	case QUIRK_AE7:
 		spec->num_outputs = 2;
 		spec->out_pins[0] = 0x0B; /* Line out */
 		spec->out_pins[1] = 0x11; /* Rear headphone out */
-- 
2.20.1

