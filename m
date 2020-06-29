Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0D3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 03:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C75BC2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 03:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="BdUD0E9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgF2DTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 23:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgF2DTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 23:19:22 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0AFC03E979
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 20:19:22 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x11so6533318plo.7
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 20:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4gesZ5upNg1RXGV/+lsgDtY0V75yfGqbAiiX0yLwNx4=;
        b=BdUD0E9cKnyJ7Y9hR0Vq3aPCNKewnQ2Js53WXLo+6SZnpnJdSdZBIYxR+Wjpo4nm5K
         AM70NnBzh9OFB3A2gwqYkialyyDojP8OVK5waMNQ/eTNM0WLROYfTMGzlsIHj54+rMan
         f162dXgnLJLqtEkX6yxZEg/54dwBDW1APP3OSFe+/0WuCYUbGjITNqaRFl7FV8W+afF7
         onoXDeeps26ev/oo3URcZSpbmNF9Se1jOAQLNKbp825xoig1e7UYMH3vQWsEWu1P5tMf
         Z0fv5D3TmLOGd2Q4O5l8JGayoIKOPMI59ccmUIRNiMo/ckusEAKHmuXCW8laQfBuSFml
         SzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4gesZ5upNg1RXGV/+lsgDtY0V75yfGqbAiiX0yLwNx4=;
        b=MlxvmoN79WG2MVlFEsXHQDISvDiKstjjgoqj/Uki3JX0lzXq+//x9Vm/yiAbN1nfwo
         RJnW9f6yMqtjVn04LMLe+cL2oEAaW3PI4M2qFuhm+EDpK5flHYEzhNsMx+KyehR1bY/R
         KCvR+gv0huSF4FNWuMSZmiiq9Pt6o6GNEAcgY26JfYAElMoegAvBfb9CjS/I5+v3dE1d
         c3I7E3b23PwFnV8yRScPrlMwWgMZEpnP4cm2M9RSd/bkZ6G1uih4jP0GqEGaMHoTO7KN
         8kqMfsgppWmZLi4ooU5M8RwPH2m6fFkGP9j4JvQsIx2FyX+5WhLgdmcbLgjkKPhTorGS
         g+5w==
X-Gm-Message-State: AOAM531WWgi5Cjw37f9rs3wsWwXdHyokLj8FqR07GoV2PhQkxhOGhsxV
        JIM256MQFtvJCi8swN8HlX5P/Q==
X-Google-Smtp-Source: ABdhPJw9NOcGyEy15wvZwxgMiqsbkeu2tq5+8bkmoxxAIUG8hgbFC2uVA5ccwNjveIJBppI+Df3gdw==
X-Received: by 2002:a17:90a:d809:: with SMTP id a9mr1580326pjv.40.1593400762094;
        Sun, 28 Jun 2020 20:19:22 -0700 (PDT)
Received: from hsinchu02.internal.sifive.com (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
        by smtp.gmail.com with ESMTPSA id j70sm12876254pfd.208.2020.06.28.20.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 20:19:21 -0700 (PDT)
From:   Zong Li <zong.li@sifive.com>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Zong Li <zong.li@sifive.com>
Subject: [RFC PATCH 1/6] dt-bindings: riscv: Add YAML documentation for PMU
Date:   Mon, 29 Jun 2020 11:19:10 +0800
Message-Id: <3de3a480517d167a3faae086aa8ab0c0c7141d99.1593397455.git.zong.li@sifive.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1593397455.git.zong.li@sifive.com>
References: <cover.1593397455.git.zong.li@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for performance monitor unit. And it passes the
dt_binding_check verification.

Signed-off-by: Zong Li <zong.li@sifive.com>
---
 .../devicetree/bindings/riscv/pmu.yaml        | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/pmu.yaml

diff --git a/Documentation/devicetree/bindings/riscv/pmu.yaml b/Documentation/devicetree/bindings/riscv/pmu.yaml
new file mode 100644
index 000000000000..f55ccbc6c685
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/pmu.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/pmu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RISC-V Performance Monitor Units
+
+maintainers:
+  - Zong Li <zong.li@sifive.com>
+  - Paul Walmsley <paul.walmsley@sifive.com>
+  - Palmer Dabbelt <palmer@dabbelt.com>
+
+properties:
+  compatible:
+    items:
+      - const: riscv,pmu
+
+  riscv,width-base-cntr:
+    description: The width of cycle and instret CSRs.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  riscv,width-event-cntr:
+    description: The width of hpmcounter CSRs.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  riscv,n-event-cntr:
+    description: The number of hpmcounter CSRs.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  riscv,hw-event-map:
+    description: The mapping of generic hardware events. Default is no mapping.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+  riscv,hw-cache-event-map:
+    description: The mapping of generic hardware cache events.
+      Default is no mapping.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+
+required:
+  - compatible
+  - riscv,width-base-cntr
+  - riscv,width-event-cntr
+  - riscv,n-event-cntr
+
+additionalProperties: false
+
+examples:
+  - |
+    pmu {
+      compatible = "riscv,pmu";
+      riscv,width-base-cntr = <64>;
+      riscv,width-event-cntr = <40>;
+      riscv,n-event-cntr = <2>;
+      riscv,hw-event-map = <0x0 0x0 0x1 0x1 0x3 0x0202 0x4 0x4000>;
+      riscv,hw-cache-event-map = <0x010201 0x0102 0x010204 0x0802>;
+    };
+
+...
-- 
2.27.0

