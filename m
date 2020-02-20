Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44C4C11D00
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9485208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 08:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLfDvpmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgBTIfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 03:35:54 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35410 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgBTIfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 03:35:53 -0500
Received: by mail-pj1-f65.google.com with SMTP id q39so585151pjc.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 00:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SW6+8bpFonKNb3f2YyuDTFneOp+QYGUKG8MU+Huhr84=;
        b=NLfDvpmphz84eNv17aBMiiqAMqVRvSFWjee1gd8DwTcU5WUsDFqZ9aP2ecjx9QMRwb
         PALAwf/6OlcTq/DyByk0h/aL5jR0Qh9kpipz1wKr+X5OrLfG1xso5chKqEDsvCEN1+7N
         AdybVWlhDI15pIfmzvZVQv43ua+uIFoDZJrZDz5Ua0Fiypghs7qmCxakm12iLhqx6prn
         MIqA8+HOleqP7N+mT+fe3/JnCtSTQM8pLAUuVj3WkfTo14VvtQavoi6qzUSIhv5TJqXr
         s9lBrcXILDs5wdYQKHBFMZkvh68Wg1UutoTVS4mSTxrtUs7NPiittk0I5xDEDo1a1I/C
         KxLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SW6+8bpFonKNb3f2YyuDTFneOp+QYGUKG8MU+Huhr84=;
        b=GBmu11licqpU9NW2RAQTxA5qnuuyKP+ANdCEt7SZEsnXQQfMKwIykO4zP1DEDNg/Tn
         lvhtD4JHEm0A7Z2s1yCC5jPdi6fxOkTHgUdU7bl6/cz0Kzz8ugQp9fXS1MAuL34xIgWy
         hq7SWW1UvwmtC0YXtjMtvPUeMOI8ytnaoMYTaASigaDyVDWEZP6/yCTYfXzuUOE1mmf5
         1DyN1x+Dq+OS8k17Pg5QqDIDSeOUw1OUKpJOlUk51GYfQa5g/lmamHFEiMy8ZDI8DIkE
         lHcwl0nJJbhsr7co+XXPypZnmwCyMulFOHjKovD/kRKrLmVo3P+iefSMuBG9/AbCa4Jw
         av7g==
X-Gm-Message-State: APjAAAVlP+hqV8vuH6dDMKTT4ztiDq3ZuL95HdurVG6FLDxOeYXHcKMk
        iUAw2n23n+Al+SCeDK3XkP4=
X-Google-Smtp-Source: APXvYqwUjt36D32iUpxvkzgCrZ5Cy1bNz6qVcLjbq7xSe6oYStvEJ3BdJs2uPheTayNx6ML7KG+AaA==
X-Received: by 2002:a17:902:8bc7:: with SMTP id r7mr30187510plo.12.1582187753221;
        Thu, 20 Feb 2020 00:35:53 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id l13sm2319038pjq.23.2020.02.20.00.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 00:35:52 -0800 (PST)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Chen-Yu Tsai <wens@csie.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Icenowy Zheng <icenowy@aosc.io>, Torsten Duwe <duwe@suse.de>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH 0/6] Add LCD support for Pine64 Pinebook 1080p
Date:   Thu, 20 Feb 2020 00:35:02 -0800
Message-Id: <20200220083508.792071-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ANX6345 driver has been merged we can add support for Pinebook LCD

This is a follow up on [1] which attempted to add support for all the
A64-based Pinebooks.

Since patches for 768p were dropped we don't need edp-connector binding
discussed in [1] and its earlier versions and we can use panel-simple
binding as everyone else does.

If we ever going to add support for 768p we can do it through dt-overlay
with appropriate panel node or by teaching bootloader to patch dtb with
correct panel compatible.

Similar approach was chosen in [2]

[1] https://patchwork.kernel.org/cover/10814169/
[2] https://patchwork.kernel.org/patch/11277765/

Icenowy Zheng (1):
  arm64: allwinner: a64: enable LCD-related hardware for Pinebook

Samuel Holland (1):
  drm/bridge: anx6345: Fix getting anx6345 regulators

Vasily Khoruzhick (4):
  drm/bridge: anx6345: Clean up error handling in probe()
  dt-bindings: Add Guangdong Neweast Optoelectronics CO. LTD vendor
    prefix
  dt-bindings: display: simple: Add NewEast Optoelectronics WJFH116008A
    compatible
  drm/panel: simple: Add NewEast Optoelectronics CO., LTD WJFH116008A
    panel support

 .../bindings/display/panel/panel-simple.yaml  |  2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 .../dts/allwinner/sun50i-a64-pinebook.dts     | 69 ++++++++++++++++++-
 .../drm/bridge/analogix/analogix-anx6345.c    | 12 ++--
 drivers/gpu/drm/panel/panel-simple.c          | 47 +++++++++++++
 5 files changed, 123 insertions(+), 9 deletions(-)

-- 
2.25.0

