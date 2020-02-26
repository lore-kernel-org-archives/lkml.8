Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFA1C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7722467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="WAeNLX8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgBZJ5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:57:51 -0500
Received: from eu-smtp-delivery-167.mimecast.com ([146.101.78.167]:23551 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727882AbgBZJ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:57:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1582711067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=XKkZ8px1iWfl8gzZykIBSANpFkwqkf6p6eNDWaPSF4M=;
        b=WAeNLX8u/qtfqif0RGyxZYCB0FaWnx2n4XC7/689owloCT/fAGJck/MTfSscLKEKg3E1Rk
        bSyEmt4SJ7k5Bo51tOJ554mlgt/qOVl2mZazLv+x9OQw0y3g/PC8VOA2IY77BmSGE6mXlc
        xt2/1djOX1fbplZLTwt7Qf/P9SpSLnQ=
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur03lp2052.outbound.protection.outlook.com [104.47.8.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-255-Z-k3_lweOZWpc70EAHjYBg-1; Wed, 26 Feb 2020 09:57:46 +0000
X-MC-Unique: Z-k3_lweOZWpc70EAHjYBg-1
Received: from AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM (52.133.63.154) by
 AM0PR10MB3553.EURPRD10.PROD.OUTLOOK.COM (10.186.174.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Wed, 26 Feb 2020 09:57:44 +0000
Received: from AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d07a:2e67:4515:dba6]) by AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d07a:2e67:4515:dba6%3]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 09:57:44 +0000
Received: from [172.17.183.132] (80.93.235.40) by VI1PR07CA0268.eurprd07.prod.outlook.com (2603:10a6:803:b4::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.13 via Frontend Transport; Wed, 26 Feb 2020 09:57:44 +0000
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        mausb-host-devel <mausb-host-devel@displaylink.com>
Subject: [PATCH v2 1/8] usb: Add MA-USB Host kernel module
Thread-Topic: [PATCH v2 1/8] usb: Add MA-USB Host kernel module
Thread-Index: AQHV7IsxaG6eCq+TZEikiWNbTpJ3fQ==
Date:   Wed, 26 Feb 2020 09:57:44 +0000
Message-ID: <0dbf7da8-a0af-8750-6e91-c6d29f7e1a72@displaylink.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0268.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::35) To AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:40::26)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [80.93.235.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0ed24769-7f9e-4677-eb09-08d7baa2537c
x-ms-traffictypediagnostic: AM0PR10MB3553:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR10MB35536FCAA9586C6386B2EC9B91EA0@AM0PR10MB3553.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:21;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(366004)(396003)(39840400004)(189003)(199004)(36756003)(8936002)(71200400001)(956004)(2616005)(6916009)(16526019)(66446008)(66946007)(44832011)(66476007)(66556008)(86362001)(64756008)(6486002)(81166006)(8676002)(81156014)(31686004)(5660300002)(478600001)(52116002)(26005)(2906002)(316002)(186003)(4326008)(31696002)(107886003)(54906003)(16576012);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR10MB3553;H:AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gsu7t6a5p8RSm9XMkuh+rvypgIZ+PRKdAWK97ZNAUEd5dma2lgMy41XnKV71PWhBbMt7xBeFu7ThNNdjV5n/gMk6iKlDyaBr3qzlwL7qeftBpI740PdirisWFx6jodc1kWYEYOIpq8nRh2sIxLywaBra5xBgkUMwl1MCektOWpFMH14c7vk+OONSz7eANqXNPhC2eTzRjqiYhkSW/af4dk7ecZRDuQUaN7jNqLJ1fnwmYHMwywLtJceqz+JZQ2mzEQuI1E4USNRPNqMPXcLUg4bKTbZU3EsfIkd1Fx5xnn2Ye4lGKTqkS2Zoq+kgR1LLovM2OJhKkw5XGkSnIy3vo8iX0V5XcuJvIeRUwfRF8ILqp15bxCnLw9twqhEvwKwG82IZ1QChrle8aWuEUR1SnSaI3b7UtpVytpN29O+I87P4+oDG+Nl/KT+qLGf2KShHSHAW4e8Gar1MTjW411ub6dCgec6/L5f6sMcBtRLujcGx/BQcVd+aD7weMvHPoBGt8A8w3VEd1ObDK39dv8O5tg==
x-ms-exchange-antispam-messagedata: 6bbA+pxXZzxT48XIP6mji9S/ZpHFDDnJrCatgYCyP4z4zzq6fdEAkuzenQRT4SRWFRaB688wFfkR0KsDg3jy3yl8PqLZw6cHZB54jm5uvpyJMOtTGznGuf8HVCSo2Y5FxhVC1A7xg7Q4I0LrNxHfaQ==
Content-ID: <E7D34997B1EEDE40B642A398BBFE2A63@EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ed24769-7f9e-4677-eb09-08d7baa2537c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 09:57:44.5427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: npzxNB2thEonxDs5o+G777j2v8EcnsdPKrqX7kUMvKUXAUDb72LWPhMt1yufNmB3KR+pU+cjchEbqNaTX88N/xZcjWked9AptVg41+HDS3fUA+nIFoLfu8htF33zO8EW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3553
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
  drivers/usb/mausb_host/Makefile     | 13 +++++
  drivers/usb/mausb_host/mausb_host.c | 90 +++++++++++++++++++++++++++++
  drivers/usb/mausb_host/utils.c      | 85 +++++++++++++++++++++++++++
  drivers/usb/mausb_host/utils.h      | 40 +++++++++++++
  8 files changed, 253 insertions(+)
  create mode 100644 drivers/usb/mausb_host/Kconfig
  create mode 100644 drivers/usb/mausb_host/Makefile
  create mode 100644 drivers/usb/mausb_host/mausb_host.c
  create mode 100644 drivers/usb/mausb_host/utils.c
  create mode 100644 drivers/usb/mausb_host/utils.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f27f40d22bb..6088f9aa640a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10226,6 +10226,13 @@ W:=09https://linuxtv.org
  S:=09Maintained
  F:=09drivers/media/radio/radio-maxiradio*
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
   source "drivers/usb/atm/Kconfig"
  +source "drivers/usb/mausb_host/Kconfig"
+
  endif # USB
   source "drivers/usb/phy/Kconfig"
diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index 1c1c1d659394..22d1998db0e2 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -66,3 +66,5 @@ obj-$(CONFIG_USBIP_CORE)=09+=3D usbip/
  obj-$(CONFIG_TYPEC)=09=09+=3D typec/
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
diff --git a/drivers/usb/mausb_host/Makefile=20
b/drivers/usb/mausb_host/Makefile
new file mode 100644
index 000000000000..ad7fec4d9ff9
--- /dev/null
+++ b/drivers/usb/mausb_host/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for DisplayLink MA-USB Host driver.
+#
+# Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+#
+
+obj-$(CONFIG_HOST_MAUSB) +=3D mausb_host.o
+mausb_host-y :=3D mausb_host.o
+mausb_host-y +=3D utils.o
+
+ccflags-y +=3D -I$(srctree)/$(src)
+ccflags-y +=3D -g
diff --git a/drivers/usb/mausb_host/mausb_host.c=20
b/drivers/usb/mausb_host/mausb_host.c
new file mode 100644
index 000000000000..8638dd0a4856
--- /dev/null
+++ b/drivers/usb/mausb_host/mausb_host.c
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
index 000000000000..a5378ee4c4f0
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
+#define mausb_pr_info(...)  mausb_pr_logs(info, 4, ##__VA_ARGS__)
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
+#define MAUSB_DRIVER_VERSION MAUSB_STRINGIFY(1.2.0.0.fb3296e6)
+
+int mausb_create_dev(void);
+void mausb_cleanup_dev(int device_created);
+
+#endif /* __MAUSB_UTILS_H__ */
--=20
2.17.1


