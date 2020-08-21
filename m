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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BDBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 211B82076E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+m4RFJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgHUSyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726839AbgHUSyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:54:25 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85495C061797
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:54:17 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id v22so1934871qtq.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4j2Ooeu2ISog/lD6w0WCQQfInoe31/wDtwY8WRaL+vA=;
        b=E+m4RFJ5QjMLgUBBbjCVHqOjHdtW7gV5D4XIJMrylgMlbQpr8JfjFy6bxdse0YqabM
         tBC8Jt/qH66/L2shnWcXhgpbk/pl6i6gRf87g6BA/EjIM17qN+uHg708iewH45k5prGH
         Go7ZpC/GpVQuZLtEq2XyFa59AMk8c36MbYG1VzdMqCTb5j2bi9LwZcS5nT4LrzMTOXSZ
         0WyNWH5DpSihpawOmNY8ZUIKEemKAQoVac+Pl75A3QBZR4jGN2F9BTPH3ZIj21C6nlBN
         RC02BsHtAzjtVPe+0c5cbTEkhx6H9xObvmK7GopRqt7sxPvptuXq6cpwD8slOkI1i8CH
         K/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4j2Ooeu2ISog/lD6w0WCQQfInoe31/wDtwY8WRaL+vA=;
        b=fMU0upzmcURVnYf0k8YrcPaigh0jQKfJYm1MVKydeyu88XorVwGtyRkJfEKz7p4TfZ
         MQ9JxlLHMUTqAs5O69K1og4DHkkF2MY/2FY6KpoBny6ZuBr8qbiuJ9FHwatpy1DUBLQh
         q0qAeT4s82gCGFT04nCjnLaR4VAZGCfMvVtN3hiGvjdbwQnUoZkJrNj2liVmMAA8C06l
         tToBbeQDebzrfU2CcxRCrXKae/vZZRZgAEUHDBmWDTFkhUxUkczgEUtSdzUbSpDcffYn
         c5Xn5pZA7RAtZ9dH2ATYro+IR8OUE25OGEejGGfqXq6ZQIUGPJ1xmvqPmyKG8JwGkFXZ
         e8aw==
X-Gm-Message-State: AOAM531w+D8kfUBZg1XMCX4t+3imeQ/bR5qyKZkA+toaYZvaav4s8h3p
        ToNolG8oGtjB5YienPh9Oxc=
X-Google-Smtp-Source: ABdhPJwr6TUAy9j3Vami64pyga/LqLY2P0SXRXQyBHOMFag3xf3VX1zyuPurLP+i660UUSJjECDduQ==
X-Received: by 2002:aed:3b57:: with SMTP id q23mr4031882qte.150.1598036056850;
        Fri, 21 Aug 2020 11:54:16 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id o72sm2468426qka.113.2020.08.21.11.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:54:16 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 19/20] ALSA: hda/ca0132 - Add AE-7 custom controls.
Date:   Fri, 21 Aug 2020 14:52:36 -0400
Message-Id: <20200821185239.26133-20-conmanx360@gmail.com>
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

Add headphone gain and DAC filter controls, which use the same commands
as the AE-5. Also, change input source enumerated control item count to
exclude front microphone.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 933f3b0be63e..9c70d85b21e0 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -5839,6 +5839,13 @@ static int ca0132_alt_input_source_put(struct snd_kcontrol *kcontrol,
 	int sel = ucontrol->value.enumerated.item[0];
 	unsigned int items = IN_SRC_NUM_OF_INPUTS;
 
+	/*
+	 * The AE-7 has no front microphone, so limit items to 2: rear mic and
+	 * line-in.
+	 */
+	if (ca0132_quirk(spec) == QUIRK_AE7)
+		items = 2;
+
 	if (sel >= items)
 		return 0;
 
@@ -7029,20 +7036,25 @@ static int ca0132_build_controls(struct hda_codec *codec)
 		}
 	}
 
-	if (ca0132_quirk(spec) == QUIRK_AE5) {
+	switch (ca0132_quirk(spec)) {
+	case QUIRK_AE5:
+	case QUIRK_AE7:
 		err = ae5_add_headphone_gain_enum(codec);
 		if (err < 0)
 			return err;
 		err = ae5_add_sound_filter_enum(codec);
 		if (err < 0)
 			return err;
-	}
-
-	if (ca0132_quirk(spec) == QUIRK_ZXR) {
+		break;
+	case QUIRK_ZXR:
 		err = zxr_add_headphone_gain_switch(codec);
 		if (err < 0)
 			return err;
+		break;
+	default:
+		break;
 	}
+
 #ifdef ENABLE_TUNING_CONTROLS
 	add_tuning_ctls(codec);
 #endif
-- 
2.20.1

