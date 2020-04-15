Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B56CC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EACE92078B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ocsih6TZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414913AbgDOPu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394209AbgDOPtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:49:50 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B791C061A41
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 08:49:50 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id c23so104343pgj.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 08:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xv5Jh31H5+w8jdcU3qZ2inNmrbUd8kK+/sKgr7aMmBA=;
        b=ocsih6TZchbbdMilfJ2eaHo8YrE4iyg4spUMxkGBGstj8CDKhojbdYG+R6JnRMOHpi
         cibm2DqYQindZF69po+bUjLtkYkIIFvjCe50kEUJUbPMiABottJBLLZhsFmJEMAKF8bX
         iYWvV+b13tAnkuxypq1P36v0kRWJuAPIlucVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xv5Jh31H5+w8jdcU3qZ2inNmrbUd8kK+/sKgr7aMmBA=;
        b=emPiMepnXRr9F7rm8zLmauC4QqeLCav8unq6voNbrlGE+5xJ6W8Thf/ny8gJCnkkFx
         IS55TPQ06zvV1t5QGQQ28SXp749JR/0mD1hp1wom61tWJQ0z2enfoT7k9N2aCvpzlr/L
         l4pT+Bw8cXwI5Ti7Pqg46716wQNZExDgXP4w5A4e79Yp6qoTm6ZcJh2TeRx/zhMuVxmN
         DUN95ROyEBMzoUd+jkkX/hV48n8a0sF5ObuPqctuYwso/fqK5JaJmybPZr1FRosPUuPX
         3dP3YeCkcyTtt4IHm3jFj5BiykS42yOu2asdrkYlnNZaJxxYH7jJcjqSIakLj9J0N9CY
         IzgA==
X-Gm-Message-State: AGi0PuYYfXYMCeE+s/gIx7iD0jxtUEAGUhaems54IRwDzQiA++w7AGUr
        qnTn8zjdEwR0ZdZrOQeUlzYDtg==
X-Google-Smtp-Source: APiQypJ7H4gzqxg/2G4EhbDrGrS2BP4/dIipLbFjqpBVazKk05eyediy+KegDkVKm7ncrS7AMSqZ6Q==
X-Received: by 2002:a62:e50f:: with SMTP id n15mr5859148pff.22.1586965789612;
        Wed, 15 Apr 2020 08:49:49 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id x27sm14382473pfj.74.2020.04.15.08.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 08:49:49 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        narmstrong@baylibre.com, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, spanda@codeaurora.org
Cc:     jonas@kwiboo.se, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, jeffrey.l.hugo@gmail.com,
        swboyd@chromium.org, jernej.skrabec@siol.net,
        linux-arm-msm@vger.kernel.org, robdclark@chromium.org,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: drm/bridge: ti-sn65dsi86: Add hpd-gpios to the bindings
Date:   Wed, 15 Apr 2020 08:48:40 -0700
Message-Id: <20200415084758.2.Ic98f6622c60a1aa547ed85781f2c3b9d3e56b734@changeid>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
In-Reply-To: <20200415084758.1.Ifcdc4ecb12742a27862744ee1e8753cb95a38a7f@changeid>
References: <20200415084758.1.Ifcdc4ecb12742a27862744ee1e8753cb95a38a7f@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow people to specify to use a GPIO for hot-plug-detect.  Add an
example.

NOTE: The current patch adding support for hpd-gpios to the Linux
driver for hpd-gpios only adds enough support to the driver so that
the bridge can use one of its own GPIOs.  The bindings, however, are
written generically.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../bindings/display/bridge/ti,sn65dsi86.yaml          | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
index 8cacc6db33a9..554bfd003000 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
@@ -60,6 +60,10 @@ properties:
     const: 1
     description: See ../../pwm/pwm.yaml for description of the cell formats.
 
+  hpd-gpios:
+    maxItems: 1
+    description: If present use the given GPIO for hot-plug-detect.
+
   data-lanes:
     description: See ../../media/video-interface.txt
 
@@ -148,7 +152,7 @@ examples:
       #address-cells = <1>;
       #size-cells = <0>;
 
-      bridge@2d {
+      sn65dsi86_bridge: bridge@2d {
         compatible = "ti,sn65dsi86";
         reg = <0x2d>;
 
@@ -165,6 +169,10 @@ examples:
         clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
         clock-names = "refclk";
 
+        gpio-controller;
+        #gpio-cells = <2>;
+        hpd-gpios = <&sn65dsi86_bridge 2 GPIO_ACTIVE_HIGH>;
+
         ports {
           #address-cells = <1>;
           #size-cells = <0>;
-- 
2.26.0.110.g2183baf09c-goog

