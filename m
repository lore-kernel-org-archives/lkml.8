Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848D4C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DF4620829
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="I5ElECNe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgIJVkz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727787AbgIJNF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:05:56 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DC0C0617A0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:05:05 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a9so5746672wmm.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 06:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=04PutPpSnQgJelQ+Ix7sCACVphrDCgo/mARCI+1M3iQ=;
        b=I5ElECNegzKV59s6JDgamlwfsKqKmsqgAZWZhuJtIF/NepdJ4yQ1J0gVJPS/gmCH2q
         pxNXUc00OBUgR9YQpa8abe/n9kcVZfDBoAtgfQ9tjH2lUERnab+Tg8553FcL5eV7i+hP
         2WoOyCWUCCctzA+uOQ6up/fQ+LG6zx7c3KMvc5l7NhovRnFapZuiWEi0uxzmaFVLoht3
         B4Fivt+et52dEemD+x8t+kw7G9/ga6YdQwmHgwSQzNUFpN13UTMRBZb6rxNXf8kJvYIU
         7Kg4SRs8FC2wDSiLJxRDt6uFoiNQfWxED4oxlfjHe0A6GvGLpnfGFprIp/jbxmz9Yd+j
         o3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=04PutPpSnQgJelQ+Ix7sCACVphrDCgo/mARCI+1M3iQ=;
        b=WAntQ17v4o9jerKUcaUybCHwjcW6T9ejZz5A7TV/Ut6L/YvA+gcwhIeRdfYZ4MOBf/
         hpm7mlC5tvN+viqe5EsOCmTMhBrZAz7FkXJjuUwG6p7AnA5uP0M+G1H6/ffyABsSgEsn
         n8ge4PR9CmjQdZezfMGrdMEbVGoxdi/PvTZRELcsb9RI8AQk1Yrjm0n9KFVJDSnHHJgz
         2q8/Acj7N3+njFN3lZKaUJ/uk4ac0C6r7K/dnQLbFai/ywq9ZRwH+4krRs/61Iu+F5V4
         myPKvmS967Xv9x/oMo6BWwW/cX9lBh4szzvKxSRf/Vd02BZCm2oDA4AxCJoZDTaIsIEF
         ewNQ==
X-Gm-Message-State: AOAM533LiPJ8N43/reYDlggDzIaj9wrYV1XnvN3Z53HPO3xR66DKwIQx
        uYb6qmsmlJpowseTlWIkNjpI+A==
X-Google-Smtp-Source: ABdhPJyDCGWUuOs1NMZFyeRKTEUtz+d0fMCNarMxxpLq2mXotOnXRILoD+iX9hJti9NpSehQlrjQHw==
X-Received: by 2002:a1c:9c4b:: with SMTP id f72mr8403290wme.188.1599743104359;
        Thu, 10 Sep 2020 06:05:04 -0700 (PDT)
Received: from debian-brgl.home (lfbn-nic-1-68-20.w2-15.abo.wanadoo.fr. [2.15.159.20])
        by smtp.gmail.com with ESMTPSA id p16sm9321988wro.71.2020.09.10.06.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 06:05:03 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 06/11] rtc: rx8010: drop unnecessary initialization
Date:   Thu, 10 Sep 2020 15:04:41 +0200
Message-Id: <20200910130446.5689-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200910130446.5689-1-brgl@bgdev.pl>
References: <20200910130446.5689-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The 'err' local variable in rx8010_init_client() doesn't need to be
initialized.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/rtc/rtc-rx8010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rx8010.c b/drivers/rtc/rtc-rx8010.c
index b065973b8a14..3b8a95330a0a 100644
--- a/drivers/rtc/rtc-rx8010.c
+++ b/drivers/rtc/rtc-rx8010.c
@@ -194,7 +194,7 @@ static int rx8010_init_client(struct i2c_client *client)
 {
 	struct rx8010_data *rx8010 = i2c_get_clientdata(client);
 	u8 ctrl[2];
-	int need_clear = 0, err = 0;
+	int need_clear = 0, err;
 
 	/* Initialize reserved registers as specified in datasheet */
 	err = i2c_smbus_write_byte_data(client, RX8010_RESV17, 0xD8);
-- 
2.26.1

