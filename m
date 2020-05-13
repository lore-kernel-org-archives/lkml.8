Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62F9CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B464B20740
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 11:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="q2NMnLi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbgEMLNt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 07:13:49 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:33659 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730957AbgEMLNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 07:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589368425; x=1620904425;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CeCU0xN3PPX4jtlITIpADGChyNcptCOI5+8PaEEcfQc=;
  b=q2NMnLi+xt28ulIx3W1xKr2hNLSOlMstS1CHrdZxs1rVTMHVcS5TVMNI
   xTzotNmO52WLdH8M4rA/ZBKHv0X6Tf753GbYH4DM3roHuJUiN+Wx2Q2CY
   cpxF+0PT07guP2R7hBWAW7fSRL9N5EmDbxGnJcShts5hF6uk0QiCnHzWf
   cs0mDyn6yxLir5GZ7SWGYYmiwMRt8aKknJjKR/G76BhzAEPEA8ddFzZUx
   5p9/wDBESU4f+n83LWq/HKDsDL0036YhqgnAg4WuVGFwfJT4idowdFZ+v
   a+lfGjvMhg8cdVHYQAGrK2K300ij/VLWu0DxVYbJ5wmXm7q0Fam5xCTjS
   A==;
IronPort-SDR: T7zeETlOhwDeM7bmaZlpb8ZrPAip7XABnfCf3Y4x3pGfxcPk2X6k9+l6uT5F5C5aRLqidYabCD
 ztbx0R9ZVw9IYsiqSPKy8k4KjUp3ezLjPCjTNvd4Z04SC6Ad5C8XPVm7VTe2KUBhlZWfWPM7Vk
 Ael3JSsl98taH6FAfcyn/jgtBmR/HgiTsOk+h9W4V2v60u10uA9ZAL029oflCfDgJo6kkslARE
 lOaPRTqlfImXgxRytGWpPwvznuTafTm2+Jf9CittWQUGCbjcRrJ4O/ErGu9waRAJZfI+tRDxrO
 zqk=
X-IronPort-AV: E=Sophos;i="5.73,387,1583218800"; 
   d="scan'208";a="79429653"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 May 2020 04:13:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 13 May 2020 04:13:44 -0700
Received: from rob-ult-m19940.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1713.5 via Frontend Transport; Wed, 13 May 2020 04:13:43 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ludovic.desroches@microchip.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <wsa@kernel.org>,
        <linus.walleij@linaro.org>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [PATCH] i2c: at91: Restore pinctrl state if can't get scl/sda gpios
Date:   Wed, 13 May 2020 14:13:22 +0300
Message-ID: <20200513111322.111114-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is a strict pinmux or if simply the scl/sda gpios are missing,
the pins will remain in gpio mode, compromizing the I2C bus.
Change to the default state of the pins before returning the error.

Fixes: a53acc7ebf27 ("i2c: at91: Fix pinmux after devm_gpiod_get() for bus recovery")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---
 drivers/i2c/busses/i2c-at91-master.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-at91-master.c b/drivers/i2c/busses/i2c-at91-master.c
index d4a3aef4a594..363d540a8345 100644
--- a/drivers/i2c/busses/i2c-at91-master.c
+++ b/drivers/i2c/busses/i2c-at91-master.c
@@ -877,6 +877,7 @@ static int at91_init_twi_recovery_gpio(struct platform_device *pdev,
 			gpiod_put(rinfo->scl_gpiod);
 			rinfo->scl_gpiod = NULL;
 		}
+		pinctrl_select_state(dev->pinctrl, dev->pinctrl_pins_default);
 		return -EINVAL;
 	}
 
-- 
2.25.1

