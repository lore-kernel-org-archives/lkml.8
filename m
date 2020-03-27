Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9DAC2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 05:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D948D2078B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 05:53:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="QzIshqlF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgC3FxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 01:53:05 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:37400 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728760AbgC3FxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 01:53:04 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id 1A36B2DC685C;
        Mon, 30 Mar 2020 16:52:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1585547571;
        bh=7micxHdia2GvvQ4mY81c4jBHOqLOZ0TeAcVaPQleunM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QzIshqlFp53qA4DB8IAUutZabSbcugvEaXNKxzsAZpWDALJWJPENQ0mvFoELV93rV
         xBDyaQhfw6Fw/7rbXS8HW2uZrWtaFnR2MvhNnl6jlQdn02p7u/PmP6ztacNKbuPyu9
         85tmlez/p2Zxt6TIwBFgAqzZRWTRiMnUh4iIZthtCkmm6j6qHrQe0olItNDpyXKcuu
         yrr563UM5DgGMo6LV7xzIIBif4ulFgC+/HkkjRqErrlhMI7zkwkMcxgPJBNiKUJris
         O3eIA6Pue08VWVHyK7Rqs/DxlrIVWcyA5LmzmtJO8eECSw88MVxEtfzv905BcPf3kH
         cMJ/o5fgzi/txiWRyh4RECCqzSOxZASTGF+B4aKQY9yDgE8tWr1RSDdkAgN9l5T7gK
         XufI3qOWi3HWntScxvoGIljl4WlGsy2jHNnAP16md7cjStgYPxE+MIOngRuFz9G+ot
         B0ZpigPUtr4kS4a5Zk/lekbvhIphRoTyFEEg27ngbAd4+R0Pdpi/03ray/974q6DRP
         oj9yVUBjNPWt7kNYNnilPCHMODV6tOeY6nPwnd/5fUVYpIYO/0G0qRYicw3MoB+cMo
         WNBBCFdNMn/eXciPsYoJgPiHCgAWonEXwlOPPECDtSKn/8ZevQqjdlygOvDl330WrX
         giiKa7eoY/kFQHdeCMxIcNVE=
Received: from localhost.lan ([10.0.1.179])
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTP id 02R7C4Ax045934;
        Fri, 27 Mar 2020 18:12:20 +1100 (AEDT)
        (envelope-from alastair@d-silva.org)
From:   "Alastair D'Silva" <alastair@d-silva.org>
To:     alastair@d-silva.org
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kurz <groug@kaod.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Subject: [PATCH v4 24/25] nvdimm/ocxl: Expose the serial number & firmware version in sysfs
Date:   Fri, 27 Mar 2020 18:12:01 +1100
Message-Id: <20200327071202.2159885-25-alastair@d-silva.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327071202.2159885-1-alastair@d-silva.org>
References: <20200327071202.2159885-1-alastair@d-silva.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Fri, 27 Mar 2020 18:12:20 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch exposes the serial number & firmware version in sysfs,
which will be used by ndctl in userspace to help users identify
the device.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/nvdimm/ocxl/main.c | 42 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/ocxl/main.c b/drivers/nvdimm/ocxl/main.c
index 92b4389e8cbb..1f422f0d51ef 100644
--- a/drivers/nvdimm/ocxl/main.c
+++ b/drivers/nvdimm/ocxl/main.c
@@ -235,6 +235,43 @@ static int reserve_metadata(struct ocxlpmem *ocxlpmem,
 	return 0;
 }
 
+static ssize_t serial_show(struct device *device, struct device_attribute *attr,
+			   char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(device);
+	struct ocxlpmem *ocxlpmem = nvdimm_provider_data(nvdimm);
+	const struct ocxl_fn_config *fn_config = ocxl_function_config(ocxlpmem->ocxl_fn);
+
+	return scnprintf(buf, PAGE_SIZE, "%llu\n", fn_config->serial);
+}
+static DEVICE_ATTR_RO(serial);
+
+static ssize_t fw_version_show(struct device *device,
+			       struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(device);
+	struct ocxlpmem *ocxlpmem = nvdimm_provider_data(nvdimm);
+
+	return scnprintf(buf, PAGE_SIZE, "%s\n", ocxlpmem->fw_version);
+}
+static DEVICE_ATTR_RO(fw_version);
+
+static struct attribute *ocxl_pmem_attrs[] = {
+	&dev_attr_serial.attr,
+	&dev_attr_fw_version.attr,
+	NULL,
+};
+
+static const struct attribute_group ocxl_pmem_attribute_group = {
+	.name = "ocxlpmem",
+	.attrs = ocxl_pmem_attrs,
+};
+
+static const struct attribute_group *ocxl_pmem_dimm_attribute_groups[] = {
+	&ocxl_pmem_attribute_group,
+	NULL,
+};
+
 /**
  * register_lpc_mem() - Discover persistent memory on a device and register it with the NVDIMM subsystem
  * @ocxlpmem: the device metadata
@@ -291,8 +328,9 @@ static int register_lpc_mem(struct ocxlpmem *ocxlpmem)
 
 	snprintf(serial, sizeof(serial), "%llx", fn_config->serial);
 	nd_mapping_desc.nvdimm = nvdimm_create(ocxlpmem->nvdimm_bus, ocxlpmem,
-					       NULL, nvdimm_flags,
-					       nvdimm_cmd_mask, 0, NULL);
+					       ocxl_pmem_dimm_attribute_groups,
+					       nvdimm_flags, nvdimm_cmd_mask, 0,
+					       NULL);
 	if (!nd_mapping_desc.nvdimm)
 		return -ENOMEM;
 
-- 
2.24.1

