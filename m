Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73BDBC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AAAA2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enofGnNv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgICUld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729292AbgICUau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:30:50 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3168C061247;
        Thu,  3 Sep 2020 13:30:49 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id z9so4148410wmk.1;
        Thu, 03 Sep 2020 13:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZsMT0CrEUbDwl+d5khTOYaGtUlOWn7Yi+9GLp9dBrZs=;
        b=enofGnNvFaQ8oGc4z15/36/YLJppZhOZTl+Gdicqyj0UX2J3ooTNj7/IH82Yi89yQs
         wsF067mgwhsLqFS9IaJ1L9v80tLwqQLChTDOaPPNG4YWKwFNZW+YLkr+Ay3tLtskpMCk
         fN73s20xMdmBEqNmoDdDf1vELFue1TqToBIzViaXZ2jHL3InyyNHSrE5aO5NGb0EQ6UX
         x/G269jmZ+7KtmaqyrEkv5CiYh3/HnMU2SGhPAsgGVYGuq8pwyPxgqI7g+5xNpMLMfxC
         ZkIWdu6i+rdwKHpey3+2EnepDxGnFRdcyqZ45rGMfg1LwCRAQN2rKYtZR0a0wSryXb9G
         yh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZsMT0CrEUbDwl+d5khTOYaGtUlOWn7Yi+9GLp9dBrZs=;
        b=FH0Q4HFshLFAEYMz3OlKGrtc0y8HGDISy/FOJJIwIgNWDUXbOCT8gfEeVPP18Dgn0i
         qGz2fKsRjrlJQB0F3SY1kVO6hi79iWZ3eUSl3ccAtsaoA1mm2Kt6Eq06GxOvNUKKEt+a
         ITVDQiAtAUAI66DN4wj0uGdPmbg/7L14OWmSjgbETD+glnYjSQ8gecw/4HyjH4b5M3mi
         1yTc+dBLvxf0DUs1u7ml+U7rfA6UImIeF4iu0jVj52Qta/hIYTZ3aiyeRbjwXJYnhxFN
         MKOJweeb6z+5Ccvuv80r5DR1hg9bL2QiqawR/5p3m7K5Ug15i2ifnCzb42MVEu2tRhgH
         dB0Q==
X-Gm-Message-State: AOAM533lYnYgTQNeysaAWJBp+nsSPIGzHPK8t3gRqCVvMYwbiQYLpYAg
        TytVDJgYlrxK8TehwWarbIY=
X-Google-Smtp-Source: ABdhPJykIn7OPNN6E/gzPrACx/DHBDDhgfTKYquUWYQ/3uZRxzPMEEUDxujl3Ys0Udb+JC9mK7US0w==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr4079475wmk.47.1599165048287;
        Thu, 03 Sep 2020 13:30:48 -0700 (PDT)
Received: from clement-Latitude-7490.numericable.fr (213-245-241-245.rev.numericable.fr. [213.245.241.245])
        by smtp.gmail.com with ESMTPSA id q186sm6818274wma.45.2020.09.03.13.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 13:30:47 -0700 (PDT)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 04/20] dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
Date:   Thu,  3 Sep 2020 22:30:18 +0200
Message-Id: <20200903203034.1057334-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200903203034.1057334-1-peron.clem@gmail.com>
References: <20200903203034.1057334-1-peron.clem@gmail.com>
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

