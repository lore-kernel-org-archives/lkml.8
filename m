Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A6CC47256
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67033207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GLrBimXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgD3Tqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgD3Tqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:46:35 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CDFC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:46:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z1so384409pfn.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZeykGkk3Qw8ydXNpK0ij5L/ci5pd/u2y9RaZLINTX7o=;
        b=GLrBimXNtCxlkIc/R3SM8JDpBk49Ata2Awlikp7OPUxsNom7jtCsZ/viFr0M+nJbBY
         W/lzwdGOgISMRKfGSxpKHQaPL8NGggrfy3SRwnopvVcs6zl/o8hpI7q2bzA5/75L7tG/
         99cGiOquE1XX87r79VRS80Y3eqJMbn3d7MDNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZeykGkk3Qw8ydXNpK0ij5L/ci5pd/u2y9RaZLINTX7o=;
        b=nfHen4OsPd2sMCuOWggxDDZAEsyl8AUYDbUyUcrtKt5gN5XscKImwLIQ7UCiKDaZuy
         lqiWrGY3cN+yOV6k9uu0sBKve4D+IcKE+gSrjhWmdD/408SWwR8QqFcwWyxVPNi/F3v2
         hfw0l130X4mIPuZHQqlgKIV1pXVrcAI7y3yfQJVo6yTTBV5p93OQUQX1w53w1wI/Pd2o
         DSQ9CBrnsfukV15NIxa/KP1Jm98vV/jTAZ8E0mwzsj3APyy7KNTulHNv6pvIA6FYN9FE
         pIL++WcSk/LNpatwFCO9Al/7psLG86C/yIKKh1RVqsoFa4V1C3PWYEVpYR3GtfXAcw3+
         9bug==
X-Gm-Message-State: AGi0PubltxvBEawTOebWzm6GVumipSJb5d9h9OarfsduNGYSlS8dvLWC
        FVxLt/RARcsKzhGHei1V3tmeLg==
X-Google-Smtp-Source: APiQypLyv/pKQEPVKvf6+ofaZP1ekvgusbH8gjGuKmg+QWnHRbszXdbbzMthYkaGvlThTdBRAOg0/A==
X-Received: by 2002:a63:5717:: with SMTP id l23mr513214pgb.217.1588275993386;
        Thu, 30 Apr 2020 12:46:33 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id u3sm495993pfb.105.2020.04.30.12.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:46:32 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        narmstrong@baylibre.com, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, spanda@codeaurora.org
Cc:     linux-gpio@vger.kernel.org, jonas@kwiboo.se,
        robdclark@chromium.org, bjorn.andersson@linaro.org,
        jeffrey.l.hugo@gmail.com, jernej.skrabec@siol.net,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/6] dt-bindings: drm/bridge: ti-sn65dsi86: Document no-hpd
Date:   Thu, 30 Apr 2020 12:46:16 -0700
Message-Id: <20200430124442.v4.5.I72892d485088e57378a4748c86bc0f6c2494d807@changeid>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
In-Reply-To: <20200430194617.197510-1-dianders@chromium.org>
References: <20200430194617.197510-1-dianders@chromium.org>
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
---

Changes in v4:
- Tacked on "or is otherwise unusable." to description.

Changes in v3:
- useful implement => useful to implement

Changes in v2:
- ("dt-bindings: drm/bridge: ti-sn65dsi86: Document no-hpd") new for v2.

 .../devicetree/bindings/display/bridge/ti,sn65dsi86.yaml  | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
index 6d7d40ad45ac..75c4e8b8e4b7 100644
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
 
@@ -207,6 +213,8 @@ examples:
         clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
         clock-names = "refclk";
 
+        no-hpd;
+
         ports {
           #address-cells = <1>;
           #size-cells = <0>;
-- 
2.26.2.526.g744177e7f7-goog

