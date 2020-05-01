Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB53C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63C28205C9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588341229;
	bh=Kh/msCxwRgXFSdlIX3Qt+SXVL5MK1dVNY6zwm0oleMc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=IrRROFkj4mo+cEGDyYhN3mBrNurTLZMxn+0uDRMGtOeSygyfZJpyRPR4rhykHTd8m
	 AIuk6EpM6vkSMGxDx68QyL+LoUjnu+Bh2Ho93HrH61guTy8U4JiHceO7EPzpo0Ll0E
	 by9xRVXL/LKfmVQ/5FKrpFel4VwfP1gh2GBCaNX0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731506AbgEANxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:53:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730332AbgEANfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:35:54 -0400
Received: from localhost.localdomain (unknown [194.230.155.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB44C208DB;
        Fri,  1 May 2020 13:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340153;
        bh=Kh/msCxwRgXFSdlIX3Qt+SXVL5MK1dVNY6zwm0oleMc=;
        h=From:To:Cc:Subject:Date:From;
        b=Ee6qUgJzQ6b+ci43bqqzMHTmf0+xPNmN7L9D6usB9g9aRax8uiOnTUpADzEicObyN
         dKcdpe9WJnwe8I7z+D5GUsfTDv1XN+L0SvEpGJgOBZ6hn6c6M+BmIlN4H7jC57vN5N
         rdl51T06Pc1CcE9/HRor9YfRQ9ArTGiT2tG9wBtc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     patches@opensource.cirrus.com, Lee Jones <lee.jones@linaro.org>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] dt-bindings: sound: wm8994: Correct required supplies based on actual implementaion
Date:   Fri,  1 May 2020 15:35:34 +0200
Message-Id: <20200501133534.6706-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The required supplies in bindings were actually not matching
implementation making the bindings incorrect and misleading.  The Linux
kernel driver requires all supplies to be present.  Also for wlf,wm8994
uses just DBVDD-supply instead of DBVDDn-supply (n: <1,3>).

Reported-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/sound/wm8994.txt       | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/wm8994.txt b/Documentation/devicetree/bindings/sound/wm8994.txt
index 68cccc4653ba..367b58ce1bb9 100644
--- a/Documentation/devicetree/bindings/sound/wm8994.txt
+++ b/Documentation/devicetree/bindings/sound/wm8994.txt
@@ -14,9 +14,15 @@ Required properties:
   - #gpio-cells : Must be 2. The first cell is the pin number and the
     second cell is used to specify optional parameters (currently unused).
 
-  - AVDD2-supply, DBVDD1-supply, DBVDD2-supply, DBVDD3-supply, CPVDD-supply,
-    SPKVDD1-supply, SPKVDD2-supply : power supplies for the device, as covered
-    in Documentation/devicetree/bindings/regulator/regulator.txt
+  - power supplies for the device, as covered in
+    Documentation/devicetree/bindings/regulator/regulator.txt, depending
+    on compatible:
+    - for wlf,wm1811 and wlf,wm8958:
+      AVDD1-supply, AVDD2-supply, DBVDD1-supply, DBVDD2-supply, DBVDD3-supply,
+      DCVDD-supply, CPVDD-supply, SPKVDD1-supply, SPKVDD2-supply
+    - for wlf,wm8994:
+      AVDD1-supply, AVDD2-supply, DBVDD-supply, DCVDD-supply, CPVDD-supply,
+      SPKVDD1-supply, SPKVDD2-supply
 
 Optional properties:
 
@@ -73,11 +79,11 @@ wm8994: codec@1a {
 
 	lineout1-se;
 
+	AVDD1-supply = <&regulator>;
 	AVDD2-supply = <&regulator>;
 	CPVDD-supply = <&regulator>;
-	DBVDD1-supply = <&regulator>;
-	DBVDD2-supply = <&regulator>;
-	DBVDD3-supply = <&regulator>;
+	DBVDD-supply = <&regulator>;
+	DCVDD-supply = <&regulator>;
 	SPKVDD1-supply = <&regulator>;
 	SPKVDD2-supply = <&regulator>;
 };
-- 
2.17.1

