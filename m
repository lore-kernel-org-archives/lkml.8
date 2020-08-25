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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CC0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03EDD20738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 20:12:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+0/zxem"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgHYUMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 16:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgHYULZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:11:25 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FDCC061757
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:25 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g26so12323557qka.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8ChaZ6nTOfS1bT+oUOP3MAm7zV3qo3G8NzOJnN+5Pbk=;
        b=D+0/zxemxo3Q1nuJ9+BA/yGCJgdp18sOmApPYRWiWAWNcWYrG1/TpkoNvchhrUEeJc
         UU2KYmnVK+tWybo7WNRZjn/pQSLgHOe9Of0XcCfe8nxWK8hWcTFBoB7dnbccu11g6wi3
         WYNBygX7RslYzlCqr4Y1gFxg3ezzArQaaF3pFQFAbuoSoCXa5aJQA+VE9F3Y0+JOoXSm
         uPh9fYKcHTFikvU3Wf1J2kluuL9noyMBHTDTa/putZAWT4OERdkrt8raM286+d+5aO/b
         i4QbuT2W9ehv2uWtFH9TjaBzh/t+G+Vk1Ko6YPO2kflHevfAJl4TNmwcIszCuWyHCaod
         TO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8ChaZ6nTOfS1bT+oUOP3MAm7zV3qo3G8NzOJnN+5Pbk=;
        b=Ku4fi4oLjLSL8uddBJYAvgGtx3xM/FP/ZR7jHLUaKo05L9tnmiRAGfYDxXPDbOTMl4
         I+Qjdg0BCxJ72rvqdvxk9+6sa1UjYhm81W0SHfofzImpXyrf15ze83h9MWGeZsD8XUIW
         kVTZqruNk2J8R8LQwOC3cXquLsrjStjyYWwP7aSbMTpPv/S29yoqJ9+jGzNNJymq0bao
         HipH4Hq5DeA/0tv6dba0EpxzM8SxXZPry43vGT9fc+DogE3xpY7/owHSrUeRZRSH1eBH
         q6MwBOaJc1ABi+WRSbO+kKI/q0NBBXp8EBoZz8uIzO20olEOCD5Njw1ucFxgMNVsAKbh
         M+VQ==
X-Gm-Message-State: AOAM531gj8T8WeeGEhbFas/KSPyA42PLi0MoPbxwmQgWCUCMYikeXS+7
        hL7vxKPG3zW3Q+qQ80qk70o=
X-Google-Smtp-Source: ABdhPJyjJnhptKpMtj2ytC2kmkr1cC8F9H6XkYVFQrC5Z0kC6fQtJnaHoBxx0QpjP3ZCxJcE4KUZBw==
X-Received: by 2002:a37:6516:: with SMTP id z22mr11135550qkb.164.1598386284822;
        Tue, 25 Aug 2020 13:11:24 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id n23sm12453459qkk.105.2020.08.25.13.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 13:11:24 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/20] ALSA: hda/ca0132 - Add ca0132_mmio_init data for SoundBlaster AE-7.
Date:   Tue, 25 Aug 2020 16:10:32 -0400
Message-Id: <20200825201040.30339-14-conmanx360@gmail.com>
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

Modify the AE-5 ca0132_mmio_init function to add AE-7 specific writes.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index bd5d4f0bd6f5..10aaa4806946 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -8748,8 +8748,26 @@ static void ca0132_mmio_init_ae5(struct hda_codec *codec)
 	data = ca0113_mmio_init_data_ae5;
 	count = ARRAY_SIZE(ca0113_mmio_init_data_ae5);
 
-	for (i = 0; i < count; i++)
+	if (ca0132_quirk(spec) == QUIRK_AE7) {
+		writel(0x00000680, spec->mem_base + 0x1c);
+		writel(0x00880680, spec->mem_base + 0x1c);
+	}
+
+	for (i = 0; i < count; i++) {
+		/*
+		 * AE-7 shares all writes with the AE-5, except that it writes
+		 * a different value to 0x20c.
+		 */
+		if (i == 21 && ca0132_quirk(spec) == QUIRK_AE7) {
+			writel(0x00800001, spec->mem_base + addr[i]);
+			continue;
+		}
+
 		writel(data[i], spec->mem_base + addr[i]);
+	}
+
+	if (ca0132_quirk(spec) == QUIRK_AE5)
+		writel(0x00880680, spec->mem_base + 0x1c);
 }
 
 static void ca0132_mmio_init(struct hda_codec *codec)
-- 
2.20.1

