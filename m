Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885CFC55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665962070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 10:41:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pEb5M+j3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgDZKlr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 06:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726182AbgDZKlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 06:41:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678A1C061A0C;
        Sun, 26 Apr 2020 03:41:22 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id d15so15346011wrx.3;
        Sun, 26 Apr 2020 03:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0RLyOmcQjC6vn1XEI3ccjJ++FkYMXRfGQ9jNbYoBA2Y=;
        b=pEb5M+j33W1xdCZzu21ZGMF+y2nvgxguxmT+udwzHEM0LMxryFmKJ67rCuQP00C/u3
         A84XG/yMmH6KqcO1Rod12V7w7z0IX0KrPCjEi64ihqn5kCl8VDGl3eRovoBaJccpVE5e
         STzoypdReKUshsrOPPueZegajrpg9FuuzMGQqpq0X9VAvIq0DTHGeKOZhTb63TN7xuUo
         oTyXrW2bosLUdfpZpicvAYyDeJBQl9eb/dbk85F4wMVmTDnC+6bS8bJZ2HeMo5RApxXR
         fYou2YCU7/OMTscpr01z2q9MJpjb07ew1nDMxYQNMu19nLcROy1f9GGDjt07oVWWxCes
         98Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0RLyOmcQjC6vn1XEI3ccjJ++FkYMXRfGQ9jNbYoBA2Y=;
        b=L8bCWauohkhydUw2dh1ob33tdZ62W/hJM6XSkROCSlAZxLybiatNxBHchYuy1VfJH2
         D4b5oOHaNSWdZI7XSxIQul4ytGJ+vmBki2k86xLno8L01qBDqnKSruFxEP6rBHB+VUY5
         D5+eLr4dablQPlYcgH6lOLLmGj/MWpyQkO1wJ969ox2yf2sscNPZjQkb/gESoxi5kAX/
         gXmR3qdjTG93NpTjRP38CU1VbTGiTKI500Rd8tjLG1e8OeD43LWigQFFECQSJgP/HIAT
         GKKOOXhRHmy815OZOkbGUrWdNteRsoMyBWs672QRZZ262Ve0k+v+D8/lGdheQXXOF0JQ
         u64w==
X-Gm-Message-State: AGi0PuZhyKaZwIlYo+wO8vgmylgOxU12ZL0910GObW4zAhm7Gb1lPOQf
        EDaV+tmsMpPZeWtvLGnAKw0=
X-Google-Smtp-Source: APiQypIhe1kOoZzu4/c9rSC9Ti+Iwj5P6aeWjhvnEk5fJtGoRvCnoPEUiUPZECcqv9GEFT1eQS0ZiQ==
X-Received: by 2002:a5d:6847:: with SMTP id o7mr21795688wrw.83.1587897681018;
        Sun, 26 Apr 2020 03:41:21 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0:59f6:22c5:d1f3:662d])
        by smtp.gmail.com with ESMTPSA id y10sm10491793wma.5.2020.04.26.03.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 03:41:20 -0700 (PDT)
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
Subject: [PATCH v3 2/7] dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
Date:   Sun, 26 Apr 2020 12:41:10 +0200
Message-Id: <20200426104115.22630-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426104115.22630-1-peron.clem@gmail.com>
References: <20200426104115.22630-1-peron.clem@gmail.com>
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

