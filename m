Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B058BC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FFD2476A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581697385;
	bh=ZKUtbs4x9z+XJALSmUTrVhdPGVdU/ZvRtqluld9BoZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UiuRc9An3yaSQe1f1UCf+F3CQKBIVGO2st7XPOoyXV66LJCCnWLhfSigm7uHdCtxx
	 mn4nIdjcFjkyPOzy+pX2o7b1tkkfZfgvnVQL7nyBNbvdk9NZlHiF4FN94HyuArRIe/
	 gYqsx3Vuz+ZyiX6cx8sLSYxGkfKhe2f7Rj/iE/Ks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393329AbgBNQXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:23:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:56516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393067AbgBNQVm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:21:42 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 507B0246C0;
        Fri, 14 Feb 2020 16:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697302;
        bh=ZKUtbs4x9z+XJALSmUTrVhdPGVdU/ZvRtqluld9BoZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QTMKwkhNpu+t47t/63Yh47gl+aa6X936gcYEJtCzkqa0ugZ53qudbAHqbSwUNn5c8
         aUHj7k0XR8bmQqwa384j/fdz/rqTqPZzonudaROlWx9h8trqS6PMiuvQynAr/yfJoR
         bgFXZNAv5urh7m7qyvISnYHTyq8gzqBtLEbBtBCE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 015/141] pinctrl: baytrail: Do not clear IRQ flags on direct-irq enabled pins
Date:   Fri, 14 Feb 2020 11:19:15 -0500
Message-Id: <20200214162122.19794-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214162122.19794-1-sashal@kernel.org>
References: <20200214162122.19794-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index f83a2a60d9c9b..1e945aa77734b 100644
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

