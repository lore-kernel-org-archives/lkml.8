Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5F3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6BD0207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=plvision.eu header.i=@plvision.eu header.b="Y+N8zHrM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgE2XH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 19:07:59 -0400
Received: from mail-db8eur05on2101.outbound.protection.outlook.com ([40.107.20.101]:10081
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726898AbgE2XH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 19:07:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bi+uvLn0k8GDSqMV8ULGc36PIg7LC27ZOwVnu19RbJ7RHxk6ksTWI+/NsBQ7YA1oPAXbPRPV/GJKWOVIPdSpm4nIZjdc6y1pU7jqQVTsGCYTGwY9JBd49DuswYVO2Gm/2a8myAMlTU2A0w6OA5owRODLbAA8MRYPXsXjb6lcoeg8c2vY8CzZ1/trHrf7rTt93ZOmmQ+aruruEGpg1vW2Yqo41tDeGej1G6aVL9JIr9J+c9bo9jVHfyvBu4fMKd9yLFdqF1PGvNtdaCi3McLu+AgaS30Ai/UtO69srlPWpA0t3A4YuD98zprABU97pgr1Ndwu0wkOKESuFXpTrUVQ4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxhBNQCLDmG8YMqFbVGGBlIyqX5L2voxo99oEZGBbYs=;
 b=mCn3tXpEJyTBgR/AAZrSErW59rbDtkwFsqSkOPcTLoFq2Wn0bG620PPNK9/BFSgxYILjEP0J4K7ZB1kgo4C5QEQ6gjOAW7jaI05x+zGp+p4pwSGEiTi1mG9L+hsCJysDGbOUIzaxZlJ/VwXWVKuSuyJ1/o6bZdgRTuPEW8cxE4JEmxaCYt3WW8JPFCtI/5wlNbwXV1Pe2xqdZORBHzz5f+JIr4uYjJ3y2UxOe5oUHqdWqNWLqcVqNtGvDYLYDlbGHL4JZOGsJYZPwvyW+1IYQue0CNY3H76pRz1yAHJdZ7F2aPitQ10nLFDnZKv6092EBviaaVtwikqCiiRSL/KYIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxhBNQCLDmG8YMqFbVGGBlIyqX5L2voxo99oEZGBbYs=;
 b=Y+N8zHrM1takBlgoXZ/o3URXMAaH+IurQOvt8wPB2J8pd8qu6ydn7gjwLqUReCibGhwmleaWM8aV6XoYJRw3WcVcnYDtIeSxronrx+Wet8sW2vdM8LIZrH7SA7XCWurkcoE50rjIrJM6+MIevX0P62TblFyhHOY8h94t8YNircI=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:35::10)
 by VI1P190MB0622.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:12d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Fri, 29 May
 2020 23:05:16 +0000
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::8149:8652:3746:574f]) by VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::8149:8652:3746:574f%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 23:05:15 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Taras Chornyi <taras.chornyi@plvision.eu>,
        Vadym Kochan <vadym.kochan@plvision.eu>
Subject: [PATCH v2 2/2] nvmem: add ONIE NVMEM cells support
Date:   Sat, 30 May 2020 02:04:51 +0300
Message-Id: <20200529230451.21337-3-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529230451.21337-1-vadym.kochan@plvision.eu>
References: <20200529230451.21337-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: AM6P191CA0045.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:7f::22) To VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:35::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan.x.ow.s (217.20.186.93) by AM6P191CA0045.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Fri, 29 May 2020 23:05:15 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80404607-ddb0-46f2-c49f-08d80424bfbc
X-MS-TrafficTypeDiagnostic: VI1P190MB0622:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1P190MB062244B8C07FBC27DC6F668B958F0@VI1P190MB0622.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6BKroNtHQ2NT8MCJ+QWr500Wh8zwY1P1TVjF6u1FzFb77ujwFVuQJM5DthI3W7E0ZCT8NoRKVQQag9XVmgyG1YL5nVSxx+mN3kmHXzMPa2Op8OQ8V1OziCUjSAfeJWO2/BDkSDM4ab+FdsQav/cYc0uGRk9taw8Ahutei2EDqyP7qjULQ6fM2pn+LLW338LAvpSIl9ikxeWf2I5g9nUiinsxWNBpI5Igt0IO09cfbyjRLg1+5A8w3MyCxFCL6ZnjZFchBEg7BxFrCB444QxNwNXyoeYh8b5EicmQrrScblwAHAZpl4cnqND8QF1BXF1pnH449KMP1ODMCfm0yCpt5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0399.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(396003)(136003)(366004)(39830400003)(346002)(376002)(66946007)(54906003)(8676002)(6666004)(6512007)(4326008)(8936002)(110136005)(316002)(6486002)(508600001)(5660300002)(52116002)(86362001)(107886003)(186003)(2616005)(16526019)(44832011)(2906002)(83380400001)(66556008)(66476007)(6506007)(956004)(1076003)(36756003)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 5TXMK6vVpLX852CwesdVPSue3R3d2Z5kItL8s52xtxD6TBK9RHiUZRspJfEcLQ5NHQCJJDlFWQID16KeL/sDqcmw+LoWHnPfliCDDYlg20tGPjwa755mOFCpQwhC4L+6bdXMpeMnof+2CTrDINKK7tsLRqKt6ZtYcipR6n2nIGHA7EeT9Pn8E/KMXAUVx6OO9YGnHtvnc5GxUEHRjGeshvhdemWE0L1M0OOIGhKnNYz2PFGFQD5xlv+Ut9E3/q6dRlxEDhcd+F9HGL9xJVZcqXfhy0AR95JZfyDlN2bK+JgN48UyotyazwrER36QbizgEl813uU0ZM2dzfrc0JMwOIxQXmmxYG6Ckpoj2JvoTctxp4fzlTbWgMPoeGn6J7rdwbjvZPkpiXLzwN/1VNYgkW3VnMxRJgki8lsY1pGD0A3WhCk1S8cTSoWiE+FcnUJ4Q3Iu3Hd+6slxl+Yij7ojnpWCjFtAGzJhzK/nG3wrhiM=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 80404607-ddb0-46f2-c49f-08d80424bfbc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 23:05:15.8116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0icVinvAoYhn63DPyiNmHSta8PNe9B65fcjqIbrPvee84uWU8IijN2kbZCRqVnqN/Be63ME9Pl96tLBYoqzmMO9G6g027g71vsbKlapz1do=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0622
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
index 000000000000..1e8b4b8d1c0d
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
+	if (memcmp(hdr->id, ONIE_NVMEM_HDR_ID, sizeof(hdr->id)) != 0)
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

