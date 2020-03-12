Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99AAC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0C1B206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584020777;
	bh=Dk8AP9wY4G68Z9k9to4FPQWu7QcG915G3p0ljqIqq4k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=ByF+ppBCmu0AynT/qjsLDG0G6yoybao/wmWblqCVLYLYyZhjxfrAYVaOboXQLxgbV
	 2nb6KhI027Nz7V6VmU6NXSxnEzirSVpbDGiGoLxkZAKx0pn+tPE8jQb9xHSi/cJoXz
	 s1CTo5lE4d3PITC+W+/HydmbogAX1rk9PJmbPzpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgCLNqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:46:16 -0400
Received: from foss.arm.com ([217.140.110.172]:35018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgCLNqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:46:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6917D30E;
        Thu, 12 Mar 2020 06:46:15 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0BC73F534;
        Thu, 12 Mar 2020 06:46:14 -0700 (PDT)
Date:   Thu, 12 Mar 2020 13:46:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     alsa-devel@alsa-project.org, Benson Leung <bleung@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        devicetree@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dt-bindings: google, cros-ec-codec: Fix dtc warnings in example" to the asoc tree
In-Reply-To:  <20200311205841.2710-1-robh@kernel.org>
Message-Id:  <applied-20200311205841.2710-1-robh@kernel.org>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: dt-bindings: google, cros-ec-codec: Fix dtc warnings in example

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From b239d0c238126f478d2fcd26ad8ffc346547ce67 Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Wed, 11 Mar 2020 15:58:41 -0500
Subject: [PATCH] ASoC: dt-bindings: google, cros-ec-codec: Fix dtc warnings in
 example

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

Fixes: eadd54c75f1e ("dt-bindings: Convert the binding file google, cros-ec-codec.txt to yaml format.")
Signed-off-by: Rob Herring <robh@kernel.org>
Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: alsa-devel@alsa-project.org
Cc: Benson Leung <bleung@chromium.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Cheng-Yi Chiang <cychiang@chromium.org>
Link: https://lore.kernel.org/r/20200311205841.2710-1-robh@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/google,cros-ec-codec.yaml  | 27 +++++++++++--------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml b/Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
index 94a85d0cbf43..c84e656afb0a 100644
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
+            cros_ec_codec: ec-codec@10500000 {
+                compatible = "google,cros-ec-codec";
+                #sound-dai-cells = <1>;
+                reg = <0x0 0x10500000 0x80000>;
+                memory-region = <&reserved_mem>;
+            };
         };
     };
-- 
2.20.1

