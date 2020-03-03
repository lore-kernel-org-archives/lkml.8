Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6052C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:29:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6889920848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 11:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583234972;
	bh=9/eMpVaFKnTKdkVwp42b3Dy3f+L3RKqCf6H3DxvZ9fo=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=HKWVlrJ1d4Tg0smyFe9UpGQc8tCBvgMJqaA8X+xwsR4Vo34OcNux27iahozQhEAF6
	 wkup4pEUDMfNGzjFZzUiAFYvpzaDq7Vn9ki2++mABHB8BuhALXyDwQ0Q0zW6sR1EZT
	 Th+S43aq1Y4+fLrtWYADgZSdZuPwuJNxUAAePLk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbgCCL3b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 06:29:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:57134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbgCCL3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 06:29:30 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE7E920848;
        Tue,  3 Mar 2020 11:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583234970;
        bh=9/eMpVaFKnTKdkVwp42b3Dy3f+L3RKqCf6H3DxvZ9fo=;
        h=From:To:Cc:Subject:Date:From;
        b=rdFQbijD0JvpxM4LjCDIWZEkvhFG3khn/R1dMNhU1DOm4HKbnvT1DcrkZhyLSuITP
         OF+9UoI4ks7oD/k3XeEmtxwAIagBuCo4lkNKhj9oO8DO+zhpAfsE3z8hU8ovSyeZXA
         Poq1URw9mnNEncAI4hzxgqigoQ0Ossp+2uJD+zVI=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] usb: phy: tegra: Include proper GPIO consumer header to fix compile testing
Date:   Tue,  3 Mar 2020 12:29:20 +0100
Message-Id: <1583234960-24909-1-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver uses only GPIO Descriptor Consumer Interface so include
proper header.  This fixes compile test failures (e.g. on i386):

    drivers/usb/phy/phy-tegra-usb.c: In function ‘ulpi_phy_power_on’:
    drivers/usb/phy/phy-tegra-usb.c:695:2: error:
        implicit declaration of function ‘gpiod_set_value_cansleep’ [-Werror=implicit-function-declaration]
    drivers/usb/phy/phy-tegra-usb.c: In function ‘tegra_usb_phy_probe’:
    drivers/usb/phy/phy-tegra-usb.c:1167:11: error:
        implicit declaration of function ‘devm_gpiod_get_from_of_node’ [-Werror=implicit-function-declaration]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/usb/phy/phy-tegra-usb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/phy/phy-tegra-usb.c b/drivers/usb/phy/phy-tegra-usb.c
index 6153cc35aba0..cffe2aced488 100644
--- a/drivers/usb/phy/phy-tegra-usb.c
+++ b/drivers/usb/phy/phy-tegra-usb.c
@@ -12,12 +12,11 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/export.h>
-#include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/platform_device.h>
 #include <linux/resource.h>
 #include <linux/slab.h>
-- 
2.7.4

