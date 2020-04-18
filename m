Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48E5C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 22:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B530F21D91
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 22:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxHYA8Ts"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgDRWoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 18:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbgDRWom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 18:44:42 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846BDC061A0C;
        Sat, 18 Apr 2020 15:44:42 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id d17so7376004wrg.11;
        Sat, 18 Apr 2020 15:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0RLyOmcQjC6vn1XEI3ccjJ++FkYMXRfGQ9jNbYoBA2Y=;
        b=RxHYA8TscBFB44NiehmUfeeQ06VUO3DFs/wsLjmwVEtal9fdToV7SPpG8MiCJfBS3j
         SPZFa960dZe2EhROSESp9ye1krXTOZiDFANBH6AMkfka/8TvX7RyL6lngNgc7vKv1zqG
         I198UmThs8xPlBLubazE9FsVpVx2WTYFzsdMooOCmI18+G/iYGooaaF4U87+MaMTyrvZ
         KIkmBGLtfkorteZae8wDxddFnlezaLiCynZ0atvPQy4AZdjabbmKOxC4AY7MoFmQ7FHJ
         hXqWCY3ZY3ChScUcC79Eh5bqQ8aMKrLvcvokHvhOwHZN8CvaIAtZsQX7aKcBBvNQ0+U+
         4uCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0RLyOmcQjC6vn1XEI3ccjJ++FkYMXRfGQ9jNbYoBA2Y=;
        b=gBDl/Znrkn+kdkyHyzrsvNFETlVIDj4CjJjPBw09bRkCpo+p7flDdcl/8XWx3XTSRS
         HTly1aIee98oyubwhtXCsORcmp6UCkQC7tHhzcf5MeOD6D6A1WwH/R7IpBdxJjHQxuy1
         TPMuDxzOhUPRqK661usGKKmwMnClfZ4XhkFLGczxUIs1gjJ+YZhv5/fDm16P+/VW5BbO
         ct5VPU4zAXFaMnxL/p+tnYUyXO8OfkXMzqTmRBMlr6Z4uomvRDfBRpoOrZUciJmkOLGC
         I2VpO8yXepG4qXvBOWucaWpYRePgNvPQLMuQtSwIDMJbCY75McLseICfa0zjo6Cqa+0M
         tY9w==
X-Gm-Message-State: AGi0PuY58s6wHq79i5V5quJZRR5VFodznOYz4F7OelN+E5b7Vke8bv3j
        qG6Hp0b7k+Zz06vSUmOv+40=
X-Google-Smtp-Source: APiQypKVFCS52LWaQqMpRrBfL5zoWfUa0PpkSMSmggBTe57uDxcMbauy9YOkMjLXPaTEMf2xJWwU2w==
X-Received: by 2002:a5d:6584:: with SMTP id q4mr11851428wru.403.1587249881115;
        Sat, 18 Apr 2020 15:44:41 -0700 (PDT)
Received: from localhost.localdomain (91-167-199-67.subs.proxad.net. [91.167.199.67])
        by smtp.gmail.com with ESMTPSA id t16sm13371559wmi.27.2020.04.18.15.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 15:44:40 -0700 (PDT)
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
Subject: [PATCH v2 2/7] dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
Date:   Sun, 19 Apr 2020 00:44:30 +0200
Message-Id: <20200418224435.23672-3-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418224435.23672-1-peron.clem@gmail.com>
References: <20200418224435.23672-1-peron.clem@gmail.com>
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

