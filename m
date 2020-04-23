Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B81C55194
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E7520704
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 16:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PZJbeCom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729707AbgDWQ0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 12:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729683AbgDWQ0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 12:26:18 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BD6C09B041
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:26:18 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a31so836292pje.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 09:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0pFOeS/sccEGP8eQs3DCcfXA0C9Qzm+B0/uziitxo7M=;
        b=PZJbeComGG7JDFOB1vq0Jdn+qnhdYrSl+H4jkTL11L9tYn72mUi7nGkoVSNEeSsD0g
         027EsBScgUtwPBDQUwrSSERa/J98e9K2LZccHBgJsVTEnustjW2Ah+SmFQ0DuvzLwCdO
         f4jxVcisWbddJDGpXHycgtzYGooB/8jVRMDj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0pFOeS/sccEGP8eQs3DCcfXA0C9Qzm+B0/uziitxo7M=;
        b=aolq/ioNXv4Gdw+1nu3siKdXk+ng+LTteN0nS34BXPr72Z9idBI/cfUDzcwdMVSK+H
         nCM7I9GJsgcJPT7wOPwmlow/v1zCXGG2TzkncgMIDPXukQmKrSdahZh9hrsdrqvEj/yl
         TZKaoGUUnR7mVYTqUbOcNPj10nf0W6HpgOXKJ04sH6uL3kSIBWWPSGHMcZclqsCRtFJg
         xCyGPh7hTDS4Mx9CZuFK+LHK2Wj9XbNXlVUzcAGk6m3xVoVtcxqwYmqFVRwrABHoLXg+
         uPYL6blkEoBhAbWlZQswdOsQuJv3krSMkTvT25PfPFpoQaCVFzTFItRSr2tWMLeBVvCQ
         349w==
X-Gm-Message-State: AGi0PuYVmh0J6ie2mZV/5aOmn9th27j+N3uR529G3mBxOmnI/Eof0D1t
        nPQxX1QTpuJ6H5CC6dt2U64Dg7G8qxn6Ew==
X-Google-Smtp-Source: APiQypKCbPFY+Q4sglYBstzKdPED0nN/sooISbAltNPO+XiIHqjiLYy5Y1KMaCJ8PsAcOItdpeGcfg==
X-Received: by 2002:a17:902:8eca:: with SMTP id x10mr4668468plo.60.1587659178165;
        Thu, 23 Apr 2020 09:26:18 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d12sm2841927pfq.36.2020.04.23.09.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 09:26:17 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        narmstrong@baylibre.com, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, spanda@codeaurora.org
Cc:     swboyd@chromium.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, jeffrey.l.hugo@gmail.com,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        robdclark@chromium.org, jernej.skrabec@siol.net, jonas@kwiboo.se,
        bjorn.andersson@linaro.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/6] dt-bindings: drm/bridge: ti-sn65dsi86: Document no-hpd
Date:   Thu, 23 Apr 2020 09:25:47 -0700
Message-Id: <20200423092431.v3.5.I72892d485088e57378a4748c86bc0f6c2494d807@changeid>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
In-Reply-To: <20200423162548.129661-1-dianders@chromium.org>
References: <20200423162548.129661-1-dianders@chromium.org>
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
---

Changes in v3:
- useful implement => useful to implement

Changes in v2:
- ("dt-bindings: drm/bridge: ti-sn65dsi86: Document no-hpd") new for v2.

 .../devicetree/bindings/display/bridge/ti,sn65dsi86.yaml    | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
index 6d7d40ad45ac..5746416b0f73 100644
--- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml
@@ -28,6 +28,10 @@ properties:
     maxItems: 1
     description: GPIO specifier for GPIO1 pin on bridge (active low).
 
+  no-hpd:
+    type: boolean
+    description: Set if the HPD line on the bridge isn't hooked up to anything.
+
   vccio-supply:
     description: A 1.8V supply that powers the digital IOs.
 
@@ -207,6 +211,8 @@ examples:
         clocks = <&rpmhcc RPMH_LN_BB_CLK2>;
         clock-names = "refclk";
 
+        no-hpd;
+
         ports {
           #address-cells = <1>;
           #size-cells = <0>;
-- 
2.26.1.301.g55bc3eb7cb9-goog

