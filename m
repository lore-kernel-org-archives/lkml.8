Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400B9C55196
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 09:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14B452071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 09:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="MkpRT/a2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgDYJUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 05:20:24 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([146.101.78.167]:42767 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726038AbgDYJUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 05:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1587806416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p3Q/qxHY8Z8sZB0IMfTWFx2ynA5v2YyuJWLXITP9bnE=;
        b=MkpRT/a2GKejnSv3I5DC3PIo+zCGLUcRl/vHQ2fRzAmbEYIsCtO/sjeS+LOwLugEThg0f0
        +4Yu+ovXTmKtqr9RwQs8+g3hyH9H00IiM5IrrF8u73qi+elyrQ+tzS8dHKrDdj2++fVydk
        2JRtFCTPYvpJSKu7WJ4FRioGa7NOL1w=
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2054.outbound.protection.outlook.com [104.47.0.54]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-233-r-P1LZCuNB2sJ5wjRAzb2Q-4; Sat, 25 Apr 2020 10:20:15 +0100
X-MC-Unique: r-P1LZCuNB2sJ5wjRAzb2Q-4
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13) by VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sat, 25 Apr
 2020 09:20:12 +0000
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cba:c335:a57e:9dfd]) by VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8cba:c335:a57e:9dfd%5]) with mapi id 15.20.2937.020; Sat, 25 Apr 2020
 09:20:12 +0000
From:   vladimir.stankovic@displaylink.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
Subject: [PATCH v5 3/8] usb: mausb_host: HCD initialization
Date:   Sat, 25 Apr 2020 11:19:49 +0200
Message-Id: <20200425091954.1610-4-vladimir.stankovic@displaylink.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
References: <20200327152614.26833-1-vladimir.stankovic@displaylink.com>
 <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
X-ClientProxiedBy: LO2P265CA0131.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::23) To VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from raven-hp.endava.net (94.189.199.177) by LO2P265CA0131.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9f::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Sat, 25 Apr 2020 09:20:11 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [94.189.199.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 501efdee-2a9a-42a3-1a30-08d7e8f9db99
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1056:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR1001MB1056E63ADF7237FEB4716AFD91D10@VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:61;
X-Forefront-PRVS: 0384275935
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(136003)(39840400004)(396003)(376002)(9686003)(6512007)(8936002)(66946007)(316002)(52116002)(66476007)(6666004)(5660300002)(8676002)(66556008)(81156014)(1076003)(86362001)(6486002)(478600001)(6506007)(956004)(6916009)(2906002)(4326008)(26005)(36756003)(2616005)(186003)(16526019)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u015OagYtp1WIjC+CpjFF8bQ0dCCluKq8OTueoRRrf0PzskMh2xrzRurd3jT7aVzOESxKQG4l4IAGHQFBxM2C/uBlHCRyddukE/78kzBlhnqS7mcC71yJ1G+tuqQ2b+Y3PEa2BPoptU/rzcLThXU6ebRb2O6LeHKP4GZC9HBESVkUrilp7YHb8NjQnDNWrasn6qI6coOTfuUONaJUCoWAi7wHhoTNNd/GsKdiqlbLvaED7KuUgkgnKRcmw4RNyXzr6ZOhbbvMf+Z9ODKX3/O8i+LiyUQoOrWRxP+EGZOen3OjOfCJ98baCBRQr4Qa6DyOzHAhirs6vaAW4rlEEt9vl+77u2fRz/1xT+W5gj6N1Ju9BfFQQbpCY/4f1pzBOcjU/1WcId6wHkLz0kOqI89vNe2SY/HtW+9defiaZPvBfQkY8lDcfzKXY44gKk6TGt2
X-MS-Exchange-AntiSpam-MessageData: QVXAkp2DPcnBqMqjIH45bkw/knil8bB5Hag0egqh0BjAMoC7KHWHe4G10GG+AhJnckwr3xzQGSwVpMC3hQ8ZzEg2xLOvQWfh+c6pqhCJIeP14ZB2kYFnYzTEPkLOIkRrKpiDQpDafWWSJdTRqzD+BxGynC/6cnUHen0R6zvizQbh43n+gEf3bv6McpiNWoyWDXKcRKlQY8IkwBvN1tG3lPGmrTiiGUGpBpgRLU+glzEArOyZANyQbiyditQpvXP8tj8EQoItsbJy2woWrzQMpX9BeGhzdQZwCobKVjI4xUH5RkyL4a93k0UJyzkhZAokTxOpzyzQUAwV6wEuQv7YtJ8FL68xbAqvBGJVCYZGUn1A/h/ICrPPkF8x/zKPtvk8Q7NTtCsCxdKM/GlU+wCUcy4CMu98z+mXpqsmop6RiFC4k3IhkweSJbnVyFCDOmxRiOwg218Y9DW/MpajDyXJebT8lVhH2goyR1Dob6kPV9uzJZhyA+ZlFImhH3E8DwpYRI4b3qj9XbJHbuj7Do3WYpMffk5uGNWxadEYUIHlAophp3qxWVzJuTE35791beC8DNgJe0I0BAs4fi73+tnxUjK0j6Yxf+3dMnmpaAC9VKxt9u22tLjM+RRjg3099fSSaDYkHUqBJf3ToW4go6K4XCqbbmNWQOU4A1j2N/At9ITIGtXCRIG/aJEE5WJ2GbFEaU2OIc2NhJC0kHrV+Qs5mdhyhm0QcI5mIXL/F0NrSZglkM7IrkN7CvWIckOaaDjiYh/g2VYlEkZZ0WakCibsHkJrOgDCwsD5OAysLLFATCE=
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501efdee-2a9a-42a3-1a30-08d7e8f9db99
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2020 09:20:12.7348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDOPMjFjumOnoT65hwbKHOapzpE86AtsFbqUYRgAE7dhKmd3T6RjIj+6eW8gUvPaq4P37PiSQnQ96V33bP1PjhAcRqxBpeT1ytAAnmlHeR+OiQuKpHXCxjcpMdxj5d9x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1056
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implemented HCD initialization/deinitialization functionality.

Signed-off-by: Vladimir Stankovic <vladimir.stankovic@displaylink.com>
---
 drivers/usb/mausb_host/Makefile     |   1 +
 drivers/usb/mausb_host/hcd.c        | 188 ++++++++++++++++++++++++++++
 drivers/usb/mausb_host/hcd.h        |  71 +++++++++++
 drivers/usb/mausb_host/mausb_core.c |  20 ++-
 4 files changed, 275 insertions(+), 5 deletions(-)
 create mode 100644 drivers/usb/mausb_host/hcd.c
 create mode 100644 drivers/usb/mausb_host/hcd.h

diff --git a/drivers/usb/mausb_host/Makefile b/drivers/usb/mausb_host/Makef=
ile
index 19445b73b50b..cce4696682b2 100644
--- a/drivers/usb/mausb_host/Makefile
+++ b/drivers/usb/mausb_host/Makefile
@@ -9,5 +9,6 @@ obj-$(CONFIG_HOST_MAUSB) +=3D mausb_host.o
 mausb_host-y :=3D mausb_core.o
 mausb_host-y +=3D utils.o
 mausb_host-y +=3D ip_link.o
+mausb_host-y +=3D hcd.o
=20
 ccflags-y +=3D -I$(srctree)/$(src)
diff --git a/drivers/usb/mausb_host/hcd.c b/drivers/usb/mausb_host/hcd.c
new file mode 100644
index 000000000000..3aa548a6cb30
--- /dev/null
+++ b/drivers/usb/mausb_host/hcd.c
@@ -0,0 +1,188 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+ */
+#include "hcd.h"
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/limits.h>
+#include <linux/module.h>
+
+#include "utils.h"
+
+static int mausb_open(struct inode *inode, struct file *file);
+static int mausb_release(struct inode *inode, struct file *file);
+static ssize_t mausb_read(struct file *file, char __user *buffer, size_t l=
ength,
+=09=09=09  loff_t *offset);
+static ssize_t mausb_write(struct file *file, const char __user *buffer,
+=09=09=09   size_t length, loff_t *offset);
+static long mausb_ioctl(struct file *file, unsigned int ioctl_func,
+=09=09=09unsigned long ioctl_buffer);
+static int mausb_bus_probe(struct device *dev);
+static int mausb_bus_remove(struct device *dev);
+static int mausb_bus_match(struct device *dev, struct device_driver *drv);
+
+static const struct file_operations mausb_fops =3D {
+=09.open=09=09=3D mausb_open,
+=09.release=09=3D mausb_release,
+=09.read=09=09=3D mausb_read,
+=09.write=09=09=3D mausb_write,
+=09.unlocked_ioctl=09=3D mausb_ioctl
+};
+
+static unsigned int major;
+static unsigned int minor =3D 1;
+static dev_t devt;
+static struct device *device;
+
+struct mausb_hcd=09*mhcd;
+static struct class=09*mausb_class;
+static struct bus_type=09mausb_bus_type =3D {
+=09.name=09=3D DEVICE_NAME,
+=09.match=09=3D mausb_bus_match,
+=09.probe=09=3D mausb_bus_probe,
+=09.remove=09=3D mausb_bus_remove,
+};
+
+static struct device_driver mausb_driver =3D {
+=09.name=09=3D DEVICE_NAME,
+=09.bus=09=3D &mausb_bus_type,
+=09.owner=09=3D THIS_MODULE,
+};
+
+static void mausb_remove(void)
+{
+=09struct usb_hcd *hcd, *shared_hcd;
+
+=09hcd=09   =3D mhcd->hcd_hs_ctx->hcd;
+=09shared_hcd =3D mhcd->hcd_ss_ctx->hcd;
+
+=09if (shared_hcd) {
+=09=09usb_remove_hcd(shared_hcd);
+=09=09usb_put_hcd(shared_hcd);
+=09=09mhcd->hcd_ss_ctx =3D NULL;
+=09}
+
+=09usb_remove_hcd(hcd);
+=09usb_put_hcd(hcd);
+=09mhcd->hcd_hs_ctx =3D NULL;
+}
+
+static int mausb_bus_probe(struct device *dev)
+{
+=09return 0;
+}
+
+static int mausb_bus_remove(struct device *dev)
+{
+=09return 0;
+}
+
+static int mausb_bus_match(struct device *dev, struct device_driver *drv)
+{
+=09if (strncmp(dev->bus->name, drv->name, strlen(drv->name)))
+=09=09return 0;
+=09else
+=09=09return 1;
+}
+
+static int mausb_open(struct inode *inode, struct file *file)
+{
+=09return 0;
+}
+
+static int mausb_release(struct inode *inode, struct file *file)
+{
+=09return 0;
+}
+
+static ssize_t mausb_read(struct file *file, char __user *buffer, size_t l=
ength,
+=09=09=09  loff_t *offset)
+{
+=09return 0;
+}
+
+static ssize_t mausb_write(struct file *file, const char __user *buffer,
+=09=09=09   size_t length, loff_t *offset)
+{
+=09return 0;
+}
+
+static long mausb_ioctl(struct file *file, unsigned int ioctl_func,
+=09=09=09unsigned long ioctl_buffer)
+{
+=09return 0;
+}
+
+int mausb_init_hcd(void)
+{
+=09int retval;
+
+=09retval =3D register_chrdev(0, DEVICE_NAME, &mausb_fops);
+=09if (retval < 0) {
+=09=09mausb_pr_err("Register_chrdev failed");
+=09=09return retval;
+=09}
+
+=09major =3D (unsigned int)retval;
+=09retval =3D bus_register(&mausb_bus_type);
+=09if (retval) {
+=09=09mausb_pr_err("Bus_register failed %d", retval);
+=09=09goto bus_register_error;
+=09}
+
+=09mausb_class =3D class_create(THIS_MODULE, CLASS_NAME);
+=09if (IS_ERR(mausb_class)) {
+=09=09mausb_pr_err("Class_create failed %ld", PTR_ERR(mausb_class));
+=09=09goto class_error;
+=09}
+
+=09retval =3D driver_register(&mausb_driver);
+=09if (retval) {
+=09=09mausb_pr_err("Driver_register failed");
+=09=09goto driver_register_error;
+=09}
+
+=09mhcd =3D kzalloc(sizeof(*mhcd), GFP_ATOMIC);
+=09if (!mhcd) {
+=09=09retval =3D -ENOMEM;
+=09=09goto mausb_hcd_alloc_failed;
+=09}
+
+=09devt =3D MKDEV(major, minor);
+=09device =3D device_create(mausb_class, NULL, devt, mhcd, DEVICE_NAME);
+=09if (IS_ERR(device)) {
+=09=09mausb_pr_err("Device_create failed %ld", PTR_ERR(device));
+=09=09goto device_create_error;
+=09}
+
+=09device->driver =3D &mausb_driver;
+
+=09return retval;
+device_create_error:
+=09kfree(mhcd);
+=09mhcd =3D NULL;
+mausb_hcd_alloc_failed:
+=09driver_unregister(&mausb_driver);
+driver_register_error:
+=09class_destroy(mausb_class);
+class_error:
+=09bus_unregister(&mausb_bus_type);
+bus_register_error:
+=09unregister_chrdev(major, DEVICE_NAME);
+
+=09return retval;
+}
+
+void mausb_deinit_hcd(void)
+{
+=09if (mhcd) {
+=09=09mausb_remove();
+=09=09device_destroy(mausb_class, devt);
+=09=09driver_unregister(&mausb_driver);
+=09=09class_destroy(mausb_class);
+=09=09bus_unregister(&mausb_bus_type);
+=09=09unregister_chrdev(major, DEVICE_NAME);
+=09}
+}
diff --git a/drivers/usb/mausb_host/hcd.h b/drivers/usb/mausb_host/hcd.h
new file mode 100644
index 000000000000..cac62ba1f1e2
--- /dev/null
+++ b/drivers/usb/mausb_host/hcd.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+ */
+#ifndef __MAUSB_HCD_H__
+#define __MAUSB_HCD_H__
+
+#include <linux/device.h>
+#include <linux/fs.h>
+#include <linux/major.h>
+#include <linux/proc_fs.h>
+#include <linux/rbtree.h>
+#include <linux/slab.h>
+#include <linux/uaccess.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
+#define DEVICE_NAME "mausb_host_hcd_dev"
+#define CLASS_NAME "mausb"
+
+#define NUMBER_OF_PORTS=09=0915
+
+#define MAX_USB_DEVICE_DEPTH=096
+
+#define RESPONSE_TIMEOUT=095000
+
+#define MAUSB_PORT_20_STATUS_LOW_SPEED       0x0200
+#define MAUSB_PORT_20_STATUS_HIGH_SPEED      0x0400
+
+enum mausb_device_type {
+=09USBDEVICE =3D 0,
+=09USB20HUB  =3D 1,
+=09USB30HUB  =3D 2
+};
+
+enum mausb_device_speed {
+=09LOW_SPEED=09 =3D 0,
+=09FULL_SPEED=09 =3D 1,
+=09HIGH_SPEED=09 =3D 2,
+=09SUPER_SPEED=09 =3D 3,
+=09SUPER_SPEED_PLUS =3D 4
+};
+
+struct mausb_hcd {
+=09spinlock_t=09lock;=09/* Protect HCD during URB processing */
+=09struct device=09*pdev;
+=09u16=09=09connected_ports;
+
+=09struct rb_root=09mausb_urbs;
+=09struct hub_ctx=09*hcd_ss_ctx;
+=09struct hub_ctx=09*hcd_hs_ctx;
+=09struct notifier_block power_state_listener;
+};
+
+struct mausb_dev {
+=09u32=09=09port_status;
+=09struct rb_root=09usb_devices;
+=09u8=09=09dev_speed;
+=09void=09=09*ma_dev;
+};
+
+struct hub_ctx {
+=09struct mausb_hcd *mhcd;
+=09struct usb_hcd=09 *hcd;
+=09struct mausb_dev ma_devs[NUMBER_OF_PORTS];
+};
+
+int mausb_init_hcd(void);
+void mausb_deinit_hcd(void);
+
+#endif /* __MAUSB_HCD_H__ */
diff --git a/drivers/usb/mausb_host/mausb_core.c b/drivers/usb/mausb_host/m=
ausb_core.c
index 8638dd0a4856..3ce90c29f6de 100644
--- a/drivers/usb/mausb_host/mausb_core.c
+++ b/drivers/usb/mausb_host/mausb_core.c
@@ -11,6 +11,7 @@
 #include <linux/moduleparam.h>
 #include <linux/net.h>
=20
+#include "hcd.h"
 #include "utils.h"
=20
 MODULE_LICENSE("GPL");
@@ -67,21 +68,30 @@ static const struct kernel_param_ops mausb_client_disco=
nnect_ops =3D {
=20
 static int mausb_host_init(void)
 {
-=09int status =3D mausb_create_dev();
+=09int status;
=20
 =09mausb_pr_info("Module load. Version=3D%s", MAUSB_DRIVER_VERSION);
+=09status =3D mausb_init_hcd();
+=09if (status < 0)
+=09=09goto cleanup;
=20
-=09if (status < 0) {
-=09=09mausb_pr_alert("Failed to load MAUSB module!");
-=09=09return status;
-=09}
+=09status =3D mausb_create_dev();
+=09if (status < 0)
+=09=09goto cleanup_hcd;
=20
 =09return 0;
+
+cleanup_hcd:
+=09mausb_deinit_hcd();
+cleanup:
+=09mausb_pr_alert("Failed to load MAUSB module!");
+=09return status;
 }
=20
 static void mausb_host_exit(void)
 {
 =09mausb_pr_info("Module unloading started...");
+=09mausb_deinit_hcd();
 =09mausb_cleanup_dev(1);
 =09mausb_pr_info("Module unloaded. Version=3D%s", MAUSB_DRIVER_VERSION);
 }
--=20
2.17.1

