Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004C2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBD8520671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:33:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WJuIZzLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgEOPdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:33:35 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:56211 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgEOPde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589556814; x=1621092814;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CpcSOYGLEtZqxN25rSHLipwl2OuTOlmaHev9wkKFKXY=;
  b=WJuIZzLVfxKlk2niP0bUa0cQ7xazMi72bcmgxSLeXOGBX1cot1TnjwkS
   lTSMpeyNVoiSHgmKozkO9gEdxZq8DAIvvZZvkyTWlY/bLGNd9qKRqzfIJ
   ylltnluzlCUKO1aOb4Mt7vb+x+nESQov/S6T/cp5en6bQN19Z9y3y8isz
   rHt8bb0HFYRJkYWVnIDztm/kYbM5NSMbPGDcYCOvfPZ4E/9cMi0ELQnAF
   wH/0ofnV9o2OsHhb3t2YJULzYK8Ff2QL3S0rcJ91nlv5KmWc+eNBI01tE
   TyEWpNaVkPPk9gRm9qffMGm3mfXrGk/7Pahuw5gqyOX/KihfHIMUEs1pu
   w==;
IronPort-SDR: Ueh7QHVqlFVv3ZYhTi4mfWHmGjFsdo6pSqHvqcYPmftWs2pWu+ht9HrYgzn0TgxmnFi3c5P4Eu
 SW0a60e/IVW6Kx7hh6a3FnWU/NfFQm/s2MArLQsgooHoCRiKYADyg3QBLvvliH4V+DRAF4ivni
 xsGnt4O6XgFwIA8lTJUKYu0kst+W1oB5vy65wuYowdv6PhONncC1DbKmZLNdk9ZOFTjpnvQQiY
 im+hBw5np7ELdJI7TiF9Ga3DFkBB51w7OPVi9k5Yz+2xYJgU16H5RqrLTSNb1KDzj3hDsi9LrK
 rFA=
X-IronPort-AV: E=Sophos;i="5.73,395,1583218800"; 
   d="scan'208";a="73591965"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 May 2020 08:33:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 15 May 2020 08:33:33 -0700
Received: from rob-ult-m19940.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Fri, 15 May 2020 08:33:27 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <eugen.hristev@microchip.com>,
        "Codrin Ciubotariu" <codrin.ciubotariu@microchip.com>
Subject: [PATCH] ARM: dts: at91: Configure SCL gpio of i2c2 node as open drain
Date:   Fri, 15 May 2020 18:32:39 +0300
Message-ID: <20200515153239.323944-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SCL gpio pin of i2c2 node used for recovery needs to be configured as
open drain.

Fixes: 455fec938bbb ("ARM: dts: at91: sama5d2: add i2c gpio pinctrl")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index 5846720fc9dc..851b8587068b 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -344,7 +344,7 @@ i2c2: i2c@600 {
 					pinctrl-0 = <&pinctrl_flx0_default>;
 					pinctrl-1 = <&pinctrl_i2c2_gpio>;
 					sda-gpios = <&pioA PIN_PB28 GPIO_ACTIVE_HIGH>;
-					scl-gpios = <&pioA PIN_PB29 GPIO_ACTIVE_HIGH>;
+					scl-gpios = <&pioA PIN_PB29 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
 					i2c-sda-hold-time-ns = <350>;
 					i2c-analog-filter;
 					i2c-digital-filter;
-- 
2.25.1

