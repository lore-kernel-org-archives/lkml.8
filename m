Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F318C433ED
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D18220714
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ki3xZi7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgGUKor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbgGUKoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:44:44 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EE3C0619D9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:44:44 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id j19so11743499pgm.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2odOJ5ld037Ng0df9XqmYUK1fIoK1GsBG35/G24WS/o=;
        b=Ki3xZi7cltDdamWKK6yyYHgCHagJybv12qvc9ZLtA09hcw9JQPQVWucr6JsdLpow+T
         ZUq1jipbkwMV79dw6G2zeLoz34M9tqRKhpRJ+VAxnePkq4IOV6rIquLTZj/UdlHi3XzE
         YZS5prl4V8wJmJj3o8jYKm0cNPYhEoGV6hkOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2odOJ5ld037Ng0df9XqmYUK1fIoK1GsBG35/G24WS/o=;
        b=MzNhjgICrdlMfQY+pTtGyt4EiEVMr4501Dd7Mi07nVQ1f5mf4bLrzNggGG8rKcZjNS
         ZS+BAs+saAK8NxuQ8eUfSjrrb1hZDCdDo7cmTKUBnuRSebAhIzMq7lk+9SFPE4etVqme
         5no08YaWg+bEHz67Vd32GhGm0SgCQlh8q69KF1OAL51FCsLG13TPWlgg4hLdtKVxiskB
         wqtdXnHO/BcoM3cxHgdmwDl+TvSrOYhAGre1QuuazD7wmflUj1HFRY0mIADwJRiHVKUU
         itJmHJtK2HNG2ATYXnQ1Q57jUjHATKXy60fo0/I1pUm1iRBkJ+yq9/CujfQ1SaJgBWER
         k3rw==
X-Gm-Message-State: AOAM533Xss5aBOhixfdYe1OcuFReUOMko2fTBCh2cfS/flfz3oTMcC+t
        8XCRoXOECEdAcKKsUA/L3J5qy3E5QKLdgQ==
X-Google-Smtp-Source: ABdhPJzGVK040lYlN453Qd3xUhg6ZkL4HAMLKyhTwFwuECikRWPUZBomPLIYQ3rT3xo4dUQiLV4nug==
X-Received: by 2002:a63:be47:: with SMTP id g7mr21960494pgo.7.1595328283477;
        Tue, 21 Jul 2020 03:44:43 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:de4a:3eff:fe7d:d39c])
        by smtp.gmail.com with ESMTPSA id cv7sm2666110pjb.9.2020.07.21.03.44.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 03:44:42 -0700 (PDT)
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
Subject: [PATCH v2 1/2] ASoC: qcom: dt-bindings: Add sc7180 machine bindings
Date:   Tue, 21 Jul 2020 18:44:21 +0800
Message-Id: <20200721104422.369368-2-cychiang@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
In-Reply-To: <20200721104422.369368-1-cychiang@chromium.org>
References: <20200721104422.369368-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings documentation file for sc7180 sound card.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 .../bindings/sound/qcom,sc7180.yaml           | 130 ++++++++++++++++++
 1 file changed, 130 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
new file mode 100644
index 000000000000..82f9483276eb
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
@@ -0,0 +1,130 @@
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
+description:
+  This binding describes the SC7180 sound card which uses LPASS for audio.
+
+definitions:
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
+properties:
+  compatible:
+    contains:
+      const: qcom,sc7180-sndcard
+
+  audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description:
+      A list of the connections between audio components. Each entry is a
+      pair of strings, the first being the connection's sink, the second
+      being the connection's source.
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: User specified audio sound card name
+
+  aux-dev:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle of the codec for headset detection
+
+patternProperties:
+  "^dai-link(@[0-9]+)?$":
+    description:
+      Each subnode represents a dai link. Subnodes of each dai links would be
+      cpu/codec dais.
+
+    type: object
+
+    properties:
+      link-name:
+        description: Indicates dai-link name and PCM stream name.
+        $ref: /schemas/types.yaml#/definitions/string
+        maxItems: 1
+
+      reg:
+        description: dai link address.
+        $ref: /schemas/types.yaml#/definitions/uint32
+        maxItems: 1
+
+      playback-only:
+        description: Specify that the dai link is only for playback.
+        $ref: /schemas/types.yaml#/definitions/flag
+
+      capture-only:
+        description: Specify that the dai link is only for capture.
+        $ref: /schemas/types.yaml#/definitions/flag
+
+      cpu:
+        $ref: "#/definitions/dai"
+
+      codec:
+        $ref: "#/definitions/dai"
+
+    required:
+      - link-name
+      - reg
+      - cpu
+      - codec
+
+    additionalProperties: false
+
+examples:
+
+  - |
+    sound {
+        compatible = "qcom,sc7180-sndcard";
+        model = "sc7180-snd-card";
+
+        audio-routing =
+                    "Headphone Jack", "HPOL",
+                    "Headphone Jack", "HPOR";
+
+        aux-dev = <&alc5682>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dai-link@0 {
+            reg = <0>;
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
+        dai-link@1 {
+            reg = <1>;
+            link-name = "MultiMedia1";
+            playback-only;
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

