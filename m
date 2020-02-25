Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1A2C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D6912082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbgBYQdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:33:07 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:35781 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730628AbgBYQdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:33:06 -0500
Received: from Internal Mail-Server by MTLPINE2 (envelope-from asmaa@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 25 Feb 2020 18:33:01 +0200
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id 01PGX0ea000928;
        Tue, 25 Feb 2020 11:33:00 -0500
Received: (from asmaa@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id 01PGX0kR019087;
        Tue, 25 Feb 2020 11:33:00 -0500
From:   Asmaa Mnebhi <Asmaa@mellanox.com>
To:     bgolaszewski@baylibre.com, linus.walleij@linaro.org
Cc:     Asmaa Mnebhi <Asmaa@mellanox.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] gpio: add driver for Mellanox BlueField 2 GPIO controller
Date:   Tue, 25 Feb 2020 11:32:53 -0500
Message-Id: <7ef84476a00e8771cf1edf5745c378273b760f5d.1582647809.git.Asmaa@mellanox.com>
X-Mailer: git-send-email 2.1.2
In-Reply-To: <cover.1582647809.git.Asmaa@mellanox.com>
References: <cover.1582647809.git.Asmaa@mellanox.com>
In-Reply-To: <cover.1582647809.git.Asmaa@mellanox.com>
References: <cover.1582647809.git.Asmaa@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the GPIO controller used by
Mellanox BlueField 2 SOCs.

Signed-off-by: Asmaa Mnebhi <Asmaa@mellanox.com>
---
 drivers/gpio/Kconfig       |   7 +
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-mlxbf2.c | 345 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 353 insertions(+)
 create mode 100644 drivers/gpio/gpio-mlxbf2.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b8013cf..6234ccc 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1399,6 +1399,13 @@ config GPIO_MLXBF
 	help
 	  Say Y here if you want GPIO support on Mellanox BlueField SoC.
 
+config GPIO_MLXBF2
+	tristate "Mellanox BlueField 2 SoC GPIO"
+	depends on (MELLANOX_PLATFORM && ARM64 && ACPI) || (64BIT && COMPILE_TEST)
+	select GPIO_GENERIC
+	help
+	  Say Y here if you want GPIO support on Mellanox BlueField 2 SoC.
+
 config GPIO_ML_IOH
 	tristate "OKI SEMICONDUCTOR ML7213 IOH GPIO support"
 	depends on X86 || COMPILE_TEST
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 0b57126..b2cfc21 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -93,6 +93,7 @@ obj-$(CONFIG_GPIO_MENZ127)		+= gpio-menz127.o
 obj-$(CONFIG_GPIO_MERRIFIELD)		+= gpio-merrifield.o
 obj-$(CONFIG_GPIO_ML_IOH)		+= gpio-ml-ioh.o
 obj-$(CONFIG_GPIO_MLXBF)		+= gpio-mlxbf.o
+obj-$(CONFIG_GPIO_MLXBF2)		+= gpio-mlxbf2.o
 obj-$(CONFIG_GPIO_MM_LANTIQ)		+= gpio-mm-lantiq.o
 obj-$(CONFIG_GPIO_MOCKUP)		+= gpio-mockup.o
 obj-$(CONFIG_GPIO_MOXTET)		+= gpio-moxtet.o
diff --git a/drivers/gpio/gpio-mlxbf2.c b/drivers/gpio/gpio-mlxbf2.c
new file mode 100644
index 0000000..0d35d4e
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
+ * The lock is enabled only if 0xd42f is written to this field
+ */
+#define YU_ARM_GPIO_LOCK_ADDR		0x2801088
+#define YU_ARM_GPIO_LOCK_SIZE		0x8
+#define YU_LOCK_ACTIVE_BIT(val)		(val >> 31)
+#define YU_ARM_GPIO_LOCK_ACQUIRE	0xd42f
+#define YU_ARM_GPIO_LOCK_RELEASE	0x0
+
+/*
+ * gpio[x] block registers and their offset
+ */
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
+/* BlueField-2 gpio block state structure. */
+struct mlxbf2_gpio_state {
+	struct gpio_chip gc;
+
+	/* YU GPIO blocks address */
+	void __iomem *gpio_io;
+
+#ifdef CONFIG_PM
+	struct mlxbf2_gpio_context_save_regs *csave_regs;
+#endif
+};
+
+/* BlueField-2 gpio shared structure. */
+struct mlxbf2_gpio_param {
+	void __iomem *io;
+	struct resource *res;
+	struct mutex *lock;
+};
+
+static struct resource yu_arm_gpio_lock_res = {
+	.start = YU_ARM_GPIO_LOCK_ADDR,
+	.end   = YU_ARM_GPIO_LOCK_ADDR + YU_ARM_GPIO_LOCK_SIZE - 1,
+	.name  = "YU_ARM_GPIO_LOCK",
+};
+
+static DEFINE_MUTEX(yu_arm_gpio_lock_mutex);
+
+static struct mlxbf2_gpio_param yu_arm_gpio_lock_param = {
+	.res = &yu_arm_gpio_lock_res,
+	.lock = &yu_arm_gpio_lock_mutex,
+};
+
+/* Request memory region and map yu_arm_gpio_lock resource */
+static int mlxbf2_gpio_get_lock_res(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	resource_size_t size;
+	int ret = 0;
+
+	mutex_lock(yu_arm_gpio_lock_param.lock);
+
+	/* Check if the memory map already exists */
+	if (yu_arm_gpio_lock_param.io)
+		goto exit;
+
+	res = yu_arm_gpio_lock_param.res;
+	size = resource_size(res);
+
+	if (!devm_request_mem_region(dev, res->start, size, res->name)) {
+		ret = -EFAULT;
+		goto exit;
+	}
+
+	yu_arm_gpio_lock_param.io = devm_ioremap_nocache(dev, res->start, size);
+	if (IS_ERR(yu_arm_gpio_lock_param.io))
+		ret = PTR_ERR(yu_arm_gpio_lock_param.io);
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
+static int mlxbf2_gpio_lock_acquire(void)
+{
+	u32 arm_gpio_lock_val;
+
+	mutex_lock(yu_arm_gpio_lock_param.lock);
+
+	arm_gpio_lock_val = readl(yu_arm_gpio_lock_param.io);
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
+static void mlxbf2_gpio_lock_release(void)
+{
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
+ * {mode1,mode0}:{Reg_DataOut=0,Reg_DataOut=1}->{DataOut=0,DataOut=1}
+ *
+ * {0,0}:Reg_DataOut{0,1}->{Z,Z} Input PAD
+ * {0,1}:Reg_DataOut{0,1}->{0,1} Full drive Output PAD
+ * {1,0}:Reg_DataOut{0,1}->{0,Z} 0-set PAD to low, 1-float
+ * {1,1}:Reg_DataOut{0,1}->{Z,1} 0-float, 1-set PAD to high
+ */
+
+/*
+ * Set input direction:
+ * {mode1,mode0} = {0,0}
+ */
+static int mlxbf2_gpio_direction_input(struct gpio_chip *chip,
+				       unsigned int offset)
+{
+	struct mlxbf2_gpio_state *gs = gpiochip_get_data(chip);
+	int ret;
+
+	/*
+	 * Although the arm_gpio_lock was set in the probe function, check again
+	 * if it is still enabled to be able to write to the ModeX registers.
+	 */
+	spin_lock(&gs->gc.bgpio_lock);
+	ret = mlxbf2_gpio_lock_acquire();
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
+ * {mode1,mode0} = {0,1}
+ */
+static int mlxbf2_gpio_direction_output(struct gpio_chip *chip,
+					unsigned int offset,
+					int value)
+{
+	struct mlxbf2_gpio_state *gs = gpiochip_get_data(chip);
+	int ret = 0;
+
+	/*
+	 * Although the arm_gpio_lock was set in the probe function,
+	 * check again it is still enabled to be able to write to the
+	 * ModeX registers.
+	 */
+	spin_lock(&gs->gc.bgpio_lock);
+	ret = mlxbf2_gpio_lock_acquire();
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
+/* BlueField-2 GPIO driver initialization routine. */
+static int
+mlxbf2_gpio_probe(struct platform_device *pdev)
+{
+	struct mlxbf2_gpio_state *gs;
+	struct device *dev = &pdev->dev;
+	struct gpio_chip *gc;
+	struct resource *res;
+	unsigned int npins;
+	int ret;
+
+	gs = devm_kzalloc(dev, sizeof(*gs), GFP_KERNEL);
+	if (!gs)
+		return -ENOMEM;
+
+	/* YU GPIO block address */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	gs->gpio_io = devm_ioremap(dev, res->start, resource_size(res));
+	if (!gs->gpio_io)
+		return -ENOMEM;
+
+	ret = mlxbf2_gpio_get_lock_res(pdev);
+	if (ret) {
+		dev_err(dev, "Failed to get yu_arm_gpio_lock resource\n");
+		return ret;
+	}
+
+	if (device_property_read_u32(dev, "npins", &npins))
+		npins = MLXBF2_GPIO_MAX_PINS_PER_BLOCK;
+
+	gc = &gs->gc;
+
+	ret = bgpio_init(gc, dev, 4,
+			gs->gpio_io + YU_GPIO_DATAIN,
+			gs->gpio_io + YU_GPIO_DATASET,
+			gs->gpio_io + YU_GPIO_DATACLEAR,
+			NULL,
+			NULL,
+			0);
+
+	gc->direction_input = mlxbf2_gpio_direction_input;
+	gc->direction_output = mlxbf2_gpio_direction_output;
+	gc->ngpio = npins;
+	gc->owner = THIS_MODULE;
+
+	platform_set_drvdata(pdev, gs);
+
+	ret = devm_gpiochip_add_data(dev, &gs->gc, gs);
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
+	struct mlxbf2_gpio_state *gs = platform_get_drvdata(pdev);
+
+	gs->csave_regs->gpio_mode0 = readl(gs->gpio_io +
+		YU_GPIO_MODE0);
+	gs->csave_regs->gpio_mode1 = readl(gs->gpio_io +
+		YU_GPIO_MODE1);
+
+	return 0;
+}
+
+static int mlxbf2_gpio_resume(struct platform_device *pdev)
+{
+	struct mlxbf2_gpio_state *gs = platform_get_drvdata(pdev);
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
+static const struct acpi_device_id mlxbf2_gpio_acpi_match[] = {
+	{ "MLNXBF22", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, mlxbf2_gpio_acpi_match);
+
+static struct platform_driver mlxbf2_gpio_driver = {
+	.driver = {
+		.name = "mlxbf2_gpio",
+		.acpi_match_table = ACPI_PTR(mlxbf2_gpio_acpi_match),
+	},
+	.probe    = mlxbf2_gpio_probe,
+#ifdef CONFIG_PM
+	.suspend  = mlxbf2_gpio_suspend,
+	.resume   = mlxbf2_gpio_resume,
+#endif
+};
+
+module_platform_driver(mlxbf2_gpio_driver);
+
+MODULE_DESCRIPTION("Mellanox BlueField-2 GPIO Driver");
+MODULE_AUTHOR("Mellanox Technologies");
+MODULE_LICENSE("GPL v2");
-- 
2.1.2

