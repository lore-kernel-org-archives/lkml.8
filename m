Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC737C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35A024697
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814392;
	bh=SpY9AsGdg7XlSt1I/aCb8556rHUzr0sSJiiICFBDHVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vxCUKMJxqxs6COvT5vsu8lbZrkFu41z24ZorOEpQUAnz3+KFzqhQAUyV6NUyStTcN
	 i8IuIwFP1qw7pXSCzcxjvS8zZibof0YaMyPRPvjDU0+HQNHg68kV9cQiJHDQARDekf
	 nMaNUci3cAo70UfMKx8TeQfCKslMDs50qCx3u1/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387739AbgB0Ojv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:39:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731863AbgB0NyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:54:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E93992469F;
        Thu, 27 Feb 2020 13:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811663;
        bh=SpY9AsGdg7XlSt1I/aCb8556rHUzr0sSJiiICFBDHVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vWa8cTXM2exAdpckCzEF8KmkyCwfY+iCVZAXeImCCr0NZsmyscTUi8fkJ/qsoa3jc
         aijD1tkvLj+QDlIbPf36+YJYCQOw2witPpDFQr7Fk2kSiaStvQdcg2KABneOQRM4e8
         KZZjzJg2ScyxCHaAJLQX4VTs27C2CqJWHBAfFn3Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 053/237] pinctrl: baytrail: Do not clear IRQ flags on direct-irq enabled pins
Date:   Thu, 27 Feb 2020 14:34:27 +0100
Message-Id: <20200227132300.699040454@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit a23680594da7a9e2696dbcf4f023e9273e2fa40b ]

Suspending Goodix touchscreens requires changing the interrupt pin to
output before sending them a power-down command. Followed by wiggling
the interrupt pin to wake the device up, after which it is put back
in input mode.

On Bay Trail devices with a Goodix touchscreen direct-irq mode is used
in combination with listing the pin as a normal GpioIo resource.

This works fine, until the goodix driver gets rmmod-ed and then insmod-ed
again. In this case byt_gpio_disable_free() calls
byt_gpio_clear_triggering() which clears the IRQ flags and after that the
(direct) IRQ no longer triggers.

This commit fixes this by adding a check for the BYT_DIRECT_IRQ_EN flag
to byt_gpio_clear_triggering().

Note that byt_gpio_clear_triggering() only gets called from
byt_gpio_disable_free() for direct-irq enabled pins, as these are excluded
from the irq_valid mask by byt_init_irq_valid_mask().

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/intel/pinctrl-baytrail.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/intel/pinctrl-baytrail.c b/drivers/pinctrl/intel/pinctrl-baytrail.c
index 9df5d29d708da..4fb3e44f91331 100644
--- a/drivers/pinctrl/intel/pinctrl-baytrail.c
+++ b/drivers/pinctrl/intel/pinctrl-baytrail.c
@@ -958,7 +958,13 @@ static void byt_gpio_clear_triggering(struct byt_gpio *vg, unsigned int offset)
 
 	raw_spin_lock_irqsave(&byt_lock, flags);
 	value = readl(reg);
-	value &= ~(BYT_TRIG_POS | BYT_TRIG_NEG | BYT_TRIG_LVL);
+
+	/* Do not clear direct-irq enabled IRQs (from gpio_disable_free) */
+	if (value & BYT_DIRECT_IRQ_EN)
+		/* nothing to do */ ;
+	else
+		value &= ~(BYT_TRIG_POS | BYT_TRIG_NEG | BYT_TRIG_LVL);
+
 	writel(value, reg);
 	raw_spin_unlock_irqrestore(&byt_lock, flags);
 }
-- 
2.20.1



