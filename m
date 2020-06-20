Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58C6C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7883223EB0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="dJqnEphI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgFTQOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 12:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgFTQOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 12:14:37 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2FBC06174E;
        Sat, 20 Jun 2020 09:14:36 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id l27so13592268ejc.1;
        Sat, 20 Jun 2020 09:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5h5wp3ORTZGg5e5YMKB8xdQFo3Gs3K18kYJZ7b2m2TE=;
        b=dJqnEphIZ9aCR3dnamuWUmn7XcxtO80UGRVABq6YRlVHbfHbEQLES6ZGaZbUhUbUXR
         cSCkI3szBJfP7LuvU//wqOt9FGRK/TKnzMjKl5/Svu0J6XfThgHu1XVW0RrND3nrN3QI
         4hpRUScwefTOIALoskYBZt9XSVhM/uwRpmjFDaQLYALq2I5Sjj64KZq9c3HG7XbRmsmY
         RmB5X1XWpUk/HD/gYOMXukfkqx8x5b+3xCALiv0laXLVKmce1kQ06vYvyGV40kKviBqG
         yzP38MaT3Sob4sqJoyOZoPmEhE/BfzvsGM+qf0g+MQale2I1Z7KaQQyzMwZkzMNs5l3E
         p1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5h5wp3ORTZGg5e5YMKB8xdQFo3Gs3K18kYJZ7b2m2TE=;
        b=mTbZCNlrYEF7Bm3CQNyZe6Gzpvr9En1DhOR8+Kc12q8ANmd3UWbORwGANSmBdK70LX
         HYlFCUCRJRk1GPVlBIGWa25xe/frs+MJSJtJtIm3XMfpZ6kAdbGOOqZRTqARTxEKp3mM
         c+7U9MKa+SmLWSEaLZZjLxw+tJ6XjHE2qfODk91C6Q/iD70G8TR86w17CfR9OE8Ox1XK
         hR3SBIV9N851opQ/gaMJYTd6HMd+1MjHUhwFbD1N27HEVER38FnLt3ScMDxu5a1fJkgL
         zAqiDdnzGQXJNYT4yOHcRWGSvYtX+1yW3zuN2pa0nPh4DfBwEYK9BFnnyHQgEMdaHrUA
         MgoA==
X-Gm-Message-State: AOAM532D0oem4fARb/lRFCOZbWQmRdFJ0+V2RjccXyt4w4amxrycbryN
        PXjcUAS3CQvcvBEJw9qUgbc=
X-Google-Smtp-Source: ABdhPJz6vp1hbLrRNQlUxG58MU8/EMo2gCfh7fH9Nj4MsFkWxILUFGJzWYl3rl3ptvKLdtrRaFlN4g==
X-Received: by 2002:a17:906:b207:: with SMTP id p7mr8271872ejz.23.1592669675716;
        Sat, 20 Jun 2020 09:14:35 -0700 (PDT)
Received: from localhost.localdomain (p200300f1371df700428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:371d:f700:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id v5sm7511031ejx.123.2020.06.20.09.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 09:14:35 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     jbrunet@baylibre.com, linux-amlogic@lists.infradead.org
Cc:     narmstrong@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] clk: meson: meson8b: Drop CLK_IS_CRITICAL from fclk_div2
Date:   Sat, 20 Jun 2020 18:14:22 +0200
Message-Id: <20200620161422.24114-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop CLK_IS_CRITICAL from fclk_div2. This was added because we didn't
know the relation between this clock and RGMII Ethernet. It turns out
that fclk_div2 is used as "timing adjustment clock" to generate the RX
delay on the MAC side - which was enabled by u-boot on Odriod-C1. When
using the RX delay on the PHY side or not using a RX delay at all then
this clock can be disabled.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/meson/meson8b.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index edc09d050ecf..3d826711c820 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -293,13 +293,6 @@ static struct clk_regmap meson8b_fclk_div2 = {
 			&meson8b_fclk_div2_div.hw
 		},
 		.num_parents = 1,
-		/*
-		 * FIXME: Ethernet with a RGMII PHYs is not working if
-		 * fclk_div2 is disabled. it is currently unclear why this
-		 * is. keep it enabled until the Ethernet driver knows how
-		 * to manage this clock.
-		 */
-		.flags = CLK_IS_CRITICAL,
 	},
 };
 
-- 
2.27.0

