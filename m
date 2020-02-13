Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B95AC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EE8C217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608158;
	bh=JaT4aqIPA7sdBwL/lS10pKXWhXxQ6KJQqjdsG1m/SVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y1Wxpz3/Ez1wxujNKtaQIqUYtgOZei5rw3O78E9vbfQioKSySMXM+ZLporU+pt5Xo
	 I5kgKh1oyMSOINHz7cmzjRdvRMDAQLvI1LUs6wmfHWo4X2cvodR3ZMUmcfcWWKzYMR
	 uhru2Q8RFmVVUBBdVs6X2rB3U/P/6K6t9jOykVEA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgBMPbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:31:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:52460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729058AbgBMP1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:27:49 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F88F218AC;
        Thu, 13 Feb 2020 15:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607668;
        bh=JaT4aqIPA7sdBwL/lS10pKXWhXxQ6KJQqjdsG1m/SVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bGZcpA9zZQP37xeEpk9HgpWI/WhL+nizYp0rOI8NmFQ1XZJY0J121weYzMD6te0i1
         qPre/ZhJN5ztFGncmR932ZucrFpVbF+WpftgyG171XNH0GiJZXTshuVc+MEZ1DTGqo
         +txWGDoi3bkBG3kn6hB4LzPbNqkRoYyWLOmdpOfc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Gazzillo <paul@pgazz.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 5.4 90/96] mfd: max77650: Select REGMAP_IRQ in Kconfig
Date:   Thu, 13 Feb 2020 07:21:37 -0800
Message-Id: <20200213151912.714627653@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151839.156309910@linuxfoundation.org>
References: <20200213151839.156309910@linuxfoundation.org>
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


