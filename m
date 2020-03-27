Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E90DC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2219020748
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="wR7KQGUj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727708AbgC0P0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:26:36 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([146.101.78.167]:58212 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726900AbgC0P0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 11:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1585322791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KILVxIqYPx0H6W7UNtSbED+2IPRYI1d+FDWj7tyP6KE=;
        b=wR7KQGUj3UnMCmNpv+gMWYua5B2Dh3mXmVLn20B/qRgB/WohbLQBndgJDEvvIBziSL4yP7
        WWKgCHZ5w4kLKPi3m22zhBbRyj/J2lj4VYS9B7ITbL2jbLRrcEXGsWUN7q9JBjKkjzzR//
        KcnyFfICsNs16LbZB73UKWh4EzqUdJw=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-145-8mPplCLTNPegod9-7aPKYA-2; Fri, 27 Mar 2020 15:26:30 +0000
X-MC-Unique: 8mPplCLTNPegod9-7aPKYA-2
Received: from AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM (10.255.30.19) by
 AM0PR10MB1939.EURPRD10.PROD.OUTLOOK.COM (52.134.81.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Fri, 27 Mar 2020 15:26:28 +0000
Received: from AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::991c:987a:8997:3aab]) by AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::991c:987a:8997:3aab%6]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 15:26:28 +0000
From:   vladimir.stankovic@displaylink.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
Subject: [PATCH v4 1/8] usb: Add MA-USB Host kernel module
Date:   Fri, 27 Mar 2020 16:26:07 +0100
Message-Id: <20200327152614.26833-2-vladimir.stankovic@displaylink.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200327152614.26833-1-vladimir.stankovic@displaylink.com>
References: <8c24bff9-79a6-ca53-ce8f-fb503163db24@displaylink.com>
 <20200327152614.26833-1-vladimir.stankovic@displaylink.com>
X-ClientProxiedBy: VI1PR10CA0090.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::19) To AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from raven-hp.endava.net (94.189.199.177) by VI1PR10CA0090.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:28::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend Transport; Fri, 27 Mar 2020 15:26:27 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [94.189.199.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd7bfea8-eccf-4adc-439e-08d7d26337fa
X-MS-TrafficTypeDiagnostic: AM0PR10MB1939:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR10MB193971B07BCFABBF3CFA428D91CC0@AM0PR10MB1939.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:21;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39840400004)(396003)(366004)(136003)(376002)(346002)(2906002)(316002)(66946007)(66476007)(5660300002)(4326008)(2616005)(956004)(66556008)(16526019)(6486002)(6666004)(36756003)(186003)(81166006)(81156014)(8676002)(8936002)(107886003)(966005)(478600001)(6916009)(1076003)(86362001)(6506007)(6512007)(52116002)(9686003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9O5VR3a4/SdFqVoj6FcWjpFifmXDCaixoPXYkbosmcSbIeifm1XR3OsX0buOr+Tp3F+f4eM19fJ1bAidVf663ZlA2XSH4sttH2VC+OD1SAjxzfCzycI3we4OhuTkpWwgd2nn8I/h+6uYUrERpMgNwOEigO9eqEF+jSzHYrIwdB0UvfjDg/tjWTNqvyO3Cwp/RqqVQu35FqpShOonEldnM12wyicOVMlaH1iv55DKendbvWlaSwi65Oz9sTyuwKcwJ2hrOwgShllGOqjyv6fQVrd22Or6/Qf0Nu+por5wz/3U3H/E+UtI1q+jdvYLN2xHVVnpu5HVPscyW15Wiwzgg9YqXhonJpfkT6JkgbFeJoeMiYiAJCxpXqZhYZ4rub8h7Otfp0CJ1EAcoxGo6obGr2dELfcsbDa2XJRXwI7/rhaNKuIK3+/sl9jxJW8/f5h5L23UOszPxqCbYIJsNNZ2IUSOQSmekyq9a0819SlGP/T83scy4pQ1RL+HAzmtsVONOmD622n7uqfV/4Gp9SkA0Q==
X-MS-Exchange-AntiSpam-MessageData: E+YF3b56rzDhc3p+nu+5av0HM+YIKBcwbw0uA1Pt08Be2RZl6TB83e5c/CPZscLX1SHpLDvLX8xEpNwPR3xy6yUwW8bZxe4x2qXJx1KSkgUGduI1//jXWJd+I7d1ljKTOhH5ajIorSUKcqxNjmojBA==
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd7bfea8-eccf-4adc-439e-08d7d26337fa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 15:26:28.0427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WzfPSgALmiowAZX1NmpbzQS9wOrFOsKhpbUsBqKH0t8wdY6cla1maZG+tBz1b3GHeLwrSjpVgvyOR5EvAxLE8gL3PqVbHN+6uatjR3MgWyrComjlTrgFDej4tOtaQC53
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB1939
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
 drivers/usb/mausb_host/Kconfig      | 14 +++++
 drivers/usb/mausb_host/Makefile     | 12 ++++
 drivers/usb/mausb_host/mausb_core.c | 90 +++++++++++++++++++++++++++++
 drivers/usb/mausb_host/utils.c      | 85 +++++++++++++++++++++++++++
 drivers/usb/mausb_host/utils.h      | 40 +++++++++++++
 8 files changed, 252 insertions(+)
 create mode 100644 drivers/usb/mausb_host/Kconfig
 create mode 100644 drivers/usb/mausb_host/Makefile
 create mode 100644 drivers/usb/mausb_host/mausb_core.c
 create mode 100644 drivers/usb/mausb_host/utils.c
 create mode 100644 drivers/usb/mausb_host/utils.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 235ab38ed478..12aac44196d7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10226,6 +10226,13 @@ W:=09https://linuxtv.org
 S:=09Maintained
 F:=09drivers/media/radio/radio-maxiradio*
=20
+MA USB HOST DRIVER
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
index 000000000000..2465aac713fe
--- /dev/null
+++ b/drivers/usb/mausb_host/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel configuration file for MA-USB Host driver.
+#
+# Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+#
+
+config HOST_MAUSB
+=09tristate "MA-USB Host Driver"
+=09depends on USB=3Dy
+=09default n
+=09help
+=09=09This is a MA-USB Host driver which enables host communication
+=09=09via MA-USB protocol stack.
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
index 000000000000..699f94fcb75b
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
+#define MAUSB_DRIVER_VERSION MAUSB_STRINGIFY(1.2.0.0.36451aec)
+
+int mausb_create_dev(void);
+void mausb_cleanup_dev(int device_created);
+
+#endif /* __MAUSB_UTILS_H__ */
--=20
2.17.1

