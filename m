Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DFAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85A4120748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DFRXGiY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgHUSyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbgHUSyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:54:02 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637DFC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:54:02 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n129so2271161qkd.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vbIqlW9tIGTLfzpUAmzhy2jwZSMiaqwnKKLjixkwjZs=;
        b=DFRXGiY0lVwbInp4Hc89l99KSZWL1Y7oOq+tGhWChfBNLIkYEbwUqlZ4BXU/tPedgV
         2wHD/yNKHdEwXsTgi7ljPnNM10evF+j56rGZJcj/UUSkuJW5O3+h+aGGBJHrLS3K+5W8
         YBCE7Uzd/2Ew6IUsRorq91yt/tLUcNL76j0F58g5xFJYCH8cozhBS6rhTI19skAZt3Na
         dGCls7TePTma8gQn7ElUlO92812r9ZQeir4EKlznCEddlp77Il1gz1alD39fjjqYYdZg
         Dz4FG6ya6MYVBuG395UPfgHZtIt0Ea7OqRSz+07GIUIzj7uwWR/CTw2SCTgJbCeEO7by
         tbhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vbIqlW9tIGTLfzpUAmzhy2jwZSMiaqwnKKLjixkwjZs=;
        b=STOba78eCUtUHrwHHd+J/VVykLbj1eoHik/sDLHJ4EULAeObDkXu5di0WL4st5Uhxc
         qV0adCIxexyPd7qaWCIBlOvp0D0LPk2JMgJLiFJW+kfCdKDEF75FxJuly4XkE1MmzzKT
         BKNBm2zGHHWy+eEvaFS+iV+p4b87ArkpCZdtSkjwR8q4ndEUmtQRZlukVi1kToH6pwx+
         LN8TCNQIQKySmPvan0VApbpJ44cDBO7z/Zy7U8qI//2OpehtsI/ZeGsXW1vBGculmsNp
         NsTHofrZ786h1f0APgIgUpWVAem6E9zjH3ECqZ+Que2LhTwytXIe62ArfueoW/4k+BgD
         fLUw==
X-Gm-Message-State: AOAM532aP13AbXXnLwHPW0TTg+z6AFNaUUbqwPWIT+vVmj/g26mBbpjo
        fQhioyafhO/S6hWR4Ax45oQ=
X-Google-Smtp-Source: ABdhPJyG++7Ob77MchmieGa7tWfqpRRJpEIGbAVu1UOAkvGBzvAcBL4dHOxqx5zI33G9zpwWabyJ/g==
X-Received: by 2002:a05:620a:1523:: with SMTP id n3mr3891494qkk.245.1598036041687;
        Fri, 21 Aug 2020 11:54:01 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id o72sm2468426qka.113.2020.08.21.11.54.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:54:01 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/20] ALSA: hda/ca0132 - Add SoundBlaster AE-7 pincfg.
Date:   Fri, 21 Aug 2020 14:52:28 -0400
Message-Id: <20200821185239.26133-12-conmanx360@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200821185239.26133-1-conmanx360@gmail.com>
References: <20200821185239.26133-1-conmanx360@gmail.com>
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
index 57cb63ea88e6..5aad9d8ee5e4 100644
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

