Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93BFC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872A820708
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581436283;
	bh=Mtx1xU/E0k84g5iO+oGAnMEJw4O0SfA58856oXy0qXk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=WH1gShhGSgQzd6pG3rl0GzhyXHfB1nclHPeu6iinVvfv8ZKr5AfVjSdVV46JlQI1g
	 wvvKQayzGK0b51LrcIxl4NPo1+jwl2b0QoNiu/zD4XaQQIKlTuyNym3yZNnP2LK12O
	 PlJ6v6FuWmfAiKMwtvjLJTf+BuuHYkzqb+oqn2uQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgBKPvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:51:23 -0500
Received: from foss.arm.com ([217.140.110.172]:48782 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbgBKPvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:51:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B23230E;
        Tue, 11 Feb 2020 07:51:22 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4B933F68E;
        Tue, 11 Feb 2020 07:51:21 -0800 (PST)
Date:   Tue, 11 Feb 2020 15:51:20 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     broonie@kernel.org, davem@davemloft.net,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        Jonathan.Cameron@huawei.com, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        mark.rutland@arm.com, mchehab+samsung@kernel.org,
        robh+dt@kernel.org, sravanhome@gmail.com
Subject: Applied "MAINTAINERS: Add entry for mp5416 PMIC driver" to the regulator tree
In-Reply-To: <20200204110419.25933-4-sravanhome@gmail.com>
Message-Id: <applied-20200204110419.25933-4-sravanhome@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   MAINTAINERS: Add entry for mp5416 PMIC driver

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-5.7

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

From c1e1fa0ae5ba99f502bd2f5a4fd34d0ea22f1fdf Mon Sep 17 00:00:00 2001
From: Saravanan Sekar <sravanhome@gmail.com>
Date: Tue, 4 Feb 2020 12:04:19 +0100
Subject: [PATCH] MAINTAINERS: Add entry for mp5416 PMIC driver

Add MAINTAINERS entry for Monolithic Power Systems mp5416 PMIC driver.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Link: https://lore.kernel.org/r/20200204110419.25933-4-sravanhome@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 38fe2f3f7b6f..060d48e5615c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11259,7 +11259,8 @@ F:	drivers/tty/mxser.*
 MONOLITHIC POWER SYSTEM PMIC DRIVER
 M:	Saravanan Sekar <sravanhome@gmail.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/regulator/mpq7920.yaml
+F:	Documentation/devicetree/bindings/regulator/mps,mp*.yaml
+F:	drivers/regulator/mp5416.c
 F:	drivers/regulator/mpq7920.c
 F:	drivers/regulator/mpq7920.h
 
-- 
2.20.1

