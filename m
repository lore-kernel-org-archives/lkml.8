Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE59C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0913B20691
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGQJYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:24:34 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:34022 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgGQJYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:24:32 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 14FA0CA7E3;
        Fri, 17 Jul 2020 17:24:30 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P26706T140360697231104S1594977862492603_;
        Fri, 17 Jul 2020 17:24:30 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <ddaa72d0616ebe5a6e81bb4e3b09c7d6>
X-RL-SENDER: yifeng.zhao@rock-chips.com
X-SENDER: zyf@rock-chips.com
X-LOGIN-NAME: yifeng.zhao@rock-chips.com
X-FST-TO: miquel.raynal@bootlin.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Yifeng Zhao <yifeng.zhao@rock-chips.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        heiko@sntech.de, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: [PATCH v8 3/8] MAINTAINERS: add maintainers to ROCKCHIP NFC
Date:   Fri, 17 Jul 2020 17:24:19 +0800
Message-Id: <20200717092420.19798-4-yifeng.zhao@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717092420.19798-1-yifeng.zhao@rock-chips.com>
References: <20200717092420.19798-1-yifeng.zhao@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers to ROCKCHIP NFC.

Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
---

Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d4aa7f942de..187634a085a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2344,12 +2344,12 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-rockchip@lists.infradead.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git
+F:	Documentation/devicetree/bindings/*/*rockchip*.yaml
 F:	Documentation/devicetree/bindings/i2c/i2c-rk3x.yaml
-F:	Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.yaml
-F:	Documentation/devicetree/bindings/spi/spi-rockchip.yaml
 F:	arch/arm/boot/dts/rk3*
 F:	arch/arm/boot/dts/rv1108*
 F:	arch/arm/mach-rockchip/
+F:	drivers/*/*/*/*rockchip*
 F:	drivers/*/*/*rockchip*
 F:	drivers/*/*rockchip*
 F:	drivers/clk/rockchip/
-- 
2.17.1



