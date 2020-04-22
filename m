Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3981C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC0D32077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZIHNbUlp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgDVWW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726030AbgDVWW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:22:57 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21037C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:22:57 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id a32so1544541pje.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7n9uO7zs3e13z9r7bmohTXGO4/vUq74CC3yhkpSAyMY=;
        b=ZIHNbUlpox+u1m0ebKe2wk0RwC2o/aYdUqLCwHJ7gtjjVybZ2jMKA3HWkkeiVdbR9X
         DsUJ612mDWci5nsLRkI/APdEF10aZNG+Jwp00tIWFYyk0DPD9L7LyOdnvpigDATntZos
         /lXXLrxJQ6hiC+2+G2eWRVln7NPqFyLKJ5nOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7n9uO7zs3e13z9r7bmohTXGO4/vUq74CC3yhkpSAyMY=;
        b=PGBD5gJW/azK1ItTWS/a5qJ0ysL1mvkmsLAcR6YCyz08i/2rqJ7MDF45WA09/M22Xq
         euiN1ztl/eBwos+JuPq00O2dx38vKIo7BoOaUAv6J+5EP6CCNJyCfCaWUD9nz07gaVV/
         Oj+HMOlwcxRP7Uw69jK+HAitFVyB1Ga5fdELsA6Onm6sYSjSk/c4QHzVOJYp5YFgozVV
         HiqvHx25HNaeiJmFOI+HVd4mHvU4igr3iY+oMiJrM7RPlkEIEj+URR/eAveUuOOIKjOx
         +5vv+oKNzVkqVColCqwGEyf59B9Msl9hN0GntOyBciiXNj9iz7348hbl4PsKjj8VdQ0Z
         vLqw==
X-Gm-Message-State: AGi0PuZUawK310kv0++I7x4MgMfjk84IYcBbW73K0bQLQ+Rtox6WRBKd
        c2be0v2up4s9SPTFfZNCqig0JVqsDR8=
X-Google-Smtp-Source: APiQypL56z/Wb04CpGSScMPO2DkFtPhoLvkZPEVd8n8lgYhypelbe1QqGnKB4xu5a/XVPjIkOl3ryQ==
X-Received: by 2002:a17:90a:3327:: with SMTP id m36mr981410pjb.116.1587594176212;
        Wed, 22 Apr 2020 15:22:56 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id w9sm541224pff.101.2020.04.22.15.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 15:22:55 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com, twawrzynczak@chromium.org,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/2] dt-bindings: chrome: Add cros-ec-typec mux props
Date:   Wed, 22 Apr 2020 15:22:39 -0700
Message-Id: <20200422222242.241699-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add properties for mode, orientation and USB data role switches for
Type C connectors. When available, these will allow the Type C connector
class port driver to configure the various switches according to USB PD
information (like orientation, alt mode etc.) provided by the Chrome OS
EC controller.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 .../bindings/chrome/google,cros-ec-typec.yaml | 27 ++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
index 6d7396ab8bee..b5814640aa32 100644
--- a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
+++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
@@ -21,7 +21,21 @@ properties:
     const: google,cros-ec-typec
 
   connector:
-    $ref: /schemas/connector/usb-connector.yaml#
+    allOf:
+      - $ref: /schemas/connector/usb-connector.yaml#
+      - type: object
+        properties:
+          mode-switch:
+            description: Reference to a DT node for the USB Type C Multiplexer
+              controlling the data lines routing for this connector.
+
+          orientation-switch:
+            description: Reference to a DT node for the USB Type C orientation
+              switch for this connector.
+
+          usb-role-switch:
+            description: Reference to a DT node for the USB Data role switch
+              for this connector.
 
 required:
   - compatible
@@ -49,6 +63,17 @@ examples:
             data-role = "dual";
             try-power-role = "source";
           };
+
+          connector@1 {
+            compatible = "usb-c-connector";
+            reg = <1>;
+            power-role = "dual";
+            data-role = "host";
+            try-power-role = "source";
+            mode-switch = <&typec_mux>;
+            orientation-switch = <&typec_orientation_switch>;
+            usb-role-switch = <&typec_mux>;
+          };
         };
       };
     };
-- 
2.26.1.301.g55bc3eb7cb9-goog

