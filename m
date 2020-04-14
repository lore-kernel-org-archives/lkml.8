Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0CCC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB2122076A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LtG3c6OT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633240AbgDNUgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633228AbgDNUgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:36:14 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19BBC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:36:12 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id i75so1053650ild.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/yoLZC4PI65ZGQO7pW9Hb3YwwOms2B6BK6ifzFp64c0=;
        b=LtG3c6OTD3OQNgT820KWIN5mGjhNfSrU75MGoulp68wDO+KMpCSQYj0MxjpS181n9I
         FccXjTZlGDkTZJUz/NTjjWQWZoAPLwV7asCXoDKKeE3jxesWOReZxdEuTgknxsc5s/iM
         2diVR0JnTfAKvWlrzgFsFC+QjRDcvygpO+aRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/yoLZC4PI65ZGQO7pW9Hb3YwwOms2B6BK6ifzFp64c0=;
        b=eMZVLO8ztY9oeRVjIEf24EH/GqASv8dwY9NoK5UhatiZCaB9/h6jcMy1n4MnebvWDb
         n4q6oRA3n4FjA1l+MoAIsXhS9ofygaRBUx4bLxMQWGfcqkJeIloD6FR4towqqpoJPvt1
         LeK5cZlOp2++2FjN9UJE0wEfv3QvGqK4f4lAJIYxKJlvle+a63jNMiZsXyaIsEmRMBfD
         QMQNmQSj37YJPHIaNqNlf6cU+EhcGLPLn4Rt9+R1h9oU4vDxeJ+0uQRgTv4iXbW0VONV
         HSK2rcO5JWhUfJny1x+Lkf+CGeUwBr6qyMwiiv9H578YKZL+398oUyX/yGTamgONnjoE
         wsCg==
X-Gm-Message-State: AGi0PuY/PO91KNw1i43uW/kT01lvN9SXIwITmBeEUFnmnS5z3PXjNZ3e
        7/ak56FsA/0li00aRvJPEKK1L5TbkdE=
X-Google-Smtp-Source: APiQypKtKt93EXLNjXJXIvv6HGtk6C4GYtQ9sbKVz4bTqmtFJsbm0dKIGaQ9U2kvDDiJpoD/Qz6qwA==
X-Received: by 2002:a92:760f:: with SMTP id r15mr2189093ilc.202.1586896571990;
        Tue, 14 Apr 2020 13:36:11 -0700 (PDT)
Received: from derch.Home (97-122-91-129.hlrn.qwest.net. [97.122.91.129])
        by smtp.gmail.com with ESMTPSA id x10sm5396027ili.88.2020.04.14.13.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:36:11 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH v10 1/2] dt-bindings: iio: Add bindings for sx9310 sensor
Date:   Tue, 14 Apr 2020 14:36:07 -0600
Message-Id: <20200414143536.v10.1.I30e2a8ff8cc4ad1ffb65df09ad933e5b4d9f16f8@changeid>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds device tree bandings for sx9310 sensor.

Signed-off-by: Daniel Campello <campello@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v10: None
Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2:
 - Added power-supply
 - Changed to dual license

 .../iio/proximity/semtech,sx9310.yaml         | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
new file mode 100644
index 00000000000000..b52ffdac678b54
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
@@ -0,0 +1,56 @@
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
+  power-supply: true
+
+required:
+  - compatible
+  - reg
+  - power-supply
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
+        power-supply = <...>;
+      };
+    };
-- 
2.26.0.110.g2183baf09c-goog

