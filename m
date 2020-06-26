Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531D7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:30:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B74207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ULDz9ecq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729216AbgFZOaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbgFZOaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:30:06 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D2EC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 07:30:06 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k6so4334679pll.9
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 07:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ojUpeeyjrikcFiKOvKiJiQjb5quxXpR7oJHG4WF/cxY=;
        b=ULDz9ecqldNqAocWoL/RXbGwTJSEmLFkA9OHKq4D9iAFPJ/t3sFLUb/mcUdmVAS8KD
         l98PKLJ6iVWDvteID3WEIW+BbB736GQWI6DZjgbbhpRSbiCrX5la/5+rwcgE9H2BQqeT
         RfL9OxEYqbgxKIIBii/2fC5JY9uby4g04Lh3AK+mO++s2rPR5429h2tXw44hA9A25tpi
         1gJNELLAsuoftYgW6wGpFiE/JSaKeJdXEdYgJpfIwh6N1U91LInCEHmFOhIMkoncJxz2
         nxd1DrfUpi9H/IkF8qtRwLaeAyE/XFpV4oR9/UexMKRJq8Ct6iOSMGrn07I/iuXbzGcj
         PzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ojUpeeyjrikcFiKOvKiJiQjb5quxXpR7oJHG4WF/cxY=;
        b=IQSMxb4Y+DsXFo5khZYAWcwgszhXFskdWKQgS6ZhgBgGM5wurg4Dx+HiwffTJP5bEa
         5DxpyAczEvw4hg6NR2sFmDFm5395M9/qdca+MTsvIvS0zsQE8J0r1Fnk7uyOh94zaj2J
         X8MzY1hLIseQ8ViCNDvry3c2v979kWrYni9cxpsnNUCoB8SNeyqP65EKCUpNJnuijM7R
         VLxwTah8PNLmnHEeH7ynFMrAVqlgSjkX7YnDDOSkow+wUieaO0WV4r0UYKXdKAqkiptY
         po8bAWsRFVRlh/A2TPI32HRuFfm7Lf1XnPiJHn+bgBLTFZY4rhzrkmeuuz1Qvc/gspTg
         oe3w==
X-Gm-Message-State: AOAM532YsXq9HUb/a4Fs0C3H6X5yaohm/p0pWYR8vWnxS/7G8FEqT6rD
        Byd6RYhWDYXH9bhDQisucLQ=
X-Google-Smtp-Source: ABdhPJx4GDvqinaHYX7jR3VfFb1w0pRsl9xGlffKVZR/J59hCVUN2AGyJrhMexYJjZRaqFxCFU6xCA==
X-Received: by 2002:a17:90b:384c:: with SMTP id nl12mr3920145pjb.108.1593181805569;
        Fri, 26 Jun 2020 07:30:05 -0700 (PDT)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by smtp.gmail.com with ESMTPSA id k92sm11565361pje.30.2020.06.26.07.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 07:30:04 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id F22F9236023A; Fri, 26 Jun 2020 23:29:59 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, krzk@kernel.org, sbkim73@samsung.com,
        s.nawrocki@samsung.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] ASoc:samsung: Fix a typo in Kconfig
Date:   Fri, 26 Jun 2020 23:29:58 +0900
Message-Id: <20200626142958.253614-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.27.0.139.gc9c318d6bf26
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a spelling typo in samsung/Kconfig.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 sound/soc/samsung/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 8bc66279116d..4b5c3481fe62 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -77,7 +77,7 @@ config SND_SOC_SAMSUNG_S3C24XX_UDA134X
 config SND_SOC_SAMSUNG_SIMTEC
 	tristate
 	help
-	  Internal node for common S3C24XX/Simtec suppor
+	  Internal node for common S3C24XX/Simtec support.
 
 config SND_SOC_SAMSUNG_SIMTEC_TLV320AIC23
 	tristate "SoC I2S Audio support for TLV320AIC23 on Simtec boards"
-- 
2.27.0.139.gc9c318d6bf26

