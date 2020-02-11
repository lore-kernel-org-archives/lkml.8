Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C57AC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B3F920714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581436314;
	bh=CW1ALRzDXQKDKjDV68hTjg2ZVzH2pIsj1iKoOAQXkIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=SPw0OBYCCrl5dfFpdvjYbdQr7QBlOrCQKxrHzOdUbyKwPcOX8biSAvjjTb/533fzJ
	 KE457AV6BhKf3zfF0sxy7Vx74zY0ig1lm507HwE4xz+HWh5UTSrUCiCSShpB9o9Rd3
	 quZ9VItkqblGF00X6HEhBCRLYw6BTB6nC+R+MTfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730662AbgBKPvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:51:54 -0500
Received: from foss.arm.com ([217.140.110.172]:48946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730647AbgBKPvv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:51:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D032030E;
        Tue, 11 Feb 2020 07:51:50 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 563D13F68E;
        Tue, 11 Feb 2020 07:51:50 -0800 (PST)
Date:   Tue, 11 Feb 2020 15:51:48 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Alok Chauhan <alokc@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-geni-qcom: Drop of.h include" to the spi tree
In-Reply-To: <20200204191206.97036-4-swboyd@chromium.org>
Message-Id: <applied-20200204191206.97036-4-swboyd@chromium.org>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   spi: spi-geni-qcom: Drop of.h include

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.7

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

From 875014cb79ea4251e8800994640be1a8012b4133 Mon Sep 17 00:00:00 2001
From: Stephen Boyd <swboyd@chromium.org>
Date: Tue, 4 Feb 2020 11:12:06 -0800
Subject: [PATCH] spi: spi-geni-qcom: Drop of.h include

This driver doesn't call any DT functions like of_get_property(). Remove
the of.h include as it isn't used.

Cc: Girish Mahadevan <girishm@codeaurora.org>
Cc: Dilip Kota <dkota@codeaurora.org>
Cc: Alok Chauhan <alokc@codeaurora.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20200204191206.97036-4-swboyd@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-geni-qcom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index f0ca7f5ae714..c3972424af71 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -6,7 +6,6 @@
 #include <linux/io.h>
 #include <linux/log2.h>
 #include <linux/module.h>
-#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/qcom-geni-se.h>
-- 
2.20.1

