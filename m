Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2A4C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B574D208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TN2CwCxN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727684AbgCXMcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:32:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38940 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbgCXMcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:32:05 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so8781914wrt.6;
        Tue, 24 Mar 2020 05:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=atHO2cCzgOMkDYaDPQrtakvRe3Ydex6Qe9QJS9pzzX8=;
        b=TN2CwCxNWlYG1JfPYWRaeZ2r0cqpdUtqKj4DxRAJ+Vcp+KYsdavUdDfv5MMVdDam89
         QsN80wkxMFNnZKozAPaRWDyiNjGIWm6PhzoTyQ4IluC4yb2kXCp4GlMM3MOTkPGhRcrv
         jg55wqIdWr9IpkIsMIrKYD+pUyQIECB7tWUNtG/DY/Dyoux6kqUgoyMCatfdDPKftdod
         nUyk7yIZBGb/ZZIWWVo/QXHt0YLbh+mpnA6XO0f8vHvVvsyg5SWsO0z8oGQ5LyzPwZ0u
         tdtoZFiZgqZKL+s+SDNNFuHRKgGDu2/NE51KiSKcxi2rG1z1IfTz14bey+GX8KqPdW8U
         tvFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=atHO2cCzgOMkDYaDPQrtakvRe3Ydex6Qe9QJS9pzzX8=;
        b=RNuNvL35scwrqtwGPj5dq9XPJ+vwogYw61mOdPesqkqHPkdIvUe4u3rxqbxttbm5tQ
         4Xo/M5nN+I8HXWxx08ZOywCp768AP1NSOYBPGF6pVtAv1pBIuQffsc+FFlkTY8ahZn4z
         BbN7t1W+4lgwva1TYoG/oqpWh1pGpDvIfdNBZ7DfrNNgmoKCai13P2kAhLEHwbFnLQDv
         7StkAVtAfwBIzUMaaem/tstzM3k/hQQaWtxkVvTt905bZqgfagaBv+Nk6u9lNFNTFjqL
         Lr2PpMgIokqLiAe0FczA5KFxw8TQTX4/OVULco99sRtA5NLhdcvdDmDR2q/wPswmXPj2
         cAHg==
X-Gm-Message-State: ANhLgQ3H5VSxVx+EhQpRkZyN7+3CqknFeP/RR/UjqWJ3y0+gIPgbPHBC
        dyS7g3OGhaVOQvEa17oaZ14=
X-Google-Smtp-Source: ADFU+vvwc7ZZX4Hf0V7jwJm1hdyW8wN+2s2AUbaBpJXWj10D0kLU62MU+6Z0rzHvlOwAe0jPxp+BMw==
X-Received: by 2002:adf:f688:: with SMTP id v8mr36392951wrp.344.1585053123707;
        Tue, 24 Mar 2020 05:32:03 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id k185sm4215029wmb.7.2020.03.24.05.32.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Mar 2020 05:32:03 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, heiko@sntech.de, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: sound: rockchip-spdif: add #sound-dai-cells property
Date:   Tue, 24 Mar 2020 13:31:54 +0100
Message-Id: <20200324123155.11858-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200324123155.11858-1-jbx6244@gmail.com>
References: <20200324123155.11858-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'#sound-dai-cells' is required to properly interpret
the list of DAI specified in the 'sound-dai' property,
so add them to 'rockchip-spdif.yaml'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 Documentation/devicetree/bindings/sound/rockchip-spdif.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
index d1c72c8a5..0546fd4cc 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/rockchip-spdif.yaml
@@ -57,6 +57,9 @@ properties:
       The phandle of the syscon node for the GRF register.
       Required property on RK3288.
 
+  "#sound-dai-cells":
+    const: 0
+
 required:
   - compatible
   - reg
@@ -65,6 +68,7 @@ required:
   - clock-names
   - dmas
   - dma-names
+  - "#sound-dai-cells"
 
 if:
   properties:
@@ -91,4 +95,5 @@ examples:
       clock-names = "mclk", "hclk";
       dmas = <&dmac1_s 8>;
       dma-names = "tx";
+      #sound-dai-cells = <0>;
     };
-- 
2.11.0

