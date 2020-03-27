Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FD6C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 05:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84A3320733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 05:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=d-silva.org header.i=@d-silva.org header.b="kC/+/w08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbgC3FW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 01:22:58 -0400
Received: from ushosting.nmnhosting.com ([66.55.73.32]:39382 "EHLO
        ushosting.nmnhosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727706AbgC3FW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 01:22:58 -0400
Received: from mail2.nmnhosting.com (unknown [202.169.106.97])
        by ushosting.nmnhosting.com (Postfix) with ESMTPS id 7A6E42DC682A;
        Fri, 27 Mar 2020 18:12:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=d-silva.org;
        s=201810a; t=1585293141;
        bh=+19ERjJVKb04vm4biVoKIgTzaFpr9UkwgZhCwlBFNZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kC/+/w081uhGq50IGkocqjNtFwFT1jfxjvZzedjpb8Zv7xxpRYbzhpwskvozUByYX
         t1UJjPknJOIK7/+aPNJSLi6XUVox4iV1VJGSrm9Uj3vTDCzhS9i/TOfK53MveelFAp
         bko/gKfzyjxtjuza/Zzfg3Lazv0GZ3jjrrXWCwg1vWGqkSIUVixWnbTR0MM7DkIYv3
         zFps93hBiRICgFLlR41gopwn4qGl98D54wGKy1XO2IDsZXDn+oys9f7szHubl2erxM
         98hazA7s2Hun5cwyF6UOwhIe8q33x097i9e5n+Rf5dLtx5rgNYv7jDOjsRKzeUUWlG
         QJtJdRZQpQ31k0EmXeQHJNxR5CcCfaSVkJEql1R4IJPneJz+k6VO55PzRXId+c+3Px
         jsmelTImM2q0z1bIl+aQUc38mZExstNx7apQSEylv5bAFmaRgbbpPWuz/9an1KZub8
         Qzb9tJxzQmy5RvMKkAtuGKgUxYeA09K4wgOVNYnoBytc1Q07/DzuM4Np1Eq88rqcTp
         81BizxxTLWlPoA9bTIfVasmLRUIxGJ5ZA+2wwklqRXTwAd2lZZB446Y4Rfva5ONbNx
         2lC2CPiWB8qxGj796Eq1C0STbZHYpgpbtTNAlfrufYLT7q3aruf3ZSbLGO9v8DSjI7
         /UOdhgZ/mEaSk8QieEOClM90=
Received: from localhost.lan ([10.0.1.179])
        by mail2.nmnhosting.com (8.15.2/8.15.2) with ESMTP id 02R7C4Ac045934;
        Fri, 27 Mar 2020 18:12:14 +1100 (AEDT)
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
Subject: [PATCH v4 03/25] powerpc/powernv: Map & release OpenCAPI LPC memory
Date:   Fri, 27 Mar 2020 18:11:40 +1100
Message-Id: <20200327071202.2159885-4-alastair@d-silva.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200327071202.2159885-1-alastair@d-silva.org>
References: <20200327071202.2159885-1-alastair@d-silva.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mail2.nmnhosting.com [10.0.1.20]); Fri, 27 Mar 2020 18:12:14 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds OPAL calls to powernv so that the OpenCAPI
driver can map & release LPC (Lowest Point of Coherency)  memory.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
Reviewed-by: Andrew Donnellan <ajd@linux.ibm.com>
---
 arch/powerpc/include/asm/pnv-ocxl.h   |  2 ++
 arch/powerpc/platforms/powernv/ocxl.c | 43 +++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/powerpc/include/asm/pnv-ocxl.h b/arch/powerpc/include/asm/pnv-ocxl.h
index 7de82647e761..560a19bb71b7 100644
--- a/arch/powerpc/include/asm/pnv-ocxl.h
+++ b/arch/powerpc/include/asm/pnv-ocxl.h
@@ -32,5 +32,7 @@ extern int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle)
 
 extern int pnv_ocxl_alloc_xive_irq(u32 *irq, u64 *trigger_addr);
 extern void pnv_ocxl_free_xive_irq(u32 irq);
+u64 pnv_ocxl_platform_lpc_setup(struct pci_dev *pdev, u64 size);
+void pnv_ocxl_platform_lpc_release(struct pci_dev *pdev);
 
 #endif /* _ASM_PNV_OCXL_H */
diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
index 8c65aacda9c8..f13119a7c026 100644
--- a/arch/powerpc/platforms/powernv/ocxl.c
+++ b/arch/powerpc/platforms/powernv/ocxl.c
@@ -475,6 +475,49 @@ void pnv_ocxl_spa_release(void *platform_data)
 }
 EXPORT_SYMBOL_GPL(pnv_ocxl_spa_release);
 
+u64 pnv_ocxl_platform_lpc_setup(struct pci_dev *pdev, u64 size)
+{
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	u32 bdfn = pci_dev_id(pdev);
+	__be64 base_addr_be64;
+	u64 base_addr;
+	int rc;
+
+	rc = opal_npu_mem_alloc(phb->opal_id, bdfn, size, &base_addr_be64);
+	if (rc) {
+		dev_warn(&pdev->dev,
+			 "OPAL could not allocate LPC memory, rc=%d\n", rc);
+		return 0;
+	}
+
+	base_addr = be64_to_cpu(base_addr_be64);
+
+#ifdef CONFIG_MEMORY_HOTPLUG_SPARSE
+	rc = check_hotplug_memory_addressable(base_addr >> PAGE_SHIFT,
+					      size >> PAGE_SHIFT);
+	if (rc)
+		return 0;
+#endif
+
+	return base_addr;
+}
+EXPORT_SYMBOL_GPL(pnv_ocxl_platform_lpc_setup);
+
+void pnv_ocxl_platform_lpc_release(struct pci_dev *pdev)
+{
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	u32 bdfn = pci_dev_id(pdev);
+	int rc;
+
+	rc = opal_npu_mem_release(phb->opal_id, bdfn);
+	if (rc)
+		dev_warn(&pdev->dev,
+			 "OPAL reported rc=%d when releasing LPC memory\n", rc);
+}
+EXPORT_SYMBOL_GPL(pnv_ocxl_platform_lpc_release);
+
 int pnv_ocxl_spa_remove_pe_from_cache(void *platform_data, int pe_handle)
 {
 	struct spa_data *data = (struct spa_data *) platform_data;
-- 
2.24.1

