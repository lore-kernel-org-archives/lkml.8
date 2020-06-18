Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DE7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD3C420885
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592447058;
	bh=EOEpLFrpL07cKV3jYLatlv8jhS7AwfBNhQfXh5nU21g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ks2/WbKYsE9fWq6Y0BQiJVDZnXInU97M4utwqgn3aWmroXuqiTcOiRrXnzBgCvbub
	 x0WG8fgDMXp2tMyv62HntFI2ESG/TCKsKTX+o+I1g4qAdcCBSLEMCerZyVfMIFIWXA
	 eNhTVfF/dE8mRE28El+iimwxv04xyTaBXDwWYCnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729071AbgFRCYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:24:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729170AbgFRBRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:17:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A958D21D79;
        Thu, 18 Jun 2020 01:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443065;
        bh=EOEpLFrpL07cKV3jYLatlv8jhS7AwfBNhQfXh5nU21g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJ8HMW+dToga0Q6yT60DxDHpEtb4py4pyxgpASQTYS7hPg3Q8HPyW67MsWKoG6XDR
         CJ/z5DvE26JeakskW1GCIOwptl7Y896PMWo7Tn7NcKEBxqPh+CShQkU6JNJSrvXhbH
         ORpUhL5sK98jAgBMeeYDJedmMmQkDEMa6JiwFMhY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>, patches@opensource.cirrus.com
Subject: [PATCH AUTOSEL 5.4 055/266] mfd: wm8994: Fix driver operation if loaded as modules
Date:   Wed, 17 Jun 2020 21:13:00 -0400
Message-Id: <20200618011631.604574-55-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit d4f9b5428b53dd67f49ee8deed8d4366ed6b1933 ]

WM8994 chip has built-in regulators, which might be used for chip
operation. They are controlled by a separate wm8994-regulator driver,
which should be loaded before this driver calls regulator_get(), because
that driver also provides consumer-supply mapping for the them. If that
driver is not yet loaded, regulator core substitute them with dummy
regulator, what breaks chip operation, because the built-in regulators are
never enabled. Fix this by annotating this driver with MODULE_SOFTDEP()
"pre" dependency to "wm8994_regulator" module.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/wm8994-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/wm8994-core.c b/drivers/mfd/wm8994-core.c
index 1e9fe7d92597..737dede4a95c 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -690,3 +690,4 @@ module_i2c_driver(wm8994_i2c_driver);
 MODULE_DESCRIPTION("Core support for the WM8994 audio CODEC");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
+MODULE_SOFTDEP("pre: wm8994_regulator");
-- 
2.25.1

