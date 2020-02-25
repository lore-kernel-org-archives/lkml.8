Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B646C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D024221744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:42:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Mwvr6TGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731156AbgBYQmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:42:49 -0500
Received: from mail-vi1eur05on2084.outbound.protection.outlook.com ([40.107.21.84]:25985
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729769AbgBYQmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:42:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yphu+98lR1PVxz95zO10QDo+req6Xab63lSWToLxpcuqlVk8A7vhQr7c24nVCCkmiapHawjT2VKhbbOjCtTQGtuOksZKGN5tqF9bvLFQs9hPWYB5rpb4ZrJy7/Cl15G7gggcvCfzQWKz2pc9vazt1HQo5TnQDvBzW+rrA05hsDRvhN7TaXmbf9bSU7Y8S7oj7gmcBiubMM+WoglYiW/z6+0tCJHj54NQ4hemeiIq1MEnyiUm/6Gy0QQyml22O0F0HskC2keAqm+21x89XB7RDGUTTrfXKsEHbgKke1fUMj8REyPqTKnI4+oRixRyIXnCj0KxS/foiDUu3eYmA5RHaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFyOb9ph73SP8bDWXkKf7bCUtQRxdhuSRjk6KbH5BVs=;
 b=Lqm3C4WCUYzDP2ZlKcCB98AS+6CH4O2spAblsWpVcdR+eQ9r9Vacm8wmcA1mia3tQK7PgWfSeIw17U/r5PWHBOt5eNHV+Ykgp0c3vjtkKmmGYqQNUWRHyamyNznpAqIHH9+Zd5maI8EvtO2rUAaR/IqIz5E5Kyob2TJ8qx8dMNSFLegcmXHDP4pnoqu+9q2/Jt99EqN/CbS0yoOdIOFVtFMMH1MK9Hu0gxjErlTXxS8GP3REROt+EtAZTVxP3KVV+e7+DCclMmKBb5XzSRzvsgEDkqwtkEoVmSHg96reQz4DqHytCLcOCYqfaiJASDGcn0jO19PePJzr8gWp1ieTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFyOb9ph73SP8bDWXkKf7bCUtQRxdhuSRjk6KbH5BVs=;
 b=Mwvr6TGkcXH+/IUkt3HUn5tm2xQDQxaBxSWFpfkP3yykUzG9aV9r2DvhODMGsyVmGmJ5RCitnhcm2jatf755OM06sjscEiwPGENFHhrZLi7yFiDynPBVhlVxTl0Bg6+h+td5uRnD2ipSQtYvzcBMI4nH1GxVi6Z08uTy5V7rQ0U=
Received: from DB6PR0501MB2712.eurprd05.prod.outlook.com (10.172.225.17) by
 DB6PR0501MB2614.eurprd05.prod.outlook.com (10.172.225.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Tue, 25 Feb 2020 16:42:32 +0000
Received: from DB6PR0501MB2712.eurprd05.prod.outlook.com
 ([fe80::58ec:69b7:ac09:8614]) by DB6PR0501MB2712.eurprd05.prod.outlook.com
 ([fe80::58ec:69b7:ac09:8614%11]) with mapi id 15.20.2750.021; Tue, 25 Feb
 2020 16:42:32 +0000
From:   Asmaa Mnebhi <Asmaa@mellanox.com>
To:     "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/1] gpio: add driver for Mellanox BlueField 2 GPIO
 controller
Thread-Topic: [PATCH v2 1/1] gpio: add driver for Mellanox BlueField 2 GPIO
 controller
Thread-Index: AQHV6/lSb3twwXT1NEWAYUP399Otg6gsGvTA
Date:   Tue, 25 Feb 2020 16:42:32 +0000
Message-ID: <DB6PR0501MB27121431EA6DCCB476B73F1DDAED0@DB6PR0501MB2712.eurprd05.prod.outlook.com>
References: <cover.1582647809.git.Asmaa@mellanox.com>
 <7ef84476a00e8771cf1edf5745c378273b760f5d.1582647809.git.Asmaa@mellanox.com>
In-Reply-To: <7ef84476a00e8771cf1edf5745c378273b760f5d.1582647809.git.Asmaa@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Asmaa@mellanox.com; 
x-originating-ip: [216.156.69.42]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e331183c-b801-4fd5-444d-08d7ba11b5e2
x-ms-traffictypediagnostic: DB6PR0501MB2614:
x-microsoft-antispam-prvs: <DB6PR0501MB26142FBA24C9BA40D43980CEDAED0@DB6PR0501MB2614.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(189003)(199004)(5660300002)(2906002)(53546011)(6506007)(26005)(66946007)(66446008)(76116006)(55016002)(478600001)(66476007)(4326008)(30864003)(64756008)(66556008)(7696005)(86362001)(186003)(81156014)(8936002)(33656002)(110136005)(316002)(9686003)(71200400001)(52536014)(81166006)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2614;H:DB6PR0501MB2712.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MfiL6xGakT/yKZENxx7KvjPc8U64NJPvDH85vvghKpZ8A+gizA1B1KtYRhnQLzMd9iSj/4PA5lelW49ppQlYe5RGpNvO6IbflKxipzdgtil9B/k+ik7AByGogjSfTQnXHyi2DrhDHDOf1dfZV2VTWZFHLbxsD6ORhLAARCs3D6PAHM2GbO8JL35+bXEX2SxuKmdSUehqtj/AdTfUT5Eup1U04gYXyaBBStkKnOvhtqea/dKII4e+pzI2tiMw0ef6XpS+FNBUtZEmetvaXcleQQYLl2S9w90mS+wsyISATzn4q1iPh1baaAr5G0uVQsxUnxBelaG0xpW5Wnvw7Y5NhuFSQszwmaDt9pcZuX4vU3J/mMThbFEFzluR3x33P9rl1hsGY5ah7n9Mh4dhIJGkRnrToH5h84L9OXIj5ToI7SIwfIHdP3c489H+MwVBhcVZ
x-ms-exchange-antispam-messagedata: l8/tUGO7nC4Js7ZxnnBhSChjiyQU4xxpG34vAmjNEh18KZKcewF9iMxjbl3wLJb/pkSVX2qOJrUhuX7yKgLn6gRMjQuX9KHbCU2HIyUhqLXN6CCgqqW9rSIpy7X42Qax/eEdEJIjuMu66tz43a8cMA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e331183c-b801-4fd5-444d-08d7ba11b5e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 16:42:32.2805
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a5YLTI98noYUqFYUhj7opf3zXMQ/GnUa6D8YPv/IgPihJYa1RGK/zCiSevpJYjvV8lzFnkXLz9gPl+3Q981fLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2614
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Thank you for your feedback!=20
I have addressed your comments and tested the code. Please note that the YU=
_ARM_GPIO_LOCK is a shared resource between the 3 gpio blocks instances.
So now that we have split up the gpio_chip into 3 instances, we need to sha=
re that LOCK resource accordingly. I have created a global variable for tha=
t purpose.
Also note, that although it is not supported in this driver at the moment, =
some gpio interrupt registers will be similar to that LOCK i.e. they are sh=
ared among the  3 gpio block instances.

-----Original Message-----
From: Asmaa Mnebhi <Asmaa@mellanox.com>=20
Sent: Tuesday, February 25, 2020 11:33 AM
To: bgolaszewski@baylibre.com; linus.walleij@linaro.org
Cc: Asmaa Mnebhi <Asmaa@mellanox.com>; linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] gpio: add driver for Mellanox BlueField 2 GPIO cont=
roller

This patch adds support for the GPIO controller used by Mellanox BlueField =
2 SOCs.

Signed-off-by: Asmaa Mnebhi <Asmaa@mellanox.com>
---
 drivers/gpio/Kconfig       |   7 +
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-mlxbf2.c | 345 +++++++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 353 insertions(+)
 create mode 100644 drivers/gpio/gpio-mlxbf2.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig index b8013cf..623=
4ccc 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1399,6 +1399,13 @@ config GPIO_MLXBF
 	help
 	  Say Y here if you want GPIO support on Mellanox BlueField SoC.
=20
+config GPIO_MLXBF2
+	tristate "Mellanox BlueField 2 SoC GPIO"
+	depends on (MELLANOX_PLATFORM && ARM64 && ACPI) || (64BIT && COMPILE_TEST=
)
+	select GPIO_GENERIC
+	help
+	  Say Y here if you want GPIO support on Mellanox BlueField 2 SoC.
+
 config GPIO_ML_IOH
 	tristate "OKI SEMICONDUCTOR ML7213 IOH GPIO support"
 	depends on X86 || COMPILE_TEST
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile index 0b57126..b=
2cfc21 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -93,6 +93,7 @@ obj-$(CONFIG_GPIO_MENZ127)		+=3D gpio-menz127.o
 obj-$(CONFIG_GPIO_MERRIFIELD)		+=3D gpio-merrifield.o
 obj-$(CONFIG_GPIO_ML_IOH)		+=3D gpio-ml-ioh.o
 obj-$(CONFIG_GPIO_MLXBF)		+=3D gpio-mlxbf.o
+obj-$(CONFIG_GPIO_MLXBF2)		+=3D gpio-mlxbf2.o
 obj-$(CONFIG_GPIO_MM_LANTIQ)		+=3D gpio-mm-lantiq.o
 obj-$(CONFIG_GPIO_MOCKUP)		+=3D gpio-mockup.o
 obj-$(CONFIG_GPIO_MOXTET)		+=3D gpio-moxtet.o
diff --git a/drivers/gpio/gpio-mlxbf2.c b/drivers/gpio/gpio-mlxbf2.c new fi=
le mode 100644 index 0000000..0d35d4e
--- /dev/null
+++ b/drivers/gpio/gpio-mlxbf2.c
@@ -0,0 +1,345 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/gpio/driver.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/resource.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/version.h>
+
+/*
+ * There are 3 YU GPIO blocks:
+ * gpio[0]: HOST_GPIO0->HOST_GPIO31
+ * gpio[1]: HOST_GPIO32->HOST_GPIO63
+ * gpio[2]: HOST_GPIO64->HOST_GPIO69
+ */
+#define MLXBF2_GPIO_MAX_PINS_PER_BLOCK 32
+
+/*
+ * arm_gpio_lock register:
+ * bit[31]	lock status: active if set
+ * bit[15:0]	set lock
+ * The lock is enabled only if 0xd42f is written to this field  */
+#define YU_ARM_GPIO_LOCK_ADDR		0x2801088
+#define YU_ARM_GPIO_LOCK_SIZE		0x8
+#define YU_LOCK_ACTIVE_BIT(val)		(val >> 31)
+#define YU_ARM_GPIO_LOCK_ACQUIRE	0xd42f
+#define YU_ARM_GPIO_LOCK_RELEASE	0x0
+
+/*
+ * gpio[x] block registers and their offset  */
+#define YU_GPIO_DATAIN			0x04
+#define YU_GPIO_MODE1			0x08
+#define YU_GPIO_MODE0			0x0c
+#define YU_GPIO_DATASET			0x14
+#define YU_GPIO_DATACLEAR		0x18
+#define YU_GPIO_MODE1_CLEAR		0x50
+#define YU_GPIO_MODE0_SET		0x54
+#define YU_GPIO_MODE0_CLEAR		0x58
+
+#ifdef CONFIG_PM
+struct mlxbf2_gpio_context_save_regs {
+	u32 gpio_mode0;
+	u32 gpio_mode1;
+};
+#endif
+
+/* BlueField-2 gpio block state structure. */ struct mlxbf2_gpio_state=20
+{
+	struct gpio_chip gc;
+
+	/* YU GPIO blocks address */
+	void __iomem *gpio_io;
+
+#ifdef CONFIG_PM
+	struct mlxbf2_gpio_context_save_regs *csave_regs; #endif };
+
+/* BlueField-2 gpio shared structure. */ struct mlxbf2_gpio_param {
+	void __iomem *io;
+	struct resource *res;
+	struct mutex *lock;
+};
+
+static struct resource yu_arm_gpio_lock_res =3D {
+	.start =3D YU_ARM_GPIO_LOCK_ADDR,
+	.end   =3D YU_ARM_GPIO_LOCK_ADDR + YU_ARM_GPIO_LOCK_SIZE - 1,
+	.name  =3D "YU_ARM_GPIO_LOCK",
+};
+
+static DEFINE_MUTEX(yu_arm_gpio_lock_mutex);
+
+static struct mlxbf2_gpio_param yu_arm_gpio_lock_param =3D {
+	.res =3D &yu_arm_gpio_lock_res,
+	.lock =3D &yu_arm_gpio_lock_mutex,
+};
+
+/* Request memory region and map yu_arm_gpio_lock resource */ static=20
+int mlxbf2_gpio_get_lock_res(struct platform_device *pdev) {
+	struct device *dev =3D &pdev->dev;
+	struct resource *res;
+	resource_size_t size;
+	int ret =3D 0;
+
+	mutex_lock(yu_arm_gpio_lock_param.lock);
+
+	/* Check if the memory map already exists */
+	if (yu_arm_gpio_lock_param.io)
+		goto exit;
+
+	res =3D yu_arm_gpio_lock_param.res;
+	size =3D resource_size(res);
+
+	if (!devm_request_mem_region(dev, res->start, size, res->name)) {
+		ret =3D -EFAULT;
+		goto exit;
+	}
+
+	yu_arm_gpio_lock_param.io =3D devm_ioremap_nocache(dev, res->start, size)=
;
+	if (IS_ERR(yu_arm_gpio_lock_param.io))
+		ret =3D PTR_ERR(yu_arm_gpio_lock_param.io);
+
+exit:
+	mutex_unlock(yu_arm_gpio_lock_param.lock);
+
+	return ret;
+}
+
+/*
+ * Acquire the YU arm_gpio_lock to be able to change the direction
+ * mode. If the lock_active bit is already set, return an error.
+ */
+static int mlxbf2_gpio_lock_acquire(void) {
+	u32 arm_gpio_lock_val;
+
+	mutex_lock(yu_arm_gpio_lock_param.lock);
+
+	arm_gpio_lock_val =3D readl(yu_arm_gpio_lock_param.io);
+
+	/*
+	 * When lock active bit[31] is set, ModeX is write enabled
+	 */
+	if (YU_LOCK_ACTIVE_BIT(arm_gpio_lock_val)) {
+		mutex_unlock(yu_arm_gpio_lock_param.lock);
+		return -EINVAL;
+	}
+
+	writel(YU_ARM_GPIO_LOCK_ACQUIRE, yu_arm_gpio_lock_param.io);
+
+	mutex_unlock(yu_arm_gpio_lock_param.lock);
+
+	return 0;
+}
+
+/*
+ * Release the YU arm_gpio_lock after changing the direction mode.
+ */
+static void mlxbf2_gpio_lock_release(void) {
+	mutex_lock(yu_arm_gpio_lock_param.lock);
+	writel(YU_ARM_GPIO_LOCK_RELEASE, yu_arm_gpio_lock_param.io);
+	mutex_unlock(yu_arm_gpio_lock_param.lock);
+}
+
+/*
+ * mode0 and mode1 are both locked by the gpio_lock field.
+ *
+ * Together, mode0 and mode1 define the gpio Mode dependeing also
+ * on Reg_DataOut.
+ *
+ * {mode1,mode0}:{Reg_DataOut=3D0,Reg_DataOut=3D1}->{DataOut=3D0,DataOut=
=3D1}
+ *
+ * {0,0}:Reg_DataOut{0,1}->{Z,Z} Input PAD
+ * {0,1}:Reg_DataOut{0,1}->{0,1} Full drive Output PAD
+ * {1,0}:Reg_DataOut{0,1}->{0,Z} 0-set PAD to low, 1-float
+ * {1,1}:Reg_DataOut{0,1}->{Z,1} 0-float, 1-set PAD to high  */
+
+/*
+ * Set input direction:
+ * {mode1,mode0} =3D {0,0}
+ */
+static int mlxbf2_gpio_direction_input(struct gpio_chip *chip,
+				       unsigned int offset)
+{
+	struct mlxbf2_gpio_state *gs =3D gpiochip_get_data(chip);
+	int ret;
+
+	/*
+	 * Although the arm_gpio_lock was set in the probe function, check again
+	 * if it is still enabled to be able to write to the ModeX registers.
+	 */
+	spin_lock(&gs->gc.bgpio_lock);
+	ret =3D mlxbf2_gpio_lock_acquire();
+	if (ret < 0) {
+		spin_unlock(&gs->gc.bgpio_lock);
+		return ret;
+	}
+
+	writel(BIT(offset), gs->gpio_io + YU_GPIO_MODE0_CLEAR);
+	writel(BIT(offset), gs->gpio_io + YU_GPIO_MODE1_CLEAR);
+
+	mlxbf2_gpio_lock_release();
+	spin_unlock(&gs->gc.bgpio_lock);
+
+	return ret;
+}
+
+/*
+ * Set output direction:
+ * {mode1,mode0} =3D {0,1}
+ */
+static int mlxbf2_gpio_direction_output(struct gpio_chip *chip,
+					unsigned int offset,
+					int value)
+{
+	struct mlxbf2_gpio_state *gs =3D gpiochip_get_data(chip);
+	int ret =3D 0;
+
+	/*
+	 * Although the arm_gpio_lock was set in the probe function,
+	 * check again it is still enabled to be able to write to the
+	 * ModeX registers.
+	 */
+	spin_lock(&gs->gc.bgpio_lock);
+	ret =3D mlxbf2_gpio_lock_acquire();
+	if (ret < 0) {
+		spin_unlock(&gs->gc.bgpio_lock);
+		return ret;
+	}
+
+	writel(BIT(offset), gs->gpio_io + YU_GPIO_MODE1_CLEAR);
+	writel(BIT(offset), gs->gpio_io + YU_GPIO_MODE0_SET);
+
+	mlxbf2_gpio_lock_release();
+	spin_unlock(&gs->gc.bgpio_lock);
+
+	return ret;
+}
+
+/* BlueField-2 GPIO driver initialization routine. */ static int=20
+mlxbf2_gpio_probe(struct platform_device *pdev) {
+	struct mlxbf2_gpio_state *gs;
+	struct device *dev =3D &pdev->dev;
+	struct gpio_chip *gc;
+	struct resource *res;
+	unsigned int npins;
+	int ret;
+
+	gs =3D devm_kzalloc(dev, sizeof(*gs), GFP_KERNEL);
+	if (!gs)
+		return -ENOMEM;
+
+	/* YU GPIO block address */
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	gs->gpio_io =3D devm_ioremap(dev, res->start, resource_size(res));
+	if (!gs->gpio_io)
+		return -ENOMEM;
+
+	ret =3D mlxbf2_gpio_get_lock_res(pdev);
+	if (ret) {
+		dev_err(dev, "Failed to get yu_arm_gpio_lock resource\n");
+		return ret;
+	}
+
+	if (device_property_read_u32(dev, "npins", &npins))
+		npins =3D MLXBF2_GPIO_MAX_PINS_PER_BLOCK;
+
+	gc =3D &gs->gc;
+
+	ret =3D bgpio_init(gc, dev, 4,
+			gs->gpio_io + YU_GPIO_DATAIN,
+			gs->gpio_io + YU_GPIO_DATASET,
+			gs->gpio_io + YU_GPIO_DATACLEAR,
+			NULL,
+			NULL,
+			0);
+
+	gc->direction_input =3D mlxbf2_gpio_direction_input;
+	gc->direction_output =3D mlxbf2_gpio_direction_output;
+	gc->ngpio =3D npins;
+	gc->owner =3D THIS_MODULE;
+
+	platform_set_drvdata(pdev, gs);
+
+	ret =3D devm_gpiochip_add_data(dev, &gs->gc, gs);
+	if (ret) {
+		dev_err(dev, "Failed adding memory mapped gpiochip\n");
+		return ret;
+	}
+
+	dev_info(dev, "Registered Mellanox BlueField-2 GPIO");
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int mlxbf2_gpio_suspend(struct platform_device *pdev,
+				pm_message_t state)
+{
+	struct mlxbf2_gpio_state *gs =3D platform_get_drvdata(pdev);
+
+	gs->csave_regs->gpio_mode0 =3D readl(gs->gpio_io +
+		YU_GPIO_MODE0);
+	gs->csave_regs->gpio_mode1 =3D readl(gs->gpio_io +
+		YU_GPIO_MODE1);
+
+	return 0;
+}
+
+static int mlxbf2_gpio_resume(struct platform_device *pdev) {
+	struct mlxbf2_gpio_state *gs =3D platform_get_drvdata(pdev);
+
+	writel(gs->csave_regs->gpio_mode0, gs->gpio_io +
+		YU_GPIO_MODE0);
+	writel(gs->csave_regs->gpio_mode1, gs->gpio_io +
+		YU_GPIO_MODE1);
+
+	return 0;
+}
+#endif
+
+static const struct acpi_device_id mlxbf2_gpio_acpi_match[] =3D {
+	{ "MLNXBF22", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, mlxbf2_gpio_acpi_match);
+
+static struct platform_driver mlxbf2_gpio_driver =3D {
+	.driver =3D {
+		.name =3D "mlxbf2_gpio",
+		.acpi_match_table =3D ACPI_PTR(mlxbf2_gpio_acpi_match),
+	},
+	.probe    =3D mlxbf2_gpio_probe,
+#ifdef CONFIG_PM
+	.suspend  =3D mlxbf2_gpio_suspend,
+	.resume   =3D mlxbf2_gpio_resume,
+#endif
+};
+
+module_platform_driver(mlxbf2_gpio_driver);
+
+MODULE_DESCRIPTION("Mellanox BlueField-2 GPIO Driver");=20
+MODULE_AUTHOR("Mellanox Technologies"); MODULE_LICENSE("GPL v2");
--
2.1.2

