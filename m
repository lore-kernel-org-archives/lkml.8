Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07D9C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA9A20727
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fe3R6CAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbgEMV72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730405AbgEMV70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:59:26 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF277C05BD0F
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:59:25 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x15so350413pfa.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uWnq+06g1H9soD1qxhwQLI1N3tT7e79PiCY3gi5c9aM=;
        b=fe3R6CAU9akKfw4dtfUNsRdKf7Ag7zoIYxBqVogXiRrGwPU0QUp/9tNbaEemvZzD1L
         /T7Z5yqdRUT6l2ksQP+kuFuuu/B8IBMAdp9GYoKzOr+E1yoOhBqUT0eiCGWp5KMK0zvw
         Dc6KMgYU8E6iLb2l9O0cf5rGVtAkeLViaDji4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uWnq+06g1H9soD1qxhwQLI1N3tT7e79PiCY3gi5c9aM=;
        b=nRecRbUTGmvfXgPe8XRZBD18zEpi9FV3Ffa25PpvQc8usIE1VkZZ7mX8eBpShqtAjn
         AfGtRB2htHhp8r1A6FVj7//mxq7+miLa6TyXEgDgkn0CyL0me2vS2NyArUcBJAuNMUlR
         AqHrP4FnvWodS7Se0cZWZiNAyv6BolxSfyGBkRrkOhSwmotXOoxtJEEb0dIALFcaz+PU
         gdlBRX6WzjJEQHxSi/5fFvFrzLYxuinrNFOgSXnMjbVn+xEy032yfSpKOEcyNYBdwUpv
         ENnsw0KWfi3GHyIYeYim3404bSr91m42aEr9M1aIMte77TufjIGdehuwffpbD5MZsgjA
         7oWQ==
X-Gm-Message-State: AOAM5320SdYmfPaZA8Og4zvnHhOq2XrXyssb884wyKYf5D8FR6zBH7oN
        MoHkCwIXz2FYO0TQQHX+uqR5tg==
X-Google-Smtp-Source: ABdhPJzkZax8TyAVILaCvSJkjfp8FipP70nrl3ZYFbtA5yfhvakjUWoYp2finzJP9lX++dBHXGJ1rg==
X-Received: by 2002:a62:1d48:: with SMTP id d69mr1299026pfd.102.1589407165323;
        Wed, 13 May 2020 14:59:25 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id k27sm547169pgb.30.2020.05.13.14.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 14:59:24 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        narmstrong@baylibre.com, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, spanda@codeaurora.org
Cc:     bjorn.andersson@linaro.org, dri-devel@lists.freedesktop.org,
        swboyd@chromium.org, devicetree@vger.kernel.org,
        jeffrey.l.hugo@gmail.com, jernej.skrabec@siol.net,
        linux-arm-msm@vger.kernel.org, robdclark@chromium.org,
        jonas@kwiboo.se, linux-gpio@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 3/3] dt-bindings: drm/bridge: ti-sn65dsi86: Document no-hpd
Date:   Wed, 13 May 2020 14:59:02 -0700
Message-Id: <20200513145807.v6.3.I72892d485088e57378a4748c86bc0f6c2494d807@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
In-Reply-To: <20200513215902.261547-1-dianders@chromium.org>
References: <20200513215902.261547-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ti-sn65dsi86 MIPI DSI to eDP bridge chip has a dedicated hardware
HPD (Hot Plug Detect) pin on it, but it's mostly useless for eDP
because of excessive debouncing in hardware.  Specifically there is no
way to disable the debouncing and for eDP debouncing hurts you because
HPD is just used for knowing when the panel is ready, not for
detecting physical plug events.

Currently the driver in Linux just assumes that nobody has HPD hooked
up.  It relies on folks setting the "no-hpd" property in the panel
node to specify that HPD isn't hooked up and then the panel driver
using this to add some worst case delays when turning on the panel.

Apparently it's also useful to specify "no-hpd" in the bridge node so
that the bridge driver can make sure it's doing the right thing
without peeking into the panel [1].  This would be used if anyone ever
found it useful to implement support for the HW HPD pin on the bridge.
Let's add this property to the bindings.

NOTES:
- This is somewhat of a backward-incompatible change.  All current
  known users of ti-sn65dsi86 didn't have "no-hpd" specified in the
  bridge node yet none of them had HPD hooked up.  This worked because
  the current Linux driver just assumed that HPD was never hooked up.
  We could make it less incompatible by saying that for this bridge
  it's assumed HPD isn't hooked up _unless_ a property is defined, but
  "no-hpd" is much more standard and it's unlikely to matter unless
  someone quickly goes and implements HPD in the driver.
- It is sensible to specify "no-hpd" at the bridge chip level and
  specify "hpd-gpios" at the panel level.  That would mean HPD is
  hooked up to some other GPIO in the system, just not the hardware
  HPD pin on the bridge chip.

[1] https://lore.kernel.org/r/20200417180819.GE5861@pendragon.ideasonboard.com

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---

Changes in v6: None
Changes in v5: None
Changes in v4:
- Tacked on "or is otherwise unusable." to description.

Changes in v3:
- useful implement => useful to implement

Changes in v2:
- ("dt-bindings: drm/bridge: ti-sn65dsi86: Document no-hpd") new for v2.

 .../devicetree/bindings/display/bridge/ti,sn65dsi86.yaml  | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
index 07d26121afca..be10e8cf31e1 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
@@ -28,6 +28,12 @@ properties:
     maxItems: 1
     description: GPIO specifier for GPIO1 pin on bridge (active low).
 
+  no-hpd:
+    type: boolean
+    description:
+      Set if the HPD line on the bridge isn't hooked up to anything or is
+      otherwise unusable.
+
   vccio-supply:
     description: A 1.8V supply that powers the digital IOs.
 
@@ -213,6 +219,8 @@ examples:
         clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
         clock-names = "refclk";
 
+        no-hpd;
+
         ports {
           #address-cells = <1>;
           #size-cells = <0>;
-- 
2.26.2.645.ge9eca65c58-goog

