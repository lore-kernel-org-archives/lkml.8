Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E3C0C35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 761E12067D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="HuM57RWF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgBWDQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 22:16:25 -0500
Received: from vps.xff.cz ([195.181.215.36]:36874 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727158AbgBWDQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 22:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582427776; bh=tDnwYEW9GEDNmkZUKddg1nhKcHJVjXNH6bPtCqGCOp0=;
        h=From:To:Cc:Subject:Date:References:From;
        b=HuM57RWFdI2ZY7MHHYC1x7XzTYzPYsuReQuZAjAE0sDuVdb7bZfCBNsF1nRK2vRzs
         MaVAolXkqtwLPMo8ulUS8d2wNLD/yoE+Ut0x4EhoxyS7Fn+yNRpB/2ZpSteph6vUBE
         cPTIlwYcZgawCLuGePBc3Xk4hvneTLQhAv2Sbm18=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Sunil Mohan Adapa <sunil@medhas.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add prefix for PocketBook International SA
Date:   Sun, 23 Feb 2020 04:16:12 +0100
Message-Id: <20200223031614.515563-2-megous@megous.com>
In-Reply-To: <20200223031614.515563-1-megous@megous.com>
References: <20200223031614.515563-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Call it "pocketbook".

Signed-off-by: Ondrej Jirman <megous@megous.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9e67944bec9c6..434cf7de691d2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -761,6 +761,8 @@ patternProperties:
     description: Broadcom Corporation (formerly PLX Technology)
   "^pni,.*":
     description: PNI Sensor Corporation
+  "^pocketbook,.*":
+    description: PocketBook International SA
   "^polaroid,.*":
     description: Polaroid Corporation
   "^portwell,.*":
-- 
2.25.1

