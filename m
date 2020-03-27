Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9779C2D0EF
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 02:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6FC2071B
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 02:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="e6a1tDVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbgC2C2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 22:28:00 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:35186 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgC2C17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 22:27:59 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id BA61C2DC682C;
        Fri, 27 Mar 2020 18:12:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1585293141;
        bh=HzmhbcogFky5JzzjdOPameps3zKSn5YAqkFn77Y+Dc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e6a1tDVWViG1+jiUIoTsiKrTGAyowuWFrA0PCTXk1vQKOWbpPReJad1CLZS9xKu8k
         EFRmZjIT9KBKqhJkrXzSnapItH1lRVZy7d4h5SogWLOpKIlosNd+cPQnK9TV3acuos
         zvH+Z0Jlut8IdWJOA4nF0J+YX9ygI9d5FS8ft8Ug6UxQqC8bWv6iiR3IjAo4/tCohC
         q6050U+9dAQa8V/fLtJsr4zD3J9cetIFwB2t9713wyqkcLVixRwfD1DhTZ6rrH9Gyv
         3fE9mD/sde6wZE8pV1MUt+saA/POMeHIwdVv6C+e47d/WERR3wVblA+1tpoOAZ2brc
         QUZbjNYVZRNoVsybJoN8DiEnEeoxsuQStYY6tLmid9RvXWGFSoH3cdanT8y1/OqKLe
         46GQ4nBoOr41PkguF0htNeCUAgxiuWpgTfoTavWhM1SgpEVR/EyN7kN9W7/S1Dcbo0
         Qe7o34WtZWKvlH5TdnhdnIt9/lMP7k8XveBbJuZMAJZ2Cv1YDeBTlAVY+huyKrNSMD
         SiWAECLmjomCHrfZsez028Ik+Ie2blO70vTcKyUoMtX8jHzd2vInEfjMo8B5jgYIbN
         MvO4F6oDy8dvsMAqHvNygUygzyX0lLS6O/099IdPj6gQvdo5SHyLURRfpB+Orwi2kV
         n8/DM6ski3PsH/O+rPuOm8L8=
Received: from localhost.lan ([10.0.1.179])
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTP id 02R7C4Ai045934;
        Fri, 27 Mar 2020 18:12:16 +1100 (AEDT)
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
Subject: [PATCH v4 09/25] ocxl: Save the device serial number in ocxl_fn
Date:   Fri, 27 Mar 2020 18:11:46 +1100
Message-Id: <20200327071202.2159885-10-alastair@d-silva.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327071202.2159885-1-alastair@d-silva.org>
References: <20200327071202.2159885-1-alastair@d-silva.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Fri, 27 Mar 2020 18:12:16 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch retrieves the serial number of the card and makes it available
to consumers of the ocxl driver via the ocxl_fn struct.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
Acked-by: Frederic Barrat <fbarrat@linux.ibm.com>
Acked-by: Andrew Donnellan <ajd@linux.ibm.com>
---
 drivers/misc/ocxl/config.c | 46 ++++++++++++++++++++++++++++++++++++++
 include/misc/ocxl.h        |  1 +
 2 files changed, 47 insertions(+)

diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
index 69cca341d446..2b835e57daca 100644
--- a/drivers/misc/ocxl/config.c
+++ b/drivers/misc/ocxl/config.c
@@ -71,6 +71,51 @@ static int find_dvsec_afu_ctrl(struct pci_dev *dev, u8 afu_idx)
 	return 0;
 }
 
+/**
+ * get_function_0() - Find a related PCI device (function 0)
+ * @device: PCI device to match
+ *
+ * Returns a pointer to the related device, or null if not found
+ */
+static struct pci_dev *get_function_0(struct pci_dev *dev)
+{
+	unsigned int devfn = PCI_DEVFN(PCI_SLOT(dev->devfn), 0);
+
+	return pci_get_domain_bus_and_slot(pci_domain_nr(dev->bus),
+					   dev->bus->number, devfn);
+}
+
+static void read_serial(struct pci_dev *dev, struct ocxl_fn_config *fn)
+{
+	u32 low, high;
+	int pos;
+
+	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DSN);
+	if (pos) {
+		pci_read_config_dword(dev, pos + 0x04, &low);
+		pci_read_config_dword(dev, pos + 0x08, &high);
+
+		fn->serial = low | ((u64)high) << 32;
+
+		return;
+	}
+
+	if (PCI_FUNC(dev->devfn) != 0) {
+		struct pci_dev *related = get_function_0(dev);
+
+		if (!related) {
+			fn->serial = 0;
+			return;
+		}
+
+		read_serial(related, fn);
+		pci_dev_put(related);
+		return;
+	}
+
+	fn->serial = 0;
+}
+
 static void read_pasid(struct pci_dev *dev, struct ocxl_fn_config *fn)
 {
 	u16 val;
@@ -208,6 +253,7 @@ int ocxl_config_read_function(struct pci_dev *dev, struct ocxl_fn_config *fn)
 	int rc;
 
 	read_pasid(dev, fn);
+	read_serial(dev, fn);
 
 	rc = read_dvsec_tl(dev, fn);
 	if (rc) {
diff --git a/include/misc/ocxl.h b/include/misc/ocxl.h
index d8b0b4d46bfb..b8514dc64bd0 100644
--- a/include/misc/ocxl.h
+++ b/include/misc/ocxl.h
@@ -46,6 +46,7 @@ struct ocxl_fn_config {
 	int dvsec_afu_info_pos; /* offset of the AFU information DVSEC */
 	s8 max_pasid_log;
 	s8 max_afu_index;
+	u64 serial;
 };
 
 enum ocxl_endian {
-- 
2.24.1

