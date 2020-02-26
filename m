Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5900C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5B624653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G1GsoxC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727461AbgBZIKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:10:43 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42379 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbgBZIKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:10:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id h8so917474pgs.9;
        Wed, 26 Feb 2020 00:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WxwmrpsEvSIHCqKyrbgIWagGPaBeap74xZ38jQnYjMI=;
        b=G1GsoxC1VQuC2LzKxNIiH8WzlN8FWR5TNjYvsUrS4EpNTF67B0l7m+ux8gBd/URe9K
         Ni169aQfWICKEdDaOovkUoQ6TY8mp7LlZHJZ6Pyh12jXifWrBo6wNpwH+hDAl0UCJeuO
         diXFcso+LmH8SDxwSQYp2Us4VaL3d/8PrHxIwh2BO6zrCkCl4rlWXND2PaGmhmv5LO4g
         866z8wbTQDg9ADpDehmo7RnXIdslb/fXtfj9fH8aEqt6k6VmU5ypu3ND+wnwX7yes9a/
         ikkRFE+xAnlAyVqjNEsi4c/y7zzELDSiseyApg0HTDvw+Sq7rIIHJHhwIduufFULCSHo
         khfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WxwmrpsEvSIHCqKyrbgIWagGPaBeap74xZ38jQnYjMI=;
        b=LUOoL7tb73MlKOhue8R1RrY7n0lg759DPeTKwRfN7v5szJvknFY0M0ebUUqRPLUk3/
         gpYr3br/mVRC/CUmZo712+3wAsX2p315DhLqkH3f6IEn5rs4ZGhXBgVuobEGg8fYUR2K
         LzwjbN+nQllqHfxQIOqw60EGfyixN4PZZVF814iPqP5ImoWzrXvbNfPluGhpV62RKA1z
         HmDtEXRHlb/sIrpsc9y+FIxuouh80tOoHMNnqUyiTgn4xtlir7EbRqlvlStsPtGDyOq/
         aVy9XiqrZcjVPxifKD7zBp+ob6IeDM1UQbYFkNBb5JyloOLRYnIFZs6RNzElS3VUCPFy
         k7+Q==
X-Gm-Message-State: APjAAAVVHolOhPoV/YetIa3VUDPPViMcHTM3nUc6egPrutPb5eqcCd2y
        ZixC8ywKIy43N0QkSSWe4v8=
X-Google-Smtp-Source: APXvYqxua5ZCZ8hYefxJVw0Z7sASanab3iVfMHAfLgUosQmXYzmdnZdSqWeV1lPWXafRXfEHEpPlMw==
X-Received: by 2002:aa7:9a96:: with SMTP id w22mr3010770pfi.210.1582704641739;
        Wed, 26 Feb 2020 00:10:41 -0800 (PST)
Received: from anarsoul-thinkpad.lan (216-71-213-236.dyn.novuscom.net. [216.71.213.236])
        by smtp.gmail.com with ESMTPSA id v7sm1679230pfn.61.2020.02.26.00.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 00:10:40 -0800 (PST)
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
        Torsten Duwe <duwe@suse.de>, Icenowy Zheng <icenowy@aosc.io>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>
Subject: [PATCH v2 0/6] Add LCD support for Pine64 Pinebook 1080p
Date:   Wed, 26 Feb 2020 00:10:05 -0800
Message-Id: <20200226081011.1347245-1-anarsoul@gmail.com>
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

v2:
  - Collect r-b tags
  - Don't print devm_regulator_get() error only if it is -EPROBE_DEFER
  - Keep compatibles alphabetically sorted in panel-simple.yaml
  - Properly indent new panel modes
  - Drop #address-cells, #size-cells properties and @0 suffix
    of endpoints in sun50i-a64-pinebook.dts

Icenowy Zheng (1):
  arm64: allwinner: a64: enable LCD-related hardware for Pinebook

Samuel Holland (1):
  drm/bridge: anx6345: Fix getting anx6345 regulators

Vasily Khoruzhick (4):
  drm/bridge: anx6345: don't print error message if regulator is not
    ready
  dt-bindings: Add Guangdong Neweast Optoelectronics CO. LTD vendor
    prefix
  dt-bindings: display: simple: Add NewEast Optoelectronics WJFH116008A
    compatible
  drm/panel: simple: Add NewEast Optoelectronics CO., LTD WJFH116008A
    panel support

 .../bindings/display/panel/panel-simple.yaml  |  2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 .../dts/allwinner/sun50i-a64-pinebook.dts     | 61 ++++++++++++++++++-
 .../drm/bridge/analogix/analogix-anx6345.c    | 12 ++--
 drivers/gpu/drm/panel/panel-simple.c          | 48 +++++++++++++++
 5 files changed, 120 insertions(+), 5 deletions(-)

-- 
2.25.0

