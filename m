Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F590C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 05:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFE11206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 05:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Dc9szpGY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgDUFGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 01:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725881AbgDUFGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 01:06:50 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B006C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 22:06:50 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id p25so6075950pfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 22:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6tjzB8IDNxXjMn/L2OX52d3R04u5HYnbdq7WzuEIBoI=;
        b=Dc9szpGYg/TMF5FeugiPobR7YSgxJmjSHAmcZTqVZLGp1hK2KxuemF5Ni1QATgELjb
         41mP7+aygDk/h9Zjc244kYSW9WSmgGj5WfX+s80DvDH0zkOO4o072+lVyWwylybt1n0S
         WH+CvoiSldcoYQr/OCPu+DSJ2rLAodUm7zij8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6tjzB8IDNxXjMn/L2OX52d3R04u5HYnbdq7WzuEIBoI=;
        b=glI95/ytwXNBQ9txzYhfmTscD5nwD+OvEqXgxOfXKVtirnWo/qCpSXqt8Li/Nal47D
         mdywyKe5r/6dOZGsLwrw1Iupt0YJKnlON/IGJevXxqL3zkXSC7DMdWAJOcjeuLOTZ9Ix
         QLy0lZ3OUX9/27XnY4aK2NV2lbYYDvJtlRAZFsxBBaq/3GEcZiWL12jFNuti3BogeXlQ
         qTrYT6Zmy30sDQyL5YRsx2snrpYrqM8/a43AY52uHVDfP8aSyewpR2snzX0YhUTaJmtt
         lDa4wxsSgc/HhcPvf3WZOzInu9P/DQX+VZgcWVqxZmRoRf6YAS+Gs1XyponrKn5DZXZx
         HJvw==
X-Gm-Message-State: AGi0Pub2S1TpbuNYZxwbcmCx7u5aAIxmlLKEuq9PruBfwKmZe+/ykA3x
        88y1AA5BvP02hL3wzcRBKPTc/A==
X-Google-Smtp-Source: APiQypJCOwQYre1csdfZjks5z/cItwlYMt1/fMfFd4zrIlSTqX4Aw/xU0x4DxUPLoG/oQsCnZ2bQKw==
X-Received: by 2002:a65:4548:: with SMTP id x8mr19697985pgr.223.1587445609328;
        Mon, 20 Apr 2020 22:06:49 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id p68sm1184780pfb.89.2020.04.20.22.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 22:06:48 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        airlied@linux.ie, daniel@ffwll.ch, robh+dt@kernel.org,
        narmstrong@baylibre.com, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, spanda@codeaurora.org
Cc:     jonas@kwiboo.se, jeffrey.l.hugo@gmail.com,
        linux-gpio@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        jernej.skrabec@siol.net, swboyd@chromium.org,
        bjorn.andersson@linaro.org, robdclark@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] drm: Prepare to use a GPIO on ti-sn65dsi86 for Hot Plug Detect
Date:   Mon, 20 Apr 2020 22:06:16 -0700
Message-Id: <20200421050622.8113-1-dianders@chromium.org>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


As talked about in commit c2bfc223882d ("drm/bridge: ti-sn65dsi86:
Remove the mystery delay"), the normal HPD pin on ti-sn65dsi86 is
kinda useless, at least for embedded DisplayPort (eDP).  However,
despite the fact that the actual HPD pin on the bridge is mostly
useless for eDP, the concept of HPD for eDP still makes sense.  It
allows us to optimize out a hardcoded delay that many panels need if
HPD isn't hooked up.  Panel timing diagrams show HPD as one of the
events to measure timing from and we have to assume the worst case if
we can't actually read HPD.

One way to use HPD for eDP without using the mostly useless HPD pin on
ti-sn65dsi86 is to route the panel's HPD somewhere else in the system,
like to a GPIO.  This works great because eDP panels aren't physically
hotplugged.  That means the debouncing logic that caused us problems
wasn't really needed and a raw GPIO works great.

As per the above, a smart board designer would realize the value of
HPD and choose to route it to a GPIO somewhere on the board to avoid
the silly sn65dsi86 debouncing.  While said "smart designer" could
theoretically route HPD anywhere on the board, a really smart designer
would realize that there are several GPIOs on the bridge itself that
are nearly useless for anything but this purpose and route HPD to one
of those.

This series of patches is intended to allow the scenario described
above.

This patch has been tested on a board that is not yet mainline.  On
the hardware I have:
- Panel spec says HPD could take up to 200 ms to come up, so without
  HPD hooked up we need to delay 200 ms.
- On my board the panel is powered by the same rail as the
  touchscreen.  By chance of probe order the touchscreen comes up
  first.  This means by the time we check HPD in ti_sn_bridge_enable()
  it's already up.  Thus we can use the panel on 200 ms earlier.
- If I measure HPD on this pane it comes up ~56 ms after the panel is
  powered.  This means I can save 144 ms of delay.

Side effects (though not main goals) of this series are:
- ti-sn65dsi86 GPIOs are now exported in Linux.
- ti-sn65dsi86 bindings are converted to yaml.
- Common panel bindings now have "hpd-gpios" listed.
- The simple-panel driver in Linux can delay in prepare based on
  "hpd-gpios"
- ti-sn65dsi86 bindings (and current user) now specifies "no-hpd"
  if HPD isn't hooked up.

Changes in v2:
- ("Export...GPIOs") is 1/2 of replacement for ("Allow...bridge GPIOs")
- ("dt-bindings: display: Add hpd-gpios to panel-common...") new for v2
- ("simple...hpd-gpios") is 1/2 of replacement for ("Allow...bridge GPIOs")
- specification => specifier.
- power up => power.
- Added back missing suspend-gpios.
- data-lanes and lane-polarities are are the right place now.
- endpoints don't need to be patternProperties.
- Specified more details for data-lanes and lane-polarities.
- Added old example back in, fixing bugs in it.
- Example i2c bus is just called "i2c", not "i2c1" now.
- ("dt-bindings: drm/bridge: ti-sn65dsi86: Document no-hpd") new for v2.
- ("arm64: dts: sdm845: Add "no-hpd" to sn65dsi86 on cheza") new for v2.

Douglas Anderson (6):
  drm/bridge: ti-sn65dsi86: Export bridge GPIOs to Linux
  dt-bindings: display: Add hpd-gpios to panel-common bindings
  drm/panel-simple: Support hpd-gpios for delaying prepare()
  dt-bindings: drm/bridge: ti-sn65dsi86: Convert to yaml
  dt-bindings: drm/bridge: ti-sn65dsi86: Document no-hpd
  arm64: dts: sdm845: Add "no-hpd" to sn65dsi86 on cheza

 .../bindings/display/bridge/ti,sn65dsi86.txt  |  87 ------
 .../bindings/display/bridge/ti,sn65dsi86.yaml | 285 ++++++++++++++++++
 .../bindings/display/panel/panel-common.yaml  |   6 +
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi    |   2 +
 drivers/gpu/drm/bridge/ti-sn65dsi86.c         | 165 ++++++++++
 drivers/gpu/drm/panel/panel-simple.c          |  53 ++++
 6 files changed, 511 insertions(+), 87 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.txt
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ti,sn65dsi86.yaml

-- 
2.26.1.301.g55bc3eb7cb9-goog

