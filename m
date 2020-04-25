Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF635C55196
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 09:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99CFF2071C
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 09:20:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="a7z3CytT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgDYJUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 05:20:19 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([146.101.78.167]:29171 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726035AbgDYJUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 05:20:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1587806413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B+XwVfHAYl0Uq4i3BzIu7dun0DoMd/SmauQgjNEcwZs=;
        b=a7z3CytTFzo74lJAlqiyUqQr9jkj6q1aSApgKfkG5np3MOiAKpV1mOphgYT9cBERv7V6wG
        1xMGpbZwJ/V3QEx6j4fnJMYh2+D0rafNAYidWWAgX0frxqPIS8l3g7+XAWAgFuktZi2iQj
        fb7WJ0UYajIYRo9J6vZtIoWO6VDbuuc=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2054.outbound.protection.outlook.com [104.47.0.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-233-DZt1QQsyOvi6I0Fu7kFPJA-1; Sat, 25 Apr 2020 10:20:12 +0100
X-MC-Unique: DZt1QQsyOvi6I0Fu7kFPJA-1
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13) by VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sat, 25 Apr
 2020 09:20:10 +0000
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cba:c335:a57e:9dfd]) by VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cba:c335:a57e:9dfd%5]) with mapi id 15.20.2937.020; Sat, 25 Apr 2020
 09:20:10 +0000
From:   vladimir.stankovic@displaylink.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
Subject: [PATCH v5 1/8] usb: Add MA-USB Host kernel module
Date:   Sat, 25 Apr 2020 11:19:47 +0200
Message-Id: <20200425091954.1610-2-vladimir.stankovic@displaylink.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
References: <20200327152614.26833-1-vladimir.stankovic@displaylink.com>
 <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
X-ClientProxiedBy: LO2P265CA0131.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::23) To VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from raven-hp.endava.net (94.189.199.177) by LO2P265CA0131.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9f::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Sat, 25 Apr 2020 09:20:09 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [94.189.199.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b0836db-65de-44fe-8266-08d7e8f9da2b
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1056:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR1001MB10568EA15E9FF9A930D1270391D10@VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:44;
X-Forefront-PRVS: 0384275935
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(136003)(39840400004)(396003)(376002)(9686003)(6512007)(8936002)(66946007)(316002)(52116002)(66476007)(6666004)(5660300002)(8676002)(66556008)(81156014)(1076003)(86362001)(6486002)(478600001)(6506007)(966005)(956004)(6916009)(2906002)(4326008)(26005)(36756003)(2616005)(186003)(16526019)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CPPBy6rahVdsp7k/k33Lec9n5m3zfFyZY7z3HPRhqwvjYRq4yEzE+IvUScJmOA6vHpmqex/nEETgYLYDShhEPumPnISho29UCUXT95vXGdptzBMVM3XC1p2kFD1ZfkHUhK4yybRSB6yoOEamBj4Fg6F/JIoqO0dVdBeSM0e7VTlcHQ+9i+XvlN+Vwl+L2LuQLplInUAoTh41qikWeoEFA/7D5nc59WI/Cpf0o4B63Jo3/uyb3VPTie4j/gAkkfCH5xTyjZKfdqrceNhlzqfYNKarUpraT58Yis5zS5zqoT8beVbyk0AtVnZV2VawEYlshe6M/I3vLeoEMNd7JKOYvDpp2LNVIKyFiqzcvdWwc3SquFmMQaTRAA/dSR5oMzub/Pxo2asyuEZga127oxF0s03FxZT8QtTPa6TKRrColspbV04AGIx3jcU9lRL8QAanfPJulEewo9qXw9kRoOpCtX8V8oUP3WYg8rIms697ChtBJF2d4IcgVDB2FM2uzv6YeN5f4rlP9R6Sl5Qty8gSnA==
X-MS-Exchange-AntiSpam-MessageData: Jt01meGWwEZJz3RlIxQFC1i9ywXn7mPyP2LG4g22Nsdg8or5EfkATYpYMJ3x8xgwz2DYjZnfNJF5Lslm0tDrYBckyQZW4dHobQ0noUwx4HVZOFgUgj6ymue97iwhitR5h9gGaEfk9DQOCBHG1G1cZGvQImE+oTUA9zQSnmHHnSIns+GuDfR6xTkSgJ9QWIpc2+JEXaM3Cuu16K6HYpD+qB0befsWzV2SltWkWzBccq+ZGNMyyzO5MwT27IUKCIHnyIcf6wbZEDxqOWRzeH+B3Py8C3Q1GsdarEDpxG6e51mDu6gNU7ULYJl1Q8oswOdfT6BJz841tK/XAFCcWOSmldAKxycWjSLLmOHHw+daT62x0sLAeSPHBQ4TUTo5PHs90uLv4V3FXN5Pm/v9SoHSWD9b8zTSQ2jtZuYd8ohXzckce6M9HITkeC1ReZAhqlkDhXzXdvF9wZ9aGoHGhX29e2oXcCn4Lc/xkGncmV21FcF+0p61I+Bh38GEh6JNuv/neD4jX7spK+k34xlDZJonNk9LMYfUaUpOVxPtoIhqNpP0rFc6I3JDyKyHm4dkJ1gok5WuK7V1QAW/kMffux/MSpNZhBAI6w5NXJHghXZZZZRmjA3kKzjPxHHQygtF8w29xmJopPStW9oba62E/i9QCrvHfh9/9iuJ6r/hyhKsMxtY8+6xSe+UuVwMQRYqQK9JhAFmg3OJ4TWbLiERaLYdsTljBVYbLLZorMEXbLTJN0OD8tRPxa+O4ixC0zN1CWikZxlxvImrujkUoddHzOiHN/zmEHdqisBdSdew3zfbqNU=
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0836db-65de-44fe-8266-08d7e8f9da2b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2020 09:20:10.2948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/K4Tbfn9LfHKHpSC0B3HxmbdOyeef6M0GnT+kvHmUws+3ycAGFZ56m9ia/7RNLAcX9gW/2tccybQ9LqdM3rTv3vAAdVM6TxgWi1g/1GCi1dDpz4dZQlqonXzmXbythf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1056
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added utility macros, kernel device creation and cleanup, functions for
handling log formatting and a placeholder module for MA-USB Host device
driver.

Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>
---
 MAINTAINERS                         |  7 +++
 drivers/usb/Kconfig                 |  2 +
 drivers/usb/Makefile                |  2 +
 drivers/usb/mausb_host/Kconfig      | 15 +++++
 drivers/usb/mausb_host/Makefile     | 12 ++++
 drivers/usb/mausb_host/mausb_core.c | 90 +++++++++++++++++++++++++++++
 drivers/usb/mausb_host/utils.c      | 85 +++++++++++++++++++++++++++
 drivers/usb/mausb_host/utils.h      | 40 +++++++++++++
 8 files changed, 253 insertions(+)
 create mode 100644 drivers/usb/mausb_host/Kconfig
 create mode 100644 drivers/usb/mausb_host/Makefile
 create mode 100644 drivers/usb/mausb_host/mausb_core.c
 create mode 100644 drivers/usb/mausb_host/utils.c
 create mode 100644 drivers/usb/mausb_host/utils.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 453fe0713e68..8b63b246ba67 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10352,6 +10352,13 @@ W:=09https://linuxtv.org
 T:=09git git://linuxtv.org/media_tree.git
 F:=09drivers/media/radio/radio-maxiradio*
=20
+MEDIA AGNOSTIC (MA) USB HOST DRIVER
+M:=09Vladimir Stankovic <vladimir.stankovic@displaylink.com>
+L:=09mausb-host-devel@displaylink.com
+W:=09https://www.displaylink.com
+S:=09Maintained
+F:=09drivers/usb/mausb_host/*
+
 MCAN MMIO DEVICE DRIVER
 M:=09Dan Murphy <dmurphy@ti.com>
 M:=09Sriram Dash <sriram.dash@samsung.com>
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 275568abc670..4e92f1fa0fa5 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -164,6 +164,8 @@ source "drivers/usb/misc/Kconfig"
=20
 source "drivers/usb/atm/Kconfig"
=20
+source "drivers/usb/mausb_host/Kconfig"
+
 endif # USB
=20
 source "drivers/usb/phy/Kconfig"
diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index 1c1c1d659394..22d1998db0e2 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -66,3 +66,5 @@ obj-$(CONFIG_USBIP_CORE)=09+=3D usbip/
 obj-$(CONFIG_TYPEC)=09=09+=3D typec/
=20
 obj-$(CONFIG_USB_ROLE_SWITCH)=09+=3D roles/
+
+obj-$(CONFIG_HOST_MAUSB)        +=3D mausb_host/
diff --git a/drivers/usb/mausb_host/Kconfig b/drivers/usb/mausb_host/Kconfi=
g
new file mode 100644
index 000000000000..a8363e7e8f97
--- /dev/null
+++ b/drivers/usb/mausb_host/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel configuration file for MA-USB Host driver.
+#
+# Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+#
+
+config HOST_MAUSB
+=09tristate "Media Agnostic (MA) USB Host Driver"
+=09depends on USB=3Dy
+=09help
+=09  This is a Media Agnostic (MA) USB Host driver which enables host
+=09  communication via MA USB protocol stack.
+
+=09  If this driver is compiled as a module, it will be named mausb_host.
diff --git a/drivers/usb/mausb_host/Makefile b/drivers/usb/mausb_host/Makef=
ile
new file mode 100644
index 000000000000..2e353fa0958b
--- /dev/null
+++ b/drivers/usb/mausb_host/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for DisplayLink MA-USB Host driver.
+#
+# Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+#
+
+obj-$(CONFIG_HOST_MAUSB) +=3D mausb_host.o
+mausb_host-y :=3D mausb_core.o
+mausb_host-y +=3D utils.o
+
+ccflags-y +=3D -I$(srctree)/$(src)
diff --git a/drivers/usb/mausb_host/mausb_core.c b/drivers/usb/mausb_host/m=
ausb_core.c
new file mode 100644
index 000000000000..8638dd0a4856
--- /dev/null
+++ b/drivers/usb/mausb_host/mausb_core.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+ */
+#include <linux/in.h>
+#include <linux/inet.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/kobject.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/net.h>
+
+#include "utils.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("DisplayLink (UK) Ltd.");
+MODULE_VERSION(MAUSB_DRIVER_VERSION);
+
+static int mausb_client_connect(const char *value,
+=09=09=09=09const struct kernel_param *kp)
+{
+=09mausb_pr_info("Version=3D%s", MAUSB_DRIVER_VERSION);
+
+=09return 0;
+}
+
+static int mausb_client_disconnect(const char *value,
+=09=09=09=09   const struct kernel_param *kp)
+{
+=09mausb_pr_info("Version=3D%s", MAUSB_DRIVER_VERSION);
+
+=09return 0;
+}
+
+static int mausb_device_connect(const char *value,
+=09=09=09=09const struct kernel_param *kp)
+{
+=09mausb_pr_info("Version=3D%s", MAUSB_DRIVER_VERSION);
+
+=09return 0;
+}
+
+static int mausb_device_disconnect(const char *value,
+=09=09=09=09   const struct kernel_param *kp)
+{
+=09mausb_pr_info("Version=3D%s", MAUSB_DRIVER_VERSION);
+
+=09return 0;
+}
+
+static const struct kernel_param_ops mausb_device_connect_ops =3D {
+=09.set =3D mausb_device_connect
+};
+
+static const struct kernel_param_ops mausb_device_disconnect_ops =3D {
+=09.set =3D mausb_device_disconnect
+};
+
+static const struct kernel_param_ops mausb_client_connect_ops =3D {
+=09.set =3D mausb_client_connect
+};
+
+static const struct kernel_param_ops mausb_client_disconnect_ops =3D {
+=09.set =3D mausb_client_disconnect
+};
+
+static int mausb_host_init(void)
+{
+=09int status =3D mausb_create_dev();
+
+=09mausb_pr_info("Module load. Version=3D%s", MAUSB_DRIVER_VERSION);
+
+=09if (status < 0) {
+=09=09mausb_pr_alert("Failed to load MAUSB module!");
+=09=09return status;
+=09}
+
+=09return 0;
+}
+
+static void mausb_host_exit(void)
+{
+=09mausb_pr_info("Module unloading started...");
+=09mausb_cleanup_dev(1);
+=09mausb_pr_info("Module unloaded. Version=3D%s", MAUSB_DRIVER_VERSION);
+}
+
+module_init(mausb_host_init);
+module_exit(mausb_host_exit);
diff --git a/drivers/usb/mausb_host/utils.c b/drivers/usb/mausb_host/utils.=
c
new file mode 100644
index 000000000000..c055b578e402
--- /dev/null
+++ b/drivers/usb/mausb_host/utils.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+ */
+#include "utils.h"
+
+#include <linux/atomic.h>
+#include <linux/cdev.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+
+#define MAUSB_KERNEL_DEV_NAME "mausb_host"
+#define MAUSB_READ_DEVICE_TIMEOUT_MS 500
+
+static dev_t mausb_major_kernel;
+static struct cdev  mausb_kernel_dev;
+static struct class *mausb_kernel_class;
+
+static int mausb_file_open(struct inode *inode, struct file *filp)
+{
+=09filp->private_data =3D NULL;
+
+=09return 0;
+}
+
+static int mausb_file_close(struct inode *inode, struct file *filp)
+{
+=09kfree(filp->private_data);
+=09filp->private_data =3D NULL;
+
+=09return 0;
+}
+
+static const struct file_operations mausb_file_ops =3D {
+=09.open=09 =3D mausb_file_open,
+=09.release =3D mausb_file_close,
+};
+
+int mausb_create_dev(void)
+{
+=09int device_created =3D 0;
+=09int status =3D alloc_chrdev_region(&mausb_major_kernel, 0, 1,
+=09=09=09=09=09 MAUSB_KERNEL_DEV_NAME "_proc");
+=09if (status)
+=09=09goto cleanup;
+
+=09mausb_kernel_class =3D class_create(THIS_MODULE,
+=09=09=09=09=09  MAUSB_KERNEL_DEV_NAME "_sys");
+=09if (!mausb_kernel_class) {
+=09=09status =3D -ENOMEM;
+=09=09goto cleanup;
+=09}
+
+=09if (!device_create(mausb_kernel_class, NULL, mausb_major_kernel, NULL,
+=09=09=09   MAUSB_KERNEL_DEV_NAME "_dev")) {
+=09=09status =3D -ENOMEM;
+=09=09goto cleanup;
+=09}
+=09device_created =3D 1;
+=09cdev_init(&mausb_kernel_dev, &mausb_file_ops);
+=09status =3D cdev_add(&mausb_kernel_dev, mausb_major_kernel, 1);
+=09if (status)
+=09=09goto cleanup;
+=09return 0;
+cleanup:
+=09mausb_cleanup_dev(device_created);
+=09return status;
+}
+
+void mausb_cleanup_dev(int device_created)
+{
+=09if (device_created) {
+=09=09device_destroy(mausb_kernel_class, mausb_major_kernel);
+=09=09cdev_del(&mausb_kernel_dev);
+=09}
+
+=09if (mausb_kernel_class)
+=09=09class_destroy(mausb_kernel_class);
+
+=09unregister_chrdev_region(mausb_major_kernel, 1);
+}
diff --git a/drivers/usb/mausb_host/utils.h b/drivers/usb/mausb_host/utils.=
h
new file mode 100644
index 000000000000..9adf4122e64d
--- /dev/null
+++ b/drivers/usb/mausb_host/utils.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+ */
+#ifndef __MAUSB_UTILS_H__
+#define __MAUSB_UTILS_H__
+
+#if defined(MAUSB_NO_LOGS)
+#define mausb_pr_logs(...)
+#else
+#include <linux/printk.h>
+#include <linux/sched.h>
+#define mausb_pr_logs(level_str, level, log, ...)\
+=09pr_##level_str("MAUSB " #level " [%x:%x] [%s] " log "\n",\
+=09current->pid, current->tgid, __func__, ##__VA_ARGS__)
+#endif /* MAUSB_NO_LOGS */
+
+#define mausb_pr_alert(...) mausb_pr_logs(alert, 1, ##__VA_ARGS__)
+
+#define mausb_pr_err(...) mausb_pr_logs(err, 2, ##__VA_ARGS__)
+
+#define mausb_pr_warn(...) mausb_pr_logs(warn, 3, ##__VA_ARGS__)
+
+#define mausb_pr_info(...) mausb_pr_logs(info, 4, ##__VA_ARGS__)
+
+#if defined(MAUSB_LOG_VERBOSE)
+=09#define mausb_pr_debug(...) mausb_pr_logs(debug, 5, ##__VA_ARGS__)
+#else
+=09#define mausb_pr_debug(...)
+#endif /* defined(MAUSB_LOG_VERBOSE) */
+
+#define MAUSB_STRINGIFY2(x) #x
+#define MAUSB_STRINGIFY(x) MAUSB_STRINGIFY2(x)
+
+#define MAUSB_DRIVER_VERSION MAUSB_STRINGIFY(1.3.0.0.6f5beb53)
+
+int mausb_create_dev(void);
+void mausb_cleanup_dev(int device_created);
+
+#endif /* __MAUSB_UTILS_H__ */
--=20
2.17.1

