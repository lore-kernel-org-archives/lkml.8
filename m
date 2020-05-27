Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7AAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9BB92088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 20:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=plvision.eu header.i=@plvision.eu header.b="fSITX8C4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgE0URo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 16:17:44 -0400
Received: from mail-am6eur05on2120.outbound.protection.outlook.com ([40.107.22.120]:52449
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727090AbgE0URn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 16:17:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBcDvOsr29jm6K6pXfMZ0bplNqZL7fo93Yo5zx8q+AOfraodBtOGe5untkU5NAT/6Skk+YGIOcnVsG0HW53LvpMijQAB7wROwkZNczbUg3lsMVuDtimJIWHGUDtL8tnmRCpkkLsL9is0Xrc3Vvzf9XpzZHutt3Vra5Cs5lPfjoCi3zVFJkqiXUco2FDCzEXyD5CJeSEOW0MSovKgehvuuFJQbPJ0MJH16VaVwxDAg8y56IUVQ4T9Q5M96Q63AoHz8QkqSnxsyCUbXBfa+d4MU4zLKnpi1667LEJrKWtq+wPzzPbLV7AUULU3bg5ePC2VJFjaHeYeGN4egmN3HMpdjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlYB9Si6BmsJ3yNdy0joI8at+8s6uvxU6tHgbxW4x7E=;
 b=oJJQSnHQHH58XD+c7iPrPC7xoyH0uB4jVCimSRUgV8le2QYV+gmws1+WN6y51T2zKJLRZSVwXBGV77Zu6Yptzt1xN40kotNpAz4YwwIMaaxHVwj/cGO/Y1oY6yRSGPt/KCoV26xLl/BB+d1IUPtI/yWtrQ7UQLudbgy5hWYFoqpAHagr+7ln4HzmSVuHEVj74py82hmDa0u3GyuRvujkGl4h9v/Gz18EDfewMzNBHHPlpCpeRC6zcXXBUIbTuS9kM3oOescTjL6zg62Mf4Bdrx3/N9WVLiBsj6MfD4PM9mX/zgLZn4ve0isT1Wr2WC40E11U7yJ2SyM3Q7mXKaIoDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlYB9Si6BmsJ3yNdy0joI8at+8s6uvxU6tHgbxW4x7E=;
 b=fSITX8C4fBk+ofJV0vfOG8aZ4OXpz2pMwtpPt7SSZ7L+kdx1fwO4HHf97uXdPbCPXkx3cZSL83mPx+MebXCCsNUCvW4ic7ZLjqS1oyD1WeaLBz0GpDXbVN3PsbBE7TLnvmvqPlTCIUCSLFlmivdJxvSVKJtbFY49VGnkO1paDQ0=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:35::10)
 by VI1P190MB0399.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Wed, 27 May
 2020 20:17:34 +0000
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::8149:8652:3746:574f]) by VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::8149:8652:3746:574f%7]) with mapi id 15.20.3045.018; Wed, 27 May 2020
 20:17:34 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Taras Chornyi <taras.chornyi@plvision.eu>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH 2/2] nvmem: add ONIE NVMEM cells support
Date:   Wed, 27 May 2020 23:17:15 +0300
Message-Id: <20200527201715.3660-3-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527201715.3660-1-vadym.kochan@plvision.eu>
References: <20200527201715.3660-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: AM6P192CA0106.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::47) To VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:35::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan.x.ow.s (217.20.186.93) by AM6P192CA0106.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Wed, 27 May 2020 20:17:33 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 082fe9d3-4c13-43f0-881b-08d8027afda7
X-MS-TrafficTypeDiagnostic: VI1P190MB0399:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1P190MB0399584DA8C6CA3115CA535C95B10@VI1P190MB0399.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-Forefront-PRVS: 04163EF38A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x7kGFml2kXQevemd5atbR+v7Jr6AiJUeQhvEDxkltPesrAjAiJGzCg4gjwbphmjhjQkpXCdcJMb4u2mfo090cDabTI1SewKBFJtgsnerQ/f0TGJJ+5CpTgTeJWXQV+8GNnxzw+FrlpKOY69OYmhTCoRkVCYyum+KDZItKYWJ3b2K/ksBCbf9kuwiKKJR924sptW2wECr/7yl0noo8ASMORooe7JJqsrKtheCIVdzqKeGQR/KSan9HisVBhjbYoIqfLrBuhJmG/WF6WdwWhU4zVYAfAUZWI/4LRaj5U5WBadNs9q3ktV8U3hKzh+XMubWSk+y+q7rrS/oOHV1q4d4qA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0399.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(39830400003)(136003)(396003)(6486002)(6506007)(6666004)(36756003)(66946007)(66556008)(66476007)(4326008)(83380400001)(5660300002)(44832011)(16526019)(8936002)(956004)(186003)(52116002)(2616005)(8676002)(107886003)(316002)(26005)(86362001)(2906002)(1076003)(508600001)(6512007)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: SgAsrSknX36PjBfEqdKm2DboBq6wiqQQVNZ2RQrkIBcumrTG4q3MhmC3S/J0gHdzzRQlt89KYy0Tu8ZfmrNzLPxUbAJ6rWnH7+dwDKgTYYGm/uT+zrzIgHBwEqFbBpM3h/drGsLkPyflx59TH45dtw897edAD2Gd1rBc5D4EKQQ3X1FaULsOqf/7BvZtakrrOdJEJmiYQ1ZLh1xkt+jatlJgGt8vRbGWnL/rJz/DU2RiQPQ9XGFNruk0uHfLqJDzaaGnjmdi2y8ulpq/+lwSZ+a5aP2IC1HdQUUF40H3skXnc4rcc6kFl9KIriA9zMW/BiEpd47EBeScrg+aRYDvX63gg1Gr3JBdcIyrBB4Ai9Tsb6TBlSg7BN1USDcwpHkl3Tg69+iTF2zatpbwDvSx9xWXmk+paspFKPsZoCtfm5eD6bKidd1oVGIi/NG1L6oOShxn8O0NMuCNG7CMzeFY6yuRZ8EDIzEDlYNTzaPDRVU=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 082fe9d3-4c13-43f0-881b-08d8027afda7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2020 20:17:33.9994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfz0EyVIziGjxHeeaG9KOk953VSn+T8xPvuh6f978wOr3TXwrAJE14LN2k4731cIGmrTCl21485uqaB2eh7Q+Ci2SiUe2lFpqojw5Ow6xrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0399
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ONIE is a small operating system, pre-installed on bare metal network
switches, that provides an environment for automated provisioning.

This system requires that NVMEM (EEPROM) device holds various system
information (mac address, platform name, etc) in a special TLV layout.

The driver registers ONIE TLV attributes as NVMEM cells which can be
accessed by other platform driver. Also it allows to use
of_get_mac_address() to retrieve mac address for the netdev.

Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---
 drivers/nvmem/Kconfig      |   9 +
 drivers/nvmem/Makefile     |   3 +
 drivers/nvmem/onie-cells.c | 332 +++++++++++++++++++++++++++++++++++++
 3 files changed, 344 insertions(+)
 create mode 100644 drivers/nvmem/onie-cells.c

diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
index d7b7f6d688e7..dd9298487992 100644
--- a/drivers/nvmem/Kconfig
+++ b/drivers/nvmem/Kconfig
@@ -273,4 +273,13 @@ config SPRD_EFUSE
 	  This driver can also be built as a module. If so, the module
 	  will be called nvmem-sprd-efuse.
 
+config NVMEM_ONIE_CELLS
+	tristate "ONIE TLV cells support"
+	help
+	  This is a driver to provide cells from ONIE TLV structure stored
+	  on NVME device.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nvmem-onie-cells.
+
 endif
diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
index a7c377218341..2199784a489f 100644
--- a/drivers/nvmem/Makefile
+++ b/drivers/nvmem/Makefile
@@ -55,3 +55,6 @@ obj-$(CONFIG_NVMEM_ZYNQMP)	+= nvmem_zynqmp_nvmem.o
 nvmem_zynqmp_nvmem-y		:= zynqmp_nvmem.o
 obj-$(CONFIG_SPRD_EFUSE)	+= nvmem_sprd_efuse.o
 nvmem_sprd_efuse-y		:= sprd-efuse.o
+
+obj-$(CONFIG_NVMEM_ONIE_CELLS)	+= nvmem-onie-cells.o
+nvmem-onie-cells-y		:= onie-cells.o
diff --git a/drivers/nvmem/onie-cells.c b/drivers/nvmem/onie-cells.c
new file mode 100644
index 000000000000..d5afd4a955db
--- /dev/null
+++ b/drivers/nvmem/onie-cells.c
@@ -0,0 +1,332 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ONIE NVMEM cells provider
+ *
+ * Author: Vadym Kochan <vadym.kochan@plvision.eu>
+ */
+
+#define ONIE_NVMEM_DRVNAME	"onie-nvmem-cells"
+
+#define pr_fmt(fmt) ONIE_NVMEM_DRVNAME ": " fmt
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
+
+#define ONIE_NVMEM_TLV_MAX_LEN	2048
+
+#define ONIE_NVMEM_HDR_ID	"TlvInfo"
+
+struct onie_nvmem_hdr {
+	u8 id[8];
+	u8 version;
+	__be16 data_len;
+} __packed;
+
+struct onie_nvmem_tlv {
+	u8 type;
+	u8 len;
+	u8 val[0];
+} __packed;
+
+struct onie_nvmem_attr {
+	struct list_head head;
+	const char *name;
+	unsigned int offset;
+	unsigned int len;
+};
+
+struct onie_nvmem {
+	struct nvmem_device *nvmem;
+	unsigned int attr_count;
+	struct list_head attrs;
+
+	struct nvmem_cell_lookup *cell_lookup;
+	struct nvmem_cell_table cell_tbl;
+};
+
+static bool onie_nvmem_hdr_is_valid(struct onie_nvmem_hdr *hdr)
+{
+	if (memcmp(hdr->id, ONIE_NVMEM_HDR_ID, sizeof(hdr->id) != 0))
+		return false;
+	if (hdr->version != 0x1)
+		return false;
+
+	return true;
+}
+
+static void onie_nvmem_attrs_free(struct onie_nvmem *onie)
+{
+	struct onie_nvmem_attr *attr, *tmp;
+
+	list_for_each_entry_safe(attr, tmp, &onie->attrs, head) {
+		list_del(&attr->head);
+		kfree(attr);
+	}
+}
+
+static const char *onie_nvmem_attr_name(u8 type)
+{
+	switch (type) {
+	case 0x21: return "product-name";
+	case 0x22: return "part-number";
+	case 0x23: return "serial-number";
+	case 0x24: return "mac-address";
+	case 0x25: return "manufacture-date";
+	case 0x26: return "device-version";
+	case 0x27: return "label-revision";
+	case 0x28: return "platforn-name";
+	case 0x29: return "onie-version";
+	case 0x2A: return "num-macs";
+	case 0x2B: return "manufacturer";
+	case 0x2C: return "country-code";
+	case 0x2D: return "vendor";
+	case 0x2E: return "diag-version";
+	case 0x2F: return "service-tag";
+	case 0xFD: return "vendor-extension";
+	case 0xFE: return "crc32";
+
+	default: return "unknown";
+	}
+}
+
+static int onie_nvmem_tlv_parse(struct onie_nvmem *onie, u8 *data, u16 len)
+{
+	unsigned int hlen = sizeof(struct onie_nvmem_hdr);
+	unsigned int offset = 0;
+	int err;
+
+	while (offset < len) {
+		struct onie_nvmem_attr *attr;
+		struct onie_nvmem_tlv *tlv;
+
+		tlv = (struct onie_nvmem_tlv *)(data + offset);
+
+		if (offset + tlv->len >= len) {
+			struct nvmem_device *nvmem = onie->nvmem;
+
+			pr_err("%s: TLV len is too big(0x%x) at 0x%x\n",
+			       nvmem_dev_name(nvmem), tlv->len, hlen + offset);
+
+			/* return success in case something was parsed */
+			return 0;
+		}
+
+		attr = kmalloc(sizeof(*attr), GFP_KERNEL);
+		if (!attr) {
+			err = -ENOMEM;
+			goto err_attr_alloc;
+		}
+
+		attr->name = onie_nvmem_attr_name(tlv->type);
+		/* skip 'type' and 'len' */
+		attr->offset = hlen + offset + 2;
+		attr->len = tlv->len;
+
+		list_add(&attr->head, &onie->attrs);
+		onie->attr_count++;
+
+		offset += sizeof(*tlv) + tlv->len;
+	}
+
+	return 0;
+
+err_attr_alloc:
+	onie_nvmem_attrs_free(onie);
+
+	return err;
+}
+
+static int onie_nvmem_decode(struct onie_nvmem *onie)
+{
+	struct nvmem_device *nvmem = onie->nvmem;
+	struct onie_nvmem_hdr hdr;
+	u8 *data;
+	u16 len;
+	int ret;
+
+	ret = nvmem_device_read(nvmem, 0, sizeof(hdr), &hdr);
+	if (ret < 0)
+		return ret;
+
+	if (!onie_nvmem_hdr_is_valid(&hdr)) {
+		pr_err("%s: invalid ONIE TLV header\n", nvmem_dev_name(nvmem));
+		ret = -EINVAL;
+		goto err_invalid;
+	}
+
+	len = be16_to_cpu(hdr.data_len);
+
+	if (len > ONIE_NVMEM_TLV_MAX_LEN)
+		len = ONIE_NVMEM_TLV_MAX_LEN;
+
+	data = kmalloc(len, GFP_KERNEL);
+	if (!data) {
+		ret = -ENOMEM;
+		goto err_kmalloc;
+	}
+
+	ret = nvmem_device_read(nvmem, sizeof(hdr), len, data);
+	if (ret < 0)
+		goto err_data_read;
+
+	ret = onie_nvmem_tlv_parse(onie, data, len);
+	if (ret)
+		goto err_info_parse;
+
+	kfree(data);
+
+	return 0;
+
+err_info_parse:
+err_data_read:
+	kfree(data);
+err_kmalloc:
+err_invalid:
+	return ret;
+}
+
+static int onie_nvmem_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct nvmem_cell_info *cells;
+	struct onie_nvmem_attr *attr;
+	struct nvmem_device *nvmem;
+	struct onie_nvmem *onie;
+	unsigned int ncells = 0;
+	int err;
+
+	nvmem = of_nvmem_device_get(np, NULL);
+	if (IS_ERR(nvmem))
+		return PTR_ERR(nvmem);
+
+	onie = kmalloc(sizeof(*onie), GFP_KERNEL);
+	if (!onie) {
+		err = -ENOMEM;
+		goto err_nvmem_alloc;
+	}
+
+	INIT_LIST_HEAD(&onie->attrs);
+	onie->attr_count = 0;
+	onie->nvmem = nvmem;
+
+	err = onie_nvmem_decode(onie);
+	if (err)
+		goto err_nvmem_decode;
+
+	if (!onie->attr_count) {
+		pr_err("%s: has no ONIE attributes\n", nvmem_dev_name(nvmem));
+		err = -EINVAL;
+		goto err_no_attrs;
+	}
+
+	cells = kmalloc_array(onie->attr_count, sizeof(*cells), GFP_KERNEL);
+	if (!cells) {
+		err = -ENOMEM;
+		goto err_cells_alloc;
+	}
+
+	onie->cell_lookup = kmalloc_array(onie->attr_count,
+					  sizeof(struct nvmem_cell_lookup),
+					  GFP_KERNEL);
+	if (!onie->cell_lookup) {
+		err = -ENOMEM;
+		goto err_lookup_alloc;
+	}
+
+	list_for_each_entry(attr, &onie->attrs, head) {
+		struct nvmem_cell_lookup *lookup;
+		struct nvmem_cell_info *cell;
+
+		cell = &cells[ncells];
+
+		lookup = &onie->cell_lookup[ncells];
+		lookup->con_id = NULL;
+
+		cell->offset = attr->offset;
+		cell->name = attr->name;
+		cell->bytes = attr->len;
+		cell->bit_offset = 0;
+		cell->nbits = 0;
+
+		lookup->nvmem_name = nvmem_dev_name(onie->nvmem);
+		lookup->dev_id = dev_name(dev);
+		lookup->cell_name = cell->name;
+		lookup->con_id = cell->name;
+
+		ncells++;
+	}
+
+	onie->cell_tbl.nvmem_name = nvmem_dev_name(onie->nvmem);
+	onie->cell_tbl.ncells = ncells;
+	onie->cell_tbl.cells = cells;
+
+	nvmem_add_cell_table(&onie->cell_tbl);
+	nvmem_add_cell_lookups(onie->cell_lookup, ncells);
+
+	dev_set_drvdata(dev, onie);
+
+	onie_nvmem_attrs_free(onie);
+
+	nvmem_device_put(nvmem);
+
+	return 0;
+
+err_lookup_alloc:
+	kfree(onie->cell_tbl.cells);
+err_cells_alloc:
+	onie_nvmem_attrs_free(onie);
+err_no_attrs:
+err_nvmem_decode:
+	kfree(onie);
+err_nvmem_alloc:
+	nvmem_device_put(nvmem);
+
+	return err;
+}
+
+static int onie_nvmem_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct onie_nvmem *onie;
+
+	onie = dev_get_drvdata(dev);
+
+	nvmem_del_cell_lookups(onie->cell_lookup, onie->attr_count);
+	nvmem_del_cell_table(&onie->cell_tbl);
+
+	kfree(onie->cell_tbl.cells);
+	kfree(onie->cell_lookup);
+	kfree(onie);
+
+	return 0;
+}
+
+static const struct of_device_id onie_nvmem_match[] = {
+	{
+		.compatible = "onie-nvmem-cells",
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, onie_nvmem_match);
+
+static struct platform_driver onie_nvmem_driver = {
+	.probe = onie_nvmem_probe,
+	.remove = onie_nvmem_remove,
+	.driver = {
+		.name = ONIE_NVMEM_DRVNAME,
+		.of_match_table = onie_nvmem_match,
+	},
+};
+module_platform_driver(onie_nvmem_driver);
+
+MODULE_AUTHOR("Vadym Kochan <vadym.kochan@plvision.eu>");
+MODULE_DESCRIPTION("ONIE NVMEM cells driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

