Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1849C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C318E2084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 20:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgIDUCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 16:02:12 -0400
Received: from gw.c-home.cz ([89.24.150.100]:41769 "EHLO dmz.c-home.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727921AbgIDUCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 16:02:02 -0400
Received: from ubuntu1804.c-home.cz (unifi.c-home.cz [192.168.1.239])
        by dmz.c-home.cz (8.14.4+Sun/8.14.4) with ESMTP id 084K1Ed8002405;
        Fri, 4 Sep 2020 22:01:19 +0200 (CEST)
From:   Martin Cerveny <m.cerveny@computer.org>
To:     devicetree@vger.kernel.org
Cc:     Martin Cerveny <m.cerveny@computer.org>,
        Chen-Yu Tsai <wens@csie.org>, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 0/6] ARM: dts: sun8i: v3s: Enable video decoder
Date:   Fri,  4 Sep 2020 22:01:06 +0200
Message-Id: <20200904200112.5563-1-m.cerveny@computer.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First patch extends cedrus capability to all decoders
because V3s missing MPEG2 decoder.

Next two patches add system control node (SRAM C1) and 
next three patches add support for Cedrus VPU.

Best regards,
Martin

Martin Cerveny (6):
  media: cedrus: Register all codecs as capability
  dt-bindings: sram: allwinner,sun4i-a10-system-control: Add V3s
    compatibles
  ARM: dts: sun8i: v3s: Add node for system control
  media: cedrus: Add support for V3s
  media: allwinner,sun4i-a10-video-engine: Add V3s compatible
  ARM: dts: sun8i: v3s: Add video engine node

 .../allwinner,sun4i-a10-video-engine.yaml     |  1 +
 .../allwinner,sun4i-a10-system-control.yaml   |  6 ++++
 arch/arm/boot/dts/sun8i-v3s.dtsi              | 33 +++++++++++++++++++
 drivers/staging/media/sunxi/cedrus/cedrus.c   | 28 +++++++++++++++-
 drivers/staging/media/sunxi/cedrus/cedrus.h   |  2 ++
 .../staging/media/sunxi/cedrus/cedrus_video.c |  2 ++
 6 files changed, 71 insertions(+), 1 deletion(-)

-- 
2.17.1

