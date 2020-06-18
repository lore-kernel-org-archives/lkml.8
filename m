Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42DCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8946C206F7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592444727;
	bh=WMSSxLlp0/ZaTJ4TLfHiw0XFmnBGQrGSj2HVAH+vOnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y45ea069roz6tTdG2xcdwKIS3Ba7xrpsjYRix2ZThsYvBKBbDXQ2Jt3IfKZ6849o3
	 rmzM6q0DXhmSsC+5iUmAglDmYJcEFlAYJKxNlbXFyy9SoT2Wo7sXFN7abVdyBjCJQx
	 +s1GEKQIAFRDgVZCcI1YCU4qBjmEUc+TaGg0l3jk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbgFRBp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:45:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732140AbgFRB2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:28:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 857532220D;
        Thu, 18 Jun 2020 01:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443722;
        bh=WMSSxLlp0/ZaTJ4TLfHiw0XFmnBGQrGSj2HVAH+vOnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WtgsyIRaZ9CJyOQFPyjIqwrv7y0zZI+Ge2vghQnPq3UAcWyko3X1g/GYTF6NfCKBn
         3lISS8MKwxYn0Zi20xsd6+9dDnqTk2ULaAwnJFAOoCtsp0JNweyAfdAcfH9ZX294E/
         dvN7g+zPJyrKqTfoArsFfHnz1LidMu7BY4vEdIgU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>, patches@opensource.cirrus.com
Subject: [PATCH AUTOSEL 4.9 18/80] mfd: wm8994: Fix driver operation if loaded as modules
Date:   Wed, 17 Jun 2020 21:27:17 -0400
Message-Id: <20200618012819.609778-18-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618012819.609778-1-sashal@kernel.org>
References: <20200618012819.609778-1-sashal@kernel.org>
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
index 8588dbad3301..925c1828ec28 100644
--- a/drivers/mfd/wm8994-core.c
+++ b/drivers/mfd/wm8994-core.c
@@ -698,3 +698,4 @@ module_i2c_driver(wm8994_i2c_driver);
 MODULE_DESCRIPTION("Core support for the WM8994 audio CODEC");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Mark Brown <broonie@opensource.wolfsonmicro.com>");
+MODULE_SOFTDEP("pre: wm8994_regulator");
-- 
2.25.1

