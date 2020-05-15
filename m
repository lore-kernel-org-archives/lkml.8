Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2044CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D792074D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="rhDjrSDN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgEOMf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 08:35:29 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([146.101.78.167]:48487 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726168AbgEOMfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:35:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1589546121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uUiqQnyYPdCETs65MQjmXqWW7YHEM6xnh6xzKX7nhV8=;
        b=rhDjrSDNsFCwOD2LRKLkCkWjFR6YhSFeMAbSrZYnMTew7PQqnsO3YarTHL3Vymi11t9NRj
        2d5odKDUjBUMf8PkX0Wdcdp/UWmA5NpKxhd2PkUJjuQiivl0DSCO5oXJog2R2mpVqdZIQQ
        xvhrrd8WRudUG0AoZKhxUfPaYMdWP8s=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-247-KMo_nHS9PvaFa8mVGw-lRg-4; Fri, 15 May 2020 13:35:20 +0100
X-MC-Unique: KMo_nHS9PvaFa8mVGw-lRg-4
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13) by VI1PR1001MB1230.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:dd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Fri, 15 May
 2020 12:35:18 +0000
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cc1:941d:635d:99f7]) by VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cc1:941d:635d:99f7%11]) with mapi id 15.20.3000.016; Fri, 15 May
 2020 12:35:18 +0000
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
Subject: [PATCH v6 3/8] usb: mausb_host: HCD initialization
Date:   Fri, 15 May 2020 14:34:57 +0200
Message-Id: <20200515123502.12099-4-vladimir.stankovic@displaylink.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515123502.12099-1-vladimir.stankovic@displaylink.com>
References: <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
 <20200515123502.12099-1-vladimir.stankovic@displaylink.com>
X-ClientProxiedBy: VI1PR09CA0140.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::24) To VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from raven-hp.endava.net (94.189.199.177) by VI1PR09CA0140.eurprd09.prod.outlook.com (2603:10a6:803:12c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Fri, 15 May 2020 12:35:17 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [94.189.199.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 873f473b-ea06-4003-0221-08d7f8cc6cc2
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1230:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR1001MB1230B4FF921357C99123BD1591BD0@VI1PR1001MB1230.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:123;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: For8d4iHtAohh3TF5scC0k9yHLWlO0OwyydQQDIsSooWnqLdq8ch9cVYNr53h5pCZCF3GI5EbrXn9WO2ZLGKCuko1UMzkZ8poyzWFzGqxGwsjDhrAy2Qk61P3PnRF9P+FKUNSsywl70MLe6y6QyQEgg3ob2QBTM3IcZsQFC211Ou8/+6smuJI8M9n03v6BARztYk1aYgMl3trJqHpCro9H745bxecD63rlVndUtiz5ZrppiEf72+gVFDMGKK5lTAPP50KIyA1gyj/WK6htuwCTDKDQW7gDhj+FaLp+bcTgH9bq+Itn/3ePJ2ipg0drgnalnpXDdBaSh4qKqLg/fos7tb0o9GLJqvnu+MDF7EkdIs2Q+3BczuGMDM/lD17QxP8G5sEbABQXEfqex7PHwicHiO/xqL35ovCE08ZWm79nafXvwfnNzYJwJNGV8TNF8Z
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39840400004)(366004)(346002)(376002)(36756003)(86362001)(5660300002)(107886003)(6666004)(66946007)(66476007)(66556008)(2906002)(4326008)(16526019)(956004)(6486002)(8676002)(186003)(8936002)(6512007)(6506007)(1076003)(478600001)(26005)(44832011)(6916009)(316002)(2616005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: BM+WIvXlBfMeQApXLhmvFlVOtjVzoqen9gC/MWg0dpIsStodE9N58atHEzqHFLRny7tYZ4fcPAXQUnjcg3nC5HhGTBhh4Fzu0Ef1sHzPoEJcUxDEXBESZtdzb/3MnFRqb7r5201BKJmPrrg/e1wEoTKF5k9fROyPrxZbYgulusFyvzlxFrpJbATeRW75swtjJ6vlEoUoCnIVspEdCObh2MvlzdNFm97zpXQ3pQ8BbKRDm65Lzud7EzVrlmTnaeSYrqWQqfCoKL4+fyATX0bYyGITd9XKU8SBmq4d7nChez1JIGoRzRihLZ3Q8+k2+uf5RHmxXcv3L+fJ0w8OdIqrPP5bBJRPP5h48vmeT55AxaF5y0a2ICyxiom+SyyeHzWBtTuj6dpXFeNGq2PjNmhw+E4tx27IS3eTED8Qk9/ezPkY1cX5NN6+FEplXLoCgg1byuF1Ikl4YEnRlURlcyuM8LbNUCcDq2p/m0scU9JliDk=
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873f473b-ea06-4003-0221-08d7f8cc6cc2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 12:35:17.9894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EHCbxQK18edx2ddCZlCAaq0DrdjjxIRHvcTCYfCbT6j48V7JlPpk31gq/beN6CZKxCFMNriGnRutfWCUaUurNxmF46aihFR7Sp+dgLxecYdtvOm8m6l6zXZFuDVFzNQT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1230
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
 drivers/usb/host/mausb/Makefile     |   1 +
 drivers/usb/host/mausb/hcd.c        | 120 ++++++++++++++++++++++++++++
 drivers/usb/host/mausb/hcd.h        |  65 +++++++++++++++
 drivers/usb/host/mausb/mausb_core.c |  18 ++++-
 4 files changed, 203 insertions(+), 1 deletion(-)
 create mode 100644 drivers/usb/host/mausb/hcd.c
 create mode 100644 drivers/usb/host/mausb/hcd.h

diff --git a/drivers/usb/host/mausb/Makefile b/drivers/usb/host/mausb/Makef=
ile
index acc8ad3f0eff..4d655cb7fab4 100644
--- a/drivers/usb/host/mausb/Makefile
+++ b/drivers/usb/host/mausb/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_USB_HOST_MAUSB) +=3D mausb_host.o
 mausb_host-y :=3D mausb_core.o
 mausb_host-y +=3D utils.o
 mausb_host-y +=3D ip_link.o
+mausb_host-y +=3D hcd.o
diff --git a/drivers/usb/host/mausb/hcd.c b/drivers/usb/host/mausb/hcd.c
new file mode 100644
index 000000000000..3a6ef9313dcb
--- /dev/null
+++ b/drivers/usb/host/mausb/hcd.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+ */
+#include "hcd.h"
+
+#include "utils.h"
+
+static int mausb_bus_match(struct device *dev, struct device_driver *drv);
+
+static const struct file_operations mausb_fops;
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
+static int mausb_bus_match(struct device *dev, struct device_driver *drv)
+{
+=09if (strncmp(dev->bus->name, drv->name, strlen(drv->name)))
+=09=09return 0;
+=09else
+=09=09return 1;
+}
+
+int mausb_init_hcd(void)
+{
+=09int retval =3D register_chrdev(0, DEVICE_NAME, &mausb_fops);
+
+=09if (retval < 0)
+=09=09return retval;
+
+=09major =3D (unsigned int)retval;
+=09retval =3D bus_register(&mausb_bus_type);
+=09if (retval)
+=09=09goto bus_register_error;
+
+=09mausb_class =3D class_create(THIS_MODULE, CLASS_NAME);
+=09if (IS_ERR(mausb_class)) {
+=09=09retval =3D (int)PTR_ERR(mausb_class);
+=09=09goto class_error;
+=09}
+
+=09retval =3D driver_register(&mausb_driver);
+=09if (retval)
+=09=09goto driver_register_error;
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
+=09=09retval =3D (int)IS_ERR(device);
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
diff --git a/drivers/usb/host/mausb/hcd.h b/drivers/usb/host/mausb/hcd.h
new file mode 100644
index 000000000000..e2374af67663
--- /dev/null
+++ b/drivers/usb/host/mausb/hcd.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+ */
+#ifndef __MAUSB_HCD_H__
+#define __MAUSB_HCD_H__
+
+#include <linux/slab.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
+#define DEVICE_NAME "mausb_host_hcd"
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
diff --git a/drivers/usb/host/mausb/mausb_core.c b/drivers/usb/host/mausb/m=
ausb_core.c
index 44f76a1b74de..485f241d2b4c 100644
--- a/drivers/usb/host/mausb/mausb_core.c
+++ b/drivers/usb/host/mausb/mausb_core.c
@@ -4,6 +4,7 @@
  */
 #include <linux/module.h>
=20
+#include "hcd.h"
 #include "utils.h"
=20
 MODULE_LICENSE("GPL");
@@ -11,12 +12,27 @@ MODULE_AUTHOR("DisplayLink (UK) Ltd.");
=20
 static int mausb_host_init(void)
 {
-=09return mausb_host_dev_register();
+=09int status =3D mausb_host_dev_register();
+
+=09if (status < 0)
+=09=09goto exit;
+
+=09status =3D mausb_init_hcd();
+=09if (status < 0)
+=09=09goto cleanup_dev;
+
+=09return 0;
+
+cleanup_dev:
+=09mausb_host_dev_deregister();
+exit:
+=09return status;
 }
=20
 static void mausb_host_exit(void)
 {
 =09dev_info(mausb_host_dev.this_device, "Module unloading started...");
+=09mausb_deinit_hcd();
 =09mausb_host_dev_deregister();
 }
=20
--=20
2.17.1

