Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C99FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CEAA206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 13:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXcf6ZXO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbgEVNby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 09:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729367AbgEVNby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 09:31:54 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F3DC061A0E;
        Fri, 22 May 2020 06:31:54 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u22so4378166plq.12;
        Fri, 22 May 2020 06:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fIP5XgLNH8pQd/AT+lCYKyHiYHAS6BGBNzZ5yozZhZ0=;
        b=HXcf6ZXOabHaWhWWiBKy1SEjM5KKFbiHktOCs6UpJOsdHEQw86gLtsnxG1mj1Hmqq7
         ASQpWbDHKzp4r8oS6ZOIIZo/IycsomCm5iRIWEpxMoDU5wJJOXNcVcKo5mFnzzIEotx/
         T6uZXfnP2/Z0ldHFKw7qWPI6+6HtlJkP2yRqChHzEuYpa1AajOsYIdkycWjkKaz6GUfZ
         685rdsXYbb7PA9b0zS3aEdA3gzglOt45FeqLZmS/MEhjfhVHhCDWiPCzzFcAVqUXQlCG
         2WcAzYVmD8z8qEcV94HIkoAtQUh2aYtCJ2Mr2UPmaGTOYkd078NXQBygTIky717HHv+9
         FpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fIP5XgLNH8pQd/AT+lCYKyHiYHAS6BGBNzZ5yozZhZ0=;
        b=RathOnKM2pRWmxjlGjLiJQ/bqg7E6cSSJEWbW1a2b6YJdDuuKdxgjtDiFwMYyLphnS
         v6O2VZ7ArvmzJJT6CpRePMyBZHgbgjwH4AGJWAPR2ygu1lowyH4L01kv648wUz1Ju3TO
         N/JWaV6GnkAQ7/4AIw0k0J1ycLuDLT25B9DTE1COaSiaDpNGSgG+FzOYMF7XsG+HcYYr
         STyeUZH3G3t2DNi5cZ+lRPEVniSp1IWTLQ0BkRipnLqoXdFTHkZNnCwS53WaZHYfrQWs
         S/5EKJ8wIKA7q8aq0uHeWtkH/i8C7FUTihX9vBYxpydlC793wc0FHOwj1QBiwJFaBSin
         PIsw==
X-Gm-Message-State: AOAM533YKasvqeteuaO0c6IsTJWAcE0RnVbIFdCE5b2bRPh5SFAbmLNM
        wZ2UuhYsXwZqWAICznDzYAKFCiZc
X-Google-Smtp-Source: ABdhPJxxegpbhEmta8ZCz6dKfvWPO/4qUjiovSmBDzZfUPENTctCBSEEGmfUrxmMkUTsSubpd4hJeQ==
X-Received: by 2002:a17:902:a414:: with SMTP id p20mr15222856plq.333.1590154298234;
        Fri, 22 May 2020 06:31:38 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.16])
        by smtp.gmail.com with ESMTPSA id c14sm6753132pfp.122.2020.05.22.06.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 06:31:37 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     robh+dt@kernel.org, jassisinghbrar@gmail.com
Cc:     orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: mailbox: Add the Spreadtrum mailbox documentation
Date:   Fri, 22 May 2020 21:31:08 +0800
Message-Id: <8d29eba045ef18c5489e122b3668afc20431f15d.1590153779.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Baolin Wang <baolin.wang@unisoc.com>

Add the Spreadtrum mailbox documentation.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Baolin Wang <baolin.wang@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
Changes from v4:
 -None.

Changes from v3:
 - None.

Changes from v2:
 - Add reviewed tag from Rob.
 - Remove redundant 'minItems'.

Changes from v1:
 - Add 'additionalProperties'.
 - Split description for each entry.
---
 .../bindings/mailbox/sprd-mailbox.yaml        | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml

diff --git a/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
new file mode 100644
index 000000000000..0f7451b42d7e
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/sprd-mailbox.yaml
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/mailbox/sprd-mailbox.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Spreadtrum mailbox controller bindings
+
+maintainers:
+  - Orson Zhai <orsonzhai@gmail.com>
+  - Baolin Wang <baolin.wang7@gmail.com>
+  - Chunyan Zhang <zhang.lyra@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - sprd,sc9860-mailbox
+
+  reg:
+    items:
+      - description: inbox registers' base address
+      - description: outbox registers' base address
+
+  interrupts:
+    items:
+      - description: inbox interrupt
+      - description: outbox interrupt
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: enable
+
+  "#mbox-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - "#mbox-cells"
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    mailbox: mailbox@400a0000 {
+      compatible = "sprd,sc9860-mailbox";
+      reg = <0 0x400a0000 0 0x8000>, <0 0x400a8000 0 0x8000>;
+      #mbox-cells = <1>;
+      clock-names = "enable";
+      clocks = <&aon_gate 53>;
+      interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>, <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
+    };
+...
-- 
2.17.1

