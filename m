Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA39DC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 11:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6AC520757
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 11:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598785900;
	bh=gXODkDbcQF17NTHovr6nEh8zgdaj1s2Ph6JY/EZmbC8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=rKOLYwrIuYFcbEkCwi/DD3FuY0v3+P0e7FQkFMonP0e9xLOzidMgKfXwB1ZGMxNcJ
	 SyE8XNmVYlNVik91ljCkISDY78kwrB0ZguiQLlIr3+E3T9ICTMR3L18e4xBG1UaS5u
	 QtjOL+E+s1nMsOw5M2pdnFFSDQo+XtTNSCvw/+aY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgH3LLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 07:11:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:56278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725845AbgH3LLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 07:11:35 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A526E20757;
        Sun, 30 Aug 2020 11:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598785894;
        bh=gXODkDbcQF17NTHovr6nEh8zgdaj1s2Ph6JY/EZmbC8=;
        h=From:To:Cc:Subject:Date:From;
        b=q+yk8voUyPk3N9ED0KyO0ZcI+jgV0Na/1bJfDfEYX+UjR+kFBDCXdw8n0NhVz160b
         ohi2ic/pU1ivI8S3Ajf5U0LSOd+t56I/edrUOuDciMQQ1+61F/WXYOD4mbBf5Cvrd3
         tiUuEnYyZvUgH85v6TYrZXfrWUcn80NWehkWo+A4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] dt-bindings: leds: common: Add mmc0 as default trigger
Date:   Sun, 30 Aug 2020 13:11:15 +0200
Message-Id: <20200830111115.32623-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMC could be a default trigger so add a pattern to match it and fix
dtbs_check warnings like:

  arch/arm/boot/dts/exynos4412-odroidx.dt.yaml: leds: led2:linux,default-trigger:0:
    'mmc0' is not one of ['backlight', 'default-on', 'heartbeat', 'disk-activity', 'ide-disk', 'timer', 'pattern']
    From schema: Documentation/devicetree/bindings/leds/leds-gpio.yaml

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../devicetree/bindings/leds/common.yaml      | 39 ++++++++++---------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
index a2a541bca73c..6b38f9f3792c 100644
--- a/Documentation/devicetree/bindings/leds/common.yaml
+++ b/Documentation/devicetree/bindings/leds/common.yaml
@@ -78,25 +78,26 @@ properties:
       This parameter, if present, is a string defining the trigger assigned to
       the LED.
     $ref: /schemas/types.yaml#definitions/string
-
-    enum:
-        # LED will act as a back-light, controlled by the framebuffer system
-      - backlight
-        # LED will turn on (but for leds-gpio see "default-state" property in
-        # Documentation/devicetree/bindings/leds/leds-gpio.yaml)
-      - default-on
-        # LED "double" flashes at a load average based rate
-      - heartbeat
-        # LED indicates disk activity
-      - disk-activity
-        # LED indicates IDE disk activity (deprecated), in new implementations
-        # use "disk-activity"
-      - ide-disk
-        # LED flashes at a fixed, configurable rate
-      - timer
-        # LED alters the brightness for the specified duration with one software
-        # timer (requires "led-pattern" property)
-      - pattern
+    oneOf:
+      - enum:
+            # LED will act as a back-light, controlled by the framebuffer system
+          - backlight
+            # LED will turn on (but for leds-gpio see "default-state" property in
+            # Documentation/devicetree/bindings/leds/leds-gpio.yaml)
+          - default-on
+            # LED "double" flashes at a load average based rate
+          - heartbeat
+            # LED indicates disk activity
+          - disk-activity
+            # LED indicates IDE disk activity (deprecated), in new implementations
+            # use "disk-activity"
+          - ide-disk
+            # LED flashes at a fixed, configurable rate
+          - timer
+            # LED alters the brightness for the specified duration with one software
+            # timer (requires "led-pattern" property)
+          - pattern
+      - pattern: "^mmc[0-9]+$"
 
   led-pattern:
     description: |
-- 
2.17.1

