Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF71AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5D2F2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="iZsC/fm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391190AbgEYQH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 12:07:56 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:45263 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391148AbgEYQHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 12:07:55 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8E99422F2E;
        Mon, 25 May 2020 18:07:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1590422873;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Lhl17HX17vWOiAlEkuHl4r5UHiKHh3vCeJE3HYnlJGQ=;
        b=iZsC/fm+utR+kq8WB1bSsEV+ti1j0PGfpqToTT0yvfxt4vjP4VNICJHj6tNi7Xb+gQ738S
        40gsMGgXg6w/OdqzyKa8M8A1muCd8G4HEymcAbQF1ZgNQGhQDUe6XwN9BVvR9Od1G15HYT
        GlTBceIx4Oc404S0p5xAWSb01XxPn+k=
From:   Michael Walle <michael@walle.cc>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v4 0/2] gpio: generic regmap implementation
Date:   Mon, 25 May 2020 18:07:39 +0200
Message-Id: <20200525160741.21729-1-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a split off of the sl28cpld series:
https://lore.kernel.org/linux-gpio/20200423174543.17161-1-michael@walle.cc/

I wasn't sure if I should also include the gpiochip_irqchip_add_domain()
patch here. So feel free to skip it. OTOH if you use interrupts with
gpio-regmap it is quite handy.

For an actual user see the patch 11/16 ("gpio: add support for the sl28cpld
GPIO controller") of the series above.

Changes since v3:
 - set reg_dat_base, that was actually broken
 - fix typo
 - fix swapped reg_in_dir/reg_out_dir documentation
 - use "goto err" in error path in gpio_regmap_register()

Changes since v2:
 See changelog in the former patch series.

Michael Walle (2):
  gpiolib: Introduce gpiochip_irqchip_add_domain()
  gpio: add a reusable generic gpio_chip using regmap

 drivers/gpio/Kconfig        |   4 +
 drivers/gpio/Makefile       |   1 +
 drivers/gpio/gpio-regmap.c  | 343 ++++++++++++++++++++++++++++++++++++
 drivers/gpio/gpiolib.c      |  20 +++
 include/linux/gpio-regmap.h |  69 ++++++++
 include/linux/gpio/driver.h |   3 +
 6 files changed, 440 insertions(+)
 create mode 100644 drivers/gpio/gpio-regmap.c
 create mode 100644 include/linux/gpio-regmap.h

-- 
2.20.1

