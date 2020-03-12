Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A827C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DFB620724
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="vy11Zat9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgCLOnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:43:13 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([146.101.78.167]:60525 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727770AbgCLOnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1584024189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FNO2y6TkOn/avxp4BRQ6kPF2U28UK3N/jtVujpX8Mn4=;
        b=vy11Zat9aR9sJ7jH6d3uKp0QCuhk9SUot+V1oCsQ/C1C/hvCT0/moxXmvo/UcQ3iIh98fM
        KqJv4yotOKWEJIs4XVMaZDNeRlyJYEKNd21uihis8M0x4orvHI/MRe1hMTYIYV4aadP/yR
        ZhpOGiQMr7Navdr/ZTUqVB2OAek/0+4=
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01lp2059.outbound.protection.outlook.com [104.47.2.59]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-63-K_3QK9c5NeufJBhAkul3Fw-1; Thu, 12 Mar 2020 14:43:07 +0000
X-MC-Unique: K_3QK9c5NeufJBhAkul3Fw-1
Received: from VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM (52.134.27.157) by
 VI1PR10MB2814.EURPRD10.PROD.OUTLOOK.COM (20.178.126.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.17; Thu, 12 Mar 2020 14:43:06 +0000
Received: from VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a1b9:204d:15b9:dcc]) by VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a1b9:204d:15b9:dcc%4]) with mapi id 15.20.2793.013; Thu, 12 Mar 2020
 14:43:06 +0000
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Subject: [PATCH v3 3/8] usb: mausb_host: HCD initialization
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        mausb-host-devel <mausb-host-devel@displaylink.com>
Message-ID: <fb93be71-dfed-c977-d6c9-8d2b63a84562@displaylink.com>
Date:   Thu, 12 Mar 2020 15:43:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
Content-Language: en-US
X-ClientProxiedBy: VI1PR07CA0233.eurprd07.prod.outlook.com
 (2603:10a6:802:58::36) To VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:37::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.17.183.132] (91.208.120.1) by VI1PR07CA0233.eurprd07.prod.outlook.com (2603:10a6:802:58::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.9 via Frontend Transport; Thu, 12 Mar 2020 14:43:06 +0000
X-Originating-IP: [91.208.120.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 412490c5-035b-4344-a48b-08d7c693ad14
X-MS-TrafficTypeDiagnostic: VI1PR10MB2814:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR10MB28141A4D0F3121BC6AE6919591FD0@VI1PR10MB2814.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:61;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(376002)(136003)(39840400004)(199004)(478600001)(2616005)(4326008)(8676002)(81156014)(8936002)(107886003)(31696002)(6916009)(31686004)(52116002)(66946007)(66556008)(66476007)(36756003)(81166006)(16576012)(316002)(6486002)(2906002)(86362001)(956004)(26005)(5660300002)(186003)(54906003)(16526019)(44832011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB2814;H:VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PPGlhOlZUzbHNa6QJRuu/zx2E4jV9d+HL2Xvlf2T069YWdavfAk9Vma5fpswCj2x5XpYipYaW1ikK/cNwuZl3R6Naec1f2m2jBHfw5/IVwL9+xdruARxmKCaY6Yociv89fNPENNhZhyAD74d8OL1INQhxhW83JPXAeIUUK7V8VaKj1mfJQhpF0JMj+A3woF876H4ySmR1FUdE98Hnc7K7mDKw/J/MxLeLD7DRZ3VXVgiDfqqz9EkwG9fhC7o1lkUqy6BxBx3fLUZu4TD33H6AJBttZTJBngiBInxezyIWmu+61WmHboR0a5t4dwwWo7EMPrD9ghR4HncnDwkzsmlTunPX7VaKYO3jIB8vNe1m8IgJwO2Vafk+j4xK5crp2VetC077tIKJJ0w3zGv2gwtDRt0vnIH9fvZ7rVQ4Z1znYfwQN+ASmrbpFMI6CoTsa6j
X-MS-Exchange-AntiSpam-MessageData: 3Jl86l0Jeg/KdPwvmi/XJ9ks6ASX5/5Ec2OBU0lqlYqv7KyQJetkU+MOF6/RG6B95rr3A4qarVwCNJ8PkcwQyoiIj/Zq9puYSuAacw8yko3usZ9cZzmnVEh05L5Gy5a4aQDhWpx0fQYNcja1OLju6g==
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 412490c5-035b-4344-a48b-08d7c693ad14
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 14:43:06.3237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ioGVP/CwAtkU07GihrSNItwA9+S0ZELK/nf5IXMx6k+HP40CDyl14m+yO7Mq/KMJFfYroxhKsix43YgXfWUdVapIP2flbK73YxTVckBit1DQBM/xVTWfyjHyj+wvv/3g
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2814
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: displaylink.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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

diff --git a/drivers/usb/mausb_host/Makefile=20
b/drivers/usb/mausb_host/Makefile
index 19445b73b50b..cce4696682b2 100644
--- a/drivers/usb/mausb_host/Makefile
+++ b/drivers/usb/mausb_host/Makefile
@@ -9,5 +9,6 @@ obj-$(CONFIG_HOST_MAUSB) +=3D mausb_host.o
  mausb_host-y :=3D mausb_core.o
  mausb_host-y +=3D utils.o
  mausb_host-y +=3D ip_link.o
+mausb_host-y +=3D hcd.o
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
diff --git a/drivers/usb/mausb_host/mausb_core.c=20
b/drivers/usb/mausb_host/mausb_core.c
index 8638dd0a4856..3ce90c29f6de 100644
--- a/drivers/usb/mausb_host/mausb_core.c
+++ b/drivers/usb/mausb_host/mausb_core.c
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


