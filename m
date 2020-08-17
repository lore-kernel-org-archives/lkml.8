Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53407C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 04:33:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27D0D206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 04:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grILEzy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgHQEc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 00:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgHQEc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 00:32:57 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D477CC061388
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 21:32:57 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a79so7603778pfa.8
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 21:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3887PACzm2rTPUGN/6IdQET6Bnh6NyEKe6nTCAYCsS8=;
        b=grILEzy0NEZTK57HI7cdMjvE7Vnh5C5rJNNMHTmrkGFDt1BKMELCmk11OlAPw88Pw2
         8Sav8ApvwvftrCA97od41UgkjZaxiZs90oMj9uQbmW9iTxAqqOnrqQYQln6U3VCOsg6k
         DmmeJWK37wfgGCfOQG8w1Vz55hzVC0WvDyuCDLuJCayayM1Ztb0UVONC+2YEO/Sr5ZGi
         dLX71LZXX+tEPm4snRF/10JR+iiXVHtKRsKKlQDMdHWn0M+Od/vzhjfoPNhFZQCtzGan
         wKQlMBrda6gPXk6AYB8pHhkKTFO+rLwq5Ov0ntEtRROmZVYWyUPO2fxOZ+fd1s6C3I4d
         BAYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3887PACzm2rTPUGN/6IdQET6Bnh6NyEKe6nTCAYCsS8=;
        b=JC1HzizvoIbQEYFWurH9VZ+rD9oSiFvLRFyxJ5knIf4YJUJ1F4wZEleS/tHJDoP8at
         XRhWPti0enKsAIjuC6yZGBNSoFhgXerDyGfzjtlEQgAwxiZPqHnyJ2JVdDfhZwsh/CVo
         lKFIDNUEsSLNlNROoKO/JAoyYHnpUDyUaHoh/VVuq4UrVvr0k2VczLNGMlJiu0Z1tUqv
         Ii8Os7KpQNabILMC5SVMhUbkaLbuQgH6LcjggrHWsYvWjQQJXS+UkuYzJUSRpSu9Yxd0
         CefUOyjIY0VWTUF5gCi3UxC7ld1mG2hypPYVQYSuaUrX/hz08872/nojGU55ZvsPtIxg
         G1tg==
X-Gm-Message-State: AOAM532lhVlFNN+5PGKPvZxOofTztkNr4R4KVLC9kObp5xkk58CONsrK
        xziYyMwvj65bp46C37C04eM=
X-Google-Smtp-Source: ABdhPJyWrZyT+ww5Lg1ZSgjFD5wroh1KR5mI/vhgxnLklBChwjOANiN9ayu0EFGxcZShM7rtRjE+5Q==
X-Received: by 2002:a62:6847:: with SMTP id d68mr10271667pfc.110.1597638777437;
        Sun, 16 Aug 2020 21:32:57 -0700 (PDT)
Received: from localhost.localdomain (68-123-15-75.lightspeed.sntcca.sbcglobal.net. [68.123.15.75])
        by smtp.googlemail.com with ESMTPSA id q82sm18714443pfc.139.2020.08.16.21.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 21:32:56 -0700 (PDT)
From:   Mike Pozulp <pozulp.kernel@gmail.com>
Cc:     Mike Pozulp <pozulp.kernel@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>,
        Jian-Hong Pan <jian-hong@endlessm.com>,
        Hui Wang <hui.wang@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thomas Hebb <tommyhebb@gmail.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Chris Chiu <chiu@endlessm.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: hda/realtek: Add model alc298-samsung-headphone
Date:   Sun, 16 Aug 2020 21:32:17 -0700
Message-Id: <20200817043219.458889-1-pozulp.kernel@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The very quiet and distorted headphone output bug that afflicted my
Samsung Notebook 9 is appearing in many other Samsung laptops. Expose
the quirk which fixed my laptop as a model so other users can try it.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=207423
Signed-off-by: Mike Pozulp <pozulp.kernel@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 29f5878f0c50..722d01a06422 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -7867,6 +7867,7 @@ static const struct hda_model_fixup alc269_fixup_models[] = {
 	{.id = ALC299_FIXUP_PREDATOR_SPK, .name = "predator-spk"},
 	{.id = ALC298_FIXUP_HUAWEI_MBX_STEREO, .name = "huawei-mbx-stereo"},
 	{.id = ALC256_FIXUP_MEDION_HEADSET_NO_PRESENCE, .name = "alc256-medion-headset"},
+	{.id = ALC298_FIXUP_SAMSUNG_HEADPHONE_VERY_QUIET, .name = "alc298-samsung-headphone"},
 	{}
 };
 #define ALC225_STANDARD_PINS \
-- 
2.28.0

