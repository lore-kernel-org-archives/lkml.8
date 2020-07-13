Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41168C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 04:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C652068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 04:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgGMEk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 00:40:26 -0400
Received: from mga03.intel.com ([134.134.136.65]:58630 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgGMEk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 00:40:26 -0400
IronPort-SDR: gU8c2iWCykjYW55gwiiKtzVM3gGZLSS8/P56MCZOJuz1hdkKlQnPTft/TWDYlUjIgSy8thCwfr
 wDSIXUHXOpFg==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="148552308"
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="148552308"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 21:40:09 -0700
IronPort-SDR: R4Jae92qMhUa3MsP2Bevg7NN4Ba4aYcw1T0jTc8xregkjWCO1Z/vl8nfLEKfA2i/6OlYUOp++5
 SAXd1GIv8fIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="scan'208";a="324130507"
Received: from yilunxu-optiplex-7050.sh.intel.com ([10.239.159.141])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jul 2020 21:40:06 -0700
From:   Xu Yilun <yilun.xu@intel.com>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Cc:     trix@redhat.com, yilun.xu@intel.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, Wu Hao <hao.wu@intel.com>
Subject: [PATCH 1/2] mfd: intel-m10-bmc: add Max10 BMC chip support for Intel FPGA PAC
Date:   Mon, 13 Jul 2020 12:34:55 +0800
Message-Id: <1594614896-16606-2-git-send-email-yilun.xu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594614896-16606-1-git-send-email-yilun.xu@intel.com>
References: <1594614896-16606-1-git-send-email-yilun.xu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements the basic functions of the BMC chip for some Intel
FPGA PCIe Acceleration Cards (PAC). The BMC is implemented using the
intel max10 CPLD.

This BMC chip is connected to FPGA by a SPI bus. To provide reliable
register access from FPGA, an Avalon Memory-Mapped (Avmm) transaction
protocol over the SPI bus is used between host and slave.

This driver implements the basic register access with the regmap framework.
The mfd cells array is empty now as a placeholder.

Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Tom Rix <trix@redhat.com>
---
 .../ABI/testing/sysfs-driver-intel-m10-bmc         |  15 +
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   3 +
 drivers/mfd/intel-m10-bmc-main.c                   | 176 ++++
 drivers/mfd/intel-spi-avmm.c                       | 904 +++++++++++++++++++++
 drivers/mfd/intel-spi-avmm.h                       |  35 +
 include/linux/mfd/intel-m10-bmc.h                  |  57 ++
 7 files changed, 1203 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
 create mode 100644 drivers/mfd/intel-m10-bmc-main.c
 create mode 100644 drivers/mfd/intel-spi-avmm.c
 create mode 100644 drivers/mfd/intel-spi-avmm.h
 create mode 100644 include/linux/mfd/intel-m10-bmc.h

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
new file mode 100644
index 0000000..54cf5bc
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
@@ -0,0 +1,15 @@
+What:		/sys/bus/spi/devices/.../bmc_version
+Date:		June 2020
+KernelVersion:	5.9
+Contact:	Xu Yilun <yilun.xu@intel.com>
+Description:	Read only. Returns the hardware build version of Intel
+		MAX10 BMC chip.
+		Format: "0x%x".
+
+What:		/sys/bus/spi/devices/.../bmcfw_version
+Date:		June 2020
+KernelVersion:	5.9
+Contact:	Xu Yilun <yilun.xu@intel.com>
+Description:	Read only. Returns the firmware version of Intel MAX10
+		BMC chip.
+		Format: "0x%x".
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index d13bb0a..9c478d7 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2130,5 +2130,18 @@ config SGI_MFD_IOC3
 	  If you have an SGI Origin, Octane, or a PCI IOC3 card,
 	  then say Y. Otherwise say N.
 
+config MFD_INTEL_M10_BMC
+	tristate "Intel MAX10 board management controller"
+	depends on SPI_MASTER
+	select REGMAP
+	select MFD_CORE
+	help
+	  Support for the Intel MAX10 board management controller using the
+	  SPI interface.
+
+	  This driver provides common support for accessing the device,
+	  additional drivers must be enabled in order to use the functionality
+	  of the device.
+
 endmenu
 endif
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 1c8d6be..fb15cde 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -265,3 +265,6 @@ obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
 obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
 
 obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
+
+intel-m10-bmc-objs                := intel-m10-bmc-main.o intel-spi-avmm.o
+obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
diff --git a/drivers/mfd/intel-m10-bmc-main.c b/drivers/mfd/intel-m10-bmc-main.c
new file mode 100644
index 0000000..7fdf1f3
--- /dev/null
+++ b/drivers/mfd/intel-m10-bmc-main.c
@@ -0,0 +1,176 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Intel Max10 Board Management Controller chip Driver
+ *
+ * Copyright (C) 2018-2020 Intel Corporation. All rights reserved.
+ *
+ */
+#include <linux/bitfield.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/module.h>
+#include <linux/mfd/core.h>
+#include <linux/init.h>
+#include <linux/spi/spi.h>
+#include <linux/mfd/intel-m10-bmc.h>
+
+#include "intel-spi-avmm.h"
+
+enum m10bmc_type {
+	M10_N3000,
+};
+
+static struct mfd_cell m10bmc_pacn3000_subdevs[] = {};
+
+static struct regmap_config intel_m10bmc_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = M10BMC_MEM_END,
+};
+
+static ssize_t bmc_version_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct intel_m10bmc *m10bmc = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	ret = m10bmc_sys_read(m10bmc, M10BMC_BUILD_VER, &val);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "0x%x\n", val);
+}
+static DEVICE_ATTR_RO(bmc_version);
+
+static ssize_t bmcfw_version_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
+	unsigned int val;
+	int ret;
+
+	ret = m10bmc_sys_read(max10, NIOS2_FW_VERSION, &val);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "0x%x\n", val);
+}
+static DEVICE_ATTR_RO(bmcfw_version);
+
+static struct attribute *m10bmc_attrs[] = {
+	&dev_attr_bmc_version.attr,
+	&dev_attr_bmcfw_version.attr,
+	NULL,
+};
+
+static struct attribute_group m10bmc_attr_group = {
+	.attrs = m10bmc_attrs,
+};
+
+static const struct attribute_group *m10bmc_dev_groups[] = {
+	&m10bmc_attr_group,
+	NULL
+};
+
+static int check_m10bmc_version(struct intel_m10bmc *m10bmc)
+{
+	unsigned int v;
+
+	if (m10bmc_raw_read(m10bmc, M10BMC_LEGACY_SYS_BASE + M10BMC_BUILD_VER,
+			    &v))
+		return -ENODEV;
+
+	if (v != 0xffffffff) {
+		dev_err(m10bmc->dev, "bad version M10BMC detected\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int m10bmc_spi_setup(struct spi_device *spi)
+{
+	/* try 32 bits bpw first then fall back to 8 bits bpw */
+	spi->mode = SPI_MODE_1;
+	spi->bits_per_word = 32;
+	if (!spi_setup(spi))
+		return 0;
+
+	spi->bits_per_word = 8;
+	return spi_setup(spi);
+}
+
+static int intel_m10_bmc_spi_probe(struct spi_device *spi)
+{
+	const struct spi_device_id *id = spi_get_device_id(spi);
+	struct device *dev = &spi->dev;
+	struct mfd_cell *cells;
+	struct intel_m10bmc *m10bmc;
+	int ret, n_cell;
+
+	ret = m10bmc_spi_setup(spi);
+	if (ret)
+		return ret;
+
+	m10bmc = devm_kzalloc(dev, sizeof(*m10bmc), GFP_KERNEL);
+	if (!m10bmc)
+		return -ENOMEM;
+
+	m10bmc->dev = dev;
+
+	m10bmc->regmap =
+		devm_regmap_init_spi_avmm(spi, &intel_m10bmc_regmap_config);
+	if (IS_ERR(m10bmc->regmap)) {
+		ret = PTR_ERR(m10bmc->regmap);
+		dev_err(dev, "Failed to allocate regmap: %d\n", ret);
+		return ret;
+	}
+
+	spi_set_drvdata(spi, m10bmc);
+
+	ret = check_m10bmc_version(m10bmc);
+	if (ret) {
+		dev_err(dev, "Failed to identify m10bmc hardware\n");
+		return ret;
+	}
+
+	switch (id->driver_data) {
+	case M10_N3000:
+		cells = m10bmc_pacn3000_subdevs;
+		n_cell = ARRAY_SIZE(m10bmc_pacn3000_subdevs);
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cells, n_cell,
+				   NULL, 0, NULL);
+	if (ret)
+		dev_err(dev, "Failed to register sub-devices: %d\n", ret);
+
+	return ret;
+}
+
+static const struct spi_device_id m10bmc_spi_id[] = {
+	{ "m10-n3000", M10_N3000 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);
+
+static struct spi_driver intel_m10bmc_spi_driver = {
+	.driver = {
+		.name = "intel-m10-bmc",
+		.dev_groups = m10bmc_dev_groups,
+	},
+	.probe = intel_m10_bmc_spi_probe,
+	.id_table = m10bmc_spi_id,
+};
+
+module_spi_driver(intel_m10bmc_spi_driver);
+
+MODULE_DESCRIPTION("Intel Max10 BMC Device Driver");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("spi:intel-m10-bmc");
diff --git a/drivers/mfd/intel-spi-avmm.c b/drivers/mfd/intel-spi-avmm.c
new file mode 100644
index 0000000..2604657
--- /dev/null
+++ b/drivers/mfd/intel-spi-avmm.c
@@ -0,0 +1,904 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Intel SPI Slave to AVMM Bus Bridge
+ *
+ * Copyright (C) 2018-2020 Intel Corporation. All rights reserved.
+ *
+ */
+
+#include "intel-spi-avmm.h"
+
+/*
+ * This driver implements the read/write protocol for a generic SPI master to
+ * communicate with the "SPI slave to Avalon Master Bridge" (spi-avmm) IP.
+ *
+ * The spi-avmm IP act as a bridge to convert encoded streams of bytes from
+ * the host to the internal mmio read/write on Avalon bus. In order to issue
+ * register access requests to the slave chip, the host should send formatted
+ * bytes that conform to the transfer protocol.
+ * The transfer protocol contains 3 layers: transaction layer, packet layer
+ * and physical layer.
+ *
+ * Reference Documents could be found at:
+ * https://www.intel.com/content/www/us/en/programmable/documentation/
+ * sfo1400787952932.html
+ *
+ * Chapter "SPI Slave/JTAG to Avalon Master Bridge Cores" is a general
+ * introduction to the protocol.
+ *
+ * Chapter "Avalon Packets to Transactions Converter Core" describes
+ * the transaction layer.
+ *
+ * Chapter "Avalon-ST Bytes to Packets and Packets to Bytes Converter Cores"
+ * describes the packet layer.
+ *
+ * Chapter "Avalon-ST Serial Peripheral Interface Core" describes the
+ * physical layer.
+ *
+ * The main function of the physical layer is the use of PHY_IDLE (4a). Host
+ * issues SCLK to query data from slave, but if slave is not ready to submit
+ * data yet, it will repeat PHY_IDLE until data is prepared.
+ * Because of this special char, it also needs an ESCAPE char (4d), to help
+ * represent data "4a". The escape rule is "4d first, following 4a ^ 20".
+ * So "4d, 6a" for data "4a", and "4d, 6d" for data "4d".
+ *
+ * The packet layer defines the boundary of a whole packet. It defines the
+ * Start Of Packet (SOP, 7a) char and End Of Packet (EOP, 7b) char. Please
+ * note that the non-special byte after EOP is the last byte of the packet.
+ * The packet layer also defines a Channel char (7c) + Channel number for
+ * multiple channel transfer. This not currently supported by this driver. So
+ * host will always send "7c, 00" when needed, and will drop the packet if
+ * "7c, non-zero" is received.
+ * Finally, a packet layer ESCAPE char (7d) is also needed to represent a
+ * data value that is the same as the special chars. The escape rule is the
+ * same. The escape rule should be used if the last byte requires it. So if a
+ * packet ends up with data 7a, the last bytes should be "7b, 7d, 5a".
+ *
+ * The transaction layer defines several transaction formats, including host
+ * write/incrementing write request, slave write response, host
+ * read/incrementing read request.
+ *
+ * +------+------------------+------------------------------+
+ * | Byte |       Field      | Description                  |
+ * +------+------------------+------------------------------+
+ * |             Host transaction format                    |
+ * +------+------------------+------------------------------+
+ * |  0   | Transaction code | 0x0, Write non-incrementing  |
+ * |      |                  | 0x4, Write incrementing      |
+ * |      |                  | 0x10, Read non-incrementing  |
+ * |      |                  | 0x14, Read incrementing      |
+ * +------+------------------+------------------------------+
+ * |  1   | Reserved         |                              |
+ * +------+------------------+------------------------------+
+ * | 3:2  | Size             | Big endian                   |
+ * +------+------------------+------------------------------+
+ * | 7:4  | Address          | Big endian                   |
+ * +------+------------------+------------------------------+
+ * | n:8  | Data             | For Write only, Little endian|
+ * +------+------------------+------------------------------+
+ * |       Slave write complete response format             |
+ * +------+------------------+------------------------------+
+ * |  0   | Response code    | Transaction code ^ 0x80      |
+ * +------+------------------+------------------------------+
+ * |  1   | Reserved         |                              |
+ * +------+------------------+------------------------------+
+ * | 3:2  | Size             | Big endian                   |
+ * +------+------------------+------------------------------+
+ *
+ * For a slave read response, there is no transaction header, simply returns
+ * the read out data.
+ *
+ *
+ * Here is a simple case to illustrate the protocol. The host requests
+ * a write32 to addr 0x024b7a40. The following diagram shows how the slave
+ * parses the incoming byte streams from MOSI layer by layer.
+ *
+ *
+ * LSB                Physical layer                            MSB
+ *
+ * |4a|7a|7c|4a|00|00|00|4a|00|04|02|4b|7d|5a|40|4d|6a|ff|03|7b|5f|
+ *  |        |           |                       |  |
+ *  +--------+-----------+                   Escape |
+ *           |                                   +--+
+ *      IDLE, Dropped                               |
+ *                                           Escape dropped,
+ *                                        Next byte XORed with 0x20
+ *                                                  |
+ *                                                  |
+ *                    Packet layer                  |
+ *                                                  |
+ *             |7a|7c|00|00|00|00|04|02|4b|7d|5a|40|4a|ff|03|7b|5f|
+ *              |  |  |                    |  |              |  |
+ *            SOP  +--+                Escape |            EOP  |
+ *                  |                      +--+                 |
+ *                 Channel 0                  |            Last valid byte
+ *                                     Escape dropped,
+ *                              Next byte XORed with 0x20
+ *                                            |
+ *                                            |
+ *                    Transaction layer       |
+ *                                            |
+ *                         |00|00|00|04|02|4b|7a|40|4a|ff|03|5f|
+ *                          |     |  |  |  |  |  |  |  |  |  |
+ *                       Write    +--+  +--+--+--+  +--+--+--+
+ *                          |       |       |           |
+ *                          |   size=4Byte  |           |
+ *                          |       |       |           |
+ *                          +-------+       |           |
+ *                            |             |           |
+ *                         Command      Addr(BE):     Data(LE):
+ *                                     0x024b7a40    0x5f03ff4a
+ *
+ *
+ * This is how host and slave interact for the single write32, only transaction
+ * layer and PHY_IDLE chars are shown for simplicity:
+ *
+ * MOSI  |00|00|00|04|02|4b|3a|40|4a|ff|03|5f|XX|XX|...|XX|XX|XX|XX|XX|
+ * MISO  |4a|4a|4a|4a|4a|4a|4a|4a|4a|4a|4a|4a|4a|4a|...|4a|80|00|00|04|
+ *                                                         |        |
+ *                                      Write done, 0x00 ^ 0x80     |
+ *                                                               4bytes written
+ *
+ * This is another case, a single read32 of addr 0x024b3a40, slave returns
+ * 0x12345678.
+ *
+ * MOSI  |10|00|00|04|02|4b|3a|40|XX|XX|...............|XX|XX|XX|XX|XX|
+ * MISO  |4a|4a|4a|4a|4a|4a|4a|4a|4a|4a|...............|4a|78|56|34|12|
+ *                                                         |  |  |  |
+ *                                                         +--+--+--+
+ *                                                            |
+ *                                                       just return data
+ */
+
+#define PKT_SOP			0x7a
+#define PKT_EOP			0x7b
+#define PKT_CHANNEL		0x7c
+#define PKT_ESC			0x7d
+
+#define PHY_IDLE		0x4a
+#define PHY_ESC			0x4d
+
+#define RX_NOT_READY_32		(PHY_IDLE << 24 | PHY_IDLE << 16 |	\
+				 PHY_IDLE << 8 | PHY_IDLE)
+#define RX_NOT_READY_8		PHY_IDLE
+
+#define TRANS_CODE_WRITE	0x0
+#define TRANS_CODE_SEQ_WRITE	0x4
+#define TRANS_CODE_READ		0x10
+#define TRANS_CODE_SEQ_READ	0x14
+#define TRANS_CODE_NO_TRANS	0x7f
+
+#define SPI_AVMM_XFER_TIMEOUT	(msecs_to_jiffies(200))
+
+/* slave's register addr is 32 bits */
+#define REG_SIZE		4UL
+/* slave's register value is 32 bits */
+#define VAL_SIZE		4UL
+
+/*
+ * max rx size could be larger. But considering the buffer consuming,
+ * it is proper that we limit 1KB xfer at max.
+ */
+#define MAX_RX_CNT		256UL
+#define MAX_TX_CNT		1UL
+
+struct trans_header {
+	u8 trans_code;
+	u8 rsvd;
+	__be16 size;
+	__be32 addr;
+};
+
+struct trans_response {
+	u8 r_trans_code;
+	u8 rsvd;
+	__be16 size;
+};
+
+#define TRANS_HEAD_SIZE		(sizeof(struct trans_header))
+#define TRANS_RESP_SIZE		(sizeof(struct trans_response))
+
+#define WR_TRANS_TX_SIZE(n)	(TRANS_HEAD_SIZE + VAL_SIZE * (n))
+#define RD_TRANS_TX_SIZE	TRANS_HEAD_SIZE
+
+#define TRANS_TX_MAX		WR_TRANS_TX_SIZE(MAX_TX_CNT)
+/*
+ * In the worst case, all chars are escaped, plus 4 special chars (SOP,
+ * CHANNEL, CHANNEL_NUM, EOP). Finally make sure the length is aligned to SPI
+ * BPW.
+ */
+#define PHY_TX_MAX		ALIGN(2 * TRANS_TX_MAX + 4, 4)
+
+/* No additional chars are in transaction layer RX, just read out data */
+#define TRANS_RX_MAX		(VAL_SIZE * MAX_RX_CNT)
+/*
+ * Unlike tx, phy rx is affected by possible PHY_IDLE bytes from slave,
+ * the driver will read the words one by one and filter out pure IDLE words.
+ * The rest of words may still contain IDLE chars. A worse case could be
+ * receiving word 0x7a7a7a7a in 4 BPW transfer mode. The 4 bytes word may
+ * consume up to 12 bytes in rx buffer, like:
+ * |4a|4a|4a|7d| |5a|7d|5a|7d| |5a|7d|5a|4a|
+ * Besides, the packet layer header may consume up to 8 bytes, like:
+ * |4a|4a|4a|7a| |7c|00|4a|4a|
+ * So the PHY_RX_MAX is calculated as following.
+ */
+#define PHY_RX_MAX		(TRANS_RX_MAX * 3 + 8)
+
+#define TRANS_BUF_SIZE		((TRANS_TX_MAX > TRANS_RX_MAX) ?	\
+				 TRANS_TX_MAX : TRANS_RX_MAX)
+#define PHY_BUF_SIZE		((PHY_TX_MAX > PHY_RX_MAX) ?	\
+				 PHY_TX_MAX : PHY_RX_MAX)
+
+/**
+ * struct spi_avmm_bridge - SPI slave to AVMM bus master bridge
+ *
+ * @spi: spi slave associated with this bridge.
+ * @word_len: bytes of word for spi transfer.
+ * @phy_len: length of valid data in phy_buf.
+ * @trans_buf: the bridge buffer for transaction layer data.
+ * @phy_buf: the bridge buffer for physical layer data.
+ * @br_swap_words: the word swapping cb for phy data. NULL if not needed.
+ * @is_word_not_ready: the cb to test if there is valid data in a rx word.
+ *
+ * As a device's registers are implemented on the AVMM bus address space, it
+ * requires the driver to issue formatted requests to spi slave to AVMM bus
+ * master bridge to perform register access.
+ */
+struct spi_avmm_bridge {
+	struct spi_device *spi;
+	unsigned char word_len;
+	unsigned int phy_len;
+	/* bridge buffer used in translation between protocol layers */
+	char trans_buf[TRANS_BUF_SIZE];
+	char phy_buf[PHY_BUF_SIZE];
+	void (*br_swap_words)(char *buf, unsigned int len);
+	bool (*is_word_not_ready)(const char *buf);
+};
+
+/*
+ * Transaction Layer
+ *
+ * The transaction layer capsules transaction code (read/write),
+ * size (16 bits), addr (32 bits) and value (32 bits) into a transaction
+ * format. SEQ_READ/WRITE will read/write the number of bytes (specified by
+ * head->size) on incrementing addr start from header->addr field.
+ * The transaction header will be followed by register data for write
+ * operations.
+ *
+ * Please note that size and addr are sent in big endian but value is sent in
+ * little endian according to transaction layer protocol.
+ */
+
+/* Format a transaction layer byte stream for tx_buf */
+static void trans_tx_prepare(bool is_read, u32 reg, u16 count, u32 *wr_val,
+			     char *tx_buf, unsigned int *tx_len)
+{
+	struct trans_header *header;
+	u8 trans_code;
+	__le32 *data;
+	int i;
+
+	trans_code = is_read ?
+			(count == 1 ? TRANS_CODE_READ : TRANS_CODE_SEQ_READ) :
+			(count == 1 ? TRANS_CODE_WRITE : TRANS_CODE_SEQ_WRITE);
+
+	header = (struct trans_header *)tx_buf;
+	header->trans_code = trans_code;
+	header->rsvd = 0;
+	header->size = cpu_to_be16(count * VAL_SIZE);
+	header->addr = cpu_to_be32(reg);
+
+	if (is_read) {
+		*tx_len = RD_TRANS_TX_SIZE;
+	} else {
+		data = (__le32 *)(tx_buf + TRANS_HEAD_SIZE);
+
+		for (i = 0; i < count; i++)
+			*data++ = cpu_to_le32(*wr_val++);
+
+		*tx_len = WR_TRANS_TX_SIZE(count);
+	}
+}
+
+/*
+ * For read transactions, the avmm bus will directly return register values
+ * without transaction response header.
+ */
+static int rd_trans_rx_parse(char *rx_buf, unsigned int rx_len, u32 *val)
+{
+	unsigned int count, i;
+	__le32 *data;
+
+	if (!rx_len || !IS_ALIGNED(rx_len, VAL_SIZE))
+		return -EINVAL;
+
+	count = rx_len / VAL_SIZE;
+
+	data = (__le32 *)rx_buf;
+	for (i = 0; i < count; i++)
+		*val++ = le32_to_cpu(*data++);
+
+	return 0;
+}
+
+/*
+ * For write transactions, the slave will return a transaction response
+ * header.
+ */
+static int wr_trans_rx_parse(char *rx_buf, unsigned int rx_len,
+			     u16 expected_len)
+{
+	struct trans_response *resp;
+	u8 trans_code;
+	u16 val_len;
+
+	if (rx_len != TRANS_RESP_SIZE)
+		return -EINVAL;
+
+	resp = (struct trans_response *)rx_buf;
+
+	trans_code = resp->r_trans_code ^ 0x80;
+	val_len = be16_to_cpu(resp->size);
+	if (!val_len || !IS_ALIGNED(val_len, VAL_SIZE) ||
+	    val_len != expected_len)
+		return -EINVAL;
+
+	/* error out if the trans code doesn't align with what the host sent */
+	if ((val_len == VAL_SIZE && trans_code != TRANS_CODE_WRITE) ||
+	    (val_len > VAL_SIZE && trans_code != TRANS_CODE_SEQ_WRITE))
+		return -EFAULT;
+
+	return 0;
+}
+
+/*
+ * The input is a transaction layer byte stream in rx_buf, the output is read
+ * out data.
+ */
+static int trans_rx_parse(bool is_read, char *rx_buf, unsigned int rx_len,
+			  u16 expected_count, u32 *rd_val)
+{
+	unsigned int expected_len = expected_count * VAL_SIZE;
+
+	if (is_read) {
+		if (expected_len != rx_len)
+			return -EINVAL;
+
+		return rd_trans_rx_parse(rx_buf, rx_len, rd_val);
+	}
+
+	return wr_trans_rx_parse(rx_buf, rx_len, expected_len);
+}
+
+/* Packet Layer & Physical Layer */
+/* The input is a trans stream in trans_buf, format a phy stream in phy_buf. */
+static void pkt_phy_tx_prepare(char *trans_buf, unsigned int trans_len,
+			       char *phy_buf, unsigned int *phy_len)
+{
+	unsigned int i;
+	char *b, *p;
+
+	b = trans_buf;
+	p = phy_buf;
+
+	*p++ = PKT_SOP;
+
+	/*
+	 * The driver doesn't support multiple channels so the channel number
+	 * is always 0.
+	 */
+	*p++ = PKT_CHANNEL;
+	*p++ = 0x0;
+
+	for (i = 0; i < trans_len; i++) {
+		/* EOP should be inserted before the last valid char */
+		if (i == trans_len - 1)
+			*p++ = PKT_EOP;
+
+		/*
+		 * insert an ESCAPE char if the data value equals any special
+		 * char.
+		 */
+		switch (*b) {
+		case PKT_SOP:
+		case PKT_EOP:
+		case PKT_CHANNEL:
+		case PKT_ESC:
+			*p++ = PKT_ESC;
+			*p++ = *b++ ^ 0x20;
+			break;
+		case PHY_IDLE:
+		case PHY_ESC:
+			*p++ = PHY_ESC;
+			*p++ = *b++ ^ 0x20;
+			break;
+		default:
+			*p++ = *b++;
+			break;
+		}
+	}
+
+	*phy_len = p - phy_buf;
+}
+
+/*
+ * The input is a phy stream in pkt_buf, parse out a trans stream in
+ * trans_buf.
+ */
+static int pkt_phy_rx_parse(struct device *dev,
+			    char *phy_buf, unsigned int phy_len,
+			    char *trans_buf, unsigned int *trans_len)
+{
+	char *b, *p;
+
+	b = phy_buf;
+	p = trans_buf;
+
+	/* Find the SOP */
+	while (b < phy_buf + phy_len && *b != PKT_SOP)
+		b++;
+
+	if (b >= phy_buf + phy_len) {
+		dev_err(dev, "%s no SOP\n", __func__);
+		return -EINVAL;
+	}
+
+	b++;
+
+	while (b < phy_buf + phy_len) {
+		switch (*b) {
+		case PHY_IDLE:
+			b++;
+			break;
+		case PKT_CHANNEL:
+			/*
+			 * We don't support multiple channels, so error out if
+			 * a non-zero channel number is found.
+			 */
+			b++;
+			if (*b != 0x0)
+				return -EINVAL;
+			b++;
+			break;
+		case PHY_ESC:
+		case PKT_ESC:
+			b++;
+			*p++ = *b++ ^ 0x20;
+			break;
+		case PKT_SOP:
+			dev_err(dev, "%s 2nd SOP\n", __func__);
+			return -EINVAL;
+		case PKT_EOP:
+			/* the char after EOP is the last valid char */
+			b++;
+
+			switch (*b) {
+			case PHY_ESC:
+			case PKT_ESC:
+			/* the last char may also be escaped */
+				b++;
+				*p++ = *b++ ^ 0x20;
+				break;
+			case PHY_IDLE:
+			case PKT_SOP:
+			case PKT_CHANNEL:
+			case PKT_EOP:
+				dev_err(dev, "%s unexpected 0x%x\n",
+					__func__, *b);
+				return -EINVAL;
+			default:
+				*p++ = *b++;
+				break;
+			}
+
+			*trans_len = p - trans_buf;
+
+			return 0;
+		default:
+			*p++ = *b++;
+			break;
+		}
+	}
+
+	/* We parsed all the bytes but didn't find EOP */
+	dev_err(dev, "%s no EOP\n", __func__);
+	return -EINVAL;
+}
+
+/*
+ * tx_buf len should be aligned with SPI's BPW. Spare bytes should be padded
+ * with PHY_IDLE, then the slave will just drop them.
+ *
+ * The driver will not simply pad 4a at the tail. The concern is that driver
+ * will not store MISO data during tx phase, if the driver pads 4a at the tail,
+ * it is possible that if the slave is fast enough to response at the padding
+ * time. As a result these rx bytes are lost. In the following case, 7a,7c,00
+ * will lost.
+ * MOSI ...|7a|7c|00|10| |00|00|04|02| |4b|7d|5a|7b| |40|4a|4a|4a| |XX|XX|...
+ * MISO ...|4a|4a|4a|4a| |4a|4a|4a|4a| |4a|4a|4a|4a| |4a|7a|7c|00| |78|56|...
+ *
+ * So the driver moves EOP and bytes after EOP to the end of the aligned size,
+ * then fill the hole with PHY_IDLE. As following:
+ * before pad ...|7a|7c|00|10| |00|00|04|02| |4b|7d|5a|7b| |40|
+ * after pad  ...|7a|7c|00|10| |00|00|04|02| |4b|7d|5a|4a| |4a|4a|7b|40|
+ * Then if the slave will not get the entire packet before the tx phase is
+ * over, it can't responsed to anything either.
+ */
+static void phy_tx_pad(unsigned char word_len, char *phy_buf,
+		       unsigned int phy_len, unsigned int *aligned_len)
+{
+	char *p = &phy_buf[phy_len - 1], *dst_p;
+
+	*aligned_len = ALIGN(phy_len, word_len);
+
+	if (*aligned_len == phy_len)
+		return;
+
+	dst_p = &phy_buf[*aligned_len - 1];
+
+	/* move EOP and bytes after EOP to the end of aligned size */
+	while (p > phy_buf) {
+		*dst_p = *p;
+
+		if (*p == PKT_EOP)
+			break;
+
+		p--;
+		dst_p--;
+	}
+
+	/* fill the hole with PHY_IDLEs */
+	while (p < dst_p)
+		*p++ = PHY_IDLE;
+}
+
+static void br_swap_words_32(char *buf, unsigned int len)
+{
+	unsigned int count;
+	u32 *p = (u32 *)buf;
+
+	count = len / 4;
+	while (count--) {
+		*p = swab32p(p);
+		p++;
+	}
+}
+
+static bool is_word_not_ready_32(const char *rxbuf)
+{
+	return *(u32 *)rxbuf == RX_NOT_READY_32;
+}
+
+static bool is_word_not_ready_8(const char *rxbuf)
+{
+	return *rxbuf == RX_NOT_READY_8;
+}
+
+static int br_rx_word_timeout(struct spi_avmm_bridge *br, char *rxbuf)
+{
+	unsigned long poll_timeout;
+	bool last_try = false;
+	int ret;
+
+	poll_timeout = jiffies + SPI_AVMM_XFER_TIMEOUT;
+	for (;;) {
+		ret = spi_read(br->spi, rxbuf, br->word_len);
+		if (ret)
+			return ret;
+
+		/*
+		 * keep on reading if the rx word does not have a valid
+		 * byte.
+		 */
+		if (!br->is_word_not_ready(rxbuf))
+			break;
+
+		if (last_try)
+			return -ETIMEDOUT;
+
+		/*
+		 * We timeout when rx is invalid for some time. But
+		 * it is possible we are scheduled out for long time
+		 * after a spi_read. So when we are scheduled in, a SW
+		 * timeout happens. But actually HW may have worked fine and
+		 * has been ready long time ago. So we need to do an extra
+		 * read, if we get a valid word we return a valid rx word,
+		 * otherwise real a HW issue happens.
+		 */
+		if (time_after(jiffies, poll_timeout))
+			last_try = true;
+	}
+
+	return 0;
+}
+
+static void br_tx_prepare(struct spi_avmm_bridge *br, bool is_read, u32 reg,
+			  u16 count, u32 *wr_val)
+{
+	unsigned int tx_len;
+
+	trans_tx_prepare(is_read, reg, count, wr_val,
+			 br->trans_buf, &tx_len);
+	pkt_phy_tx_prepare(br->trans_buf, tx_len,
+			   br->phy_buf, &tx_len);
+	phy_tx_pad(br->word_len, br->phy_buf, tx_len, &tx_len);
+
+	br->phy_len = tx_len;
+}
+
+static int br_rx_parse(struct spi_avmm_bridge *br, bool is_read,
+		       u16 expected_count, u32 *rd_val)
+{
+	struct device *dev = &br->spi->dev;
+	unsigned int trans_len;
+	int ret;
+
+	ret = pkt_phy_rx_parse(dev, br->phy_buf, br->phy_len,
+			       br->trans_buf, &trans_len);
+	if (ret) {
+		dev_err(dev, "%s pkt_phy_rx_parse failed %d\n",
+			__func__, ret);
+		goto phy_pkt_rx_err;
+	}
+
+	ret = trans_rx_parse(is_read, br->trans_buf, trans_len,
+			     expected_count, rd_val);
+	if (!ret)
+		return 0;
+
+	dev_err(dev, "%s trans_rx_parse failed %d\n", __func__, ret);
+	print_hex_dump(KERN_DEBUG, "trans rx:", DUMP_PREFIX_OFFSET,
+		       16, 1, br->trans_buf, trans_len, true);
+
+phy_pkt_rx_err:
+	print_hex_dump(KERN_DEBUG, "phy rx:", DUMP_PREFIX_OFFSET,
+		       16, 1, br->phy_buf, br->phy_len, true);
+
+	return ret;
+}
+
+static void rx_max_adjust(const char *w, const char *eop, u8 word_len,
+			  u32 rx_len, u32 *rx_max)
+{
+	u32 remaining_bytes  = w + word_len - 1 - eop, additional_bytes = 0;
+	const char *ptr;
+
+	if (remaining_bytes == 0) {
+		/*
+		 * EOP is the last byte in the word, rx 2 more bytes and
+		 * finish.
+		 */
+		additional_bytes = 2;
+	} else if (remaining_bytes == 1) {
+		/* 1 byte left in the word after EOP. */
+		ptr = eop + 1;
+		/*
+		 * If the byte is an ESCAPE char, rx 1 more byte and
+		 * finish. Otherwise it is OK to finish rx immediately.
+		 */
+		if (*ptr == PHY_ESC || *ptr == PKT_ESC)
+			additional_bytes = 1;
+	}
+	/*
+	 * 2 or more bytes are left in the word after EOP, OK to finish rx
+	 * immediately.
+	 */
+
+	/* Adjust rx_max, make sure we don't exceed the original rx_max. */
+	*rx_max = min(*rx_max, ALIGN(rx_len + additional_bytes, word_len));
+}
+
+/*
+ * In tx phase, the slave only returns PHY_IDLE (0x4a). So the driver will
+ * ignore rx in tx phase.
+ *
+ * The slave may send an unknown number of PHY_IDLEs in rx phase, so we cannot
+ * prepare a fixed length buffer to receive all of the rx data in a batch. We
+ * have to read word by word and filter out pure PHY_IDLE words. The rest of
+ * words have a predictable max length, the driver prepares a large enough
+ * buffer for them. See comments for definition of PHY_RX_MAX.
+ *
+ * When EOP is detected, 1 or 2 (if the last byte is escaped) more bytes should
+ * be received before the rx is finished.
+ */
+static int br_txrx(struct spi_avmm_bridge *br)
+{
+	u32 rx_max = PHY_RX_MAX, rx_len = 0;
+	const char *eop = NULL;
+	u8 wl = br->word_len;
+	char *rxbuf;
+	int ret;
+
+	/* reorder words for spi transfer */
+	if (br->br_swap_words)
+		br->br_swap_words(br->phy_buf, br->phy_len);
+
+	/* send all data in phy_buf  */
+	ret = spi_write(br->spi, br->phy_buf, br->phy_len);
+	if (ret)
+		goto out;
+
+	rxbuf = br->phy_buf;
+	while (rx_len <= rx_max - wl) {
+		/* read word by word */
+		ret = br_rx_word_timeout(br, rxbuf);
+		if (ret)
+			goto out;
+
+		rx_len += wl;
+
+		/* reorder word back now */
+		if (br->br_swap_words)
+			br->br_swap_words(rxbuf, wl);
+
+		if (!eop) {
+			/* find eop */
+			eop = memchr(rxbuf, PKT_EOP, wl);
+			if (eop) {
+				/*
+				 * When EOP is found in the word, then we are
+				 * about to finish rx, there is no need to fill
+				 * the whole phy buf. But if EOP is not the
+				 * last byte in rx stream, we may read 1 or 2
+				 * more bytes and early finish rx by adjusting
+				 * rx_max.
+				 */
+				rx_max_adjust(rxbuf, eop, wl, rx_len, &rx_max);
+			}
+		}
+
+		rxbuf += wl;
+	}
+
+out:
+	br->phy_len = rx_len;
+
+	ret = ret ? : (eop ? 0 : -EINVAL);
+	if (ret) {
+		dev_err(&br->spi->dev, "%s br txrx err %d\n", __func__, ret);
+		print_hex_dump(KERN_DEBUG, "phy rx:", DUMP_PREFIX_OFFSET,
+			       16, 1, br->phy_buf, rx_len, true);
+	}
+	return ret;
+}
+
+static int do_reg_access(void *context, bool is_read, unsigned int reg,
+			 unsigned int *value, u16 count)
+{
+	struct spi_avmm_bridge *br = context;
+	int ret;
+
+	br_tx_prepare(br, is_read, reg, count, value);
+
+	ret = br_txrx(br);
+	if (ret)
+		return ret;
+
+	return br_rx_parse(br, is_read, count, value);
+}
+
+#define do_reg_read(_ctx, _reg, _value, _count) \
+	do_reg_access(_ctx, true, _reg, _value, _count)
+#define do_reg_write(_ctx, _reg, _value, _count) \
+	do_reg_access(_ctx, false, _reg, _value, _count)
+
+static int regmap_spi_avmm_reg_read(void *context, unsigned int reg,
+				    unsigned int *val)
+{
+	return do_reg_read(context, reg, val, 1);
+}
+
+static int regmap_spi_avmm_reg_write(void *context, unsigned int reg,
+				     unsigned int val)
+{
+	return do_reg_write(context, reg, &val, 1);
+}
+
+static int regmap_spi_avmm_gather_write(void *context,
+					const void *reg_buf, size_t reg_len,
+					const void *val_buf, size_t val_len)
+{
+	if (reg_len != REG_SIZE)
+		return -EINVAL;
+
+	return do_reg_write(context, *(u32 *)reg_buf, (u32 *)val_buf,
+			    (u16)(val_len / VAL_SIZE));
+}
+
+static int regmap_spi_avmm_write(void *context, const void *data, size_t bytes)
+{
+	if (bytes < REG_SIZE + VAL_SIZE)
+		return -EINVAL;
+
+	return regmap_spi_avmm_gather_write(context, data, REG_SIZE,
+					    data + REG_SIZE, bytes - REG_SIZE);
+}
+
+static int regmap_spi_avmm_read(void *context,
+				const void *reg_buf, size_t reg_len,
+				void *val_buf, size_t val_len)
+{
+	if (reg_len != REG_SIZE)
+		return -EINVAL;
+
+	return do_reg_read(context, *(u32 *)reg_buf, val_buf,
+			   (u16)(val_len / VAL_SIZE));
+}
+
+static struct spi_avmm_bridge *
+spi_avmm_bridge_ctx_gen(struct spi_device *spi)
+{
+	struct spi_avmm_bridge *br;
+
+	br = kzalloc(sizeof(*br), GFP_KERNEL);
+	if (!br)
+		return NULL;
+
+	br->spi = spi;
+	br->word_len = spi->bits_per_word / 8;
+	if (br->word_len == 4) {
+		br->is_word_not_ready = is_word_not_ready_32;
+
+		/*
+		 * Phy layer data is filled byte by byte from low addr to high.
+		 * So the protocol requires LSB first. If the spi device cannot
+		 * do LSB_FIRST transfer, the driver needs to swap the byte
+		 * order word by word.
+		 */
+		if (!(br->spi->mode & SPI_LSB_FIRST))
+			br->br_swap_words = br_swap_words_32;
+	} else if (br->word_len == 1) {
+		br->is_word_not_ready = is_word_not_ready_8;
+	}
+
+	return br;
+}
+
+static void spi_avmm_bridge_ctx_free(void *context)
+{
+	kfree(context);
+}
+
+static const struct regmap_bus regmap_spi_avmm_bus = {
+	.write = regmap_spi_avmm_write,
+	.gather_write = regmap_spi_avmm_gather_write,
+	.read = regmap_spi_avmm_read,
+	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
+	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
+	.max_raw_read = VAL_SIZE * MAX_RX_CNT,
+	.max_raw_write = VAL_SIZE * MAX_TX_CNT,
+
+	.reg_write = regmap_spi_avmm_reg_write,
+	.reg_read = regmap_spi_avmm_reg_read,
+
+	.free_context = spi_avmm_bridge_ctx_free,
+};
+
+struct regmap *__devm_regmap_init_spi_avmm(struct spi_device *spi,
+					   const struct regmap_config *config,
+					   struct lock_class_key *lock_key,
+					   const char *lock_name)
+{
+	struct spi_avmm_bridge *bridge;
+	struct regmap *map;
+
+	if (!spi)
+		return ERR_PTR(-ENODEV);
+
+	/* Only support BPW == 8 or 32 now */
+	if (spi->bits_per_word != 8 && spi->bits_per_word != 32)
+		return ERR_PTR(-EINVAL);
+
+	bridge = spi_avmm_bridge_ctx_gen(spi);
+	if (!bridge)
+		return ERR_PTR(-ENOMEM);
+
+	map = __devm_regmap_init(&spi->dev, &regmap_spi_avmm_bus,
+				 bridge, config, lock_key, lock_name);
+	if (IS_ERR(map)) {
+		spi_avmm_bridge_ctx_free(bridge);
+		return ERR_CAST(map);
+	}
+
+	return map;
+}
diff --git a/drivers/mfd/intel-spi-avmm.h b/drivers/mfd/intel-spi-avmm.h
new file mode 100644
index 0000000..df46dff
--- /dev/null
+++ b/drivers/mfd/intel-spi-avmm.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Driver Header File for Intel SPI Slave to AVMM Bus Bridge
+ *
+ * Copyright (C) 2018-2020 Intel Corporation. All rights reserved.
+ *
+ */
+
+#ifndef __INTEL_SPI_AVMM_H
+#define __INTEL_SPI_AVMM_H
+
+#include <linux/spi/spi.h>
+#include <linux/regmap.h>
+
+struct regmap *__devm_regmap_init_spi_avmm(struct spi_device *spi,
+					   const struct regmap_config *config,
+					   struct lock_class_key *lock_key,
+					   const char *lock_name);
+
+/**
+ * devm_regmap_init_spi_avmm() - Initialize register map for Intel SPI Slave
+ * to AVMM Bus Bridge
+ *
+ * @spi: Device that will be interacted with
+ * @config: Configuration for register map
+ *
+ * The return value will be an ERR_PTR() on error or a valid pointer
+ * to a struct regmap.  The map will be automatically freed by the
+ * device management code.
+ */
+#define devm_regmap_init_spi_avmm(spi, config)				\
+	__regmap_lockdep_wrapper(__devm_regmap_init_spi_avmm, #config,	\
+				 spi, config)
+
+#endif /* __INTEL_SPI_AVMM_H */
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
new file mode 100644
index 0000000..4979756
--- /dev/null
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Driver Header File for Intel Max10 Board Management Controller chip.
+ *
+ * Copyright (C) 2018-2020 Intel Corporation, Inc.
+ *
+ */
+#ifndef __INTEL_M10_BMC_H
+#define __INTEL_M10_BMC_H
+
+#include <linux/regmap.h>
+
+#define M10BMC_LEGACY_SYS_BASE	0x300400
+#define M10BMC_SYS_BASE		0x300800
+#define M10BMC_MEM_END		0x200000fc
+
+/* Register offset of system registers */
+#define NIOS2_FW_VERSION	0x0
+#define M10BMC_TEST_REG		0x3c
+#define M10BMC_BUILD_VER	0x68
+#define M10BMC_VER_MAJOR_MSK	GENMASK(23, 16)
+#define M10BMC_VER_PCB_INFO_MSK	GENMASK(31, 24)
+
+/**
+ * struct intel_m10bmc - Intel Max10 BMC MFD device private data structure
+ * @dev: this device
+ * @regmap: the regmap used to access registers by m10bmc itself
+ */
+struct intel_m10bmc {
+	struct device *dev;
+	struct regmap *regmap;
+};
+
+/*
+ * register access helper functions.
+ *
+ * m10bmc_raw_read - read m10bmc register per addr
+ * m10bmc_sys_read - read m10bmc system register per offset
+ */
+static inline int
+m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
+		unsigned int *val)
+{
+	int ret;
+
+	ret = regmap_read(m10bmc->regmap, addr, val);
+	if (ret)
+		dev_err(m10bmc->dev, "fail to read raw reg %x: %d\n",
+			addr, ret);
+
+	return ret;
+}
+
+#define m10bmc_sys_read(m10bmc, offset, val) \
+	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
+
+#endif /* __INTEL_M10_BMC_H */
-- 
2.7.4

