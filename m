Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D40C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B79C2206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598711412;
	bh=hqxOstCnIoNKDrJ+bAx6KqDpcFo8rUnfZrqeID5wT9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T3SswvRg5OKumzoYK57H+rN+e45zJcZe9HkAg8Uamjb3/3wiG5LYoV4xIpdikmAOY
	 OIEj+gNNqv/9ZDC0GNNhQSmWPLr5B06/a1CN89sHPwNhUpFHpCXSPOqgOYRSX46E9K
	 kEY4Z9wFtV7keEpVm8oGT7kN76SXZKNTYnMG7UP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgH2OaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 10:30:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728234AbgH2OaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 10:30:05 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15CEA2145D;
        Sat, 29 Aug 2020 14:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598711404;
        bh=hqxOstCnIoNKDrJ+bAx6KqDpcFo8rUnfZrqeID5wT9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iWFH41dwQbo4aGO8QE8tMY3Lx+UEYhq+gPPZdyRLMwJqzjuu0SHeXVEmf2/ni7sYm
         0dlk3hJLGoaw19UVDhv7tqiQrnNvlkWeGaFzfCV5ArszmQSC5bdV+moMhnQdtOFQIG
         JLFhpV5zsMJzpFKp2WLTVOXk/eA3vEf0NZjDKPh8=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Opasiak <k.opasiak@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfc@lists.01.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>
Subject: [RFT 3/4] nfc: s3fwrn5: Remove wrong vendor prefix from GPIOs
Date:   Sat, 29 Aug 2020 16:29:47 +0200
Message-Id: <20200829142948.32365-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829142948.32365-1-krzk@kernel.org>
References: <20200829142948.32365-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device tree property prefix describes the vendor, which in case of
S3FWRN5 chip is Samsung.  Therefore the "s3fwrn5" prefix for "en-gpios"
and "fw-gpios" is not correct and should be deprecated.  Introduce
properly named properties for these GPIOs but still support deprecated
ones.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/nfc/s3fwrn5/i2c.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/nfc/s3fwrn5/i2c.c b/drivers/nfc/s3fwrn5/i2c.c
index b4eb926d220a..557279492503 100644
--- a/drivers/nfc/s3fwrn5/i2c.c
+++ b/drivers/nfc/s3fwrn5/i2c.c
@@ -200,13 +200,21 @@ static int s3fwrn5_i2c_parse_dt(struct i2c_client *client)
 	if (!np)
 		return -ENODEV;
 
-	phy->gpio_en = of_get_named_gpio(np, "s3fwrn5,en-gpios", 0);
-	if (!gpio_is_valid(phy->gpio_en))
-		return -ENODEV;
+	phy->gpio_en = of_get_named_gpio(np, "en-gpios", 0);
+	if (!gpio_is_valid(phy->gpio_en)) {
+		/* Support also deprecated property */
+		phy->gpio_en = of_get_named_gpio(np, "s3fwrn5,en-gpios", 0);
+		if (!gpio_is_valid(phy->gpio_en))
+			return -ENODEV;
+	}
 
-	phy->gpio_fw_wake = of_get_named_gpio(np, "s3fwrn5,fw-gpios", 0);
-	if (!gpio_is_valid(phy->gpio_fw_wake))
-		return -ENODEV;
+	phy->gpio_fw_wake = of_get_named_gpio(np, "wake-gpios", 0);
+	if (!gpio_is_valid(phy->gpio_fw_wake)) {
+		/* Support also deprecated property */
+		phy->gpio_fw_wake = of_get_named_gpio(np, "s3fwrn5,fw-gpios", 0);
+		if (!gpio_is_valid(phy->gpio_fw_wake))
+			return -ENODEV;
+	}
 
 	return 0;
 }
-- 
2.17.1

