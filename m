Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B63C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D1AA206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dfr2Iiy9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbgESVqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 17:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgESVqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:46:33 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96555C08C5C1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 14:46:32 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y198so523884pfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 14:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wbpf3YHhdKi0hj9/gLxGnwwJOKLMjdegtmkz5dArxGA=;
        b=Dfr2Iiy9ihlox5SzAtBXjGIemJwVQ4F2JN3uJbTnbY/qrYXq8sQozcpMM/b8pKxPY0
         V94cK/FnHX88kap4Wi+xUxYSPTBAcT20pUoRsuSaexowqwRd6OB3iOHUSyllctMEb+u7
         7XgqDgwlIZoP8+BuhfDm1NBDvFu1/en5tP4I4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wbpf3YHhdKi0hj9/gLxGnwwJOKLMjdegtmkz5dArxGA=;
        b=KzXiWRLm9pn/d9znp/+TjW+HLVCd5sIkDNUQBzSugK+Talml04qNHH8TjBAixJqpBG
         dsyqhSo3FA5Lo6Q28/akaU/e4w5XCh6upxl41t23/wxBa5pkhE+v8kNg+0OHdI24ZeJ6
         MXtPzp9fh5eOAFd5/liW/Xd4wsnZZjHkcBrrHMkbIQxY5DoP4/D+baaK5sMsjGr5KnT0
         mtg3DVAhJRgNi3cUYj03QD2XvbXOmUt25D1vcGHsRhwsDz3041uRcvunZI3hr24edcpY
         Mpvt6uh8VCa+//76C+sJYvS/kH6jX0KlpCDFwzRC/KAW1k89lp1qJVU0rhwu6xOTzWnT
         C3ww==
X-Gm-Message-State: AOAM531KwijS+mlvU0JFPBBA/gZ4gNSrmK/B7X7RfDq/jNY25X92H9B6
        bSzsr+Eu811s90u1LQOcg/m2X2vzOSk=
X-Google-Smtp-Source: ABdhPJwjUJDJtSAp8x1oX6Fqw6gFTc9NhosvV4//DjsVLDlDelXgP6ca/5uQeOs9JEzvruuzJWqOQw==
X-Received: by 2002:a63:1d4:: with SMTP id 203mr1113573pgb.74.1589924791817;
        Tue, 19 May 2020 14:46:31 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id w1sm323779pgh.53.2020.05.19.14.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 14:46:30 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org, robh+dt@kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v3 1/2] dt-bindings: chrome: Add cros-ec-typec mux props
Date:   Tue, 19 May 2020 14:46:02 -0700
Message-Id: <20200519214604.180036-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
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
Acked-by: Benson Leung <bleung@chromium.org>
---

Changes in v3:
- Fixed Acked-by tag typo.

Changes in v2:
- Added more text to the switch descriptions, explaining their purpose,
  and relation to the Type C connector class framework.

 .../bindings/chrome/google,cros-ec-typec.yaml | 40 ++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
index 6d7396ab8bee..800c005a0e44 100644
--- a/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
+++ b/Documentation/devicetree/bindings/chrome/google,cros-ec-typec.yaml
@@ -21,7 +21,34 @@ properties:
     const: google,cros-ec-typec
 
   connector:
-    $ref: /schemas/connector/usb-connector.yaml#
+    allOf:
+      - $ref: /schemas/connector/usb-connector.yaml#
+      - type: object
+        properties:
+          mode-switch:
+            description: Reference to a DT node for the USB Type C Multiplexer
+              for this connector. This switch controls the data lines routing
+              for this connector for various operation modes, including
+              Alternate Modes. This switch is assumed registered with the Type C
+              connector class framework by its driver. The Type C connector
+              class framework assumes that the mode switch property uses this
+              name.
+
+          orientation-switch:
+            description: Reference to a DT node for the USB Type C orientation
+              switch for this connector. This switch controls routing the
+              correct data pairs depending on the cable plug orientation from
+              this connector to the USB / Alternate Mode controllers. This
+              switch is assumed registered with the Type C connector class
+              framework by its driver. The Type C connector class framework
+              assumes that the orientation switch property uses this name.
+
+          usb-role-switch:
+            description: Reference to a DT node for the USB Data role switch
+              for this connector. This switch is assumed registered with the
+              Type C connector class framework by its driver. The Type C
+              connector class framework assumes that the USB role switch
+              property uses this name.
 
 required:
   - compatible
@@ -49,6 +76,17 @@ examples:
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
2.26.2.761.g0e0b3e54be-goog

