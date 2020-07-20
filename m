Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24006C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:28:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E95B422C9C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595251703;
	bh=NJ2250te8v8tlFOpV4OLmV7BWL8Xr/txR4PHTbvuTSc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=11nGgFtRMW4Ao4Gh8BsKlYwjwI186Dhwjplc+/5sGOiKZyi3uS7mDBlvNrk7jHRf+
	 +buMAsxQKZmMNq/Fkb8XnOxGtc3OTnbwTqvr1QmI5XR4y4QjJcm3G41WKRxvx2+uQ/
	 M46CSEX9xaWFWrjDYWhixc74mrIKwqhm2tzIFC9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbgGTN2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTN2U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:28:20 -0400
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.194.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 421F120729;
        Mon, 20 Jul 2020 13:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595251700;
        bh=NJ2250te8v8tlFOpV4OLmV7BWL8Xr/txR4PHTbvuTSc=;
        h=From:To:Cc:Subject:Date:From;
        b=O7PlODg5hjUPIR3iNkhJ1WhJw3YJQ7pknCH6+wrbRPJi5hGiOcdeMmyBhpzXu6X2w
         +GGXhN+GeejEXiIvJJ3xu42rfGpwI74LxDPmA8l0UH7ulnWOEFT9US9PGdI0gNCTia
         oCxYTc+47UxBjAx93qtnPOa/bu2Qr8VmYbOq5oOU=
Received: by wens.tw (Postfix, from userid 1000)
        id CFAD55FC86; Mon, 20 Jul 2020 21:28:17 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
Subject: [PATCH v3] regulator: gpio: Honor regulator-boot-on property
Date:   Mon, 20 Jul 2020 21:28:09 +0800
Message-Id: <20200720132809.26908-1-wens@kernel.org>
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

Also add a comment stating that the enable-at-boot property should not
be used.

Fixes: 006694d099e8 ("regulator: gpio-regulator: Allow use of GPIO controlled regulators though DT")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
Changes since v2:
  - Keep enable-at-boot property support
  - Add comment stating enable-at-boot should not be used

Changes since v1:
  - Reworded commit log
  - Fixed typo in subject
---
 drivers/regulator/gpio-regulator.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/regulator/gpio-regulator.c b/drivers/regulator/gpio-regulator.c
index 110ee6fe76c4..044e45ee9629 100644
--- a/drivers/regulator/gpio-regulator.c
+++ b/drivers/regulator/gpio-regulator.c
@@ -148,6 +148,13 @@ of_get_gpio_regulator_config(struct device *dev, struct device_node *np,
 
 	config->supply_name = config->init_data->constraints.name;
 
+	if (config->init_data->constraints.boot_on)
+		config->enabled_at_boot = true;
+
+	/*
+	 * Do not use: undocumented device tree property.
+	 * This is kept around solely for device tree ABI stability.
+	 */
 	if (of_property_read_bool(np, "enable-at-boot"))
 		config->enabled_at_boot = true;
 
-- 
2.27.0

