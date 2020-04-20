Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2012AC54FCF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:26:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC79B20782
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="cLwjk5gq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgDTU05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:26:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbgDTU02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:26:28 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835A5C061A0C;
        Mon, 20 Apr 2020 13:26:26 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j2so13816459wrs.9;
        Mon, 20 Apr 2020 13:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=12hs4YLLCufVbSpoUu4zR/3+gNwt68TorMhibZvZWLI=;
        b=cLwjk5gqfhFP7XPc1WTOJKTsNbecnTPqX7BZorzhQAg+pGMcma2NIF7vDGD6OLnhb3
         kYIWZLIh8xTS/cbAjhOkApRLFzkhx5oNHtd2x9YTNUcdqVbS/j7A09nqgn34DBbWg28U
         cWNP8XHg0MfFocJqZUhhsHczYEBPSAbxfXcFNd7rYrKSoMUkGzy7HFQFNQE8yIyUqYmb
         Und6o2PeAQunIOOkDlR3Cf9JjZyIIdntNtjRxE02ibMKNFtVjBFfMkNO9UnKB6/LwI9Q
         qHwI3NjljnCDVqHWfECRKx54pYAhow0B/++S6dLfm1p8t9Jhcgq1sh6Y0TIPnKH8YiFQ
         OToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=12hs4YLLCufVbSpoUu4zR/3+gNwt68TorMhibZvZWLI=;
        b=l98Omdf6WufLA4saTvroBeo8TKD99NYjgxhv6Ms5w2Oms4tIM2EIOxLl62993e3E3s
         6/hH2KvTPZ8eJGHMnTPVfLUSqKShFWITWFJcfvkY/gqc7F5Y+S5kup1vVJ1FwY5ZS+Ta
         K+U2CMyQ6EynYCV02++s/clMNgijt0LVbvccHhYgEV/2ImFjp9v7YNRDN10mH3ZPSTej
         G1qGk7yJe4S3RLnraDDrhgDgTbolek+h6HFHj1ZMF95OddI2F087pXyvgb2EWICyjSPc
         Art5uBG73Rrb5im3qyMn0G4Ab4xLtSATLa2qStUHTtBmAvvLVrJuT6Ne0n6+zCpqalv0
         yU4A==
X-Gm-Message-State: AGi0Pub4MAgA0nUppjGHyXzQy19fegh1B1S3r5W71m8SuLIFLoGnY3sE
        /OMwBOZqDzGEbhfmcsrrl/o=
X-Google-Smtp-Source: APiQypKKfwCx2uMlD9ZjYrFIfLIMZf8tt0ML84Nh+6zg9axz/9K0LeqvQFCtGnXvrkjHchIFlICq5g==
X-Received: by 2002:a5d:4748:: with SMTP id o8mr20225311wrs.422.1587414385151;
        Mon, 20 Apr 2020 13:26:25 -0700 (PDT)
Received: from localhost.localdomain (p200300F137142E00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:f1:3714:2e00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id l19sm657846wmj.14.2020.04.20.13.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 13:26:24 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     robh+dt@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 2/4] dt-bindings: power: meson-ee-pwrc: add support for the Meson GX SoCs
Date:   Mon, 20 Apr 2020 22:26:10 +0200
Message-Id: <20200420202612.369370-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200420202612.369370-1-martin.blumenstingl@googlemail.com>
References: <20200420202612.369370-1-martin.blumenstingl@googlemail.com>
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
 .../bindings/power/amlogic,meson-ee-pwrc.yaml | 28 +++++++++++++++++++
 include/dt-bindings/power/meson-gxbb-power.h  | 13 +++++++++
 2 files changed, 41 insertions(+)
 create mode 100644 include/dt-bindings/power/meson-gxbb-power.h

diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
index 2a1c933ae434..51a6fac892e3 100644
--- a/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
+++ b/Documentation/devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml
@@ -26,6 +26,7 @@ properties:
       - amlogic,meson8-pwrc
       - amlogic,meson8b-pwrc
       - amlogic,meson8m2-pwrc
+      - amlogic,meson-gxbb-pwrc
       - amlogic,meson-g12a-pwrc
       - amlogic,meson-sm1-pwrc
 
@@ -42,9 +43,11 @@ properties:
 
   resets:
     minItems: 11
+    maxItems: 12
 
   reset-names:
     minItems: 11
+    maxItems: 12
 
   "#power-domain-cells":
     const: 1
@@ -80,6 +83,31 @@ allOf:
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
index 000000000000..1262dac696c0
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
+#define PWRC_GXBB_ETHERNET_MEM_ID	1
+
+#endif
-- 
2.26.1

