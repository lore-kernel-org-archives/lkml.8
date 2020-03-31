Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC03C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 12:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E880B20848
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 12:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rgtwhkzG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730649AbgCaMOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:14:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41360 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbgCaMOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 08:14:02 -0400
Received: by mail-wr1-f67.google.com with SMTP id h9so25589516wrc.8;
        Tue, 31 Mar 2020 05:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RaTwRr96LXp/hTXZkNHh+ephRC8ostasbFPkQNr4Hb8=;
        b=rgtwhkzGGRUXYxeH5bHrhNHBc+JNY4l8GMVg4YFEl5L/oeNrTK+SSQvLvLYuMs0BHU
         /pDfG/JQYKRApYpuFaeQy9dioDlkxtTiqMM1RHkwJs5DUoEAKpq1nHUD+2Eg622wyGqu
         KUUvLmJc8kAcsQl9D51OEqcaVKE6WU1Ie3+r9DhE+wJabKtrCaAaEXEk1KAaLNpIMnKc
         LkNokC22Zxi2QcQxaDKXzQJfzK0ls+pE2UY5xuRCNmULNT4TvWajX6TiB/dO4bSyGxdd
         FgAhD2+fcm+3CyUmxIYmRGemPJialzqSLq4ZUZ5K3SE8RZfeKzLFCUSPIIMFH6f75se3
         3pMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RaTwRr96LXp/hTXZkNHh+ephRC8ostasbFPkQNr4Hb8=;
        b=iVUlDg6+EjjNt230mWN2wyAuxrWtav3eIZkZH3W3Oh9RS5htTp+nv3wzMyiLQqmHH9
         9MCSVFi3QSwrTPKwHbtRm7YicxIWUZX5Uh6m80SVbU5B9LWlzhajMoA6KJKXV1BxogaA
         sApSsqywWquq2/IGRCMEw5RyjMSd1R8ULgrLCtRP7j0aBMm4feM0XIOii7kHqeuWlV6g
         KKMljuOGgmx3XM5u+76ZydhwbA1g6PHGyMbLgPLXfW2j9qS+zLUpUgL3ScsQVQEMsanj
         mn19U+01bw2pTZ3myiSNQWtxfuziVEwlb/zkj3fo+wtkyfOECKHeMzV1T69SGv+cwh2m
         aLNw==
X-Gm-Message-State: ANhLgQ0AACyB8sIeX4P+o3++C8Y5XpGGA46aYGxb2X1lCDLbYFIZAhHt
        crs7rmmlCTZhbQcmsa7bvbs=
X-Google-Smtp-Source: ADFU+vszFwYArrRRDeb7hvjW6c2dFE+s6oWpyrtFll1nJHKll+cyfkE5fWhk8+23o8wRsxRkmz8U1g==
X-Received: by 2002:adf:b1d8:: with SMTP id r24mr20580572wra.266.1585656839738;
        Tue, 31 Mar 2020 05:13:59 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 127sm3754936wmd.38.2020.03.31.05.13.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2020 05:13:59 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 1/2] dt-bindings: sram: convert rockchip-pmu-sram bindings to yaml
Date:   Tue, 31 Mar 2020 14:13:51 +0200
Message-Id: <20200331121352.3825-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current dts files with 'rockchip-pmu-sram' compatible nodes
are now verified with sram.yaml, although the original
text document still exists. Merge rockchip-pmu-sram.txt
with sram.yaml by adding it as description with an example.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Not tested with hardware.

Changes v3:
  Document the compatible

Changed v2:
  Merge with sram.yaml
---
 .../devicetree/bindings/sram/rockchip-pmu-sram.txt       | 16 ----------------
 Documentation/devicetree/bindings/sram/sram.yaml         | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 16 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt

diff --git a/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt b/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt
deleted file mode 100644
index 6b42fda30..000000000
--- a/Documentation/devicetree/bindings/sram/rockchip-pmu-sram.txt
+++ /dev/null
@@ -1,16 +0,0 @@
-Rockchip SRAM for pmu:
-------------------------------
-
-The sram of pmu is used to store the function of resume from maskrom(the 1st
-level loader). This is a common use of the "pmu-sram" because it keeps power
-even in low power states in the system.
-
-Required node properties:
-- compatible : should be "rockchip,rk3288-pmu-sram"
-- reg : physical base address and the size of the registers window
-
-Example:
-	sram@ff720000 {
-		compatible = "rockchip,rk3288-pmu-sram", "mmio-sram";
-		reg = <0xff720000 0x1000>;
-	};
diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
index 7b83cc6c9..605eb1460 100644
--- a/Documentation/devicetree/bindings/sram/sram.yaml
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -29,6 +29,7 @@ properties:
       enum:
         - mmio-sram
         - atmel,sama5d2-securam
+        - rockchip,rk3288-pmu-sram
 
   reg:
     maxItems: 1
@@ -224,6 +225,19 @@ examples:
     };
 
   - |
+    // Rockchip's rk3288 SoC uses the sram of pmu to store the function of
+    // resume from maskrom(the 1st level loader). This is a common use of
+    // the "pmu-sram" because it keeps power even in low power states
+    // in the system.
+    sram@ff720000 {
+      compatible = "rockchip,rk3288-pmu-sram", "mmio-sram";
+      reg = <0xff720000 0x1000>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      ranges = <0 0xff720000 0x1000>;
+    };
+
+  - |
     // Allwinner's A80 SoC uses part of the secure sram for hotplugging of the
     // primary core (cpu0). Once the core gets powered up it checks if a magic
     // value is set at a specific location. If it is then the BROM will jump
-- 
2.11.0

