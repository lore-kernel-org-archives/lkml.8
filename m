Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861AAC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC282065F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 12:02:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fiq88mJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgGQMCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 08:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgGQMCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 08:02:23 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F09C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 05:02:23 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x9so5366742plr.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 05:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L3pqPBmqTtCeYXo5oFQYdRCBTjDx4yuoNDp8LIqBhrc=;
        b=Fiq88mJGxvol+DfakU3u1Vx74pRzPYj7T7rmvxTYQ0R6XbPjlDyufuGXHO11rL4Aqu
         cxkaKvAndUauNZlZy+N01asDPJLjTFxRqEo+fYpTFPtizdn6V5RKvdsdvaukmq4Y5Wfg
         WhBvEwK69Z286KKGEqm/S0i9dtloZWeu2N070=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L3pqPBmqTtCeYXo5oFQYdRCBTjDx4yuoNDp8LIqBhrc=;
        b=QSuqzNJIQwJQkIGbMyAwl2AplApTiB+BtJFavyXBgEizt0vNXf9bYTWK23jYAREoNV
         g+tSKl7heq6unRB5Lpiyfe5HHmMpr6zSk/m1sNFLtb+bQxHrVPeDpkefFX9ClnwNiuw0
         rV8tlx+f6jRpcKOko+I4ujKZ42yZc0vc2g1/fQkjswejYNx4s9hG/gL7JEFgyGrl2GSt
         OH8Rmke35ZXAaxvN8AU6mzqFuY9dXqfTkHqX4D7Z9z8fBItkJubobGDelnWedoFjSvTq
         ozPDT5mEbafCqkyAcZTgzVBRUNXnhGrf2CWYrRb0HbmyuXjqUmUghcO/8AMIY6cXMG++
         BoxA==
X-Gm-Message-State: AOAM530aBaCTWLaQxr2DwbocuZxSwp34ybb1+H0tXEvtJmHqJIEa2E4Q
        Q6VCRdKIDhk4meh1b+S/r1WOfemrbM57RA==
X-Google-Smtp-Source: ABdhPJzC5HAlXulCQHydsosvZqKgOL2r1Sq7g4jGNcgmX3dlnIzS0V0GhWvXYW2BuiohLAxnovDWvg==
X-Received: by 2002:a17:90a:1748:: with SMTP id 8mr9068453pjm.131.1594987342798;
        Fri, 17 Jul 2020 05:02:22 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:de4a:3eff:fe7d:d39c])
        by smtp.gmail.com with ESMTPSA id c188sm7770179pfc.143.2020.07.17.05.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 05:02:21 -0700 (PDT)
From:   Cheng-Yi Chiang <cychiang@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>, Taniya Das <tdas@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Banajit Goswami <bgoswami@codeaurora.org>,
        Patrick Lai <plai@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH 1/2] ASoC: qcom: dt-bindings: Add sc7180 machine bindings
Date:   Fri, 17 Jul 2020 20:02:06 +0800
Message-Id: <20200717120207.3471030-1-cychiang@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings documentation file for sc7180 sound card.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 .../bindings/sound/qcom,sc7180.yaml           | 123 ++++++++++++++++++
 1 file changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
new file mode 100644
index 000000000000..d60d2880d991
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,sc7180.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies Inc. SC7180 ASoC sound card driver
+
+maintainers:
+  - Rohit kumar <rohitkr@codeaurora.org>
+  - Cheng-Yi Chiang <cychiang@chromium.org>
+
+description: |
+  This binding describes the SC7180 sound card, which uses LPASS for audio.
+
+definitions:
+
+  link-name:
+    description: Indicates dai-link name and PCM stream name.
+    $ref: /schemas/types.yaml#/definitions/string
+    maxItems: 1
+
+  dai:
+    type: object
+    properties:
+      sound-dai:
+        maxItems: 1
+        $ref: /schemas/types.yaml#/definitions/phandle-array
+        description: phandle array of the codec or CPU DAI
+
+    required:
+      - sound-dai
+
+  unidirectional:
+    description: Specify direction of unidirectional dai link.
+                 0 for playback only. 1 for capture only.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+properties:
+  compatible:
+    contains:
+      enum:
+        - qcom,sc7180-sndcard
+
+  audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description: |-
+      A list of the connections between audio components. Each entry is a
+      pair of strings, the first being the connection's sink, the second
+      being the connection's source.
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: User specified audio sound card name
+
+patternProperties:
+  "^dai-link-[0-9]+$":
+    description: |
+      Each subnode represents a dai link. Subnodes of each dai links would be
+      cpu/codec dais.
+
+    type: object
+
+    properties:
+      link-name:
+        $ref: "#/definitions/link-name"
+
+      unidirectional:
+        $ref: "#/definitions/unidirectional"
+
+      cpu:
+        $ref: "#/definitions/dai"
+
+      codec:
+        $ref: "#/definitions/dai"
+
+    required:
+      - link-name
+      - cpu
+      - codec
+
+    additionalProperties: false
+
+examples:
+
+  - |
+    snd {
+        compatible = "qcom,sc7180-sndcard";
+        model = "sc7180-snd-card";
+
+        pinctrl-names = "default";
+        pinctrl-0 = <&sec_mi2s_active &sec_mi2s_dout_active
+                     &sec_mi2s_ws_active &pri_mi2s_active
+                     &pri_mi2s_dout_active &pri_mi2s_ws_active
+                     &pri_mi2s_din_active &pri_mi2s_mclk_active>;
+
+        audio-routing =
+                    "Headphone Jack", "HPOL",
+                    "Headphone Jack", "HPOR";
+
+        dai-link-0 {
+            link-name = "MultiMedia0";
+            cpu {
+                sound-dai = <&lpass_cpu 0>;
+            };
+
+            codec {
+                sound-dai = <&alc5682 0>;
+            };
+        };
+
+        dai-link-1 {
+            link-name = "MultiMedia1";
+            unidirectional = <0>;
+            cpu {
+                sound-dai = <&lpass_cpu 1>;
+            };
+
+            codec {
+                sound-dai = <&max98357a>;
+            };
+        };
+    };
-- 
2.28.0.rc0.105.gf9edc3c819-goog

