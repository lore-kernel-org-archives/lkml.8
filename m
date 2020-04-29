Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5681C8300B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 958142083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 20:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="CHODodNm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgD2URX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 16:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgD2URP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 16:17:15 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07273C03C1AE;
        Wed, 29 Apr 2020 13:17:15 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d17so4076988wrg.11;
        Wed, 29 Apr 2020 13:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=70PGPQVXxWkWt5bMu/YYfSXZfY8zmYWnV1uR/DOx3oI=;
        b=CHODodNmsuW+chZgMSL/aU4EnarAaDIB7eXBAjMvlsonq+wuNDVGUJCixVrpFPVHv0
         eLe7iQE0b6IVK9woGS4WRHgp1pIDNyiU/pvax4e/hFhd8Tg+XuRQDhxcWP8g+hESasfG
         0PvoOjleMGc/VhEHapA/nrVQIz+u3cU4WKukUCaPObHXRo4oVjyNp/dma6TvvoKJBSv1
         UHFO/dN7/7fOEoicRBiobhcCPrV9VPlDGDJ0bcuHdimr4jBLKUBuXsqV3K6RVjdpryfB
         NHeEkJE9MD54wgSGOsu79UcZVkVL2erbRs5xdDHnHc7otZm23Z9/6PHRNiGJkv0mCM5U
         H4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=70PGPQVXxWkWt5bMu/YYfSXZfY8zmYWnV1uR/DOx3oI=;
        b=EPFAHS6MLHzJGwGiGGa76EZlVLh7maVpFJD2V286nrSqYiolVu/zf50ebR5TUuR2mE
         QYcKrdhC14wjg9nf5ToiecGdPq1XdXpZ273LsDu3+fuVJOAZJ+qWptFjoKTFRwSxjjRK
         WDobGcSvNQk+wXVBlKta+/mlSo84fN5Fm1CCYiecehWA1dQgPcZOtagARsR/3P5TfUeQ
         PmqKt2u+lV5np4ELaipM+jdMCuDqu54CoL7SYrDSYIpajV20SnmtJRTeLZs3bbSUAh5v
         QYdun0Yaja9yYu658ytAu/joffa2t28lFPr176HbWmwnC4gRpsL2+g0Nb+FG71Zh4dqg
         x4WA==
X-Gm-Message-State: AGi0PuZlqo57XW+3uYNrvsCOUc3TxJDxZgNpW2dX8nHDWSFLHB6cSS5U
        Sm5X14TRPiIqtfqPYCCa2gA=
X-Google-Smtp-Source: APiQypJtmwbq9B5dWA8SnCuu/BSQvt25+h0Lxx4pGLSnoOKCcBACToJY8vRY4FM4aHun8MA3Wxv0vg==
X-Received: by 2002:adf:f343:: with SMTP id e3mr39846693wrp.51.1588191433642;
        Wed, 29 Apr 2020 13:17:13 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id q143sm9923623wme.31.2020.04.29.13.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 13:17:13 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     robh+dt@kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     jianxin.pan@amlogic.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v2 02/11] dt-bindings: net: dwmac-meson: Document the "timing-adjustment" clock
Date:   Wed, 29 Apr 2020 22:16:35 +0200
Message-Id: <20200429201644.1144546-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429201644.1144546-1-martin.blumenstingl@googlemail.com>
References: <20200429201644.1144546-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PRG_ETHERNET registers can add an RX delay in RGMII mode. This
requires an internal re-timing circuit whose input clock is called
"timing adjustment clock". Document this clock input so the clock can be
enabled as needed.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/net/amlogic,meson-dwmac.yaml   | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
index 8d851f59d9f2..2bc0e8b0d25b 100644
--- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
@@ -40,18 +40,22 @@ allOf:
     then:
       properties:
         clocks:
+          minItems: 3
+          maxItems: 4
           items:
             - description: GMAC main clock
             - description: First parent clock of the internal mux
             - description: Second parent clock of the internal mux
+            - description: The clock which drives the timing adjustment logic
 
         clock-names:
           minItems: 3
-          maxItems: 3
+          maxItems: 4
           items:
             - const: stmmaceth
             - const: clkin0
             - const: clkin1
+            - const: timing-adjustment
 
         amlogic,tx-delay-ns:
           $ref: /schemas/types.yaml#definitions/uint32
@@ -120,7 +124,7 @@ examples:
          reg = <0xc9410000 0x10000>, <0xc8834540 0x8>;
          interrupts = <8>;
          interrupt-names = "macirq";
-         clocks = <&clk_eth>, <&clkc_fclk_div2>, <&clk_mpll2>;
-         clock-names = "stmmaceth", "clkin0", "clkin1";
+         clocks = <&clk_eth>, <&clk_fclk_div2>, <&clk_mpll2>, <&clk_fclk_div2>;
+         clock-names = "stmmaceth", "clkin0", "clkin1", "timing-adjustment";
          phy-mode = "rgmii";
     };
-- 
2.26.2

