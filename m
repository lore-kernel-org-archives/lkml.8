Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A96C3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208B720675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608057;
	bh=JaT4aqIPA7sdBwL/lS10pKXWhXxQ6KJQqjdsG1m/SVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y3YMt/28VlvRR22dK8HQCQ1/GhLZ3ZZb4mzYTHDaP9C5rhPNAYzd5LQ880rEztMep
	 W8+GVow8kCWxBZWCgcf3Fcj0kl7TM8gBCsHENh8HBRoc8XlOdZEk7q4CGQHtKBXLbO
	 tYblLp/WQ8SAM2MWo1+koICVl7038pyRTjOBCl5I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729922AbgBMPeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:34:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:59982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387819AbgBMP3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:29:20 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64CFA222C2;
        Thu, 13 Feb 2020 15:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607759;
        bh=JaT4aqIPA7sdBwL/lS10pKXWhXxQ6KJQqjdsG1m/SVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HwF8gUyYrgPjXmmjdbpg3i8J7RrjQGbVJziG6PR+T47ItoAfmXXtFKkYgGhuVnBky
         QpiBZfJ23x3M3DXLqHufT3/yNnZgpAVZTVbnYbdNv/Ehwndk+5oXSzYp9J2zf4f2Fw
         9Zl4YkKGZBKAy2m3+Wa+h6pfl2vSrlsYORIvGIjk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Gazzillo <paul@pgazz.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 5.5 114/120] mfd: max77650: Select REGMAP_IRQ in Kconfig
Date:   Thu, 13 Feb 2020 07:21:50 -0800
Message-Id: <20200213151938.589101176@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

commit cb7a374a5e7a5af3f8c839f74439193add6d0589 upstream.

MAX77650 MFD driver uses regmap_irq API but doesn't select the required
REGMAP_IRQ option in Kconfig. This can cause the following build error
if regmap irq is not enabled implicitly by someone else:

    ld: drivers/mfd/max77650.o: in function `max77650_i2c_probe':
    max77650.c:(.text+0xcb): undefined reference to `devm_regmap_add_irq_chip'
    ld: max77650.c:(.text+0xdb): undefined reference to `regmap_irq_get_domain'
    make: *** [Makefile:1079: vmlinux] Error 1

Fix it by adding the missing option.

Fixes: d0f60334500b ("mfd: Add new driver for MAX77650 PMIC")
Reported-by: Paul Gazzillo <paul@pgazz.com>
Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mfd/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -758,6 +758,7 @@ config MFD_MAX77650
 	depends on OF || COMPILE_TEST
 	select MFD_CORE
 	select REGMAP_I2C
+	select REGMAP_IRQ
 	help
 	  Say Y here to add support for Maxim Semiconductor MAX77650 and
 	  MAX77651 Power Management ICs. This is the core multifunction


