Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E12C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9537D2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UWsgLVFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgFZNFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFZNFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:05:31 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327F1C08C5DB
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:05:31 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id o8so8766743wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 06:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6du7sHpmroejr9lp9ztEYkWIN/fkcg7/2Uksn80/5h0=;
        b=UWsgLVFRaDNyhFO1xT+LBUyTFFSmoKYce1w5HR+oyOoZjlI2VIetRXHVv0ch5mYgXC
         IqCuj/qcmtBNc/qm+riwEb3JXaPnmf3WlzoUZxMse3tMkwOUl2f9F6hAwtFxCgQYlgQu
         /NBi05hfpZyzwTGRd5e3u6roLKEP5pr0sKjGU60X+9CJKWYbTeI6Y9Q6WHxwrUZTf4M6
         PHIZTyaDKpc657YDC4rsn3THlGs6o2cnDeiLFGABbZTmcnQeu+a04Dov95pgGhnvLKor
         ba62ALADZf3j6AMz9l+Xu/vmcMB4Hui9d9pWDj1pw09ld0N6+M+hEN3RpR55JEF+iFnR
         B4zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6du7sHpmroejr9lp9ztEYkWIN/fkcg7/2Uksn80/5h0=;
        b=KZgXFA68eVDWkZpB2JZZUCB2Qtk3nBiSXK97EemB7XXKCnRDNXFh0dR7DE1pilTaSu
         Qo29FzlrTjFYjADAQhcrmiFgGwhvI0BkIBY4hVSV4ag3LiUuSPEXgWi1N4sNMMkdSODz
         hldV/kkKAFTwPdTKocx/kZb+Ys+YMxUENSznTIVKJiCMxNeNW5dCQBYvis3SB/0z4DLe
         86XkC4k3h2FnjSrIk+k52mv29C17Atmin8kZgt/YO1FhpOIqERW41oD31kBmY2lDviyZ
         OW2/EW2Q4pEDnLrdbBn5D8hKGjVAMgosYnJaUiQtVI8qZlSpi/Kw//YncKFc6N1A6Ple
         9SXw==
X-Gm-Message-State: AOAM531inZXAhwOA/t837vT0REzasYHgkLQFEApeMd/ODDMNX17rGftw
        WiJ8xu2HfU4QwGhVwR+d4DGclQ==
X-Google-Smtp-Source: ABdhPJyJ2n62/Y1Rl+W1QOIJetY7OS5+awAyZ6wQTR6lWI70ZzGrBOLFafJyKmyAFcSNekqG1/1E/g==
X-Received: by 2002:a05:600c:2254:: with SMTP id a20mr3238838wmm.115.1593176729872;
        Fri, 26 Jun 2020 06:05:29 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id u20sm16746904wmc.44.2020.06.26.06.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 06:05:29 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Rodolfo Giometti <giometti@linux.it>,
        "Eurotech S.p.A" <info@eurotech.it>
Subject: [PATCH 01/10] misc: c2port: core: Ensure source size does not equal destination size in strncpy()
Date:   Fri, 26 Jun 2020 14:05:16 +0100
Message-Id: <20200626130525.389469-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626130525.389469-1-lee.jones@linaro.org>
References: <20200626130525.389469-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to ensure there's a place for the NULL terminator.

Fixes the following W=1 warning(s):

 In file included from include/linux/bitmap.h:9,
 from include/linux/nodemask.h:95,
 from include/linux/mmzone.h:17,
 from include/linux/gfp.h:6,
 from include/linux/umh.h:4,
 from include/linux/kmod.h:9,
 from include/linux/module.h:16,
 from drivers/misc/c2port/core.c:9:
 In function ‘strncpy’,
 inlined from ‘c2port_device_register’ at drivers/misc/c2port/core.c:926:2:
 include/linux/string.h:297:30: warning: ‘__builtin_strncpy’ specified bound 32 equals destination size [-Wstringop-truncation]
 297 | #define __underlying_strncpy __builtin_strncpy
 | ^
 include/linux/string.h:307:9: note: in expansion of macro ‘__underlying_strncpy’
 307 | return __underlying_strncpy(p, q, size);
 | ^~~~~~~~~~~~~~~~~~~~

Cc: Rodolfo Giometti <giometti@linux.it>
Cc: "Eurotech S.p.A" <info@eurotech.it>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/c2port/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
index 33bba18022892..80d87e8a0bea9 100644
--- a/drivers/misc/c2port/core.c
+++ b/drivers/misc/c2port/core.c
@@ -923,7 +923,7 @@ struct c2port_device *c2port_device_register(char *name,
 	}
 	dev_set_drvdata(c2dev->dev, c2dev);
 
-	strncpy(c2dev->name, name, C2PORT_NAME_LEN);
+	strncpy(c2dev->name, name, C2PORT_NAME_LEN - 1);
 	c2dev->ops = ops;
 	mutex_init(&c2dev->mutex);
 
-- 
2.25.1

