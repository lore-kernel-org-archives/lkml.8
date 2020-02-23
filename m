Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33BAC35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE9020707
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="l8Tf0h9K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgBWDQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 22:16:18 -0500
Received: from vps.xff.cz ([195.181.215.36]:36846 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbgBWDQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 22:16:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1582427776; bh=x4ETbhklf9C5iN2AAibtBUXNgpDN11ycD8F1mG47eMs=;
        h=From:To:Cc:Subject:Date:From;
        b=l8Tf0h9KZfoXwcar7dNECQUNppL6t+Q2ZCVJyIc+Sm5Y/xzkaYlxhELRRlcAL8U6s
         E9Ye2E+H/QruMazofyY3hlsrJAsKOkngPI5oKipvVb9MqDeYLQPHk6z2d4UFj9DReT
         hek33f/l/90bKn+HzwcvfPnGB1cq0oJ9fAM+HI8c=
From:   Ondrej Jirman <megous@megous.com>
To:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     Ondrej Jirman <megous@megous.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Sunil Mohan Adapa <sunil@medhas.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add support for PocketBook Touch Lux 3 e-book reader
Date:   Sun, 23 Feb 2020 04:16:11 +0100
Message-Id: <20200223031614.515563-1-megous@megous.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds a fairly complete support for this e-book reader.

Missing parts are eink display driver and the touch panel driver.
Support for both is available out-of-tree for now at:
  https://megous.com/git/linux/log/?h=pb-5.6

The rest of the board is supported by the mainline drivers.

Please take a look.

thank you and regards,
  Ondrej Jirman

Ondrej Jirman (3):
  dt-bindings: vendor-prefixes: Add prefix for PocketBook International
    SA
  dt-bindings: arm: sunxi: Add PocketBook Touch Lux 3
  ARM: dts: sun5i: Add PocketBook Touch Lux 3 support

 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/sun5i-a13-pocketbook-touch-lux-3.dts  | 257 ++++++++++++++++++
 4 files changed, 265 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun5i-a13-pocketbook-touch-lux-3.dts

-- 
2.25.1

