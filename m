Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84499C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59BC92076B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586878682;
	bh=3DcWBMkHYt7UCLuJw2C+rh7kKvm6dei6Pct6rgtk3RM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=UFUhJFci1JzYbATHAEXAXMTriKu0Bs90OSVBgRYNphNLRVA3AWQsEP1Uhm+xTNcxx
	 xPwATgiH/VZUEhDTKY2o1yMRF3t/VBrl2Z60vousFijteUpXHew3MPxwobnW4feXlD
	 lmczd9URt13V6Wvif3G30scpCaOW4A8Ox+hrJof0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440538AbgDNPiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:38:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:58044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440524AbgDNPhq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:37:46 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75806206D5;
        Tue, 14 Apr 2020 15:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586878666;
        bh=3DcWBMkHYt7UCLuJw2C+rh7kKvm6dei6Pct6rgtk3RM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=J82j8tq+ov9dP3vL5aafeuxG4z7zN4VfHB4CwPjALkvYUJzA1ITED1XYqQn+Ky1IM
         4McW1PnbfX4fjeCA9v1Nee7LDWATYcmR0nh2fcLrQ/DA40isbw7ZJs2Cg6w2pSo2dE
         hm8egFNJbIpA8CUhP9sOnf+W+OD8ZjZejMGqfcwE=
Date:   Tue, 14 Apr 2020 16:37:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     broonie@kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: add reg_sequence helpers" to the regmap tree
In-Reply-To:  <20200402084111.30123-1-m.felsch@pengutronix.de>
Message-Id:  <applied-20200402084111.30123-1-m.felsch@pengutronix.de>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: add reg_sequence helpers

has been applied to the regmap tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git 

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

From bd3ddb495762575ab14e7bd2e4017dc1f9a80b2f Mon Sep 17 00:00:00 2001
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Thu, 2 Apr 2020 10:41:11 +0200
Subject: [PATCH] regmap: add reg_sequence helpers

Add helper to make it easier to define a reg_sequence array.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Link: https://lore.kernel.org/r/20200402084111.30123-1-m.felsch@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/regmap.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 40b07168fd8e..0b5582a78df8 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -71,6 +71,13 @@ struct reg_sequence {
 	unsigned int delay_us;
 };
 
+#define REG_SEQ(_reg, _def, _delay_us) {		\
+				.reg = _reg,		\
+				.def = _def,		\
+				.delay_us = _delay_us,	\
+				}
+#define REG_SEQ0(_reg, _def)	REG_SEQ(_reg, _def, 0)
+
 #define	regmap_update_bits(map, reg, mask, val) \
 	regmap_update_bits_base(map, reg, mask, val, NULL, false, false)
 #define	regmap_update_bits_async(map, reg, mask, val)\
-- 
2.20.1

