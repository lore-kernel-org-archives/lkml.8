Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BF7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 362D1207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 08:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgGVIhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 04:37:54 -0400
Received: from lucky1.263xmail.com ([211.157.147.130]:35594 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgGVIhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 04:37:53 -0400
Received: from localhost (unknown [192.168.167.69])
        by lucky1.263xmail.com (Postfix) with ESMTP id 50338CAA67;
        Wed, 22 Jul 2020 16:37:48 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P18496T139713711163136S1595407061138531_;
        Wed, 22 Jul 2020 16:37:47 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <b7709ae5e45381d15e4f4a4129a92abf>
X-RL-SENDER: jon.lin@rock-chips.com
X-SENDER: jon.lin@rock-chips.com
X-LOGIN-NAME: jon.lin@rock-chips.com
X-FST-TO: broonie@kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Jon Lin <jon.lin@rock-chips.com>
To:     broonie@kernel.org
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jon Lin <jon.lin@rock-chips.com>
Subject: [PATCH v2 3/3] spi: rockchip: Fix error in SPI slave pio read
Date:   Wed, 22 Jul 2020 16:37:37 +0800
Message-Id: <20200722083737.8820-3-jon.lin@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722083737.8820-1-jon.lin@rock-chips.com>
References: <20200722083737.8820-1-jon.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RXFLR is possible larger than rx_left in Rockchip SPI, fix it.

Signed-off-by: Jon Lin <jon.lin@rock-chips.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/spi/spi-rockchip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index a451dacab5cf..75a8a9428ff8 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -291,7 +291,7 @@ static void rockchip_spi_pio_writer(struct rockchip_spi *rs)
 static void rockchip_spi_pio_reader(struct rockchip_spi *rs)
 {
 	u32 words = readl_relaxed(rs->regs + ROCKCHIP_SPI_RXFLR);
-	u32 rx_left = rs->rx_left - words;
+	u32 rx_left = (rs->rx_left > words) ? rs->rx_left - words : 0;
 
 	/* the hardware doesn't allow us to change fifo threshold
 	 * level while spi is enabled, so instead make sure to leave
-- 
2.17.1



