Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC18C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D40B2084C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWxCfElw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728264AbgGDLkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 07:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgGDLjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 07:39:11 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFE1C08C5DE;
        Sat,  4 Jul 2020 04:39:10 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l17so34362758wmj.0;
        Sat, 04 Jul 2020 04:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZsMT0CrEUbDwl+d5khTOYaGtUlOWn7Yi+9GLp9dBrZs=;
        b=CWxCfElwflkj5WONPGRdnQaYiBwZy6w16x4tiGVF4F3fu4Oi6amp7+80lpZNuKfszE
         M9MKKSr3k9MyE9glWYaEaoGFSsdiXu4UGAxQl+DpjJqIX/GiOWzcGx7GSItnaHCPa0B5
         hqadLjAJ7JrYoVlmTSr4ARyeRO+khyjdL0qCRuyn6cFjb4OZQMa1DGXRTfGnim+IT5Hh
         ePqYWSfVwk5DiXrdikVJaAJiMa0iCX/TdW2R1rjdDXM+uJHviTj3jlvjaTihL59V6KUr
         2xvFWdRGGvBLwto2Giu3coB8ZiGSJ3j9WAd5yOBoTFUsgcfkOuZIwsZaDLI3ZovtFm42
         AR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZsMT0CrEUbDwl+d5khTOYaGtUlOWn7Yi+9GLp9dBrZs=;
        b=PX1eW5IPaH2HeCJtAVrZOG0rtQ4EchzjHrUXa6bJMQzRp9MD9i16fOpSGFTbTh7uZP
         EfPskc0UBtOQAhxG/rlXVj3wU7fTcpzPZC5EArmhnwNVpCLrctYUgg3LVVIZdLBIV6C7
         jr+TM2lfk9+rn4Y2JlE3C3RwoBYsvV1YssFEGe7U+3LTKMgBHRbBxrp/xz5jicHhz1DN
         h5+ImOH0w0iYLPerNFl2Y0vjATU+EpQosWNjOlCWxPHohvX5VJgu7NG5A60SxmbHx+Ms
         5tqQtwB0XLGdkjxUFtG6v1SpEIwt5q6C9TfAVvVRFHOw8eLoswEbkaIJ+SB71TwOGDlG
         tqqg==
X-Gm-Message-State: AOAM533X5hsqubEuUaojVNrknK2++9aVd44Ko2LXKieZ11mWtsJBuiC7
        HvD6med/TLifc0MDmBgmavo=
X-Google-Smtp-Source: ABdhPJxLVU5s3PcDZkCGylGjdsqSH/E6IhkRhbORJX9k4Y433+Def/ioWVDRJ/5MZkenGYU8fL6Osg==
X-Received: by 2002:a05:600c:249:: with SMTP id 9mr35124620wmj.80.1593862749557;
        Sat, 04 Jul 2020 04:39:09 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id j24sm18657373wrd.43.2020.07.04.04.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 04:39:08 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 03/16] dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
Date:   Sat,  4 Jul 2020 13:38:49 +0200
Message-Id: <20200704113902.336911-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200704113902.336911-1-peron.clem@gmail.com>
References: <20200704113902.336911-1-peron.clem@gmail.com>
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
Acked-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
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
2.25.1

