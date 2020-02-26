Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF39C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F3DB2467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="sLNVPnAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgBZJ6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:58:23 -0500
Received: from eu-smtp-delivery-167.mimecast.com ([207.82.80.167]:29335 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726936AbgBZJ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1582711099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=UguUViZpTZPjss/rR7YH58gT8PkIVyd21bRuy5/bIV0=;
        b=sLNVPnAn7PJqEEhj8HR+fvURSN1Ca/ajjsFV70o/qXm7rAEdM7Qm4UbN3iOecCqmJYYlRg
        +nRdjL7ANyCg1/XusoPmIvCZArVy1d//by2D39/BnYdHmoGY+gPvP3nusESRvHe+7wnvcq
        7SLUov688dpgyLVYLTPY0Lpzq0TTvmw=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2053.outbound.protection.outlook.com [104.47.12.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-18-XG2eDOQuNlW12J25uGxJUA-1; Wed, 26 Feb 2020 09:58:18 +0000
X-MC-Unique: XG2eDOQuNlW12J25uGxJUA-1
Received: from AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM (52.133.63.154) by
 AM0PR10MB2676.EURPRD10.PROD.OUTLOOK.COM (20.178.119.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Wed, 26 Feb 2020 09:58:17 +0000
Received: from AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d07a:2e67:4515:dba6]) by AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::d07a:2e67:4515:dba6%3]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 09:58:17 +0000
Received: from [172.17.183.132] (80.93.235.40) by VI1PR07CA0258.eurprd07.prod.outlook.com (2603:10a6:803:b4::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.13 via Frontend Transport; Wed, 26 Feb 2020 09:58:16 +0000
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        mausb-host-devel <mausb-host-devel@displaylink.com>
Subject: [PATCH v2 3/8] usb: mausb_host: HCD initialization
Thread-Topic: [PATCH v2 3/8] usb: mausb_host: HCD initialization
Thread-Index: AQHV7ItEETQLCpi19E+KEEE+SZVSAg==
Date:   Wed, 26 Feb 2020 09:58:17 +0000
Message-ID: <6ed0f684-94d4-e8d1-18c6-31580eed09ae@displaylink.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0258.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::25) To AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:40::26)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [80.93.235.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d1e6e76-3d8f-44f9-79c8-08d7baa26706
x-ms-traffictypediagnostic: AM0PR10MB2676:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR10MB26766DF13F4A2BAE16DF7D7191EA0@AM0PR10MB2676.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:61;
x-forefront-prvs: 0325F6C77B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(366004)(39840400004)(346002)(189003)(199004)(81166006)(8936002)(44832011)(8676002)(81156014)(956004)(36756003)(478600001)(71200400001)(2906002)(5660300002)(16576012)(316002)(54906003)(86362001)(66946007)(26005)(64756008)(66446008)(2616005)(31686004)(4326008)(6916009)(66476007)(66556008)(16526019)(52116002)(107886003)(31696002)(186003)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR10MB2676;H:AM0PR10MB1954.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e2MvapMeELfeVcOyDiFMqGOdQiiVjqCme4nKmjLjW4Vf6Txh4NThg1Qx+captHLIKdNE+9gbbWHj8IRSrv4wVYWJvOaRyEzGhLj3zf9BmDAZwtc6LDo+OHM4XlbDnClcZHgw3ocwzV7s0XtiEDUwFDdCDhxyiySAxa9Ky4LfVhxmPtsCL3tbpDRe3nz/S5CxcFMIxO7tvhFG2G74WyHEVKG8SGejdXx11lIUFPXCxVXjGmCnqWuW60hHqvaTJ1fQIXguStHADVqpX2iqiMwelT4DblAr/VxLUrjmDZAMgt1X0XctVNc5VP+evJfDSRhfrIi4mCODnxeijNaHRavsVIkkbUYCMvuMTMHYXGZUulUU+Hj4yQMkQCj7iUGayK4HVCANEGFOwxAHpFcho3+OCow5dY+ecAWA8HLqTvuBDZmA+mW+J4OcchoA9j51Vo4v
x-ms-exchange-antispam-messagedata: 2BhvsLS7mDtJPnqrnKY5eKEOk7MuG3Iwru/BiVPu23bn5mVNCL8nfoWFQpiQdr39ThnBS3Br0eqgACcWyuk49JvM8e7s4n/ppCNAkC4DJ1NppxkH0I4KGhGNokP+ma2MgJGuus+GENXhzff3jbp21A==
Content-ID: <73A03FEF6BF7C2479EEF1137CF895F5A@EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1e6e76-3d8f-44f9-79c8-08d7baa26706
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2020 09:58:17.3239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +lj0XdSA35Ro6p2Idk7S0AaaAP+idQALwD0IWVFaBsX2dy1lgrgTDDC7w8YCywLJ+91MqdGwJZHb7Ti6Y0dgaSe5eLHon9VoxV71aHtblOCMid+dOxLUYslkJwSnTcce
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2676
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
  drivers/usb/mausb_host/mausb_host.c |  20 ++-
  4 files changed, 275 insertions(+), 5 deletions(-)
  create mode 100644 drivers/usb/mausb_host/hcd.c
  create mode 100644 drivers/usb/mausb_host/hcd.h

diff --git a/drivers/usb/mausb_host/Makefile=20
b/drivers/usb/mausb_host/Makefile
index 4db9dbfc1ebb..855947376f71 100644
--- a/drivers/usb/mausb_host/Makefile
+++ b/drivers/usb/mausb_host/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_HOST_MAUSB) +=3D mausb_host.o
  mausb_host-y :=3D mausb_host.o
  mausb_host-y +=3D utils.o
  mausb_host-y +=3D ip_link.o
+mausb_host-y +=3D hcd.o
   ccflags-y +=3D -I$(srctree)/$(src)
  ccflags-y +=3D -g
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
+static ssize_t mausb_read(struct file *file, char __user *buffer,=20
size_t length,
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
+static ssize_t mausb_read(struct file *file, char __user *buffer,=20
size_t length,
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
diff --git a/drivers/usb/mausb_host/mausb_host.c=20
b/drivers/usb/mausb_host/mausb_host.c
index 8638dd0a4856..3ce90c29f6de 100644
--- a/drivers/usb/mausb_host/mausb_host.c
+++ b/drivers/usb/mausb_host/mausb_host.c
@@ -11,6 +11,7 @@
  #include <linux/moduleparam.h>
  #include <linux/net.h>
  +#include "hcd.h"
  #include "utils.h"
   MODULE_LICENSE("GPL");
@@ -67,21 +68,30 @@ static const struct kernel_param_ops=20
mausb_client_disconnect_ops =3D {
   static int mausb_host_init(void)
  {
-=09int status =3D mausb_create_dev();
+=09int status;
   =09mausb_pr_info("Module load. Version=3D%s", MAUSB_DRIVER_VERSION);
+=09status =3D mausb_init_hcd();
+=09if (status < 0)
+=09=09goto cleanup;
  -=09if (status < 0) {
-=09=09mausb_pr_alert("Failed to load MAUSB module!");
-=09=09return status;
-=09}
+=09status =3D mausb_create_dev();
+=09if (status < 0)
+=09=09goto cleanup_hcd;
   =09return 0;
+
+cleanup_hcd:
+=09mausb_deinit_hcd();
+cleanup:
+=09mausb_pr_alert("Failed to load MAUSB module!");
+=09return status;
  }
   static void mausb_host_exit(void)
  {
  =09mausb_pr_info("Module unloading started...");
+=09mausb_deinit_hcd();
  =09mausb_cleanup_dev(1);
  =09mausb_pr_info("Module unloaded. Version=3D%s", MAUSB_DRIVER_VERSION);
  }
--=20
2.17.1


