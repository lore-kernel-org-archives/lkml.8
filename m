Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E698C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 12:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0611820721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 12:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="lCd6EmFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgBCMCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 07:02:05 -0500
Received: from ned.t-8ch.de ([212.47.237.191]:51366 "EHLO ned.t-8ch.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727605AbgBCMCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 07:02:04 -0500
From:   =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
        s=mail; t=1580731319;
        bh=+Okifast5Z8vy48S+GU5utB9xtgNB2T6HyQybZGy9QU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lCd6EmFRjcfVSf9KPW/Pb5jEK245CM+n2FWTxeU5ErT4p1PFul8W0Qki4uz4CGzUw
         04popHu62sT/mL3K2AQDbaW+tgnUDkekbocncbVhWy4LWbOCSPBY9mGm/FXBEHUuY7
         u7R1RBxFo2LbBBkzOIa5D4347raGJQ4R6p9CmLVs=
To:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Cc:     ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 2/2] platform/x86: thinkpad_acpi: use standard charge control attribute names
Date:   Mon,  3 Feb 2020 13:01:32 +0100
Message-Id: <20200203120132.102576-3-linux@weissschuh.net>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200203120132.102576-2-linux@weissschuh.net>
References: <20200131143650.4149-1-linux@weissschuh.net>
 <20200203120132.102576-1-linux@weissschuh.net>
 <20200203120132.102576-2-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The standard attributes were only introduced after the ones from
thinkpad_acpi in commit 813cab8f3994 ("power: supply: core:
Add CHARGE_CONTROL_{START_THRESHOLD,END_THRESHOLD} properties").

The new standard attributes are aliased to their previous names,
preserving backwards compatibility.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/platform/x86/thinkpad_acpi.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 2d3a99e3efb7..2cbcd2e3092f 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -9608,38 +9608,52 @@ static ssize_t tpacpi_battery_show(int what,
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
+static ssize_t charge_control_end_threshold_show(struct device *device,
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
+static ssize_t charge_control_end_threshold_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
 	return tpacpi_battery_store(THRESHOLD_STOP, dev, buf, count);
 }
 
-static DEVICE_ATTR_RW(charge_start_threshold);
-static DEVICE_ATTR_RW(charge_stop_threshold);
+static DEVICE_ATTR_RW(charge_control_start_threshold);
+static DEVICE_ATTR_RW(charge_control_end_threshold);
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
+	&dev_attr_charge_control_start_threshold.attr,
+	&dev_attr_charge_control_end_threshold.attr,
 	&dev_attr_charge_start_threshold.attr,
 	&dev_attr_charge_stop_threshold.attr,
 	NULL,
-- 
2.25.0

