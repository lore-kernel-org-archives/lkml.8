Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F5BC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 04:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC12D20663
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 04:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZa4Ftrm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgEHENg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 00:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgEHENe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 00:13:34 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3823EC05BD43;
        Thu,  7 May 2020 21:13:34 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id hi11so3665876pjb.3;
        Thu, 07 May 2020 21:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Db6qOihor5Bj8DkFXZYYMAre3zfCOsyEXmYIyTZWgqc=;
        b=HZa4Ftrmwnb5Ap1XUema1giGFlB40rvdwsHrEWexpeZ6u5tBF43Pq4MFzxAYUu84aI
         JunK7vj/+KG0NUE2q78MI7A8GNKQoC+8zU6hWn6d1wy/rzVCxyRUPShkVXyJi/z4rZ8X
         i25uLgD5ruVcCH5djhBBhZKzsS361Rev4ajBHWYRd4FOcqm3ApHA7RHKdjnCKfSxMdL/
         OYq7KHB0yYJoOYEjmMuKH2w3YwgJDQNmQMo5R1V5fS/spm2DHonKxkvkoJEquM3oeLcX
         SCQtrBzKRLKh6kVEGNoNtw3jUeLMTnSQoqR3iHXqONoXhHB0amdTdYRt6MPXFkfyz2Fy
         C1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Db6qOihor5Bj8DkFXZYYMAre3zfCOsyEXmYIyTZWgqc=;
        b=kN9XUvekDgWUFRGY9S/3GnIgHRWROel/SC9kXNhiPJwrHpXT0fCwjy9LeS4UQiDy38
         HO1MXlFdjIu/It8T0atTveb+5B6N6uVJ3Q4BfMvMWHyEnqPYX59eV5we7GlMgIy/ILva
         pwh5QnyKn9J4BMhH7D1mRwozZ3L6ihQvopNX3B5TC0yCvGqlJ/LPU1KwjQqOccwVgbAB
         3nqt5QxOUcbFi13gWcnmQ1G2ivpk1DXc9y1UauDa8IsTCKeV+xEeOL3TSjyFHP2E+icc
         9jb+fqQzOjQCBcHrScyrP6i4lIAvDKU+MRSWWxqB45vOL0m+yDUzqQFoE6xrhiHASoiF
         Dsmg==
X-Gm-Message-State: AGi0PuZ6/pddXFXmoTc6jjQJ6McOF1bjLQJrUF7tZTqNNXdLPzcV1oR7
        RXM5PLkmraQzbv0cVe371jc=
X-Google-Smtp-Source: APiQypJLGCxoTkz92z+vdPnEwubOafhAAPIJICKtjIgVVEZQPHbclNonxkvq6mn3XY2pZohgYlX7KQ==
X-Received: by 2002:a17:90a:208f:: with SMTP id f15mr3825087pjg.60.1588911213774;
        Thu, 07 May 2020 21:13:33 -0700 (PDT)
Received: from fmin-OptiPlex-7060.nreal.work ([103.206.190.146])
        by smtp.gmail.com with ESMTPSA id h12sm314868pfq.176.2020.05.07.21.13.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 21:13:33 -0700 (PDT)
From:   dillon.minfei@gmail.com
To:     robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, thierry.reding@gmail.com,
        sam@ravnborg.org, airlied@linux.ie, daniel@ffwll.ch,
        mturquette@baylibre.com, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-clk@vger.kernel.org,
        dillon min <dillon.minfei@gmail.com>
Subject: [PATCH v2 3/5] dt-bindings: display: panel: Add ilitek ili9341 panel bindings
Date:   Fri,  8 May 2020 12:13:12 +0800
Message-Id: <1588911194-12433-4-git-send-email-dillon.minfei@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588911194-12433-1-git-send-email-dillon.minfei@gmail.com>
References: <1588911194-12433-1-git-send-email-dillon.minfei@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: dillon min <dillon.minfei@gmail.com>

Add documentation for "ilitek,ili9341" panel.

Signed-off-by: dillon min <dillon.minfei@gmail.com>
---

Hi Rob Herring,

This patch [PATCH V2 3/5] about ilitek,ili9341.yaml was verifyed with make dt_binding_check

thanks.

best regards,

dillon,

.../bindings/display/panel/ilitek,ili9341.yaml     | 68 ++++++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
new file mode 100644
index 0000000..94c2b15
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9341.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ilitek,ili9341.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek-9341 Display Panel
+
+maintainers:
+  - Dillon Min <dillon.minfei@gmail.com>
+
+description: |
+  Ilitek ILI9341 TFT panel driver with SPI control bus
+  This is a driver for 320x240 TFT panels, accepting a rgb input
+  streams that get adapted and scaled to the panel.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: stm32f429,ltdc-panel
+      - {} # ilitek,ili9341, but not listed here to avoid false select
+
+  reg: true
+
+  dc-gpios:
+    maxItems: 1
+    description: panel spi dc gpio
+
+  spi-3wire: true
+
+  spi-max-frequency:
+    const: 10000000
+
+  port: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - dc-gpios
+  - spi-3wire
+  - spi-max-frequency
+  - port
+
+examples:
+  - |+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        panel: display@0 {
+                 compatible = "stm32f429,ltdc-panel", "ilitek,ili9341";
+                 reg = <0>;
+                 spi-3wire;
+                 spi-max-frequency = <10000000>;
+                 dc-gpios = <&gpiod 13 0>;
+                 port {
+                         panel_in: endpoint {
+                           remote-endpoint = <&display_out>;
+                      };
+                 };
+             };
+        };
+...
+
-- 
2.7.4

