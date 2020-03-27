Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3553C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63C5620748
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 15:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="J4hzZjC9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgC0P1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 11:27:06 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([146.101.78.167]:33037 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727505AbgC0P0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 11:26:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1585322794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p3Q/qxHY8Z8sZB0IMfTWFx2ynA5v2YyuJWLXITP9bnE=;
        b=J4hzZjC9xdQugbLiNxvGV7ZcifYxAL1YO9KrkrYiUyYda8gvbUg7g8A66GDZrCI9KFuhPH
        YY39GT2xWk8L9Ay6SkPl8Tj2ug7+GM+159x9m7Z7fXkCuJOb2tCUQon1I/le/cVg1VH+Lt
        fnmemtAMQgyfGrrCokE+6jQwgkmk31g=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-231-5eMxg2AyNfmValZSnZsSEA-2; Fri, 27 Mar 2020 15:26:33 +0000
X-MC-Unique: 5eMxg2AyNfmValZSnZsSEA-2
Received: from AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM (10.255.30.19) by
 AM0PR10MB1939.EURPRD10.PROD.OUTLOOK.COM (52.134.81.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Fri, 27 Mar 2020 15:26:29 +0000
Received: from AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::991c:987a:8997:3aab]) by AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::991c:987a:8997:3aab%6]) with mapi id 15.20.2856.019; Fri, 27 Mar 2020
 15:26:29 +0000
From:   vladimir.stankovic@displaylink.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
Subject: [PATCH v4 3/8] usb: mausb_host: HCD initialization
Date:   Fri, 27 Mar 2020 16:26:09 +0100
Message-Id: <20200327152614.26833-4-vladimir.stankovic@displaylink.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200327152614.26833-1-vladimir.stankovic@displaylink.com>
References: <8c24bff9-79a6-ca53-ce8f-fb503163db24@displaylink.com>
 <20200327152614.26833-1-vladimir.stankovic@displaylink.com>
X-ClientProxiedBy: VI1PR10CA0090.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::19) To AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from raven-hp.endava.net (94.189.199.177) by VI1PR10CA0090.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:28::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18 via Frontend Transport; Fri, 27 Mar 2020 15:26:28 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [94.189.199.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 884537e8-37c6-4407-0d53-08d7d26338b9
X-MS-TrafficTypeDiagnostic: AM0PR10MB1939:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR10MB193939633B838E7ABEA914D091CC0@AM0PR10MB1939.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:61;
X-Forefront-PRVS: 0355F3A3AE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3075.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39840400004)(396003)(366004)(136003)(376002)(346002)(2906002)(316002)(66946007)(66476007)(5660300002)(4326008)(2616005)(956004)(66556008)(16526019)(6486002)(6666004)(36756003)(186003)(81166006)(81156014)(8676002)(8936002)(107886003)(478600001)(6916009)(1076003)(86362001)(6506007)(6512007)(52116002)(9686003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rzvlBcd8S195ehgI5t5c68rlUwRrjMUWXQdi6XnoInsWGvBvEeYqbIze113yKJt8f+K1Hw9OKEoxiZhuuzbRfZi4ctvdPKOWJ28DYk/3XTkaS8OvxiipINsALPsK/TKWGWh3C1gAKX0gHEt94S7IZbsqzoJ953iGPxMvM0eQQ/DqiS4SBZkHw8E0BuEiLLupNe4fWCiPW6SS7bi4QrXm0jx07h2vLjDIfO/XFpKl1N26SmYvBuQ4WeAfNSfESuTzSGrymAwaVGkQSiAB4Jt2VqtoK6k3OdutsMvAjwChbt05qra2mD1smc9rwAIP1xMSGxDKTTcLmKEbrQkW4GT4Usk3DUrP92oBnJyxvI8AscmTYcfFSEqiZMuB/IFZBPl8iaOvLY+qB+/3o0OTDyrnlAzx6E2v2H9ObFRTZ7XHKY161jRhTdJFabd/OfuVzrlF
X-MS-Exchange-AntiSpam-MessageData: oRZV8n6u940UQsm/acIntsNp9mO7OkAKaonnhTfy5VU1rV7TWdoKnTgNeTDorcQsxsk95pagfwpLP8I3867R6LKyMeguBIwSbsV8huQV/fbWwaF0mRZbVrZw9ITz9ZFQbFt5VsG5SQsEx1DyXB65Yg==
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884537e8-37c6-4407-0d53-08d7d26338b9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2020 15:26:29.3410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EB3z64/EX/S5+wpF3dlNY5/dx75o6knhZutMeZBzbNteJRKSNViRxVgu3tvYK1rh0Yg0GcZjyMEiQNlcDBXUgIfaO3WAmsqwaNSzq7plrMzoNP9cy+IFlvZMV7n33H0L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB1939
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

