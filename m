Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF43C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B28E20C09
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G2U+xauh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgIGKBr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbgIGKBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:01:04 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8EFC061575
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 03:01:04 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z15so4266853plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 03:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZtBzFsLnQlADUQhDYi9AZbvuBk6CQQ/iUSZHP9znWeA=;
        b=G2U+xauhwOUIg1+sfdCC9aGNcSvglEqkkMBh6DCjmfq58K/T2d7rJA9Cm3fcyMxHva
         FZL7nTTT0HKvp2iSqi9GycSU1R25JyFScUE8CIwwhjboY6mUfSUEWHlrUwFy4jp08xOP
         rLUPwbwHtsSqUQcR+GUR0uUTwxIaBGbGCdHzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZtBzFsLnQlADUQhDYi9AZbvuBk6CQQ/iUSZHP9znWeA=;
        b=ecL4rF1xG+G3iOxMFL2OQVcHhlqxpkDMcJA2Eys4f18GDwCssgGYIbJgSVk68mtPbu
         cEBBveXCdRevabnDRnkRzvVVKMmVggW5qMB/qG2uDea/LSYjdUyCYy/wIsAp2I52Lc0+
         ZtSo7rw0+AZ5+MK/h7wM8Sbfj4LLN/80S2m8S/5UDqZxrftLbsJZ0ulNsP9tGZJ/+WQv
         2t5c11gDT+dRZ+NaOyUx0GhsRfBqJINlVTT2VPV2G0EX19shRmoEsilvE1xTH0Srj2C7
         lCPOUYdCEc72Xpk1w3QmnDbKcwmTt09uoCPxkVpbqrJBfcxdMpzcmWdgEP3lfDPNcGBP
         CEaQ==
X-Gm-Message-State: AOAM532AOiVsJUST+PI6ia5u7fohZk0lN4UgcLyOpHQGe6G6Va7fmQMK
        s9M8RGQmfph449qwEd4X+l/+p/ZUf5db6IDn
X-Google-Smtp-Source: ABdhPJy9M8TMIRsRKfrSjFR15RkH+UCAIyZCO0fegGFdbr591p5xjKjo7GRykgUpbZfQWpn/LAH21A==
X-Received: by 2002:a17:90a:fa8b:: with SMTP id cu11mr18268777pjb.10.1599472863741;
        Mon, 07 Sep 2020 03:01:03 -0700 (PDT)
Received: from localhost ([2401:fa00:1:10:de4a:3eff:fe7d:d39c])
        by smtp.gmail.com with ESMTPSA id k4sm11907489pjl.10.2020.09.07.03.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 03:01:03 -0700 (PDT)
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
        Takashi Iwai <tiwai@suse.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>, dianders@chromium.org,
        dgreid@chromium.org, tzungbi@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Cheng-Yi Chiang <cychiang@chromium.org>
Subject: [PATCH v7 2/3] ASoC: qcom: dt-bindings: Add sc7180 machine bindings
Date:   Mon,  7 Sep 2020 18:00:38 +0800
Message-Id: <20200907100039.1731457-3-cychiang@chromium.org>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
In-Reply-To: <20200907100039.1731457-1-cychiang@chromium.org>
References: <20200907100039.1731457-1-cychiang@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree bindings documentation file for sc7180 sound card.

Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
---
 .../bindings/sound/qcom,sc7180.yaml           | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
new file mode 100644
index 000000000000..ae809346ca80
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
@@ -0,0 +1,143 @@
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
+properties:
+  compatible:
+    const: qcom,sc7180-sndcard
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
+  headset-jack:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle of the codec for headset detection
+
+  hdmi-jack:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle of the codec for hdmi jack detection
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^dai-link(@[0-9])?$":
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
+
+      cpu:
+        description: Holds subnode which indicates cpu dai.
+        type: object
+        properties:
+          sound-dai: true
+
+      codec:
+        description: Holds subnode which indicates codec dai.
+        type: object
+        properties:
+          sound-dai: true
+
+    required:
+      - link-name
+      - cpu
+      - codec
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - model
+  - headset-jack
+  - hdmi-jack
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
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
+        headset-jack = <&alc5682>;
+        hdmi-jack = <&msm_dp>;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dai-link@0 {
+            link-name = "MultiMedia0";
+            reg = <0>;
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
+            link-name = "MultiMedia1";
+            reg = <1>;
+            cpu {
+                sound-dai = <&lpass_cpu 1>;
+            };
+
+            codec {
+                sound-dai = <&max98357a>;
+            };
+        };
+
+        dai-link@2 {
+            link-name = "MultiMedia2";
+            reg = <2>;
+            cpu {
+                sound-dai = <&lpass_hdmi 0>;
+            };
+
+            codec {
+                sound-dai = <&msm_dp>;
+            };
+        };
+    };
-- 
2.28.0.526.ge36021eeef-goog

