Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75BFCC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FCB520738
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qur/Atmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgG0HoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgG0HoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:44:03 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B72C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 00:44:03 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l63so8953266pge.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 00:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5US/XCWACBZUG+u/wcd8ufH/ZA+g/IaYFSks30i6g9k=;
        b=qur/AtmdKo9Z1/6syLwN1Bs4Sm/0w7BycwiIZCY7HuB+hYitWI7TQ8VkabtUNI47M/
         29JN1tJWNYx+YxEysZUSk7IW1ZJlGbD9Y+yD1pR4biouLN2Rgnw9LfDEja2iMYVkyCgT
         yZ/d/pZGG8Mcqy6Ki+qZBMYfcZc0+vmoTzIRvAG7jJs9FZk7wUpEIh5fU+gIpDRoqJNl
         y8F1anTTNJ6r6hyPdW5JNd6JfWtEle2hAkZLUteWrM+AN2Vd/94lXUquyxFVmQxLl+cE
         L4xu9F/uvyrIwP131jddQKfXgyD9Ix8VNsH3b6wUbBNMmzxO0zIxXBJ6+GTo0B3/ydWD
         Y2tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5US/XCWACBZUG+u/wcd8ufH/ZA+g/IaYFSks30i6g9k=;
        b=PgyuzgQxeDzZIcDeS7GKoB9r7fa2Q67LoxoeQUOMJw/mO+ve1vwbFjg8Puj7jHwZ58
         HfTF6Sv9XMl5tUfm8BC+maY9ipKcsq4f1Oo+IjJjTt/QEqzFq9PT+U0GF7w9oskUyrPh
         sCsm17kiZ1VbIlvQTlwivw6tfXQA/Flmrv11dM+wObn/rB+fKpcYkhxVgwIGcxGSlvtG
         veIceLVvvk80j8KpoRlshpPagQskGW6k2SVyqGHXjQmwoaf/DY9+BoduOopiBRLj2SWD
         C/cc0pqQNSHMtCVNxCUCAS4haqhONgCmGfKt0EQmf4sBAAG3WN709ckLO0ufLqFdGrdW
         5TFQ==
X-Gm-Message-State: AOAM530GN43J7ZyxjPQkVDHTOX2ZWB2/5MvgMHYSRZ+Ve2QNMJrK5gGx
        pp24vlnWJ+azsvB4DTkbllR/2w==
X-Google-Smtp-Source: ABdhPJzMXwH+bJlvAoqfT0h/bFkfqXsia+jQnXAdIqrualZwu256Gdg7aSGAbhqMTbYCq6zWUmBiug==
X-Received: by 2002:a62:7991:: with SMTP id u139mr18349947pfc.87.1595835842812;
        Mon, 27 Jul 2020 00:44:02 -0700 (PDT)
Received: from nagraj.local ([49.206.21.239])
        by smtp.gmail.com with ESMTPSA id n22sm13062152pjq.25.2020.07.27.00.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 00:44:01 -0700 (PDT)
From:   Sumit Semwal <sumit.semwal@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: [PATCH v3 1/2] dt-bindings: display: panel: Add bindings for Tianma nt36672a panel
Date:   Mon, 27 Jul 2020 13:13:47 +0530
Message-Id: <20200727074348.26116-2-sumit.semwal@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727074348.26116-1-sumit.semwal@linaro.org>
References: <20200727074348.26116-1-sumit.semwal@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nt36672a panel from Tianma is a FHD+ panel with a resolution of
1080x2246 and 6.18 inches size. It is found in some of the Poco F1
phones.

Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>

---
v2: remove ports node, making port@0 directly under panel@0 node.
v3: updated to replace port@0 to just 'port'.
---
 .../display/panel/tianma,nt36672a.yaml        | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml b/Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml
new file mode 100644
index 000000000000..03dc323332a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/tianma,nt36672a.yaml
@@ -0,0 +1,95 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/tianma,nt36672a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Tianma model NT36672A DSI Panel display driver
+
+maintainers:
+  - Sumit Semwal <sumit.semwal@linaro.org>
+
+description: |
+  The nt36672a panel from Tianma is a FHD+ LCD display panel with a resolution
+  of 1080x2246. It is a video mode DSI panel.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: tianma,nt36672a
+
+  reg:
+    description: DSI virtual channel of the peripheral
+
+  reset-gpios:
+    description: phandle of gpio for reset line - This should be 8mA, gpio
+      can be configured using mux, pinctrl, pinctrl-names (active high)
+
+  vddio-supply:
+    description: phandle of the regulator that provides the supply voltage
+      Power IC supply
+
+  vddpos-supply:
+    description: phandle of the positive boost supply regulator
+
+  vddneg-supply:
+    description: phandle of the negative boost supply regulator
+
+  pinctrl-names:
+    description: Pinctrl for panel active and suspend
+
+  pinctrl-0:
+    description: Active pinctrls
+
+  pinctrl-1:
+    description: Suspend pinctrls
+
+  port: true
+
+required:
+  - compatible
+  - reg
+  - vddi0-supply
+  - vddpos-supply
+  - vddneg-supply
+  - reset-gpios
+  - pinctrl-names
+  - pinctrl-0
+  - pinctrl-1
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |+
+    #include <dt-bindings/gpio/gpio.h>
+    dsi0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      panel@0 {
+        compatible = "tianma,nt36672a";
+        reg = <0>;
+        vddi0-supply = <&vreg_l14a_1p88>;
+        vddpos-supply = <&lab>;
+        vddneg-supply = <&ibb>;
+
+        reset-gpios = <&tlmm 6 GPIO_ACTIVE_HIGH>;
+
+        pinctrl-names = "panel_active", "panel_suspend";
+        pinctrl-0 = <&sde_dsi_active>;
+        pinctrl-1 = <&sde_dsi_suspend>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+        port {
+          tianma_nt36672a_in_0: endpoint {
+            remote-endpoint = <&dsi0_out>;
+          };
+        };
+      };
+    };
+
+...
-- 
2.27.0

