Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F92DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 20:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40E8120702
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 20:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="EWhJ9v1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgA2UvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 15:51:14 -0500
Received: from ned.t-8ch.de ([212.47.237.191]:44320 "EHLO ned.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgA2UvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 15:51:14 -0500
X-Greylist: delayed 444 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jan 2020 15:51:13 EST
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1580330625;
        bh=WQpcTQM59ICWLbo7nhLJM/haB2c2OkM0qICuhuLiH4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EWhJ9v1zokSnYPGBPxBD2UCv3jZtj8tN+MLd2Uwthrn0J6F6KvR9IDyT6T7g3xpwz
         1i9nmTfvCXY5WfoUWV18Rvx8gNkr7SHMHWHEcPTCNS4tw7GQY32mfHd/Jshs7Mw8wn
         NIodntsmFpEEUIarZyLnn9x3avTsjsTLXw3gZMLY=
To:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 2/3] platform/x86: thinkpad_acpi: use standard charge control attribute names
Date:   Wed, 29 Jan 2020 21:43:37 +0100
Message-Id: <20200129204338.4055-3-linux@weissschuh.net>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200129204338.4055-2-linux@weissschuh.net>
References: <20200129204338.4055-1-linux@weissschuh.net>
 <20200129204338.4055-2-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The standard attributes were only introduced after the ones from
thinkpad_acpi in commit 813cab8f3994 ("power: supply: core: Add CHARGE_CONTROL_{START_THRESHOLD,END_THRESHOLD} properties").

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/x86/thinkpad_acpi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 2d3a99e3efb7..25e877789352 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9608,40 +9608,40 @@ static ssize_t tpacpi_battery_show(int what,
 	return sprintf(buf, "%d\n", ret);
 }
 
-static ssize_t charge_start_threshold_show(struct device *device,
+static ssize_t charge_control_start_threshold_show(struct device *device,
 				struct device_attribute *attr,
 				char *buf)
 {
 	return tpacpi_battery_show(THRESHOLD_START, device, buf);
 }
 
-static ssize_t charge_stop_threshold_show(struct device *device,
+static ssize_t charge_control_stop_threshold_show(struct device *device,
 				struct device_attribute *attr,
 				char *buf)
 {
 	return tpacpi_battery_show(THRESHOLD_STOP, device, buf);
 }
 
-static ssize_t charge_start_threshold_store(struct device *dev,
+static ssize_t charge_control_start_threshold_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
 	return tpacpi_battery_store(THRESHOLD_START, dev, buf, count);
 }
 
-static ssize_t charge_stop_threshold_store(struct device *dev,
+static ssize_t charge_control_stop_threshold_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
 	return tpacpi_battery_store(THRESHOLD_STOP, dev, buf, count);
 }
 
-static DEVICE_ATTR_RW(charge_start_threshold);
-static DEVICE_ATTR_RW(charge_stop_threshold);
+static DEVICE_ATTR_RW(charge_control_start_threshold);
+static DEVICE_ATTR_RW(charge_control_stop_threshold);
 
 static struct attribute *tpacpi_battery_attrs[] = {
-	&dev_attr_charge_start_threshold.attr,
-	&dev_attr_charge_stop_threshold.attr,
+	&dev_attr_charge_control_start_threshold.attr,
+	&dev_attr_charge_control_stop_threshold.attr,
 	NULL,
 };
 
-- 
2.25.0

