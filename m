Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07A0C4332E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C079920754
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728070AbgCUPyX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:54:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39075 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgCUPyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:54:01 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFgRh-0005V5-C0; Sat, 21 Mar 2020 16:53:57 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B5DCD1C22F2;
        Sat, 21 Mar 2020 16:53:51 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:53:51 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] acpi: Remove header dependency
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200321113241.246190285@linutronix.de>
References: <20200321113241.246190285@linutronix.de>
MIME-Version: 1.0
Message-ID: <158480603133.28353.12839063456015319868.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     df23e2be3d240b67222375062ce873f5ec84854d
Gitweb:        https://git.kernel.org/tip/df23e2be3d240b67222375062ce873f5ec84854d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 21 Mar 2020 12:25:49 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 21 Mar 2020 16:00:21 +01:00

acpi: Remove header dependency

In order to avoid future header hell, remove the inclusion of
proc_fs.h from acpi_bus.h. All it needs is a forward declaration of a
struct.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lkml.kernel.org/r/20200321113241.246190285@linutronix.de
---
 drivers/platform/x86/dell-smo8800.c                      | 1 +
 drivers/platform/x86/wmi.c                               | 1 +
 drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c | 1 +
 include/acpi/acpi_bus.h                                  | 2 +-
 4 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell-smo8800.c b/drivers/platform/x86/dell-smo8800.c
index bfcc1d1..b531fe8 100644
--- a/drivers/platform/x86/dell-smo8800.c
+++ b/drivers/platform/x86/dell-smo8800.c
@@ -16,6 +16,7 @@
 #include <linux/interrupt.h>
 #include <linux/miscdevice.h>
 #include <linux/uaccess.h>
+#include <linux/fs.h>
 
 struct smo8800_device {
 	u32 irq;                     /* acpi device irq */
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index dc2e966..941739d 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -29,6 +29,7 @@
 #include <linux/uaccess.h>
 #include <linux/uuid.h>
 #include <linux/wmi.h>
+#include <linux/fs.h>
 #include <uapi/linux/wmi.h>
 
 ACPI_MODULE_NAME("wmi");
diff --git a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
index 7130e90..a478cff 100644
--- a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
+++ b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
@@ -19,6 +19,7 @@
 #include <linux/acpi.h>
 #include <linux/uaccess.h>
 #include <linux/miscdevice.h>
+#include <linux/fs.h>
 #include "acpi_thermal_rel.h"
 
 static acpi_handle acpi_thermal_rel_handle;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 0c23fd0..a92bea7 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -80,7 +80,7 @@ bool acpi_dev_present(const char *hid, const char *uid, s64 hrv);
 
 #ifdef CONFIG_ACPI
 
-#include <linux/proc_fs.h>
+struct proc_dir_entry;
 
 #define ACPI_BUS_FILE_ROOT	"acpi"
 extern struct proc_dir_entry *acpi_root_dir;
