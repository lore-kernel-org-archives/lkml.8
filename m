Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C5EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 07:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBAF9206F4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 07:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WD5wrr46"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgGKHIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 03:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgGKHIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 03:08:46 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB2CC08C5DD
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 00:08:46 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id a6so6974112ilq.13
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jul 2020 00:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=3zaiLFbNh7L3+bFoK+wl7i5xM2TsBDsZ5cXl+f5vIV8=;
        b=WD5wrr46I1z4QIoObyt1ro0aEC7r5zKOQHU9c903/TxQOkyxxlhlIxviz5lYwf/5JK
         EFfesDnDXaffkFcOthkfV0fD0f2MpVCfKKZUntQs9jPfPv6opWoZVayzQsYcIQ0F9vkV
         LUpCEtRs5XapkrGV0fLRT4fgqSxGkN3lL2++5iRAyFuZ9DPmDn5ShbHYwahMM4m+KKl+
         Zs9BrTHUGG3fbf7Bxahk/liKjy8+wm3hCp07fNoAXC4wksLX15poHHxAVg2opHZ9bsRB
         6fJMLzSbAbtJuH/350dCONdeSeeqg+WgP0hJKK+jtax0Bxz+4gom36xYxmMLQVHhb4l7
         0fyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3zaiLFbNh7L3+bFoK+wl7i5xM2TsBDsZ5cXl+f5vIV8=;
        b=mOO+c52pHYgKobfIGQ8+fHyk7ezjjdlyhZzyDA0tRW2f7UiTCTqhp2hf2N64TGFzQ/
         DtW981+ihNPB3BlSYjSgDpsEvBlgFFsD/xPeC4z4clpaD0xQM41mZXodZI1fZGIXN5wl
         N1pSHyXLGntqYjPElBF9YyW42sY+QRfAkO6kP9i7Rg4swZyXC95ARIX2KfZBhNwdWMtj
         xrTZHBv4IzNr7HNWlWeFDxVw3nsYRHyEgZhYGwcRKahW8PAw0+Z4oh8Qnwtwsj5amqi0
         gv7VhHbze68bg96j2lYNVRlILercBtKH6HRAfiHsKzTkIDsVLtGXDzjk6rVwhm9P8MN6
         BsPA==
X-Gm-Message-State: AOAM532eMo2meeJwmetgRdbfCUzq5TgUjOL+ncDvry+Td/VcVTiK7cya
        w1poLDyQtCtmQt3gVCcBVqg=
X-Google-Smtp-Source: ABdhPJw9FantHw3DWTcb4xX67aNuzRPAdFkv7mM8PWkXa8Wel+7ugRwbStJKPaNhZueRIwsrpkQ0ow==
X-Received: by 2002:a92:41d0:: with SMTP id o199mr22608975ila.205.1594451324621;
        Sat, 11 Jul 2020 00:08:44 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [160.94.145.20])
        by smtp.googlemail.com with ESMTPSA id u6sm4469475ilg.32.2020.07.11.00.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 00:08:44 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu
Subject: [PATCH] ALSA: trident: Fix a memory leak in snd_trident_create
Date:   Sat, 11 Jul 2020 02:08:30 -0500
Message-Id: <20200711070835.4855-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the implementation of snd_trident_create(), the allocated trident is
leaked if snd_trident_mixer() fails. Release via snd_trident_free().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 sound/pci/trident/trident_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index 6e50376163a2..e98c692f6aa9 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -3582,8 +3582,11 @@ int snd_trident_create(struct snd_card *card,
 		return err;
 	}
 
-	if ((err = snd_trident_mixer(trident, pcm_spdif_device)) < 0)
+	err = snd_trident_mixer(trident, pcm_spdif_device);
+	if (err < 0) {
+		snd_trident_free(trident);
 		return err;
+	}
 	
 	/* initialise synth voices */
 	for (i = 0; i < 64; i++) {
-- 
2.17.1

