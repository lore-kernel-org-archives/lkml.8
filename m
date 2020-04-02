Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4355EC18E5B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 162E4206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="d9IdAHDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387857AbgDBJJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 05:09:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54875 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbgDBJJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 05:09:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id c81so2544990wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 02:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=StLW4oQA2WaIFFPJqSGzSymR2wGzT0o0QxMbZtBUVlk=;
        b=d9IdAHDZyEa62Jw04B77sMtjVPdNa9vpnb4vpYZxhWIYq3dd19MZtHfhDJtpigL4Aj
         0lTur6dAWq/vA3A5LzqOa9PCxYDSfcgoOkQ6DWrnhT5CaZYbzaafQ8ZoQbQNGHpl76zV
         XdHZQ8zGRGZ+Z3o3PL6fL2THK4+JKFeqY5SU8bghIVTLvB3g9cmdzfEyq9RRWGaV6dJ2
         VEZfIrAeawGjRpsXFkAB73r0sX5WcZCC+0TEvToep7FMLtZST9mL/X86o8YOYDXZ4W+W
         1f85fZry1d2bPj9tCUGgWKkaHEm4rXwC7YcOD5qTMp3O6lqbC0rkUzV6tlLY+zduzxLD
         rygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=StLW4oQA2WaIFFPJqSGzSymR2wGzT0o0QxMbZtBUVlk=;
        b=mL3NAMgwfMAhqF4AEsFoZI8c1WMDW5hHlwOU70HgLbUjvwrlPu13CeSrbIGpAQQu+F
         eb8Ip69EMtn/Xgz2dGafniTliewWoS35z8I73+su1i5SqeI5yEpEgtsZg1nc4LnXyfJ9
         BeAArFH9Rm4OTAdabshqNYvRNOrMSGyi5NqCsg7RM143fNLr62frcn1hINGhlKQDKKtX
         TTRpYWY8/cKYVKhjCIypjg7ShxeWone8srV0cWVnLpMmwdC2QC1oWarC3TfHNNb27TuV
         o3bwQ0Kz0NH3dSQQ1bcZNJ8GGydyFxD4+QKVjXXQrssQDIfehzdtBmNh0PUkdhjNG3lE
         ZAkQ==
X-Gm-Message-State: AGi0PubhIrBUAIYDmQvyEPmb+yiMjlTcDjClX8jbq/g4yZIY38GJO8A8
        eb/FWe98JyIjIVLrhqELMsm3CA==
X-Google-Smtp-Source: APiQypL8UW6cTm5VP6BFVGzslvteA1w9m7t8nZrQqPskNcZ68K6UnXvkCjIsdFXA8Xk1zJTdxJLHMw==
X-Received: by 2002:a1c:6605:: with SMTP id a5mr2512660wmc.32.1585818539513;
        Thu, 02 Apr 2020 02:08:59 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id h2sm6150372wmb.16.2020.04.02.02.08.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Apr 2020 02:08:58 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     linus.walleij@linaro.org, mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] pinctrl: sunxi: handle probe defferal
Date:   Thu,  2 Apr 2020 09:08:52 +0000
Message-Id: <1585818532-23051-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When checking the logs on my sun8i-a33-olinuxino I saw:
sun8i-a23-r-pinctrl 1f02c00.pinctrl: Reset controller missing
but this driver was working after.
This message is just here because the reset controller was still not probed.
So don't say anything if the return code say to wait.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c
index 8a08c4afc6a8..9e5b61449999 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sun8i-a23-r.c
@@ -103,8 +103,11 @@ static int sun8i_a23_r_pinctrl_probe(struct platform_device *pdev)
 
 	rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
 	if (IS_ERR(rstc)) {
-		dev_err(&pdev->dev, "Reset controller missing\n");
-		return PTR_ERR(rstc);
+		ret = PTR_ERR(rstc);
+		if (ret == -EPROBE_DEFER)
+			return ret;
+		dev_err(&pdev->dev, "Reset controller missing err=%d\n", ret);
+		return ret;
 	}
 
 	ret = reset_control_deassert(rstc);
-- 
2.24.1

