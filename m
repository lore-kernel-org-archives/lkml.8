Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13449C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6695206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="abN68/5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgEVLeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 07:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbgEVLeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 07:34:01 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE28EC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 04:34:00 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z4so8349603wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 04:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OajhC/Jlp+i5qsov4pnkcjK6U5hx+P44py8BzGS7Qqs=;
        b=abN68/5Nj5GdX9fC++rV7XC3ur2E20eyulOefbRkWbnKrAUtlysPhPPMLqTKRQD9os
         nwJ956KW0FJ7BVAV5e7aAeII3u3gli7euG9VcbTIctPPrbk9LsU4vcbvEs88rKkt48kl
         y/KqZ/VHG2Gieg/qFtseQPo5h2g1Ol+1FPSBnWmm6d83o5SYfww7iYMyja+MgRMJ7LCp
         Now19vKKy/Kjo8gurwddkhNJrrnTcHHomJ/EPjVZO3CB+DUdfyG6zYQb6kExTuuXsmCS
         NxvKu5WKUbO96+q64APDEZUl2EQJKf26aRt5a/w0xU56mmAXukV7DyBWJq4yreaP/fh1
         qYSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OajhC/Jlp+i5qsov4pnkcjK6U5hx+P44py8BzGS7Qqs=;
        b=sDAiGzPcDl39m01CGWd9prS8BF8Ye5VZKL4tiMUFUnKqsvlSRTKvtlrjm7N6pMeA1J
         T05ZgKf8MIZnMkqyBtS+f8sxS3P2JbPcyOi3FX+3HbSXi3TfEFSE6wWOM3vlAqm4eCvG
         7pyBtNOo0WXY02jY43hlTo697uYrC+ZBKZKtg22Crwqc8UjWqO8D65+6uLQD0TuYLd4n
         KV9zNxA5VXcT24PTHYhJDqYEkd2xu1cY0x+TN2sHjsNgSqDJUXS2Ga7DJM+gxSVOHO/0
         Z7Eb123B5EZEhl6d0qw/zfXdaFD3KCJS6fZ72R1BQJdCN7ETuoM7hsUm1FPjUtT2BkEg
         wgzQ==
X-Gm-Message-State: AOAM531ux/Y4Volr7ZOCPyCR/Mw7QSpfgoIy2AU5g761sE2Yp3mXJZiN
        OyNlpp67EPTAqvYRh92K4VZcA3jEoYA=
X-Google-Smtp-Source: ABdhPJwfo7U/siJSifClNKcPlD6DhwK0aOP4wVhWFb5ziGMQ5SJYW3K4H+LHrChTPCeDT5exThyLUQ==
X-Received: by 2002:a7b:c95a:: with SMTP id i26mr13109176wml.117.1590147237437;
        Fri, 22 May 2020 04:33:57 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id y8sm628420wmc.37.2020.05.22.04.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 04:33:56 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     srini@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] nvmem: qfprom: remove incorrect write support
Date:   Fri, 22 May 2020 12:33:41 +0100
Message-Id: <20200522113341.7728-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qfprom has different address spaces for read and write. Reads are
always done from corrected address space, where as writes are done
on raw address space.
Writing to corrected address space is invalid and ignored, so it
does not make sense to have this support in the driver which only
supports corrected address space regions at the moment.

Fixes: 4ab11996b489 ("nvmem: qfprom: Add Qualcomm QFPROM support.")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/qfprom.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index d057f1bfb2e9..8a91717600be 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -27,25 +27,11 @@ static int qfprom_reg_read(void *context,
 	return 0;
 }
 
-static int qfprom_reg_write(void *context,
-			 unsigned int reg, void *_val, size_t bytes)
-{
-	struct qfprom_priv *priv = context;
-	u8 *val = _val;
-	int i = 0, words = bytes;
-
-	while (words--)
-		writeb(*val++, priv->base + reg + i++);
-
-	return 0;
-}
-
 static struct nvmem_config econfig = {
 	.name = "qfprom",
 	.stride = 1,
 	.word_size = 1,
 	.reg_read = qfprom_reg_read,
-	.reg_write = qfprom_reg_write,
 };
 
 static int qfprom_probe(struct platform_device *pdev)
-- 
2.21.0

