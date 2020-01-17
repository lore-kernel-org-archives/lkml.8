Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524D6C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C4252072E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 15:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579275862;
	bh=PLGG5v2UjtFrJh7Ix0P046cuCtmSFKLW+sw9968VJTw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=pCnkazagjtRNGZs431GmNjgyYTNwa4a1Dxp6Jw8BEuBAfeECrysTrFsSIuYrj8t4l
	 jUwXtOuas5FpAYE+YcWsIBawkzHkgCMLuxk1EZSa3utAXcUdeC5YvJkNMKI5ATrUZa
	 ibK+ayOaPZN2Av+sEC/OTqWsCo63FRP9SbDLIiPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgAQPoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 10:44:21 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:53660 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728780AbgAQPoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 10:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=MO5mnIdK1revfmpWP6iIsmX9v4V7hiNKb4UKiswsbnc=; b=Ij5qe4j5ge+X
        DJVob3VXbx8oOuN1pES+Uzm2ZaWYbqITKdIh1wEantG/FQA78d1/Kjeif1n7m71LOzTMED5mchDzW
        EjvRN9mBcvSoGx4byc0meLChSBsEu+VQgcDls4/7UUx8ZkLzcaJdgwsHXz2FwsnSj2tMSzMHfPT9H
        4SitY=;
Received: from fw-tnat-cam4.arm.com ([217.140.106.52] helo=fitzroy.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <broonie@sirena.org.uk>)
        id 1isTnG-0006tt-Ej; Fri, 17 Jan 2020 15:44:18 +0000
Received: by fitzroy.sirena.org.uk (Postfix, from userid 1000)
        id 21A02D02A2A; Fri, 17 Jan 2020 15:44:18 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: Applied "regulator: mpq7920: Fix incorrect defines" to the regulator tree
In-Reply-To: <20200115002953.14731-1-axel.lin@ingics.com>
Message-Id: <applied-20200115002953.14731-1-axel.lin@ingics.com>
X-Patchwork-Hint: ignore
Date:   Fri, 17 Jan 2020 15:44:18 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mpq7920: Fix incorrect defines

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.6

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 53ba2f1aa3860f7ea0bf81543aab4a66af3f01d0 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 15 Jan 2020 08:29:53 +0800
Subject: [PATCH] regulator: mpq7920: Fix incorrect defines

Fix defines for MPQ7920_MASK_BUCK_ILIM and MPQ7920_DISCHARGE_ON
Remove unused MPQ7920_REG_REGULATOR_EN1.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Link: https://lore.kernel.org/r/20200115002953.14731-1-axel.lin@ingics.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mpq7920.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/mpq7920.h b/drivers/regulator/mpq7920.h
index 1498a1e3f4f5..489924655a96 100644
--- a/drivers/regulator/mpq7920.h
+++ b/drivers/regulator/mpq7920.h
@@ -43,11 +43,10 @@
 #define MPQ7920_LDO5_REG_B		0x1e
 #define MPQ7920_LDO5_REG_C		0x1f
 #define MPQ7920_REG_MODE		0x20
-#define MPQ7920_REG_REGULATOR_EN1	0x22
 #define MPQ7920_REG_REGULATOR_EN	0x22
 
 #define MPQ7920_MASK_VREF		0x7f
-#define MPQ7920_MASK_BUCK_ILIM		0xd0
+#define MPQ7920_MASK_BUCK_ILIM		0xc0
 #define MPQ7920_MASK_LDO_ILIM		BIT(6)
 #define MPQ7920_MASK_DISCHARGE		BIT(5)
 #define MPQ7920_MASK_MODE		0xc0
@@ -57,7 +56,7 @@
 #define MPQ7920_MASK_DVS_SLEWRATE	0xc0
 #define MPQ7920_MASK_OVP		0x40
 #define MPQ7920_OVP_DISABLE		~(0x40)
-#define MPQ7920_DISCHARGE_ON		0x1
+#define MPQ7920_DISCHARGE_ON		BIT(5)
 
 #define MPQ7920_REGULATOR_EN_OFFSET	7
 
-- 
2.20.1

