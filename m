Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB922C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF95206A5
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:01:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2SSEBYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbgEDUBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 16:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726816AbgEDUBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:01:22 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D11C061A0E;
        Mon,  4 May 2020 13:01:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id e26so834026wmk.5;
        Mon, 04 May 2020 13:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hEW76UZB/sZtEFwmy764PGyYDv4AC7eZ6iGbT8XBec0=;
        b=J2SSEBYc/WoxujpQAS2W/xAgYPgfa8Gz1OkN083PUPlkb0CDiWh627fuYKmGJ5bc3w
         +QdwvO/51msDiu0IfKR4ndHu9IiwtIq7teOW3p5tSI2WbuWKna2mJl1fQlKjz17ZZmF3
         THlGeaChnbRvKAI7Q8QqOe6ae4HYWTSDS/PMA0S89z+aAX1yR+AlkEIij2kCtLSV0z42
         7opNx8ys/Zhqc8h2pQ/n5P++unPQUydbBgHCFSlkqrrWrToPlELa4up+xC9Jgofwi+3b
         Wnh8BmjFnMX4xlKwfTVxFbivZJAElzBraWM8WSSaZ9orVoqqUuWa4Z2KjFoJFVf53DKf
         tveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hEW76UZB/sZtEFwmy764PGyYDv4AC7eZ6iGbT8XBec0=;
        b=Or6aPO58je+Oofwl1UqUeyOqfOCpjHs+HZrX5EhMyi2N+NB3EKSqfWHVy7H0uszH/N
         Mh8F09rc6E/nwxvmJsr3WLD1ze4zWhdlRP8J+rWcGxjrN4hSI/Z08sJvxMNVOt1jEJSq
         9gzGvotXg8IYLKucdORibwwfgaqW88K4+Ne07sxunjsfGzhoKyOccnyqNCl8ljnD21un
         vAIfTRr0HKrJ8douCvbvgkkka/IqxmxCrsL/i4TqRe+I5HL5TbLpbFiiOT+uXcx/rwqS
         zPI8ECwq7tSpgRZq/yXpnNLiClFOi2WsJkZ/38MwNhu/mif3AOm3FO1e/mfXn682GxRz
         VQ1A==
X-Gm-Message-State: AGi0PuabzQJMb6TSc2GvMFcKqqOc0xj5TLFIXGbnUr3BSDd4n5GamxpD
        rZ2YjwAIHnkmu/E4f+SJfTc=
X-Google-Smtp-Source: APiQypLcSw0pOqEp8W828P4UsPw9yMNrnI+r6qNGKRZbiBZZ1S7x++V+QiE1tOHTdDZ2VFwHokZlbA==
X-Received: by 2002:a1c:2d0e:: with SMTP id t14mr16607050wmt.153.1588622479996;
        Mon, 04 May 2020 13:01:19 -0700 (PDT)
Received: from localhost.localdomain (abag125.neoplus.adsl.tpnet.pl. [83.6.170.125])
        by smtp.googlemail.com with ESMTPSA id s17sm739252wmc.48.2020.05.04.13.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 13:01:19 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [v3 PATCH 2/2] dt-bindings: display: Document ASUS Z00T TM5P5 NT35596 panel compatible
Date:   Mon,  4 May 2020 22:01:00 +0200
Message-Id: <20200504200102.129195-3-konradybcio@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200504200102.129195-1-konradybcio@gmail.com>
References: <20200504200102.129195-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
---
 .../display/panel/asus,z00t-tm5p5-n35596.yaml | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/asus,z00t-tm5p5-n35596.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/asus,z00t-tm5p5-n35596.yaml b/Documentation/devicetree/bindings/display/panel/asus,z00t-tm5p5-n35596.yaml
new file mode 100644
index 0000000000000..aa8940e493eb1
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/asus,z00t-tm5p5-n35596.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/tm5p5,nt35596.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ASUS Z00T TM5P5 NT35596 5.5" 1080×1920 LCD Panel
+
+maintainers:
+  - Konrad Dybcio <konradybcio@gmail.com>
+
+description: |+
+  This panel seems to only be found in the Asus Z00T
+  smartphone and we have no straightforward way of
+  actually getting the correct model number,
+  as no schematics are released publicly.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: asus,z00t-tm5p5-n35596
+  reg: true
+  reset-gpios: true
+  vdd-supply:
+     description: core voltage supply
+  vddio-supply:
+     description: vddio supply
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vddio-supply
+  - reset-gpios
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            panel@0 {
+                    reg = <0>;
+
+                    compatible = "asus,z00t-tm5p5-n35596";
+
+                    vdd-supply = <&pm8916_l8>;
+                    vddio-supply = <&pm8916_l6>;
+                    reset-gpios = <&msmgpio 25 GPIO_ACTIVE_HIGH>;
+            };
+    };
-- 
2.26.1

