Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3156EC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F7620678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586878696;
	bh=yoR8dnEAdxGB5gQMFS40YmgPThG76ZaPq9eo50kGaRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=T1cQovn98bJm3X6JLCsZoio6yUW2+uhJoy+wxjsNbtr9cfxJV+BbWrTZ5lZPAoQVj
	 Vg6vKRf48WCMjGTb26kxoVR+U9EClOohrjuWEWi+4HrD6HJgaj9q7slgWIpUm1/WN/
	 Ff3SMqFjxQhs+BSPCf2gZTP2JquM9B+B3ZuVAv9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440552AbgDNPiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:38:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440533AbgDNPh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:37:57 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD1702076D;
        Tue, 14 Apr 2020 15:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586878677;
        bh=yoR8dnEAdxGB5gQMFS40YmgPThG76ZaPq9eo50kGaRg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RpPFU7zuhfmDKC/jf/Kv/mDD2c8pXyV+TUZN9t80ZoxvPubI9QbCqpIS7DqGuM/Jd
         hvJbY3UwaAXaJLRVZ6DELMS9iAtDAUcc+oQleSj4gPk3mxmRacm3Rwxc7tW/56SxnR
         9oHhI/I/pMkXqa88XuvisJdmIvzmImmpk0aRo39c=
Date:   Tue, 14 Apr 2020 16:37:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     arnd@arndb.de, baolin.wang7@gmail.com, broonie@kernel.org,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
Subject: Applied "regmap: Add bus reg_update_bits() support" to the regmap tree
In-Reply-To:  <df32fd0529957d1e7e26ba1465723f16cfbe92c8.1586757922.git.baolin.wang7@gmail.com>
Message-Id:  <applied-df32fd0529957d1e7e26ba1465723f16cfbe92c8.1586757922.git.baolin.wang7@gmail.com>
X-Patchwork-Hint: ignore
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regmap: Add bus reg_update_bits() support

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

From 80215f133d59310fdfce5ee4398aeb7076c2e99f Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang7@gmail.com>
Date: Mon, 13 Apr 2020 14:13:20 +0800
Subject: [PATCH] regmap: Add bus reg_update_bits() support

Add reg_update_bits() support in case some platforms use a special method
to update bits of registers.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
Link: https://lore.kernel.org/r/df32fd0529957d1e7e26ba1465723f16cfbe92c8.1586757922.git.baolin.wang7@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 59f911e57719..553d92aa0c68 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -827,6 +827,7 @@ struct regmap *__regmap_init(struct device *dev,
 	} else if (!bus->read || !bus->write) {
 		map->reg_read = _regmap_bus_reg_read;
 		map->reg_write = _regmap_bus_reg_write;
+		map->reg_update_bits = bus->reg_update_bits;
 
 		map->defer_caching = false;
 		goto skip_format_initialization;
-- 
2.20.1

