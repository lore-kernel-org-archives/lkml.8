Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20070C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3383206D3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbgA0Kfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 05:35:48 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43611 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbgA0Kfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:35:47 -0500
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1iw1k8-0003WU-V3; Mon, 27 Jan 2020 11:35:44 +0100
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1iw1k7-0002Ty-Lo; Mon, 27 Jan 2020 11:35:43 +0100
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Markus Pietrek <mpie@msc-ge.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V1] eeprom: at24: add TPF0001 ACPI ID for 24c1024 device
Date:   Mon, 27 Jan 2020 11:35:41 +0100
Message-Id: <20200127103541.6975-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Pietrek <mpie@msc-ge.com>

This ID is used at leas on some variants of MSC C6B-SLH board.

Signed-off-by: Markus Pietrek <mpie@msc-ge.com>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/misc/eeprom/at24.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/eeprom/at24.c b/drivers/misc/eeprom/at24.c
index 2cccd82a3106..1c8e2ff96d9d 100644
--- a/drivers/misc/eeprom/at24.c
+++ b/drivers/misc/eeprom/at24.c
@@ -228,6 +228,7 @@ MODULE_DEVICE_TABLE(of, at24_of_match);
 
 static const struct acpi_device_id at24_acpi_ids[] = {
 	{ "INT3499",	(kernel_ulong_t)&at24_data_INT3499 },
+	{ "TPF0001",	(kernel_ulong_t)&at24_data_24c1024 },
 	{ /* END OF LIST */ }
 };
 MODULE_DEVICE_TABLE(acpi, at24_acpi_ids);
-- 
2.25.0

