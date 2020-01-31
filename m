Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 336B6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D7E20705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Mo1hrMOy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgAaOiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 09:38:06 -0500
Received: from ned.t-8ch.de ([212.47.237.191]:37364 "EHLO ned.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729060AbgAaOiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 09:38:05 -0500
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1580481445;
        bh=lQqAJct9Yuo28e2dXgyV7zV5l+ie2h3xCuN3ZDZgzwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mo1hrMOy2XUB0qm3UVpsPM6dGt9espikJCl1ifrhbiXLyphxJPouwAUYmvzto5AtI
         sjYqNhE04DJKJtg4C91uiQQFrgNQIEwTJ9LG2vWUvz/K0UWKnh0N01NmjSBMCnw1jC
         vKfaJNtCxJzOZdfWWJDOD8L76qh/mwXQR2ESg8ug=
To:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 3/3] platform/x86: thinkpad_acpi: restore old battery charge attributes
Date:   Fri, 31 Jan 2020 15:36:50 +0100
Message-Id: <20200131143650.4149-4-linux@weissschuh.net>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200131143650.4149-3-linux@weissschuh.net>
References: <20200131143650.4149-1-linux@weissschuh.net>
 <20200131143650.4149-2-linux@weissschuh.net>
 <20200131143650.4149-3-linux@weissschuh.net>
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
index 5f0e3299778a..2cbcd2e3092f 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9638,10 +9638,24 @@ static ssize_t charge_control_end_threshold_store(struct device *dev,
 
 static DEVICE_ATTR_RW(charge_control_start_threshold);
 static DEVICE_ATTR_RW(charge_control_end_threshold);
+struct device_attribute dev_attr_charge_start_threshold = __ATTR(
+	charge_start_threshold,
+	0644,
+	charge_control_start_threshold_show,
+	charge_control_start_threshold_store
+);
+struct device_attribute dev_attr_charge_stop_threshold = __ATTR(
+	charge_stop_threshold,
+	0644,
+	charge_control_end_threshold_show,
+	charge_control_end_threshold_store
+);
 
 static struct attribute *tpacpi_battery_attrs[] = {
 	&dev_attr_charge_control_start_threshold.attr,
 	&dev_attr_charge_control_end_threshold.attr,
+	&dev_attr_charge_start_threshold.attr,
+	&dev_attr_charge_stop_threshold.attr,
 	NULL,
 };
 
-- 
2.25.0

