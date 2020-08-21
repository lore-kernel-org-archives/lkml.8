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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F03C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77CE720714
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 18:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkvKiaq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgHUSzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 14:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726830AbgHUSyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 14:54:07 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F49AC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:54:07 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id s23so1928191qtq.12
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qKt7bPUZQnkT6XxuyI/7DeILPZNYGDd8MAMg7+2S4/c=;
        b=fkvKiaq14uwqeFl2aJIPJ5b+7SSEgU1TB8DCu1vYRpFleqw1QoN6DkOBRqNuNPyC22
         CbsaWhw3Z8V96rct34xe2ro7d58LY0ir4tVF5G5UH78JStO9e/17g+k2D1qRSpIhoON0
         sHRca8IHZYCT3cdjyf/T8DToR7RwxrgeVEphQgo76e5hStJjiaOcHa0vtn7NE4SrKV0m
         g7bCbtP2+QnjKAGuqSNwBixzTruehwrcfOfQcl5iM6mKaAqHTQj/mTUcmdTBoX7JhCYJ
         VQX9wOiLHLP54osruzrzV2Spyk7pRTD/WTU0PEze/D2eksoQ5q1n3Ed/pE6MilLcgfeQ
         ciow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qKt7bPUZQnkT6XxuyI/7DeILPZNYGDd8MAMg7+2S4/c=;
        b=YE/mBLXwuvXsbD2I3TJ4z7rV+J3IFFTUEZ1hUrq1sj4SadalMkhZLKv3njEIpwh//6
         9+UxnCM/ZmsOg7vc+ealMaN3B+GQ0zaJg6xyEf30XsXUJ/PSfyk4hSlMl+98plFquM9j
         d66vxTUZJ3N/U37lhDJCVogEkQz8BJZQF4gl93pYXUAbMW9gghkEYH9rPVqxVMqY5AwP
         JtzmmFK487G7hgopUJLtu2KVrEdlLK5P/tZTyQp5o6esgzQ66qigODhpfIJj/i2P9v8V
         vgB9QA8cm9COTEdu2lkpXQGdGGGagzt5BPOqo8DeS1kjqV/6LXbO7Ts9k84YlT9AuKbm
         mckQ==
X-Gm-Message-State: AOAM532YQHgS+UFGZKohXpDMnPh3HQ6Qw7Ep/T/XwQDTb4ce4JCYFqr/
        1RYkDGIp5lwiX/x2xnDC4KM=
X-Google-Smtp-Source: ABdhPJwTOkWX/G9fbyfVm9iYhQhIPaZK9WX8Tg95UwBfH7O2FJaPNCh8McdgwdZdDlhe81LqygJXAw==
X-Received: by 2002:aed:36aa:: with SMTP id f39mr4078516qtb.297.1598036045579;
        Fri, 21 Aug 2020 11:54:05 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id o72sm2468426qka.113.2020.08.21.11.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 11:54:05 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/20] ALSA: hda/ca0132 - Add ca0132_mmio_init data for SoundBlaster AE-7.
Date:   Fri, 21 Aug 2020 14:52:30 -0400
Message-Id: <20200821185239.26133-14-conmanx360@gmail.com>
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

Modify the AE-5 ca0132_mmio_init function to add AE-7 specific writes.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index ffad29ac7290..41838a5587b6 100644
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

