Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74E0C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B099320848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583507029;
	bh=tsLJQo5g76IdhhvV8GDVa0HgUrSzXjBd2wRaU/DOCHI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=oJ5D6PBU4ZyBEdHoufHupXIKJ7Is5AcrAWzNyI8QaaDKdCjCxDrSTvxw17T+zGadn
	 wyCYwihqmEHvwlG53ckaOcMLE2vLfWFT7IhaILONiX1Q/dVyG0HsqEeXq0mTNVGru5
	 5aWYyCA384COo5df6aThc9MXtuX2WjvE6HfROurk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgCFPDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 10:03:48 -0500
Received: from foss.arm.com ([217.140.110.172]:35202 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgCFPDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 10:03:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE34030E;
        Fri,  6 Mar 2020 07:03:47 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62EEB3F237;
        Fri,  6 Mar 2020 07:03:47 -0800 (PST)
Date:   Fri, 06 Mar 2020 15:03:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>
Subject: Applied "ASoC: wcd934x: remove unused headers" to the asoc tree
In-Reply-To:  <20200306132806.19684-3-srinivas.kandagatla@linaro.org>
Message-Id:  <applied-20200306132806.19684-3-srinivas.kandagatla@linaro.org>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: wcd934x: remove unused headers

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From e0e247d593f78f4ac5647a9ef2c6db8f918ecbdc Mon Sep 17 00:00:00 2001
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Date: Fri, 6 Mar 2020 13:28:06 +0000
Subject: [PATCH] ASoC: wcd934x: remove unused headers

Looks like there are some unused headers, remove them.
Seems to be missed while moving to mfd.

Reported-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20200306132806.19684-3-srinivas.kandagatla@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wcd934x.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 83d643a07775..5269857e2746 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -3,7 +3,6 @@
 
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
-#include <linux/gpio.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/mfd/wcd934x/registers.h>
@@ -11,10 +10,7 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of_clk.h>
-#include <linux/of_device.h>
-#include <linux/of_gpio.h>
 #include <linux/of.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
-- 
2.20.1

