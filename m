Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 818CCC38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CDF721974
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q5HNev90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgDROkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726240AbgDROjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:39:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F237C061A41;
        Sat, 18 Apr 2020 07:39:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a81so6013747wmf.5;
        Sat, 18 Apr 2020 07:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0RLyOmcQjC6vn1XEI3ccjJ++FkYMXRfGQ9jNbYoBA2Y=;
        b=q5HNev90MzXTL/ywnewZwrnzuyIqxvWF/Kr5tUh24SzGbZFJmIRryOT5Cne5AqSmRv
         jdt5+JW2IUSB+CLsoguUYD27kcuJ7qzXbg4BFujwC79yB6hpHcW/nHeJez/eqLWKeGO+
         Ufn0Fz+U8dKq6Q6QJ0PFYKEJFK3dU26R30ikE296gF2mi2pO1sSLRw9c32lll9aa929C
         tb5Bn9Tv3SghyHF7ArFMxWm0OmVKUizia4vv+e3iRk7n0Li55z/HYKxbK1tDQ6NvEZRI
         JRFKzjVL61ilvfzUDvWmCtbaFM5de1FG0eShlLhI4TMw00HfqQrTY3ftWVGCILa3QXLQ
         4mqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0RLyOmcQjC6vn1XEI3ccjJ++FkYMXRfGQ9jNbYoBA2Y=;
        b=D6w0Lx0wncM0miwJSg47ujgnlZPOgsDIBdFGw+nc2Tf65h4Za/jU1brFy0cUljo+tI
         gehH4eXx7KNrLmpTK0xgwMfwJnp/jI3LQqWgXukv2IQHOaOSbF34XnKqdWlylXiz3wzE
         ypptdb/dNyuG01tE0vamek2+rqgcB9IhtBnkn1t52lNnFj5FPqUjLrlw7TfZyLJNzGSV
         EXWKQ+w0weNdwzhhEXeMcpvw3GEvUU2TiR2oVl64Lb/DT1IuTvWCkieW232fexI6MEN3
         GyaAFeLikBYL2xnV4osZ4/uIVz8JVqD1QJWrntAQEfZiIgIpMY+j4enX4Q6NEQjmxZZx
         1K2w==
X-Gm-Message-State: AGi0PualyO0PUsKbo767y209RNyr9vKbG4wFgPSCUDyz/gbAKJzkRYWb
        +/lGaKqvc/6O1JNXnoXL/bM=
X-Google-Smtp-Source: APiQypLxyXDor7+tKSZgFN2C/9biQv72swhCvNXp4GtJiTquiN8BtbiZEPJAKGuJ5Sp1vGD1nVcH8A==
X-Received: by 2002:a1c:8084:: with SMTP id b126mr8178036wmd.135.1587220769442;
        Sat, 18 Apr 2020 07:39:29 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:4e7:1fdd:b7c2:b3ab])
        by smtp.gmail.com with ESMTPSA id s9sm25375322wrg.27.2020.04.18.07.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 07:39:28 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Marcus Cooper <codekipper@gmail.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH 2/7] dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
Date:   Sat, 18 Apr 2020 16:39:18 +0200
Message-Id: <20200418143923.19608-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418143923.19608-1-peron.clem@gmail.com>
References: <20200418143923.19608-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

H6 I2S is very similar to H3, except that it supports up to 16 channels
and thus few registers have fields on different position.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Marcus Cooper <codekipper@gmail.com>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 .../devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml      | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
index 112ae00d63c1..606ad2d884a8 100644
--- a/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/allwinner,sun4i-a10-i2s.yaml
@@ -24,6 +24,7 @@ properties:
       - items:
           - const: allwinner,sun50i-a64-i2s
           - const: allwinner,sun8i-h3-i2s
+      - const: allwinner,sun50i-h6-i2s
 
   reg:
     maxItems: 1
@@ -59,6 +60,7 @@ allOf:
               - allwinner,sun8i-a83t-i2s
               - allwinner,sun8i-h3-i2s
               - allwinner,sun50i-a64-codec-i2s
+              - allwinner,sun50i-h6-i2s
 
     then:
       required:
-- 
2.20.1

