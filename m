Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5ECBC41621
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 07:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B794020753
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 07:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbgCUH6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 03:58:23 -0400
Received: from olimex.com ([184.105.72.32]:52495 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728008AbgCUH6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 03:58:20 -0400
Received: from localhost.localdomain ([89.25.85.162])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 00:58:11 -0700
From:   Stefan Mavrodiev <stefan@olimex.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Corentin Labbe <clabbe@baylibre.com>,
        Stefan Mavrodiev <stefan@olimex.com>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner
        sunXi SoC support), linux-kernel@vger.kernel.org (open list)
Cc:     linux-sunxi@googlegroups.com
Subject: [PATCH 0/2] Add A20-OLinuXino-LIME-eMMC
Date:   Sat, 21 Mar 2020 09:57:55 +0200
Message-Id: <20200321075757.15853-1-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The board is the same as A20-OLinuXino-LIME with added eMMC chip. So the
dts is almost identical with A20-OLinuXino-LIME2.

This patch series adds a new dts file and appends the bindings
documentation.

Stefan Mavrodiev (2):
  ARM: dts: sun7i: Add A20-OLinuXino-LIME-eMMC
  dt-bindings: arm: sunxi: Add compatible for A20-OLinuXino-LIME-eMMC

 .../devicetree/bindings/arm/sunxi.yaml        |  5 +++
 arch/arm/boot/dts/Makefile                    |  1 +
 .../dts/sun7i-a20-olinuxino-lime-emmc.dts     | 32 +++++++++++++++++++
 3 files changed, 38 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun7i-a20-olinuxino-lime-emmc.dts

-- 
2.17.1
