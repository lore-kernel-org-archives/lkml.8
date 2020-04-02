Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB46DC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 00:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C128520721
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 00:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733287AbgDBACt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 20:02:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35672 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733204AbgDBACt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 20:02:49 -0400
Received: from floko.floko.floko (unknown [IPv6:2804:431:e7cc:11ff:4f80:3de:e2b2:5c1d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: koike)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 4142129765E;
        Thu,  2 Apr 2020 01:02:42 +0100 (BST)
From:   Helen Koike <helen.koike@collabora.com>
To:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        robh+dt@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        kernel@collabora.com, dafna.hirschfeld@collabora.com,
        ezequiel@collabora.com, mark.rutland@arm.com,
        karthik.poduval@gmail.com
Subject: [PATCH 0/4] move Rockchip ISP bindings out of staging / add ISP DT nodes for RK3399
Date:   Wed,  1 Apr 2020 21:02:30 -0300
Message-Id: <20200402000234.226466-1-helen.koike@collabora.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the bindings out of drivers/staging and place them in
Documentation/devicetree/bindings instead.

Also, add DT nodes for RK3399 and verify with make ARCH=arm64 dtbs_check

Tested by verifying images streamed from RockPi 4 board with imx219
module.

Helen Koike (2):
  dt-bindings: phy: phy-rockchip-dphy-rx0: move rockchip dphy rx0
    bindings out of staging
  dt-bindings: media: rkisp1: move rockchip-isp1 bindings out of staging

Shunqian Zheng (2):
  arm64: dts: rockchip: add rx0 mipi-phy for rk3399
  arm64: dts: rockchip: add isp0 node for rk3399

 .../bindings/media/rockchip-isp1.yaml         |  0
 .../bindings/phy/rockchip-mipi-dphy-rx0.yaml  |  0
 arch/arm64/boot/dts/rockchip/rk3399.dtsi      | 38 +++++++++++++++++++
 3 files changed, 38 insertions(+)
 rename {drivers/staging/media/rkisp1/Documentation => Documentation}/devicetree/bindings/media/rockchip-isp1.yaml (100%)
 rename {drivers/staging/media/phy-rockchip-dphy-rx0/Documentation => Documentation}/devicetree/bindings/phy/rockchip-mipi-dphy-rx0.yaml (100%)

-- 
2.26.0

