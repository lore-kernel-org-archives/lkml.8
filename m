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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820C0C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 627DC20748
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHMz4Ht5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgHUSzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgHUSx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:53:58 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A710EC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:53:58 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g26so2285433qka.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dRoRCggi8EdohCRwOMamTs7F9Ex68uNFaZTz9zGb0Zk=;
        b=bHMz4Ht5vwX+q8ADoAC35a2xJJdiDVCnVPj/wyg2XKkhfeQcjZjCesbaCZr7UJRizQ
         V/y7W7d7lssHUAcpf3GpeVnAftjyH2Cwmy3WUd/lfBz6GTUX3U6Uv+AUfcLsCdlsYW6x
         kLhzg1wDyNWEEkwf/L6OBzxM7zrNQbWEvGROZQo0VltKceupu478Qixm5qOZsWJDC2LI
         QJpDbGSfWTMO55Xtp1TuUJ/VlNC2taw5uqP7O20c0bYy18x4bH733NoJ7rYB0uPfauHF
         OTk1OBiJEsjabiJn5vjMmzWkuIHb88155pW+xp+M+DA6eYdX8iTXGeye5SEV+TlD9MQp
         1ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dRoRCggi8EdohCRwOMamTs7F9Ex68uNFaZTz9zGb0Zk=;
        b=LtMlFtoweN3E1sApP45u1G8d/TmsbnqeJmnES5h6UEtonru70pxcUhIlKBYVoQxe5j
         HJrIFUF6ukGbxn2QrpgI0jHa3+XOX1ohYSByH/mdA4EIlvUX9m/YE2z2JrU/5a4jBOmS
         9nLCIw85BcWmo9QFL9XTNTx7OmgZJiCQGdIiKHx/mklrfMhdsN/YDGvACKJQB+6VCJ4L
         i1r+M0KLdkQGffxBng4StN/8vD4Td++7ytZ9Jk0tfb7AW01l6pPJ8cW2OJTQTZj1PY+o
         j3ebVUR0SxlQCi9HZ5kkAhOMNpNPR4+tuYIKT5c/SDdTuj2YnoSbS4TtLK3AfxJoGXlR
         8vQg==
X-Gm-Message-State: AOAM533AxaLjj/i2WrL7fe2+0miBj01doBKAhECh3z49aMYjfETFg6km
        OoCTpkTV9ZoRqlAXMpLjmQs=
X-Google-Smtp-Source: ABdhPJyy1Yysmy6zE+dyTA641LNOUFu78UKKJ8Evz1PzwzSm4I5hRZxkO4dY76b1gWaI5Mv2d/nMWQ==
X-Received: by 2002:a37:a4ce:: with SMTP id n197mr4011097qke.77.1598036037979;
        Fri, 21 Aug 2020 11:53:57 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id o72sm2468426qka.113.2020.08.21.11.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:53:57 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/20] ALSA: hda/ca0132 - Fix Recon3D Center/LFE output.
Date:   Fri, 21 Aug 2020 14:52:26 -0400
Message-Id: <20200821185239.26133-10-conmanx360@gmail.com>
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

Properly set the GPIO pin to un-mute the Center/LFE channel on the
Recon3D.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index ac9dcaf69a2e..9c61a10114aa 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7819,6 +7819,12 @@ static void r3d_setup_defaults(struct hda_codec *codec)
 	if (ca0132_quirk(spec) == QUIRK_R3DI)
 		r3di_gpio_dsp_status_set(codec, R3DI_DSP_DOWNLOADED);
 
+	/* Disable mute on Center/LFE. */
+	if (ca0132_quirk(spec) == QUIRK_R3D) {
+		ca0113_mmio_gpio_set(codec, 2, false);
+		ca0113_mmio_gpio_set(codec, 4, true);
+	}
+
 	/* Setup effect defaults */
 	num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT + 1;
 	for (idx = 0; idx < num_fx; idx++) {
-- 
2.20.1

