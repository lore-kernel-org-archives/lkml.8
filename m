Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9360C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 21:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F55820789
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 21:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="auZktx6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgFMVli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 17:41:38 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:40570 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgFMVlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 17:41:36 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 49krdW4074z9vZ1k
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 21:41:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CT2m4FgzfgOX for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 16:41:35 -0500 (CDT)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 49krdW1xCZz9vZ1S
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 16:41:35 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 49krdW1xCZz9vZ1S
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 49krdW1xCZz9vZ1S
Received: by mail-io1-f72.google.com with SMTP id b11so8624180ioh.22
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 14:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LSFpRsDH7hPv0sXcI0eBKridM6HBdGl5vIGKq0rJzoY=;
        b=auZktx6ehAhBajQlNLlI3wm6+d/hAPq8yaPTIV0vlYaeRrgaW3hoVKPn9qzjsia14p
         PiNxeKtm8fOFcqmrbG++0+2KZ2Jfx9ybuCk8eyx1je4TBejzWJzhBwHirnfDeOZNESDe
         b6qaIEBwyW498ZP7ZKeSkzzbpNwlpEXxglPubM78kJo/euKcITeUPzisctzP3RPMwr87
         7UoQ6m8bnLiqQBIElWMX1q7TpOHphL8f38WMAFGB2PmvGYRT1i5wA4mFRvwLyLMlR4lg
         ZbFZc9kcFMeb0XJEv3c0fbE9WsxIcH9/sgZKUa9+qBQwJV/UP28bN7oFf/506QB9gYTZ
         NZNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LSFpRsDH7hPv0sXcI0eBKridM6HBdGl5vIGKq0rJzoY=;
        b=JjZ65q/6xp+hkNAigQcd8Ehtve4hgUk44LzL5CagANc98p74E7JM6dayV0XDgVLoNm
         2DPJU1uREXSjaMkt95JHmDSdn/vou7DUOUTpuWmH4RIhCw0EDMDiP6PR0xbdXMxUo3Sw
         wouUX6jvc7xvuVsLYeZ1IQoU4T2OXnrwOAdAb00o86NpiIGNTGj3y4N8A2Hz8dj7A+8f
         ic1myQTZ9UeT39HFa+ZEuXfwvCztdeUX0FqCBlpPOejCWaGIwDtckXmkDF+8/+lYKqDJ
         urYTnLETv/SyGHNR6I42O1V0Lfd8pZbrGkEM91KAP14qDKeVK0HWdkHSaUPp/+M4Q3p2
         Rm0A==
X-Gm-Message-State: AOAM532wLM16nZiUBJZ4IKXl//5/rOxvRfsVudH3RLMcCjM3OBMpqDfR
        5fV22xam0/O1zvPuaPwleALIHCxYZtphJU14J9nGcYUSvatCY8Bdbi2Z3oJXHuZy0DDDMgIqvtL
        ExcsBh8zS0fE+JSHzSonW1O9fA3C2
X-Received: by 2002:a92:c9ce:: with SMTP id k14mr19250708ilq.250.1592084494710;
        Sat, 13 Jun 2020 14:41:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyb26JtPoL+OYiwijo1f/aBaj8/q93A9vM3woScZqAS1tFwQgWOSDCRXrCE9R7tquWbd2eGgg==
X-Received: by 2002:a92:c9ce:: with SMTP id k14mr19250688ilq.250.1592084494366;
        Sat, 13 Jun 2020 14:41:34 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
        by smtp.gmail.com with ESMTPSA id d5sm5174386ioe.20.2020.06.13.14.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 14:41:33 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        linux-samsung-soc@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] char: hw_random: Fix a reference count leak.
Date:   Sat, 13 Jun 2020 16:41:28 -0500
Message-Id: <20200613214128.32665-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

Calling pm_runtime_get_sync increments the counter even in case of
failure, causing incorrect ref count if pm_runtime_put_sync is not
called in error handling paths. Thus replace the jump target
"err_pm_get" by "err_clock".

Fixes: 6cd225cc5d8a ("hwrng: exynos - add Samsung Exynos True RNG driver")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/char/hw_random/exynos-trng.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/exynos-trng.c b/drivers/char/hw_random/exynos-trng.c
index 8e1fe3f8dd2d..ffa7e0f061f0 100644
--- a/drivers/char/hw_random/exynos-trng.c
+++ b/drivers/char/hw_random/exynos-trng.c
@@ -135,7 +135,7 @@ static int exynos_trng_probe(struct platform_device *pdev)
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "Could not get runtime PM.\n");
-		goto err_pm_get;
+		goto err_clock;
 	}
 
 	trng->clk = devm_clk_get(&pdev->dev, "secss");
@@ -166,8 +166,6 @@ static int exynos_trng_probe(struct platform_device *pdev)
 
 err_clock:
 	pm_runtime_put_sync(&pdev->dev);
-
-err_pm_get:
 	pm_runtime_disable(&pdev->dev);
 
 	return ret;
-- 
2.17.1

