Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11A5BC433E3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2402B2086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DcZwLeIU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgHCXmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 19:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbgHCXmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:42:01 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082CEC061757
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 16:42:00 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id u126so3079970iod.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 16:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ySLfczwfPCSsE/wIMdBijYsg19z6IEGg8VtkjJac6SY=;
        b=DcZwLeIUcR1SxjgrjtGSRF0f2IaIwkE2cwYwmc4Wow/SeAyV4MiPpWcMB8TJ4eauEY
         vECMqzmfNeED0nATqni3SI8pI3puiGdsNq1GVvTO0Bj7MHYIgfiCJ8ddluTfnIG1OdBq
         1T+YRqoNReDpWeeUGSo52zs2v/cybiX1wnn14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ySLfczwfPCSsE/wIMdBijYsg19z6IEGg8VtkjJac6SY=;
        b=tyd3r8X7AiSkycnwpDKMegospoW2bLSHuglIW1yOfPrhcKn1NicUy4dVTm5mUH8h+C
         0u9cVQU+nVa1Wvs0nlR6lFogQwlJPT/Aa/CZAIbepIhQ1kpVvnq4VsJBmV4CyRynA14i
         /pa0YMStNgAbuuuYsqwT6IQukQ5UFB9OguYwtaTSw2+IAp9TQq+TEJH/BsUXnJ21MCpR
         R0ZywiyUz7lzqAenzbGGzCQsMwJ24+bcf/XdOBDb94TIrhH0OXJZZq6RGFKa44XK0C1E
         xJKG9j1RuAkIH187C4iv0XQWvhAOsv1MADVw9AOBIC1aGtxxV/snn2me/YTkv090XYFs
         CfNQ==
X-Gm-Message-State: AOAM532jrPfPk4twFrZLhPKdyQopt+GKFx46TDRkxRgZaFjIGiGXm5yY
        WV5uVyPNkWvJWbUdPIkJyMKbhA==
X-Google-Smtp-Source: ABdhPJzDGIe+hSIe7APq0Lc1WUsIPi4TvIWjSHUGZz5lkp3h7XL6rCOs1v64EAKNtBkCZCDJwqsRvA==
X-Received: by 2002:a05:6638:2689:: with SMTP id o9mr2591145jat.37.1596498120365;
        Mon, 03 Aug 2020 16:42:00 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id g2sm5468435ioe.4.2020.08.03.16.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:42:00 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH v4 01/15] dt-bindings: iio: Add bindings for sx9310 sensor
Date:   Mon,  3 Aug 2020 17:41:40 -0600
Message-Id: <20200803131544.v4.1.I0925046377211b8b6f06764857f03b4ab592bddb@changeid>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b6-goog
In-Reply-To: <20200803234154.320400-1-campello@chromium.org>
References: <20200803234154.320400-1-campello@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds device tree bindings for sx9310 sensor.

Signed-off-by: Daniel Campello <campello@chromium.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Rob Herring <robh+dt@kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
[swboyd@chromium.org: Add both regulators and make them optional]
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2:
 - Added #io-channel-cells as a required property

 .../iio/proximity/semtech,sx9310.yaml         | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
new file mode 100644
index 00000000000000..5739074d3592fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/semtech,sx9310.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Semtech's SX9310 capacitive proximity sensor
+
+maintainers:
+  - Daniel Campello <campello@chromium.org>
+
+description: |
+  Semtech's SX9310/SX9311 capacitive proximity/button solution.
+
+  Specifications about the devices can be found at:
+  https://www.semtech.com/products/smart-sensing/sar-sensors/sx9310
+
+properties:
+  compatible:
+    enum:
+      - semtech,sx9310
+      - semtech,sx9311
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      The sole interrupt generated by the device used to announce the
+      preceding reading request has finished and that data is
+      available or that a close/far proximity event has happened.
+    maxItems: 1
+
+  vdd-supply:
+    description: Main power supply
+
+  svdd-supply:
+    description: Host interface power supply
+
+  "#io-channel-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - "#io-channel-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      proximity@28 {
+        compatible = "semtech,sx9310";
+        reg = <0x28>;
+        interrupt-parent = <&pio>;
+        interrupts = <5 IRQ_TYPE_LEVEL_LOW 5>;
+        vdd-supply = <&pp3300_a>;
+        svdd-supply = <&pp1800_prox>;
+        #io-channel-cells = <1>;
+      };
+    };
-- 
2.28.0.163.g6104cc2f0b6-goog

