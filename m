Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AB9C352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB4CC2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="S+K/4POx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2632906AbgDNUPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2632874AbgDNUPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:15:31 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB0AC0610D5;
        Tue, 14 Apr 2020 13:15:30 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j2so16051911wrs.9;
        Tue, 14 Apr 2020 13:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hgI4BrhRzwo1MiGrMwLDXDTrl4Dmoe1307hvr9odN8Q=;
        b=S+K/4POxBnzMHicOhDPjATbCVv9zh8IupE/lRJLSrzjANxjo0OVF1P2t3JtDPB0UUc
         jLnB9CO20GCHpKD4YvU9bvKWpBT1AbakItdUXf/o1GGIDRO9KU+0mzw+4K7rHlG9qNbo
         hHtrzr3gJBFEvXCZG/YCiMr+MakvAH1kwSejcMrHobw6rdYr5gnPgcSz8aDg/pQzYTYM
         2YZDdu7hoUXk7aOC9v6EHihwnViZDcGfvms9R3MFV5Vx1x54Bksb3Vq0ftQqkp7y+iPN
         OoceKkiHZDNa+eX7p7L8ExfHyhX5stXHCxbn3d/BCw2AcaP8Zflxj1z6bMbPiz1MBcm9
         pV0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hgI4BrhRzwo1MiGrMwLDXDTrl4Dmoe1307hvr9odN8Q=;
        b=WKzHAvPKgZiiKq6D+D2r9hS261UkVv2BQMLO84qawn1H5OcZSbbWfTR3PtcvBSySar
         JoQNwVVna/0G5xPmkqxpz9C88poQtyOpi37gwPIgxxgfwdVCbN1qEDqG9gwvkgSKbvS2
         eYngj0uOzmdUaAd/xDbBXraWUtjf8SczyDyGPqFL0+EJmqTz3Wo/HOa9yUETN7Z/VP+R
         9GJlJ+4oCwJATh+FLQ3XQlsBAGHudIdpSl4SFx3O0QzWhxlyQxpB92Y7XBnxLpRUwSPs
         aGKdoCQmbecRYjDH1hghXiVGiKAEO2jDZusN3t37yz+0UVqRVBZiEBrMprH9sZg/dWGi
         Iinw==
X-Gm-Message-State: AGi0PuYKs7QGnCnTDcjb/t21Mdk87TliobzD1bLtgOqUQYqX8sdTkY+r
        YK0NycMYsvqft1hOxwXnoEQ=
X-Google-Smtp-Source: APiQypJSn3teWPYCLKE3B3vLZOyI+srye9W6W5AID45Tz+dhtJPjxcLZfhHDVMJ26884KuX8bPuvjQ==
X-Received: by 2002:adf:fecd:: with SMTP id q13mr17184706wrs.12.1586895329459;
        Tue, 14 Apr 2020 13:15:29 -0700 (PDT)
Received: from localhost.localdomain (p200300F13717DF00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3717:df00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id u17sm22537467wra.63.2020.04.14.13.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:15:29 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     robh+dt@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH RFC v1 2/4] dt-bindings: power: meson-ee-pwrc: add support for the Meson GX SoCs
Date:   Tue, 14 Apr 2020 22:14:55 +0200
Message-Id: <20200414201457.229131-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200414201457.229131-1-martin.blumenstingl@googlemail.com>
References: <20200414201457.229131-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power domains on the GX SoCs are very similar to G12A. The only
known differences so far are:
- The GX SoCs do not have the HHI_VPU_MEM_PD_REG2 register (for the
  VPU power-domain)
- The GX SoCs have an additional reset line called "dvin"

Add a new compatible string and adjust the reset line expectations for
these SoCs.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../bindings/power/amlogic,meson-ee-pwrc.yaml | 27 +++++++++++++++++++
 include/dt-bindings/power/meson-gxbb-power.h  | 13 +++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 include/dt-bindings/power/meson-gxbb-power.h

diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
index a0e4cf143b9c..15a29ed19327 100644
--- a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
@@ -26,6 +26,7 @@ properties:
       - amlogic,meson8-pwrc
       - amlogic,meson8b-pwrc
       - amlogic,meson8m2-pwrc
+      - amlogic,meson-gxbb-pwrc
       - amlogic,meson-g12a-pwrc
       - amlogic,meson-sm1-pwrc
 
@@ -42,6 +43,7 @@ properties:
 
   resets:
     minItems: 11
+    maxItems: 12
 
   "#power-domain-cells":
     const: 1
@@ -77,6 +79,31 @@ allOf:
         - resets
         - reset-names
 
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson-gxbb-pwrc
+    then:
+      properties:
+        reset-names:
+          items:
+            - const: viu
+            - const: venc
+            - const: vcbus
+            - const: bt656
+            - const: dvin
+            - const: rdma
+            - const: venci
+            - const: vencp
+            - const: vdac
+            - const: vdi6
+            - const: vencl
+            - const: vid_lock
+      required:
+        - resets
+        - reset-names
+
   - if:
       properties:
         compatible:
diff --git a/include/dt-bindings/power/meson-gxbb-power.h b/include/dt-bindings/power/meson-gxbb-power.h
new file mode 100644
index 000000000000..57ab38dcb6bb
--- /dev/null
+++ b/include/dt-bindings/power/meson-gxbb-power.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+/*
+ * Copyright (c) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#ifndef _DT_BINDINGS_MESON_GXBB_POWER_H
+#define _DT_BINDINGS_MESON_GXBB_POWER_H
+
+#define PWRC_GXBB_VPU_ID		0
+#define PWRC_GXBB_ETH_ID		1
+
+#endif
-- 
2.26.0

