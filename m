Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 157F3C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 20:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C7E20716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 20:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Lo3CWjR9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgA2UvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 15:51:23 -0500
Received: from ned.t-8ch.de ([212.47.237.191]:44316 "EHLO ned.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726618AbgA2UvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 15:51:14 -0500
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1580330625;
        bh=pD9DOP8o4NJhC/UfLuYM3FwTvcditszUCwuLr1jQOhI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lo3CWjR9+PQBenoD9/aUC4/pQkmeeNo0mSR7gtu4Mr27/32rP6HNnF3bBvzIwddal
         AVjq3GFWu3rj3QbcU1DbDhvAPP/Rk/oaBtvk7/Lz1ojFclLcdPpouOdc1B9IhaGURT
         DtLRKedTklhZUD18jesweSiH97PFcxiqqYO9umoE=
To:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 3/3] platform/x86: thinkpad_acpi: restore old battery charge attributes
Date:   Wed, 29 Jan 2020 21:43:38 +0100
Message-Id: <20200129204338.4055-4-linux@weissschuh.net>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200129204338.4055-3-linux@weissschuh.net>
References: <20200129204338.4055-1-linux@weissschuh.net>
 <20200129204338.4055-2-linux@weissschuh.net>
 <20200129204338.4055-3-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alias the new standard attributes to their previous names, preserving
backwards compatibility.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/x86/thinkpad_acpi.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 25e877789352..443b2b16dc11 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9638,10 +9638,24 @@ static ssize_t charge_control_stop_threshold_store(struct device *dev,
 
 static DEVICE_ATTR_RW(charge_control_start_threshold);
 static DEVICE_ATTR_RW(charge_control_stop_threshold);
+struct device_attribute dev_attr_charge_start_threshold = __ATTR(
+	charge_start_threshold,
+	0644,
+	charge_control_start_threshold_show,
+	charge_control_start_threshold_store
+);
+struct device_attribute dev_attr_charge_stop_threshold = __ATTR(
+	charge_stop_threshold,
+	0644,
+	charge_control_stop_threshold_show,
+	charge_control_stop_threshold_store
+);
 
 static struct attribute *tpacpi_battery_attrs[] = {
 	&dev_attr_charge_control_start_threshold.attr,
 	&dev_attr_charge_control_stop_threshold.attr,
+	&dev_attr_charge_start_threshold.attr,
+	&dev_attr_charge_stop_threshold.attr,
 	NULL,
 };
 
-- 
2.25.0

