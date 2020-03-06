Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4174C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28EA2072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbEDp+IF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgCFPUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 10:20:37 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37470 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCFPUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 10:20:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id 6so2823747wre.4;
        Fri, 06 Mar 2020 07:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r/uHS4evC8ik+CyCrbOO3pGogteVgXLxKemz6/uGGdQ=;
        b=AbEDp+IFY6BORZhzlbBIjYCIfYe7FXnbf8iRtrJGMPubxijFk2J5oMWWQwvK1O9o28
         E9JtP0mwLt0nNQdAM7iZ+/iGMa7pszGI6yrmI3/BNq05jOmdi5aBhE3Xng6Mjpy2LYg1
         lBIUfuWCptV6NN7NuCJm3USjMQ7SP8bpFrMGCHiPsTW64RwWqrz3g+ikMiH8iraDfEw3
         9QGsmRm+OZNNhhe47Ys47PSKwHlhwduuWxiRQJXwYRmjvvzAiAhAvTf78c7bQyLfwm5n
         70+mQ7FH/S6WUBDUe1gcd8gUlaZVWZhOYEYqJi5mauJNy5vNG81EpRA9AjF9ggzFohTX
         wORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r/uHS4evC8ik+CyCrbOO3pGogteVgXLxKemz6/uGGdQ=;
        b=tmCI7ZzyQPsdEQKRhIFzEhWZuLSBNWfqUYh0jxVQKf6221cJIIsRbgphgYoH6TLkY2
         j5lsPAqj0WCdO21uukATBdwXx12GOqWJC1+HQRFbc1EXSnGpSU9y50ZvUQxyBwOX0p0n
         VMCoZqSns8ICY8Evvp60t6kP69zOMGqAI0VaHF5jd2wziDgAOzKBFyeLh9LyqVNntAkp
         xXhfZP1iUK+XrwP583aGzJ0i/30RZ3kjLweBxIwUII53rotZEBjIZ9ojWzFqlHG24tgx
         +PJynw3qzcIY5M6msdGbUAq4pN/1HglPaTVGp+M1axphA/aVJ7epotUOUIISYVdVVrsp
         LDIg==
X-Gm-Message-State: ANhLgQ0ehJ9CI2AmWUdOWG0U0bbqwN5nqNl1YnXcTbkHWM1l8iRxqGrD
        e1c4KsExsLutQpYSrPQgcE8=
X-Google-Smtp-Source: ADFU+vvX6BQLrE6t4ebXFAnVTSXAsdtf5xvn0XFpWu8QGbtNW/F/3Z18Lt4cV79Iv0e+8payXdq1bQ==
X-Received: by 2002:adf:f7c9:: with SMTP id a9mr4535175wrq.225.1583508033317;
        Fri, 06 Mar 2020 07:20:33 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2510:d000:28e7:f2d4:3603:fb7])
        by smtp.gmail.com with ESMTPSA id j14sm49640202wrn.32.2020.03.06.07.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 07:20:32 -0800 (PST)
From:   Lad Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Chris.Paterson2@renesas.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RESEND PATCH v7] dt-bindings: display: Add idk-2121wr binding
Date:   Fri,  6 Mar 2020 15:20:31 +0000
Message-Id: <20200306152031.14212-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Add binding for the idk-2121wr LVDS panel from Advantech.

Some panel-specific documentation can be found here:
https://buy.advantech.eu/Displays/Embedded-LCD-Kits-High-Brightness/model-IDK-2121WR-K2FHA2E.htm

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Apologies for flooding in I missed to add the ML email-ids for the earlier
version so resending it.

Hi All,

This patch is part of series [1] ("Add dual-LVDS panel support to EK874),
all the patches have been accepted from it except this one. I have fixed
Rob's comments in this version of the patch.

[1] https://patchwork.kernel.org/cover/11297589/

v6->7
 * Added reference to lvds.yaml
 * Changed maintainer to myself
 * Switched to dual license
 * Dropped required properties except for ports as rest are already listed
   in lvds.panel
 * Dropped Reviewed-by tag of Laurent, due to the changes made it might not
   be valid.

v5->v6:
 * No change

v4->v5:
* No change

v3->v4:
* Absorbed patch "dt-bindings: display: Add bindings for LVDS
  bus-timings"
* Big restructuring after Rob's and Laurent's comments

v2->v3:
* New patch

 .../display/panel/advantech,idk-2121wr.yaml        | 120 +++++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.yaml b/Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.yaml
new file mode 100644
index 0000000..b05df05
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/advantech,idk-2121wr.yaml
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/advantech,idk-2121wr.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Advantech IDK-2121WR 21.5" Full-HD dual-LVDS panel
+
+maintainers:
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+description: |
+  The IDK-2121WR from Advantech is a Full-HD dual-LVDS panel.
+  A dual-LVDS interface is a dual-link connection with even pixels traveling
+  on one link, and with odd pixels traveling on the other link.
+
+  The panel expects odd pixels on the first port, and even pixels on the
+  second port, therefore the ports must be marked accordingly (with either
+  dual-lvds-odd-pixels or dual-lvds-even-pixels).
+
+allOf:
+  - $ref: lvds.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: advantech,idk-2121wr
+      - {} # panel-lvds, but not listed here to avoid false select
+
+  width-mm:
+    const: 476
+
+  height-mm:
+    const: 268
+
+  data-mapping:
+    const: vesa-24
+
+  ports:
+    type: object
+    properties:
+      port@0:
+        type: object
+        description: The sink for odd pixels.
+        properties:
+          reg:
+            const: 0
+
+          dual-lvds-odd-pixels: true
+
+        required:
+          - reg
+          - dual-lvds-odd-pixels
+
+      port@1:
+        type: object
+        description: The sink for even pixels.
+        properties:
+          reg:
+            const: 1
+
+          dual-lvds-even-pixels: true
+
+        required:
+          - reg
+          - dual-lvds-even-pixels
+
+  panel-timing: true
+
+additionalProperties: false
+
+required:
+  - ports
+
+examples:
+  - |+
+    panel-lvds {
+      compatible = "advantech,idk-2121wr", "panel-lvds";
+
+      width-mm = <476>;
+      height-mm = <268>;
+
+      data-mapping = "vesa-24";
+
+      panel-timing {
+        clock-frequency = <148500000>;
+        hactive = <1920>;
+        vactive = <1080>;
+        hsync-len = <44>;
+        hfront-porch = <88>;
+        hback-porch = <148>;
+        vfront-porch = <4>;
+        vback-porch = <36>;
+        vsync-len = <5>;
+      };
+
+      ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        port@0 {
+          reg = <0>;
+          dual-lvds-odd-pixels;
+          panel_in0: endpoint {
+            remote-endpoint = <&lvds0_out>;
+          };
+        };
+
+        port@1 {
+          reg = <1>;
+          dual-lvds-even-pixels;
+          panel_in1: endpoint {
+            remote-endpoint = <&lvds1_out>;
+          };
+        };
+      };
+    };
+
+...
-- 
2.7.4

