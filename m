Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39570C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12CCF20674
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 18:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584122748;
	bh=tS2q+oXz20VqzSeHESYk3tjWn89uZDkDnSDm+k5Qa9M=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ZHdqMio9nN14Fp9ysQPV0Cvu3nuaA9ifZz1M5sUvDduM08GsYa0eQK81qOcdCH8DO
	 5WoaSwIEWtGDdbmrr+dwQpwuzUftGjtjk2UL7Jff8YggQzdTnMSWo5LpjaFxAKLYeb
	 O/iizJ600WveM+HmR3FY7rgZNPSk/QVd2Zs9Agb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbgCMSFr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:05:47 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41873 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgCMSFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 14:05:46 -0400
Received: by mail-ot1-f67.google.com with SMTP id s15so11034611otq.8;
        Fri, 13 Mar 2020 11:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q7+Nkcvfl4/gb9mNioMQHbyMcrjEyqR+fODsE4xtIGc=;
        b=aNdLZnx9pxZYX5AWitZZDzEpDZVH2DjVgkZSn7MRmkn8MUOd/BLDvTjKQvyB8Hdpw6
         5H6I5I7+nS93dThRWxPRVPQSxx7rUqjYK5ROJKVtMUO85Q9NKOMhPazAnqg/DuRJemA0
         ER2v2h2DZe/h0F20PPYZItJZzRO1uqS8DWAWxq1IGt9Bg6XHUtxO6fXRVXkSxlqHHr7f
         wDyGXXUPqe/bZ0vJsXN2r2QbKDR1uznpBmWMah6wvUfrIWZpWJPQAPK/edtMLJiK/ESX
         hCakBUBFkxyxldqwb1q5ZDrLThNZCNMPFHP+yEHRLdj9vwGMcSy1A1khzD/w/HMvWVFS
         TpoA==
X-Gm-Message-State: ANhLgQ0egWnOzTBS6y4NpM0LB37uCA/utIb0E4LVqmIQ7NUQqOKUXND2
        KsSGKxrDoQGxHNOe6vBmZg==
X-Google-Smtp-Source: ADFU+vuE1znAWJdS12d/3fpV7RSOblB37rwLd2+2qwovCXq+PD/Gh05XlFdke2N5njfGD69QMU3nNw==
X-Received: by 2002:a05:6830:1498:: with SMTP id s24mr10839643otq.242.1584122745570;
        Fri, 13 Mar 2020 11:05:45 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id b15sm8012288oic.52.2020.03.13.11.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 11:05:44 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Benson Leung <bleung@chromium.org>,
        alsa-devel@alsa-project.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v2] ASoC: dt-bindings: google,cros-ec-codec: Fix dtc warnings in example
Date:   Fri, 13 Mar 2020 13:05:43 -0500
Message-Id: <20200313180543.20497-1-robh@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extra dtc warnings (roughly what W=1 enables) are now enabled by default
when building the binding examples. These were fixed treewide in
5.6-rc5, but the newly added google,cros-ec-codec schema adds some new
warnings:

Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dts:17.28-21.11:
Warning (unit_address_vs_reg): /example-0/reserved_mem: node has a reg or ranges property, but no unit name
Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dts:22.19-32.11:
Warning (unit_address_vs_reg): /example-0/cros-ec@0: node has a unit name, but no reg property
Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dts:26.37-31.15:
Warning (unit_address_vs_reg): /example-0/cros-ec@0/ec-codec: node has a reg or ranges property, but no unit name

Fixing the above, then results in:

Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dts:26.13-23:
Warning (reg_format): /example-0/cros-ec@0:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/sound/google,cros-ec-codec.example.dts:27.37-32.15:
Warning (unit_address_vs_reg): /example-0/cros-ec@0/ec-codec: node has a reg or ranges property, but no unit name

Fix these warnings and adjust the node name to 'audio-codec' while we're
touching the node name.

Fixes: eadd54c75f1e ("dt-bindings: Convert the binding file google, cros-ec-codec.txt to yaml format.")
Cc: Cheng-Yi Chiang <cychiang@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Benson Leung <bleung@chromium.org>
Cc: alsa-devel@alsa-project.org
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
 - s/ec-codec/audio-codec/
---
 .../bindings/sound/google,cros-ec-codec.yaml  | 27 +++++++++++--------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
index 94a85d0cbf43..d62284288f23 100644
--- a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
@@ -44,19 +44,24 @@ additionalProperties: false
 
 examples:
   - |
-    reserved_mem: reserved_mem {
+    reserved_mem: reserved-mem@52800000 {
         compatible = "shared-dma-pool";
-        reg = <0 0x52800000 0 0x100000>;
+        reg = <0x52800000 0x100000>;
         no-map;
     };
-    cros-ec@0 {
-        compatible = "google,cros-ec-spi";
-        #address-cells = <2>;
-        #size-cells = <1>;
-        cros_ec_codec: ec-codec {
-            compatible = "google,cros-ec-codec";
-            #sound-dai-cells = <1>;
-            reg = <0x0 0x10500000 0x80000>;
-            memory-region = <&reserved_mem>;
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        cros-ec@0 {
+            compatible = "google,cros-ec-spi";
+            #address-cells = <2>;
+            #size-cells = <1>;
+            reg = <0>;
+            cros_ec_codec: audio-codec@10500000 {
+                compatible = "google,cros-ec-codec";
+                #sound-dai-cells = <1>;
+                reg = <0x0 0x10500000 0x80000>;
+                memory-region = <&reserved_mem>;
+            };
         };
     };
-- 
2.20.1

