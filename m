Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D74C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 020CA22BEF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 10:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595239281;
	bh=LVubc+F0JQI4FQaSy7JIShrF/KXQ3v3Jg/s4/IEFm8o=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BEpzoZUIGpaBIo6F5rhspiplBFMQ4AIilQVxVzFbcidoopkABmJw7bDZtTqfdz4hl
	 ALQwXje6qRwu6z0x5Tb+txppy/63W5Ok7bGpWAApC33Ct269MX8aV/NuR3LcLXuWgv
	 NgveW5xLWQZ2nbkHCJXjEZ4ESvQecXmCUIqlKTQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgGTKBT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 06:01:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgGTKBT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 06:01:19 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.194.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FB1B21775;
        Mon, 20 Jul 2020 10:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595239278;
        bh=LVubc+F0JQI4FQaSy7JIShrF/KXQ3v3Jg/s4/IEFm8o=;
        h=From:To:Cc:Subject:Date:From;
        b=RfDRxT0LglMSisisyD29I5hbPDUDhHBF/mLSSNWuh950m1n7hZY6rKeN9DgcmxrDc
         Bj/CQ3C67v6hzRfQw9ydcgEUF8s9MASPhnZEgtWzD1oFJiekLmyT5bE4cSu3+ZjYqB
         W/r+tioH9xGDGzjD3QNFFnbEWExF27ijOziYLqaQ=
Received: by wens.tw (Postfix, from userid 1000)
        id 29FF95FC86; Mon, 20 Jul 2020 18:01:16 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v2] regulator: gpio: Honor regulator-boot-on property
Date:   Mon, 20 Jul 2020 18:01:13 +0800
Message-Id: <20200720100113.6481-1-wens@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

When requesting the enable GPIO, the driver should do so with the
correct output level matching some expected state. This is especially
important if the regulator is a critical one, such as a supply for
the boot CPU. This is currently done by checking for the enable-at-boot
property, but this is not documented in the device tree binding, nor
does it match the common regulator properties.

Honor the common regulator-boot-on property by checking the boot_on
constraint setting within the DT probe path. This is the same as what
is done in the fixed regulator driver.

Also drop support for the undocumented enable-at-boot property. This
property was not documented in the original commit introducing DT
support, nor is it now, and there are no in-tree device trees that use
this property.

Fixes: 006694d099e8 ("regulator: gpio-regulator: Allow use of GPIO controlled regulators though DT")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/regulator/gpio-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 110ee6fe76c4..5646b7a26288 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -148,7 +148,7 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 
 	config->supply_name = config->init_data->constraints.name;
 
-	if (of_property_read_bool(np, "enable-at-boot"))
+	if (config->init_data->constraints.boot_on)
 		config->enabled_at_boot = true;
 
 	of_property_read_u32(np, "startup-delay-us", &config->startup_delay);
-- 
2.27.0

