Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60F9C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7709E20768
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="CBEtX+ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbgIIQG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730701AbgIIQFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:05:04 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33452C061799
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 09:04:20 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a65so2803463wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 09:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h1AWnbsFuPZ6MacypHQ8HsT3a6NqF6t9qfTWoa+8SvY=;
        b=CBEtX+eetvQyYOJlhFNdL2Py9mlE1aqXsNu2yLaDW0ofpA3brnezX+6b7BJvAYKLuT
         V68bQ27V+dOY0t21Y4cMcopxcuHJl9KObw5od6vAqTGIiccB8nljhohkaX6b988Fh2dk
         +WW6yD629U3/2fVJqNwKLxqout6WmwgAJehP3FyS2yuM8GQiUC90ENf1p4GYBpYQ1Iie
         Wpy0Soe3C+7W3P8HjatHnNJQkG2CkCbnx8oIy57b/J9dP5ITDpA9dh0MNYzSsk8BdLcY
         BApABE2lixWzfO/MPhOK6ycI/B2lwLg0mofAc4MAh5J3fNsWtMENu062OPINiimT08Cd
         6Edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h1AWnbsFuPZ6MacypHQ8HsT3a6NqF6t9qfTWoa+8SvY=;
        b=pdUvpnSbxIEBukIffRDlLhodJAYcqogeGsqvqqH3pCyLcnnStsKqfEqYXsSkA8k/n/
         fcCSppMOF3qdniXF6xofmEopFqE7gj8TRRKIGqD+5riRX39ElL8Q3YVd+aJEobq+kZSF
         DaiLuq5go6tJs7yzyCGYpw0NLnzZL3M6pEdnYWGRBt2fkOgocjYylfu4b97hxvqMlNPt
         VIHqVhkBjAH4MWgnq2FYvq5FDCsYVDE9smkUleotX8nJN6qI88Qg5RV5gLqk/2xdaI2G
         R7S9NrTJ38com2CEO9eFu0W+FX3iDmcqy9FkSmCGL4ytKNgizeaTMLwo6xSVlLKtJnTA
         n90g==
X-Gm-Message-State: AOAM53114rXTzTc312RyUdWCREukIW1/vaup4Zi/6OFuw+wPgjBvfXzs
        wLGAyYyeUKfohBggBwdPVL02Zg==
X-Google-Smtp-Source: ABdhPJxj7lBo+0hk4DkP0KoDHzMJtbj02HX+VSFjyvK7FqFw6/ssYu+ZmXW2UR8kbhGhvelekB8u/w==
X-Received: by 2002:a7b:c5d0:: with SMTP id n16mr4098812wmk.7.1599667458702;
        Wed, 09 Sep 2020 09:04:18 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id y6sm4850700wrn.41.2020.09.09.09.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 09:04:18 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH 2/5] dt-bindings: usb: amlogic,meson-g12a-usb-ctrl: add the Amlogic AXG Families USB Glue Bindings
Date:   Wed,  9 Sep 2020 18:04:06 +0200
Message-Id: <20200909160409.8678-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200909160409.8678-1-narmstrong@baylibre.com>
References: <20200909160409.8678-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic AXG is close from the GXL Glue but with a single OTG PHY.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../usb/amlogic,meson-g12a-usb-ctrl.yaml      | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
index 5b04a7dfa018..c0058332b967 100644
--- a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
+++ b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
@@ -25,13 +25,14 @@ description: |
   The Amlogic A1 embeds a DWC3 USB IP Core configured for USB2 in
   host-only mode.
 
-  The Amlogic GXL & GXM SoCs doesn't embed an USB3 PHY.
+  The Amlogic GXL, GXM & AXG SoCs doesn't embed an USB3 PHY.
 
 properties:
   compatible:
     enum:
       - amlogic,meson-gxl-usb-ctrl
       - amlogic,meson-gxm-usb-ctrl
+      - amlogic,meson-axg-usb-ctrl
       - amlogic,meson-g12a-usb-ctrl
       - amlogic,meson-a1-usb-ctrl
 
@@ -151,6 +152,25 @@ allOf:
 
       required:
         - clock-names
+  - if:
+      properties:
+        compatible:
+          enum:
+            - amlogic,meson-axg-usb-ctrl
+
+    then:
+      properties:
+        phy-names:
+          items:
+            - const: usb2-phy1 # USB2 PHY1 if USBOTG_B port is used
+        clocks:
+          minItems: 2
+        clock-names:
+          items:
+            - const: usb_ctrl
+            - const: ddr
+      required:
+        - clock-names
   - if:
       properties:
         compatible:
-- 
2.22.0

