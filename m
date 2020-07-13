Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9450DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 716E1206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:58:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbgGMI6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:58:33 -0400
Received: from host-88-217-225-28.customer.m-online.net ([88.217.225.28]:62342
        "EHLO mail.dev.tdt.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726077AbgGMI6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:58:33 -0400
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jul 2020 04:58:32 EDT
Received: from feckert.dev.tdt.de (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id 035D1204FC;
        Mon, 13 Jul 2020 08:50:20 +0000 (UTC)
From:   Florian Eckert <fe@dev.tdt.de>
To:     info@metux.net, vhart@infradead.org, andy@infradead.org,
        Eckert.Florian@googlemail.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Eckert <fe@dev.tdt.de>
Subject: [PATCH 1/1] platform/x86: revert pcengines-apuv2 wire up simswitch gpio as led
Date:   Mon, 13 Jul 2020 10:50:10 +0200
Message-Id: <20200713085010.26394-1-fe@dev.tdt.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 5037d4ddda31c2dbbb018109655f61054b1756dc.

Explanation why this does not work:
This change connects the simswap to the LED subsystem of the kernel.
From my point of view, it's nonsense. If we do it this way, then this
can be switched relatively easily via the LED subsystem (trigger:
none/default-on) and that is dangerous! If this is used, it would be
unfavorable, since there is also another trigger (trigger:
heartbeat/netdev).

Therefore, this simswap GPIO should remain in the GPIO
subsystem and be switched via it and not be connected to the LED
subsystem. To avoid the problems mentioned above. The LED subsystem is
not made for this and it is not a good compromise, but rather dangerous.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/platform/x86/pcengines-apuv2.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/platform/x86/pcengines-apuv2.c b/drivers/platform/x86/pcengines-apuv2.c
index 9b11ef1a401f..6aff6cf41414 100644
--- a/drivers/platform/x86/pcengines-apuv2.c
+++ b/drivers/platform/x86/pcengines-apuv2.c
@@ -78,7 +78,6 @@ static const struct gpio_led apu2_leds[] = {
 	{ .name = "apu:green:1" },
 	{ .name = "apu:green:2" },
 	{ .name = "apu:green:3" },
-	{ .name = "apu:simswap" },
 };
 
 static const struct gpio_led_platform_data apu2_leds_pdata = {
@@ -95,8 +94,6 @@ static struct gpiod_lookup_table gpios_led_table = {
 				NULL, 1, GPIO_ACTIVE_LOW),
 		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_LED3,
 				NULL, 2, GPIO_ACTIVE_LOW),
-		GPIO_LOOKUP_IDX(AMD_FCH_GPIO_DRIVER_NAME, APU2_GPIO_LINE_SIMSWAP,
-				NULL, 3, GPIO_ACTIVE_LOW),
 	}
 };
 
-- 
2.20.1

