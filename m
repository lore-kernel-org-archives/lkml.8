Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E38C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3EAB21924
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446023;
	bh=Rf3LPCGb3dBwX1vd7JFmaCn40Uto/QjI0gBEgR/7IK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hC9t41HkmecdDHWFOW4qC+me8zkG26gCrOBvCVfc0CzSe4ZdaOiSMjJuNUJQhG26N
	 rxQgEwWWNUO2+fz73b1k2W/mVlOocz0bLsTXvH5QGYsgoK/IRksBnr5xe7ESzm71Jt
	 4YVdPgXrDD4nbhvWVxGl+uMblQ2guRUlp0Lg9vyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731192AbgFRCHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:07:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730229AbgFRBW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:22:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83EC0214DB;
        Thu, 18 Jun 2020 01:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443346;
        bh=Rf3LPCGb3dBwX1vd7JFmaCn40Uto/QjI0gBEgR/7IK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EI4PiaFQcBeagZDk1Kt7kn/yq9dAsOQOYFqf2+oaBipbFe0UEN2Mo+lSkUJC3Z72U
         j9edph9ojgx6bowbjq/KmcIFw/biVBad5iV9SMVCjOyWInrfO1qqw30xLuNM0QhWfs
         nVrcneB7x4k7jrbA4pc1rn+kuGIg3hKkvJm4ILEA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 006/172] iio: pressure: bmp280: Tolerate IRQ before registering
Date:   Wed, 17 Jun 2020 21:19:32 -0400
Message-Id: <20200618012218.607130-6-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012218.607130-1-sashal@kernel.org>
References: <20200618012218.607130-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 97b31a6f5fb95b1ec6575b78a7240baddba34384 ]

With DEBUG_SHIRQ enabled we have a kernel crash

[  116.482696] BUG: kernel NULL pointer dereference, address: 0000000000000000

...

[  116.606571] Call Trace:
[  116.609023]  <IRQ>
[  116.611047]  complete+0x34/0x50
[  116.614206]  bmp085_eoc_irq+0x9/0x10 [bmp280]

because DEBUG_SHIRQ mechanism fires an IRQ before registration and drivers
ought to be able to handle an interrupt happening before request_irq() returns.

Fixes: aae953949651 ("iio: pressure: bmp280: add support for BMP085 EOC interrupt")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/pressure/bmp280-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index fe87d27779d9..d47922a1d0f3 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -703,7 +703,7 @@ static int bmp180_measure(struct bmp280_data *data, u8 ctrl_meas)
 	unsigned int ctrl;
 
 	if (data->use_eoc)
-		init_completion(&data->done);
+		reinit_completion(&data->done);
 
 	ret = regmap_write(data->regmap, BMP280_REG_CTRL_MEAS, ctrl_meas);
 	if (ret)
@@ -959,6 +959,9 @@ static int bmp085_fetch_eoc_irq(struct device *dev,
 			"trying to enforce it\n");
 		irq_trig = IRQF_TRIGGER_RISING;
 	}
+
+	init_completion(&data->done);
+
 	ret = devm_request_threaded_irq(dev,
 			irq,
 			bmp085_eoc_irq,
-- 
2.25.1

