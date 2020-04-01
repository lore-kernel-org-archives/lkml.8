Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8199C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CBD20BED
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758498;
	bh=osVIca6bYVnHqNC/TdjKIzwH1ccKO70hUhKTlUZOtkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=z1JXTsic4CH4DR9McqJY/DUnayCIybIlbs6pc8NuluJQhAyDMpnmqZguwP7FnwOQu
	 PYt3p1XqYscuE0HxY6o2T6+JHyl0sSmmX41ceb4ynWJh8vCEbKJGLK8thdsVD1m/uk
	 BRQPecGc6/67LHf8vTOWIi29bcoKqEb1adlo/wKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387499AbgDAQ2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:28:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:53548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388078AbgDAQ2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:28:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E14B20BED;
        Wed,  1 Apr 2020 16:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758494;
        bh=osVIca6bYVnHqNC/TdjKIzwH1ccKO70hUhKTlUZOtkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2cgFzfWvdhu/X7jWO9RaN/f8wpA6kr06LtXoROopqSumohEpSBoM27EUFHicUTxwd
         Ge1IytZwFd+Oi/FgpGE3j5GClpctV+3/2a5HiiT+mXmlxuy7p4PIv5skgR2ZEsSzY1
         7pWGe9/JBeEwHUD1wz5Dej7ch8G3OKc5oQLvYDs0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marc Lehmann <schmorp@schmorp.de>
Subject: [PATCH 4.19 107/116] gpiolib: acpi: Add quirk to ignore EC wakeups on HP x2 10 CHT + AXP288 model
Date:   Wed,  1 Apr 2020 18:18:03 +0200
Message-Id: <20200401161555.852764311@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161542.669484650@linuxfoundation.org>
References: <20200401161542.669484650@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

commit 0c625ccfe6f754d0896b8881f5c85bcb81699f1f upstream.

There are at least 3 models of the HP x2 10 models:

Bay Trail SoC + AXP288 PMIC
Cherry Trail SoC + AXP288 PMIC
Cherry Trail SoC + TI PMIC

Like on the other HP x2 10 models we need to ignore wakeup for ACPI GPIO
events on the external embedded-controller pin to avoid spurious wakeups
on the HP x2 10 CHT + AXP288 model too.

This commit adds an extra DMI based quirk for the HP x2 10 CHT + AXP288
model, ignoring wakeups for ACPI GPIO events on the EC interrupt pin
on this model. This fixes spurious wakeups from suspend on this model.

Fixes: aa23ca3d98f7 ("gpiolib: acpi: Add honor_wakeup module-option + quirk mechanism")
Reported-and-tested-by: Marc Lehmann <schmorp@schmorp.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20200302111225.6641-4-hdegoede@redhat.com
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpio/gpiolib-acpi.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/drivers/gpio/gpiolib-acpi.c
+++ b/drivers/gpio/gpiolib-acpi.c
@@ -1391,6 +1391,21 @@ static const struct dmi_system_id gpioli
 			.ignore_wake = "INT33FC:02@28",
 		},
 	},
+	{
+		/*
+		 * HP X2 10 models with Cherry Trail SoC + AXP288 PMIC use an
+		 * external embedded-controller connected via I2C + an ACPI GPIO
+		 * event handler on INT33FF:01 pin 0, causing spurious wakeups.
+		 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP Pavilion x2 Detachable"),
+			DMI_MATCH(DMI_BOARD_NAME, "813E"),
+		},
+		.driver_data = &(struct acpi_gpiolib_dmi_quirk) {
+			.ignore_wake = "INT33FF:01@0",
+		},
+	},
 	{} /* Terminating entry */
 };
 


