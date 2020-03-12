Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB715C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:42:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A732071C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="HqLO0nkx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgCLOmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:42:39 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([207.82.80.167]:46204 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727637AbgCLOmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1584024155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CE6ZjattzXd8phAl+PRVbqV4MfsOC/KKmrgE8lzlilY=;
        b=HqLO0nkxa+W5MwJNASR7R6f48XQGJ9mCioNxQDrDAdg1xbyu9RDRhcWyI4QN1v/0e4ncUs
        FhNoWS1C79RyKDfrNXM6mEdykBvO16PT8TJn+1dtVKnxTayrQ/y3LhbW8B8UTogiKshAG3
        YIceQSQx0zGR439Dquiis2IdxFLbHx4=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2055.outbound.protection.outlook.com [104.47.2.55]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-206-tDr1AYV4P9yLHlnbiRsdkw-1; Thu, 12 Mar 2020 14:42:33 +0000
X-MC-Unique: tDr1AYV4P9yLHlnbiRsdkw-1
Received: from VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM (52.134.27.157) by
 VI1PR10MB2814.EURPRD10.PROD.OUTLOOK.COM (20.178.126.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 14:42:31 +0000
Received: from VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a1b9:204d:15b9:dcc]) by VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a1b9:204d:15b9:dcc%4]) with mapi id 15.20.2793.013; Thu, 12 Mar 2020
 14:42:31 +0000
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Subject: [PATCH v3 1/8] usb: Add MA-USB Host kernel module
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        mausb-host-devel <mausb-host-devel@displaylink.com>
Message-ID: <efe5dbe1-4bd7-43cb-1eea-b6b999dd15e6@displaylink.com>
Date:   Thu, 12 Mar 2020 15:42:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
Content-Language: en-US
X-ClientProxiedBy: VI1PR07CA0223.eurprd07.prod.outlook.com
 (2603:10a6:802:58::26) To VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:37::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.17.183.132] (91.208.120.1) by VI1PR07CA0223.eurprd07.prod.outlook.com (2603:10a6:802:58::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.9 via Frontend Transport; Thu, 12 Mar 2020 14:42:31 +0000
X-Originating-IP: [91.208.120.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acb5d147-e411-4f86-274e-08d7c693982b
X-MS-TrafficTypeDiagnostic: VI1PR10MB2814:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR10MB2814FB119336689654B2392491FD0@VI1PR10MB2814.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:21;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(376002)(136003)(39840400004)(199004)(478600001)(2616005)(4326008)(8676002)(81156014)(8936002)(107886003)(31696002)(6916009)(31686004)(966005)(52116002)(66946007)(66556008)(66476007)(36756003)(81166006)(16576012)(316002)(6486002)(2906002)(86362001)(956004)(26005)(5660300002)(186003)(54906003)(16526019)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2814;H:VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /j+flrREoCKHJVG+k0U+6/xF3YKD7QBmOqGWpt5urE88v3mMDrNGZUSmi6uGSJb0xoEnf7GQWvXHDwd8UOuts3wGT1sIIZTuYw/pNPn2IarrSCtIt16GFGw0O9eDQUTfK+OfPsByIdsCI+CN4tV3Ub+lXssOmfXhWEGNb/E7nP8JZNpmuReKeHEdzkIeDM2LZlFPNJRnLb2rlyQhRC3OarGfha5PQe5hWGeyw7jeNk2bh/9WNITsEuMBSGaWo3CAYQR9ItXHtgQHgezGeGZrSQ7u4GN8fk6qOzx+fT/WaxBzzMmHBzOx9jpJ58Wqp0uKwVq7eUC04C10B3cq+Gz3FBNK/Vsp7jF9rFNhw7bHCaNU9GCWG9HeU5sHTKsbVWHcMuaJPnHtTT8lZVZE5bkenOV1WSKjzaKYRlhVYdH8FYwc0tMSRLa5CZMTLdrHqMZgYn894Sf2fvK5SQf/KGrhF1BkQkmYl4ZootrrWaAto4OP8rzz6k9h+LG1sGRS9tWZpmsRMg/XcahH1kMTMUr3EA==
X-MS-Exchange-AntiSpam-MessageData: +1noas7lmTUAgpzfm2cpjd9x107CMPii7gepBb8Ys5HH/6bNECL4QHyYq9TMr3plypP5Qr/dit6K6aSCr/tWXM+MKYDoIHvuzfq7V4Hxddpe2z5ZaoF5tHQWzJqLqxKRdXWRMhbN++EzIySv4KXlag==
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb5d147-e411-4f86-274e-08d7c693982b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 14:42:31.2461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oXoXBSPwRiyZoOs/4ziTiKoXz130MkyC/9dR6W7xROqU9zMCJKWy8Hl2z4H44QpGIQ6gMCA6Tsd8yoWj9WyGt3zeuFHmLDhZVoRsFEiyDMtmHmyoClN5WpdGyQhJmYs4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2814
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
diff --git a/drivers/usb/mausb_host/mausb_core.c=20
b/drivers/usb/mausb_host/mausb_core.c
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


