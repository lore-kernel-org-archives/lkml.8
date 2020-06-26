Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD15C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB5420768
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="FAu14qyK";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="rQZx2czv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgFZE5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 00:57:19 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:29044 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726096AbgFZE5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:57:19 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05Q4qPJl016256;
        Thu, 25 Jun 2020 21:55:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=fZ1+fVLmuXrPLfthjKscKYLbNB/R7JueBZIBxjK8CVA=;
 b=FAu14qyK50CCJw3Pt6NpMt1kSEJNGESuO2/5hc6gf0xykCA6PADmhUDd9ih499G9BJV0
 U1rGb8x++wcJnpxxslfHuqyRSjNSqAREY5Q83BSoT5RfHEj5rn4ubhR2dTvpQJsoZDmW
 Kwird1u/alW8VwETDozmagcBb5sz6jh7oVjKCeDTqrwXIsQN+0csLJ5jhN5lkZ56rzyr
 zmxKGS9DuroBpuPZEZqhOvWX0V+nu/J+EFmiB8t5o4XMBEgUlv4G1bQY487CskcbW3r5
 4RFQW9Iwv68ZJN605IGORliQP7n1lPlso51HIyLEYQK3v6lDMHhvm3pfuhh1TX8RE8sJ rA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-0014ca01.pphosted.com with ESMTP id 31uur5sh5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Jun 2020 21:55:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TQDGSqO8WOF7MVTAF1k2ulWFgAZG0TNbkbn5tQOFO4YT87dSjNgLtnZ4UJUmeWv8ATXkKihtBigMPoEnxl9cgf6EPuAXkM1us4QRQwSL+6tqGBdJdZ7MRj7f7OQuhPewwbYXkOD9Wzqk1Aw+L7ApnIsxS4QXKfrtWD0inGK8qv+Rb2bTRUJ1xbwLNssofJy4WOWdP/b8sSv4uduumunU6Iq6Rb8Eq7jbqqq1uSSCpVZ6WNaD4r9oiqi7nbI6bts5PIu4TuT7hALz2x1iGTvbF5DleVgEKzYaFptwZtwJOWvW7zBFW4UuFnXGl4vubpY0sMubP33V6c7z4zw4+m6tqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ1+fVLmuXrPLfthjKscKYLbNB/R7JueBZIBxjK8CVA=;
 b=Xwuk8b0VoXpQEnuO5AQMlKMDCXNYSa1H+iSgnM1cxtWPH0YTDP24U4+egwVHZuijhimh9IjehYU/lvh3HDudxE9XwLoC+S7PzrwR0mPzSTCfqKpyKH60JbFC8q0sKuY48EzVn6lo9NTf67Iu98WU854qzf8FcZYMCwyV8z2OmClGch8VzkE5ZVOxxHdU2rMx0A609b5vtl+pVo8mGiDqeL9iEV5qVDHuVwzvNLz8ysyFwpoTJVsA5X1lX/CLD2u43R1KT+vpiv5MCe1qkNmdNF8xnRzzsnvr2vCUHs3a08LcXCYkF2wWLX90H4PYY9kJAZg7Na+egQ7bmPyRgeeQUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ1+fVLmuXrPLfthjKscKYLbNB/R7JueBZIBxjK8CVA=;
 b=rQZx2czv+LFNHsLh1DZZgjSLs2DuhCyRcTAXnkWyPd8GFDhH+DeQaKhALNH8kdPv9ZtewtoXiwwyt56HJRn2dqaiAwoHPskylZPzTVPdyGnthHe9DvlTCdKNOL85nRAxAUqKgrTvUD3IHm8coIyOKzgQR1/blM7MZN9/B4FmCg4=
Received: from DM6PR21CA0028.namprd21.prod.outlook.com (2603:10b6:5:174::38)
 by BYAPR07MB4616.namprd07.prod.outlook.com (2603:10b6:a02:f1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Fri, 26 Jun
 2020 04:55:55 +0000
Received: from DM6NAM12FT008.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::ba) by DM6PR21CA0028.outlook.office365.com
 (2603:10b6:5:174::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.2 via Frontend
 Transport; Fri, 26 Jun 2020 04:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT008.mail.protection.outlook.com (10.13.179.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.13 via Frontend Transport; Fri, 26 Jun 2020 04:55:54 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 05Q4tnkB202776
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Thu, 25 Jun 2020 21:55:53 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 26 Jun 2020 06:55:49 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 26 Jun 2020 06:55:49 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 05Q4tnqd010930;
        Fri, 26 Jun 2020 06:55:49 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 05Q4tnfp010929;
        Fri, 26 Jun 2020 06:55:49 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <balbi@kernel.org>, <devicetree@vger.kernel.org>
CC:     <dan.carpenter@oracle.com>, <ben.dooks@codethink.co.uk>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <peter.chen@nxp.com>,
        <weiyongjun1@huawei.com>, <jpawar@cadence.com>,
        <kurahul@cadene.com>, <sparmar@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH RFC 2/5] usb:cdns3: Add pci to platform driver wrapper
Date:   Fri, 26 Jun 2020 06:54:47 +0200
Message-ID: <20200626045450.10205-3-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200626045450.10205-1-pawell@cadence.com>
References: <20200626045450.10205-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(396003)(346002)(376002)(36092001)(46966005)(107886003)(70206006)(86362001)(70586007)(36906005)(81166007)(82740400003)(42186006)(82310400002)(54906003)(356005)(478600001)(316002)(4326008)(47076004)(110136005)(1076003)(8936002)(8676002)(2616005)(2906002)(336012)(7416002)(186003)(426003)(36756003)(5660300002)(26005);DIR:OUT;SFP:1101;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ba93ba7-c3b6-4baa-14ab-08d8198d34eb
X-MS-TrafficTypeDiagnostic: BYAPR07MB4616:
X-Microsoft-Antispam-PRVS: <BYAPR07MB4616359AFE7102489ABED78ADD930@BYAPR07MB4616.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0446F0FCE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E3HedS5dWOLP+QAHanXYHpFFiKaU/YCDYLCAipzNJSwQfXerjR3Zd69cK+ViB2utU7Q3Fai87uokbBVyaPlq9+UeREJARXYCmosNY0Jbk2adjuk33hX0xuSvm5jUEE7G+GOu8nOQs5DpAaQc10rDe9T81IIj9z7aTez8y87L95DMfwJBhc2NE3kdB8GU/Og2NAmeAptQd0gmIMOWkaWnE8PwqyXW3gLxG+QtcIKYI62s6DitOjsdbtWVQ4XDxxDou7DCyvM2RqVXboa9tnSCR68AF2NWkiPVNAizEzM0sADVRbrcXRG0k/rk9YVdyk1ta8cGDa0qT1e5d4aTYg6WL6jrdeXBExw3MXRHlBAW+iO7rLu/n/UXoXvhBWEkqgB5jpeluBiIazV+J+4rHbvMqYymcqoUYwEt3QWkC4VSVek=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2020 04:55:54.0730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba93ba7-c3b6-4baa-14ab-08d8198d34eb
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT008.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4616
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-26_01:2020-06-26,2020-06-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 phishscore=0
 mlxlogscore=804 priorityscore=1501 malwarescore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 suspectscore=0 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006260034
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds PCI specific glue driver that creates and registers in-system
cdns-usbssp platform device. Thanks to that we will be able to use
the cdns-usbssp platform driver for USBSS-DEV controller
build on PCI board.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/Kconfig           |   1 +
 drivers/usb/Makefile          |   1 +
 drivers/usb/cdnsp/Kconfig     |  26 +++++
 drivers/usb/cdnsp/Makefile    |   3 +
 drivers/usb/cdnsp/cdnsp-pci.c | 214 ++++++++++++++++++++++++++++++++++
 5 files changed, 245 insertions(+)
 create mode 100644 drivers/usb/cdnsp/Kconfig
 create mode 100644 drivers/usb/cdnsp/Makefile
 create mode 100644 drivers/usb/cdnsp/cdnsp-pci.c

diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 26475b409b53..555c4a4cb465 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -112,6 +112,7 @@ source "drivers/usb/usbip/Kconfig"
 endif
 
 source "drivers/usb/cdns3/Kconfig"
+source "drivers/usb/cdnsp/Kconfig"
 
 source "drivers/usb/mtu3/Kconfig"
 
diff --git a/drivers/usb/Makefile b/drivers/usb/Makefile
index 1c1c1d659394..84727f7a4b92 100644
--- a/drivers/usb/Makefile
+++ b/drivers/usb/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_USB_DWC2)		+= dwc2/
 obj-$(CONFIG_USB_ISP1760)	+= isp1760/
 
 obj-$(CONFIG_USB_CDNS3)		+= cdns3/
+obj-$(CONFIG_USB_CDNSP)		+= cdnsp/
 
 obj-$(CONFIG_USB_MON)		+= mon/
 obj-$(CONFIG_USB_MTU3)		+= mtu3/
diff --git a/drivers/usb/cdnsp/Kconfig b/drivers/usb/cdnsp/Kconfig
new file mode 100644
index 000000000000..5796a19bb8a0
--- /dev/null
+++ b/drivers/usb/cdnsp/Kconfig
@@ -0,0 +1,26 @@
+config USB_CDNSP
+	tristate "Cadence CDNSP Dual-Role Controller"
+	depends on USB_SUPPORT && (USB || USB_GADGET) && HAS_DMA
+	select USB_XHCI_PLATFORM if USB_XHCI_HCD
+	select USB_ROLE_SWITCH
+	help
+	  Say Y here if your system has a Cadence CDNSP dual-role controller.
+	  It supports: dual-role switch Host-only, and Peripheral-only.
+
+	  If you choose to build this driver is a dynamically linked
+	  module, the module will be called cdnsp.ko.
+
+if USB_CDNSP
+
+config USB_CDNSP_PCI
+	tristate "Cadence CDNSP support on PCIe-based platforms"
+	depends on USB_PCI && ACPI
+	default USB_CDNSP
+	help
+	  If you're using the CDNSP Core IP with a PCIe, please say
+	  'Y' or 'M' here.
+
+	  If you choose to build this driver as module it will
+	  be dynamically linked and module will be called cdnsp-pci.ko
+
+endif
diff --git a/drivers/usb/cdnsp/Makefile b/drivers/usb/cdnsp/Makefile
new file mode 100644
index 000000000000..21adf3eb2f7d
--- /dev/null
+++ b/drivers/usb/cdnsp/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_USB_CDNSP_PCI)		+= cdnsp-pci.o
diff --git a/drivers/usb/cdnsp/cdnsp-pci.c b/drivers/usb/cdnsp/cdnsp-pci.c
new file mode 100644
index 000000000000..7e05d584d57c
--- /dev/null
+++ b/drivers/usb/cdnsp/cdnsp-pci.c
@@ -0,0 +1,214 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence PCI Glue driver.
+ *
+ * Copyright (C) 2019 Cadence.
+ *
+ * Author: Pawel Laszczak <pawell@cadence.com>
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/pci.h>
+
+struct cdnsp_wrap {
+	struct platform_device *plat_dev;
+	struct resource dev_res[6];
+	int devfn;
+};
+
+#define RES_IRQ_HOST_ID		0
+#define RES_IRQ_PERIPHERAL_ID	1
+#define RES_IRQ_OTG_ID		2
+#define RES_HOST_ID		3
+#define RES_DEV_ID		4
+#define RES_DRD_ID		5
+
+#define PCI_BAR_HOST		0
+#define PCI_BAR_OTG		0
+#define PCI_BAR_DEV		2
+
+#define PCI_DEV_FN_HOST_DEVICE	0
+#define PCI_DEV_FN_OTG		1
+
+#define PCI_DRIVER_NAME		"cdns-pci-usbssp"
+#define PLAT_DRIVER_NAME	"cdns-usbssp"
+
+#define CDNS_VENDOR_ID		0x17cd
+#define CDNS_DEVICE_ID		0x0100
+#define CDNS_DRD_IF		(PCI_CLASS_SERIAL_USB << 8 | 0x80)
+
+static struct pci_dev *cdnsp_get_second_fun(struct pci_dev *pdev)
+{
+	struct pci_dev *func;
+
+	/*
+	 * Gets the second function.
+	 * It's little tricky, but this platform has two function.
+	 * The fist keeps resources for Host/Device while the second
+	 * keeps resources for DRD/OTG.
+	 */
+	func = pci_get_device(pdev->vendor, pdev->device, NULL);
+	if (unlikely(!func))
+		return NULL;
+
+	if (func->devfn == pdev->devfn) {
+		func = pci_get_device(pdev->vendor, pdev->device, func);
+		if (unlikely(!func))
+			return NULL;
+	}
+
+	return func;
+}
+
+static int cdnsp_pci_probe(struct pci_dev *pdev,
+			   const struct pci_device_id *id)
+{
+	struct platform_device_info plat_info;
+	struct cdnsp_wrap *wrap;
+	struct resource *res;
+	struct pci_dev *func;
+	int err;
+
+	/*
+	 * For GADGET/HOST PCI (devfn) function number is 0,
+	 * for OTG PCI (devfn) function number is 1.
+	 */
+	if (!id || (pdev->devfn != PCI_DEV_FN_HOST_DEVICE &&
+		    pdev->devfn != PCI_DEV_FN_OTG))
+		return -EINVAL;
+
+	func = cdnsp_get_second_fun(pdev);
+	if (unlikely(!func))
+		return -EINVAL;
+
+	if (func->class == PCI_CLASS_SERIAL_USB_XHCI ||
+	    pdev->class == PCI_CLASS_SERIAL_USB_XHCI)
+		return -EINVAL;
+
+	err = pcim_enable_device(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "Enabling PCI device has failed %d\n", err);
+		return err;
+	}
+
+	pci_set_master(pdev);
+
+	if (pci_is_enabled(func)) {
+		wrap = pci_get_drvdata(func);
+	} else {
+		wrap = kzalloc(sizeof(*wrap), GFP_KERNEL);
+		if (!wrap) {
+			pci_disable_device(pdev);
+			return -ENOMEM;
+		}
+	}
+
+	res = wrap->dev_res;
+
+	/* For GADGET device function number is 0. */
+	if (pdev->devfn == 0) {
+		/* Function 0: host(BAR_0) + device(BAR_1).*/
+		dev_dbg(&pdev->dev, "Initialize Device resources\n");
+		res[RES_DEV_ID].start = pci_resource_start(pdev, PCI_BAR_DEV);
+		res[RES_DEV_ID].end =   pci_resource_end(pdev, PCI_BAR_DEV);
+		res[RES_DEV_ID].name = "dev";
+		res[RES_DEV_ID].flags = IORESOURCE_MEM;
+		dev_dbg(&pdev->dev, "USBSS-DEV physical base addr: %pa\n",
+			&res[RES_DEV_ID].start);
+
+		res[RES_HOST_ID].start = pci_resource_start(pdev, PCI_BAR_HOST);
+		res[RES_HOST_ID].end = pci_resource_end(pdev, PCI_BAR_HOST);
+		res[RES_HOST_ID].name = "xhci";
+		res[RES_HOST_ID].flags = IORESOURCE_MEM;
+		dev_dbg(&pdev->dev, "USBSS-XHCI physical base addr: %pa\n",
+			&res[RES_HOST_ID].start);
+
+		/* Interrupt for XHCI, */
+		wrap->dev_res[RES_IRQ_HOST_ID].start = pdev->irq;
+		wrap->dev_res[RES_IRQ_HOST_ID].name = "host";
+		wrap->dev_res[RES_IRQ_HOST_ID].flags = IORESOURCE_IRQ;
+
+		/* Interrupt device. It's the same as for HOST. */
+		wrap->dev_res[RES_IRQ_PERIPHERAL_ID].start = pdev->irq;
+		wrap->dev_res[RES_IRQ_PERIPHERAL_ID].name = "peripheral";
+		wrap->dev_res[RES_IRQ_PERIPHERAL_ID].flags = IORESOURCE_IRQ;
+	} else {
+		res[RES_DRD_ID].start = pci_resource_start(pdev, PCI_BAR_OTG);
+		res[RES_DRD_ID].end =   pci_resource_end(pdev, PCI_BAR_OTG);
+		res[RES_DRD_ID].name = "otg";
+		res[RES_DRD_ID].flags = IORESOURCE_MEM;
+		dev_dbg(&pdev->dev, "CDNSP-DRD physical base addr: %pa\n",
+			&res[RES_DRD_ID].start);
+
+		/* Interrupt for OTG/DRD. */
+		wrap->dev_res[RES_IRQ_OTG_ID].start = pdev->irq;
+		wrap->dev_res[RES_IRQ_OTG_ID].name = "otg";
+		wrap->dev_res[RES_IRQ_OTG_ID].flags = IORESOURCE_IRQ;
+	}
+
+	if (pci_is_enabled(func)) {
+		/* Set up platform device info. */
+		memset(&plat_info, 0, sizeof(plat_info));
+		plat_info.parent = &pdev->dev;
+		plat_info.fwnode = pdev->dev.fwnode;
+		plat_info.name = PLAT_DRIVER_NAME;
+		plat_info.id = pdev->devfn;
+		wrap->devfn  = pdev->devfn;
+		plat_info.res = wrap->dev_res;
+		plat_info.num_res = ARRAY_SIZE(wrap->dev_res);
+		plat_info.dma_mask = pdev->dma_mask;
+		/* Register platform device. */
+		wrap->plat_dev = platform_device_register_full(&plat_info);
+		if (IS_ERR(wrap->plat_dev)) {
+			pci_disable_device(pdev);
+			err = PTR_ERR(wrap->plat_dev);
+			kfree(wrap);
+			return err;
+		}
+	}
+
+	pci_set_drvdata(pdev, wrap);
+	return err;
+}
+
+static void cdnsp_pci_remove(struct pci_dev *pdev)
+{
+	struct cdnsp_wrap *wrap;
+	struct pci_dev *func;
+
+	func = cdnsp_get_second_fun(pdev);
+
+	wrap = (struct cdnsp_wrap *)pci_get_drvdata(pdev);
+	if (wrap->devfn == pdev->devfn)
+		platform_device_unregister(wrap->plat_dev);
+
+	if (!pci_is_enabled(func))
+		kfree(wrap);
+}
+
+static const struct pci_device_id cdnsp_pci_ids[] = {
+	{ PCI_VENDOR_ID_CDNS, CDNS_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
+	  PCI_CLASS_SERIAL_USB_DEVICE, PCI_ANY_ID },
+	{ PCI_VENDOR_ID_CDNS, CDNS_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,
+	  CDNS_DRD_IF, PCI_ANY_ID },
+	{ 0, }
+};
+
+static struct pci_driver cdnsp_pci_driver = {
+	.name = "cdnsp-pci",
+	.id_table = &cdnsp_pci_ids[0],
+	.probe = cdnsp_pci_probe,
+	.remove = cdnsp_pci_remove,
+};
+
+module_pci_driver(cdnsp_pci_driver);
+MODULE_DEVICE_TABLE(pci, cdnsp_pci_ids);
+
+MODULE_AUTHOR("Pawel Laszczak <pawell@cadence.com>");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Cadence CDNSP PCI Glue Layer");
-- 
2.17.1

