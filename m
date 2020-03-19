Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CF2C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2A3D20663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAfJ6Cb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgCSQMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:12:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38033 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgCSQMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 12:12:10 -0400
Received: by mail-wm1-f65.google.com with SMTP id l20so2984961wmi.3;
        Thu, 19 Mar 2020 09:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kcI9L10AVu3IFfDLlq7fYdN8ePr2Q+2h97GxsvZx3J0=;
        b=OAfJ6Cb3Q7fO4i8JHLbUWXZbGL9oGZ25fAszYa+CqeczsxwpIpylMDlEaAE3/6thJw
         KDRToGk8bkf4r6chrw1GbZXwv1UPYsxCBC+WIDQhNV4VNFn6bWcI0joUFSxwznheJPCg
         lxP0P/PWJiwSO2nMZL6FVLSU9KUopelr5zs871Yi9UHdL5tlvPnYh7KgRnh3EM+2SkVn
         itx45pb22aoykPkRDFoX1u728LHpvSdtwnjYuY2Zf0+IEe+xE+Nym0hoy0weKmpxdtLX
         KSooY/ODYEwZSNZQl24hdoaGVkigEYOPDppGJv2vGS3gNqp1WJ2az5SO3s7y1pUkXnVo
         y/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kcI9L10AVu3IFfDLlq7fYdN8ePr2Q+2h97GxsvZx3J0=;
        b=a3S7L5jQBHtXNUnH2rE2oZ6HkxzuJG8xOv84najdp0QzM4TX59eH49mAXZ/vflvzl9
         +ZMBrY3humE02/EsBM2yrZv+mjCZRLf5HldRACI/UoQtPTchVzcKlN34RdvdiBk2tHzq
         9xqslHUqAFVeecJzIJkTZe7V4XOvSfls8LUM4GL6y6R5i8iLo53JfuO0aljJY+zVLgbZ
         VRpW6xfpy5eHWi7NZzpLlHq9UMoxAxMLsXgV9esUBqM2Af4bkZlkbm5DGJrH//WvG1T+
         g6YuJeF5ykymoB174OC0tx4yjjdUrgZpwaeLOgSQwMi6zSF46t2uHaxOaHV5Hzsjk+o8
         WmmQ==
X-Gm-Message-State: ANhLgQ3Bk6BPrZjX/dy0hKmjS6ghJqWtQae2pC0eMaNoFpEkWj2RFdFI
        kwUZXcw7wnnTz9/tE/V0eWg=
X-Google-Smtp-Source: ADFU+vv7RkcNf6iJ+zQ/ULJBSRGSg9vNsaWp0WejEfo/Y0gYZuPRr4L3BhyGJyqw2V3klwYvuQYG2g==
X-Received: by 2002:a05:600c:210d:: with SMTP id u13mr4718627wml.92.1584634327036;
        Thu, 19 Mar 2020 09:12:07 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id w204sm3973485wma.1.2020.03.19.09.12.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 09:12:06 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/2] dt-bindings: sram: convert rockchip-pmu-sram bindings to yaml
Date:   Thu, 19 Mar 2020 17:11:58 +0100
Message-Id: <20200319161159.24548-1-jbx6244@gmail.com>
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

Changed v2:
  Merge with sram.yaml
---
 .../devicetree/bindings/sram/rockchip-pmu-sram.txt       | 16 ----------------
 Documentation/devicetree/bindings/sram/sram.yaml         | 13 +++++++++++++
 2 files changed, 13 insertions(+), 16 deletions(-)
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
index 7b83cc6c9..a9b1c2b74 100644
--- a/Documentation/devicetree/bindings/sram/sram.yaml
+++ b/Documentation/devicetree/bindings/sram/sram.yaml
@@ -224,6 +224,19 @@ examples:
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

