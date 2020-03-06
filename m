Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFABC3F2D8
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5785D20870
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YCCN2t1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCFEOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 23:14:00 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40536 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgCFEOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 23:14:00 -0500
Received: by mail-pj1-f68.google.com with SMTP id gv19so509235pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 20:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FYo0wCuLZS6Af0DjoF3Xj17jVoInSu2OB15HTnyAsCo=;
        b=YCCN2t1CB2P2CfMaPm6rIKOPVG8t/6V3YQ2aCXAgjwQ/oXYOdBygxVA5DtyYataKSO
         8jXTgzI9ZnMO/rKDqORjVs1ktjYBpeo3sqPj4vQGQJb5Dyg3EMeOJSo5Rar1l1W4uIHX
         DB1YWKd8PndfLlPLZiNSXoYYlp+cRIkYlwyFE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FYo0wCuLZS6Af0DjoF3Xj17jVoInSu2OB15HTnyAsCo=;
        b=B9Xw4g9JPY4l/xPqacuDNqWoX9xTNT9VjxYWeFm6AnchyEdFQ4nAXeMTA9h0cqe/PL
         ZXeMLy4p+Hs42CWcHX4DIQEJHr+g/JmeOAvTEB24MQDbECJl3Fw4VLPay4CMGhAOy+DC
         /TmiveG3zdg18n3b1VRyvY8dVOHKQVtbCCK6JxW6HLAOVLvGM8EztjPojuyDMBWK5JCU
         ttY/UMmh80NSET7r4zrY7WRqUcJAG10LpGdiGX6Ju8msuL/qLOlZ4+denVeAbwnD0/vb
         xtx5ds/dPCNhqi+pJ9ldVzeC2UUw9fbRmFdeAsehc13JVyztZ4/0HZNP7ENmYG3jeQ5V
         W7Ww==
X-Gm-Message-State: ANhLgQ1MtsTX/z46CqHNgbhfDUiu7rAaZX/CiOxMcm7iFsmjOYCyLyNk
        As314uyEX9MlSBjZoCIWE/6/9Q==
X-Google-Smtp-Source: ADFU+vsapmfZZvpytvq8zfJi0p1aO+2auKRfer0iGIeUM9zhX2RKOVB+rq7eHpBtbvY0Yo4mFBVKTg==
X-Received: by 2002:a17:90a:b94a:: with SMTP id f10mr1564406pjw.1.1583468038770;
        Thu, 05 Mar 2020 20:13:58 -0800 (PST)
Received: from drinkcat2.tpe.corp.google.com ([2401:fa00:1:b:d8b7:33af:adcb:b648])
        by smtp.gmail.com with ESMTPSA id q97sm6295025pja.9.2020.03.05.20.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 20:13:58 -0800 (PST)
From:   Nicolas Boichat <drinkcat@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Nick Fan <nick.fan@mediatek.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org
Subject: [PATCH v5 1/4] dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183
Date:   Fri,  6 Mar 2020 12:13:42 +0800
Message-Id: <20200306041345.259332-2-drinkcat@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200306041345.259332-1-drinkcat@chromium.org>
References: <20200306041345.259332-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a compatible string for the Mali Bifrost GPU found in
Mediatek's MT8183 SoCs.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Reviewed-by: Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
---

v5:
 - Rename "2d" power domain to "core2"
v4:
 - Add power-domain-names description
   (kept Alyssa's reviewed-by as the change is minor)
v3:
 - No change

 .../bindings/gpu/arm,mali-bifrost.yaml        | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index e8b99adcb1bd292..c5ceca513192f99 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -17,6 +17,7 @@ properties:
     items:
       - enum:
           - amlogic,meson-g12a-mali
+          - mediatek,mt8183-mali
           - realtek,rtd1619-mali
           - rockchip,px30-mali
       - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
@@ -62,6 +63,30 @@ allOf:
           minItems: 2
       required:
         - resets
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8183-mali
+    then:
+      properties:
+        sram-supply: true
+        power-domains:
+          description:
+            List of phandle and PM domain specifier as documented in
+            Documentation/devicetree/bindings/power/power_domain.txt
+          minItems: 3
+          maxItems: 3
+        power-domain-names:
+          items:
+            - const: core0
+            - const: core1
+            - const: core2
+
+      required:
+        - sram-supply
+        - power-domains
+        - power-domains-names
 
 examples:
   - |
-- 
2.25.1.481.gfbce0eb801-goog

