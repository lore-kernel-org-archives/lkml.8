Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BC5C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CF3620705
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVKlAInB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgEDTkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725956AbgEDTkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:40:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A893FC061A0E;
        Mon,  4 May 2020 12:40:07 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k1so470151wro.12;
        Mon, 04 May 2020 12:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hEW76UZB/sZtEFwmy764PGyYDv4AC7eZ6iGbT8XBec0=;
        b=sVKlAInB9QaiGr8TxrDwVwGVUTMk3Z2sanuBv38O6D7p5wDtfW4OTPur0/IqpcUlFU
         k2HH34g5fWr6DkHSmByla0c2aSeqrAJ3pjufHlf4EhwUZFb26j4GM7c4K9vIc1sWEKv3
         ru1D26JuI3qPR9ITDCBTxONyYXPeKHCagzRRoKl95IYfpopUPoKm0lc6UC2eX3RtgWsK
         /NG29twXUdSZ7qQobLBM6MRFaOdoKV5s2llvFFFe2fulgMYe5E/FXpK6nDTSLSDylxgs
         FlDk/TpcItC2FWJ18TEsMfi0kUh+L8tIXYr/QLtZOmRbM1mVzMLq19Ru2tJLheZffZNv
         RVZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hEW76UZB/sZtEFwmy764PGyYDv4AC7eZ6iGbT8XBec0=;
        b=JALM/kr7s8tWsGAe3Qni1+RWB9A+pyEI4O8ILmDf6oEQrSj/fhkOOkzGlJq89TNnKk
         FvrCfBj/EW+fYfE1/wmBGXyLDzPmXCt5GV7j6VWrpRE+NlJI/qPjCjnrsZQwXVOTb2ZX
         tvnCCKJ+jd38IuC5BDRVDoxIaHZ/twZHJjreZnz8WQfMel1u1ioLXJer+smsO12MSWW/
         6QoK4HSdN8VgcfEXK/phMxCn4JuwQLJN85U3X9o523isHKvaRhPyWCo+hqkAT6WTS6+/
         jJO+vpeZHf47T+WA9FHY5jzKAz5aNLDulRL4zKvsieGUrV/c+bS+bOvPxV8SVdD9DMdj
         AjFw==
X-Gm-Message-State: AGi0PubbUw05AbvOWLcJkK/NGfOA9uDtPEFU2P1ixSB/5GU4v/qLXHZM
        y6bmGnx3RMudtgFdMNePh9k=
X-Google-Smtp-Source: APiQypIW3ogpPeWwO8fPmBAkiTyDt7oumahho6djwlkn0Hrgx03BjpfCvOGxXwqYYxpGHyc3gI9yOw==
X-Received: by 2002:a5d:628e:: with SMTP id k14mr1011368wru.390.1588621206417;
        Mon, 04 May 2020 12:40:06 -0700 (PDT)
Received: from localhost.localdomain (abag125.neoplus.adsl.tpnet.pl. [83.6.170.125])
        by smtp.googlemail.com with ESMTPSA id p7sm20631312wrf.31.2020.05.04.12.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:40:06 -0700 (PDT)
From:   Konrad Dybcio <konradybcio@gmail.com>
Cc:     Konrad Dybcio <konradybcio@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [v2 PATCH 2/2] dt-bindings: display: Document ASUS Z00T TM5P5 NT35596 panel compatible
Date:   Mon,  4 May 2020 21:38:14 +0200
Message-Id: <20200504193816.126299-3-konradybcio@gmail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200504193816.126299-1-konradybcio@gmail.com>
References: <20200504193816.126299-1-konradybcio@gmail.com>
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

