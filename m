Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590C9C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F00A02063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759735;
	bh=MfcDThaTPKmBvoit5K+m3YHIT6p5iRuI/Pc5lZ+tk3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X7A091LUJ0iNnteMBa81mL2OzsSA/DzQxfVVrJtjZ7LMdgqXjC/hncS0l+049a+Rx
	 UZ9S4T/BR4/JxyFHXMSKuyM4SdJbQvS7EG/SqL9PLvWJD3ZPiDWNCPxt7hdjsk/L0v
	 +6fgszXsWlZJb8XH6ANxwIVFujIeXqJ9se+0J9cA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389597AbgDAQpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:45:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389527AbgDAQpE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:45:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C20FE2071A;
        Wed,  1 Apr 2020 16:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759503;
        bh=MfcDThaTPKmBvoit5K+m3YHIT6p5iRuI/Pc5lZ+tk3o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TUua4RUml5lUdav+A2wV7f0t04j1fituV3zoCWa8BTV5xkpjUwJ06RF/0dNZAGMfY
         cS0YdzwxIMwJFVrbjJyw980S3LUUEt1bYmlyaNRODFt4kY9m5kcw08gqKlqpi2RPl1
         2+SAIzbumccprkTb/zjrK1C2a9H7rMndI87e1wyU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4.14 100/148] gpiolib: acpi: Add quirk to ignore EC wakeups on HP x2 10 BYT + AXP288 model
Date:   Wed,  1 Apr 2020 18:18:12 +0200
Message-Id: <20200401161602.404317194@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 0e91506ba00730f088961a8d39f8693b0f8e3fea upstream.

Commit aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option +
quirk mechanism") was added to deal with spurious wakeups on one specific
model of the HP x2 10 series. In the mean time I have learned that there
are at least 3 different HP x2 10 models:

Bay Trail SoC + AXP288 PMIC
Cherry Trail SoC + AXP288 PMIC
Cherry Trail SoC + TI PMIC

And the original quirk is only correct for (and only matches the)
Cherry Trail SoC + TI PMIC model.

The Bay Trail SoC + AXP288 PMIC model has different DMI strings, has
the external EC interrupt on a different GPIO pin and only needs to ignore
wakeups on the EC interrupt, the INT0002 device works fine on this model.

This commit adds an extra DMI based quirk for the HP x2 10 BYT + AXP288
model, ignoring wakeups for ACPI GPIO events on the EC interrupt pin
on this model. This fixes spurious wakeups from suspend on this model.

Fixes: aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option + quirk mechanism")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20200302111225.6641-3-hdegoede@redhat.com
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpiolib-acpi.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1425,6 +1425,21 @@ static const struct dmi_system_id gpioli
 			.ignore_wake = "INT33FF:01@0,INT0002:00@2",
 		},
 	},
+	{
+		/*
+		 * HP X2 10 models with Bay Trail SoC + AXP288 PMIC use an
+		 * external embedded-controller connected via I2C + an ACPI GPIO
+		 * event handler on INT33FC:02 pin 28, causing spurious wakeups.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Hewlett-Packard"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion x2 Detachable"),
+			DMI_MATCH(DMI_BOARD_NAME, "815D"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "INT33FC:02@28",
+		},
+	},
 	{} /* Terminating entry */
 };
 


