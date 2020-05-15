Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04589C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD4AA20767
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 12:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=displaylink.com header.i=@displaylink.com header.b="rEk+TCSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgEOMfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 08:35:25 -0400
Received: from eu-smtp-delivery-167.mimecast.com ([146.101.78.167]:56628 "EHLO
        eu-smtp-delivery-167.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgEOMfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 08:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=displaylink.com;
        s=mimecast20151025; t=1589546119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G8Da7JqpDvXAiuuR1S6C0Dn1p2bC2zwP+OJq5GnqLXI=;
        b=rEk+TCSEG/Vpwm7dyDHSexsO8kY+nn07kdkRIVjudF4w3NLRNQk9nTn/CUBNqzzJKA5q3A
        oVix2B1pu4tab9iqd2ITwLCbnWTCJ8oeWTgB/k8mBet+CYuflmOjLO76T3pKGwokY405Y6
        xaYy8Nagx6LYFCd1sMiVVlL+WslOT/A=
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04lp2053.outbound.protection.outlook.com [104.47.14.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-247-qU8i7QyAPrq2h-AnsCWYSA-1; Fri, 15 May 2020 13:35:18 +0100
X-MC-Unique: qU8i7QyAPrq2h-AnsCWYSA-1
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13) by VI1PR1001MB1230.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:dd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Fri, 15 May
 2020 12:35:16 +0000
Received: from VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cc1:941d:635d:99f7]) by VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cc1:941d:635d:99f7%11]) with mapi id 15.20.3000.016; Fri, 15 May
 2020 12:35:16 +0000
From:   Vladimir Stankovic <vladimir.stankovic@displaylink.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        mausb-host-devel@displaylink.com
Subject: [PATCH v6 1/8] usb: Add MA-USB Host kernel module
Date:   Fri, 15 May 2020 14:34:55 +0200
Message-Id: <20200515123502.12099-2-vladimir.stankovic@displaylink.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200515123502.12099-1-vladimir.stankovic@displaylink.com>
References: <20200425091954.1610-1-vladimir.stankovic@displaylink.com>
 <20200515123502.12099-1-vladimir.stankovic@displaylink.com>
X-ClientProxiedBy: VI1PR09CA0140.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::24) To VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:64::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from raven-hp.endava.net (94.189.199.177) by VI1PR09CA0140.eurprd09.prod.outlook.com (2603:10a6:803:12c::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25 via Frontend Transport; Fri, 15 May 2020 12:35:16 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [94.189.199.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b8813d4-5d1a-4ee3-bcef-08d7f8cc6be9
X-MS-TrafficTypeDiagnostic: VI1PR1001MB1230:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR1001MB1230F8E8629D652750903B6B91BD0@VI1PR1001MB1230.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:287;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AdoIOIV2A6RG1eB83T1cUOmSk3gOLD4B9YcSN8iQHAEY5yLxrtr1KCa9L10NPDk2+QLV9CI8AVSci+TYAsHkztoK1MLGxXsOxY+oEg9MnhO74TWFqn32mhDu5a0X96C0BxRByHC60APR88knJRHc5PIGSMumJfLgbM1LA9CO7AWuuFHMf6/x+Mr15Rio9FJYMZY4or2db5d/7Jn/g1mIaAP74gISurQ4hlwxWLwE2RFrLTVPkD3vM6F3YrlHEkzoo+pnCseZomGXItzy+t39xhADhIiW9f5kqNOnI7SBps15T3x6jHDEF/ABlecOGYFcj4vYLQSX2aLKGMS4D4J74zYkLyFoI6kyYfSJacU/BI2q2T4BsWwnhnHcYtiXFpCU/Dnc51q9uZ266xd1msv5eqd3eN023FSSpbUpL0G6/iksixCG+fNOb88X3zYWfcGeGQNjejlnAs4QOodd2r/vK+L7sOuenuG4L1rLagSzedy558A2TcLFaIuKHoiE16cceoUpVmtYnF73Le1ZWtILUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR1001MB1056.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39840400004)(366004)(346002)(376002)(36756003)(86362001)(5660300002)(107886003)(6666004)(66946007)(66476007)(66556008)(2906002)(4326008)(16526019)(956004)(6486002)(8676002)(186003)(8936002)(6512007)(6506007)(1076003)(478600001)(26005)(44832011)(6916009)(316002)(2616005)(52116002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 0ZOKC5AQPjP9qF8unSV4fdd5wBLzPstbRLKHD1NnHd4Dp9MZN0Jv2yY9tnaRgP2cpx+wAI8ox7K5JxpNJlprVXObYDuwldVqCK5AwbvZlKXzqT/sfSOFJhwXHFurRH5fOwxJoACdIDV/69smaU9y4yrM7zroGXLUdrqq8SAU6XDfTltAnLveBcwYF10217ML0RsWa59sdys6PHvqWEgAnCVC9xyDaPpLh9Nffzj32NjYyTUY/dRQdfW8Ydni63dkacO6HuiG50bwDlqEnjcHAaIftxE1e93bUy39wVm/XBKkyUY2X4k7s4e+M9BUywPm8WQ+fiex5fphrH74wKfnGx8peV0saj9MSP5/dvOaq2DPID5FOzKQ9QpBBhKERWQcizZP4G0S3keqr15aR23nmRKGF1P+LWZv+qOmx7IVex4FnRXjJpEMREJJyF2TQF0y7YHnQjnwDpOsoNDsrSpIl4djIAzyL6n6uvZbzPeD7qfAUCTT+BDc5S4RTvoYBtOt
X-OriginatorOrg: displaylink.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8813d4-5d1a-4ee3-bcef-08d7f8cc6be9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 12:35:16.5830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4bda75a-b444-4312-9c90-44a7c4b2c91a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2UBW7Li/KYIkO4XQ+66CJGIw2HUrbzEjlJrgRB/NYiS4FctCjX34X58sDMDwdb2YTb4SLwQjWIAl6RtBBrFhqkkZS8yx+rMxozQ5YmhUeulQfSNXDiMOcIIf80usCvr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR1001MB1230
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
 MAINTAINERS                         |  7 +++++
 drivers/usb/Kconfig                 |  2 ++
 drivers/usb/Makefile                |  1 +
 drivers/usb/host/mausb/Kconfig      | 15 +++++++++
 drivers/usb/host/mausb/Makefile     | 10 ++++++
 drivers/usb/host/mausb/mausb_core.c | 24 +++++++++++++++
 drivers/usb/host/mausb/utils.c      | 47 +++++++++++++++++++++++++++++
 drivers/usb/host/mausb/utils.h      | 15 +++++++++
 8 files changed, 121 insertions(+)
 create mode 100644 drivers/usb/host/mausb/Kconfig
 create mode 100644 drivers/usb/host/mausb/Makefile
 create mode 100644 drivers/usb/host/mausb/mausb_core.c
 create mode 100644 drivers/usb/host/mausb/utils.c
 create mode 100644 drivers/usb/host/mausb/utils.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 091ec22c1a23..9b7b79215f47 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10343,6 +10343,13 @@ W:=09https://linuxtv.org
 T:=09git git://linuxtv.org/media_tree.git
 F:=09drivers/media/radio/radio-maxiradio*
=20
+MEDIA AGNOSTIC (MA) USB HOST DRIVER
+M:=09Vladimir Stankovic <vladimir.stankovic@displaylink.com>
+L:=09mausb-host-devel@displaylink.com
+W:=09https://www.displaylink.com
+S:=09Maintained
+F:=09drivers/usb/host/mausb/*
+
 MCAN MMIO DEVICE DRIVER
 M:=09Dan Murphy <dmurphy@ti.com>
 M:=09Sriram Dash <sriram.dash@samsung.com>
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 275568abc670..35f5c3ac6656 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -99,6 +99,8 @@ source "drivers/usb/mon/Kconfig"
=20
 source "drivers/usb/host/Kconfig"
=20
+source "drivers/usb/host/mausb/Kconfig"
+
 source "drivers/usb/renesas_usbhs/Kconfig"
=20
 source "drivers/usb/class/Kconfig"
diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index 1c1c1d659394..2389b55723ab 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -34,6 +34,7 @@ obj-$(CONFIG_USB_IMX21_HCD)=09+=3D host/
 obj-$(CONFIG_USB_FSL_USB2)=09+=3D host/
 obj-$(CONFIG_USB_FOTG210_HCD)=09+=3D host/
 obj-$(CONFIG_USB_MAX3421_HCD)=09+=3D host/
+obj-$(CONFIG_USB_HOST_MAUSB)=09+=3D host/mausb/
=20
 obj-$(CONFIG_USB_C67X00_HCD)=09+=3D c67x00/
=20
diff --git a/drivers/usb/host/mausb/Kconfig b/drivers/usb/host/mausb/Kconfi=
g
new file mode 100644
index 000000000000..ba72ef42f942
--- /dev/null
+++ b/drivers/usb/host/mausb/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Kernel configuration file for MA-USB Host driver.
+#
+# Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+#
+
+config USB_HOST_MAUSB
+=09tristate "Media Agnostic (MA) USB Host Driver"
+=09depends on USB=3Dy
+=09help
+=09  This is a Media Agnostic (MA) USB Host driver which enables host
+=09  communication via MA USB protocol stack.
+
+=09  If this driver is compiled as a module, it will be named mausb_host.
diff --git a/drivers/usb/host/mausb/Makefile b/drivers/usb/host/mausb/Makef=
ile
new file mode 100644
index 000000000000..cafccac0edba
--- /dev/null
+++ b/drivers/usb/host/mausb/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for DisplayLink MA-USB Host driver.
+#
+# Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+#
+
+obj-$(CONFIG_USB_HOST_MAUSB) +=3D mausb_host.o
+mausb_host-y :=3D mausb_core.o
+mausb_host-y +=3D utils.o
diff --git a/drivers/usb/host/mausb/mausb_core.c b/drivers/usb/host/mausb/m=
ausb_core.c
new file mode 100644
index 000000000000..44f76a1b74de
--- /dev/null
+++ b/drivers/usb/host/mausb/mausb_core.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+ */
+#include <linux/module.h>
+
+#include "utils.h"
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("DisplayLink (UK) Ltd.");
+
+static int mausb_host_init(void)
+{
+=09return mausb_host_dev_register();
+}
+
+static void mausb_host_exit(void)
+{
+=09dev_info(mausb_host_dev.this_device, "Module unloading started...");
+=09mausb_host_dev_deregister();
+}
+
+module_init(mausb_host_init);
+module_exit(mausb_host_exit);
diff --git a/drivers/usb/host/mausb/utils.c b/drivers/usb/host/mausb/utils.=
c
new file mode 100644
index 000000000000..1cfa2140311e
--- /dev/null
+++ b/drivers/usb/host/mausb/utils.c
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+ */
+#include "utils.h"
+
+#include <linux/fs.h>
+#include <linux/slab.h>
+
+#define MAUSB_KERNEL_DEV_NAME "mausb_host"
+#define MAUSB_READ_DEVICE_TIMEOUT_MS 500
+
+struct miscdevice mausb_host_dev;
+
+static int mausb_host_dev_open(struct inode *inode, struct file *filp)
+{
+=09filp->private_data =3D NULL;
+
+=09return 0;
+}
+
+static int mausb_host_dev_release(struct inode *inode, struct file *filp)
+{
+=09kfree(filp->private_data);
+=09filp->private_data =3D NULL;
+
+=09return 0;
+}
+
+static const struct file_operations mausb_host_dev_fops =3D {
+=09.open=09 =3D mausb_host_dev_open,
+=09.release =3D mausb_host_dev_release,
+};
+
+int mausb_host_dev_register(void)
+{
+=09mausb_host_dev.minor =3D MISC_DYNAMIC_MINOR;
+=09mausb_host_dev.name =3D MAUSB_KERNEL_DEV_NAME;
+=09mausb_host_dev.fops =3D &mausb_host_dev_fops;
+=09mausb_host_dev.mode =3D 0;
+=09return misc_register(&mausb_host_dev);
+}
+
+void mausb_host_dev_deregister(void)
+{
+=09misc_deregister(&mausb_host_dev);
+}
diff --git a/drivers/usb/host/mausb/utils.h b/drivers/usb/host/mausb/utils.=
h
new file mode 100644
index 000000000000..e810e691c39d
--- /dev/null
+++ b/drivers/usb/host/mausb/utils.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 - 2020 DisplayLink (UK) Ltd.
+ */
+#ifndef __MAUSB_UTILS_H__
+#define __MAUSB_UTILS_H__
+
+#include <linux/miscdevice.h>
+
+extern struct miscdevice mausb_host_dev;
+
+int mausb_host_dev_register(void);
+void mausb_host_dev_deregister(void);
+
+#endif /* __MAUSB_UTILS_H__ */
--=20
2.17.1

