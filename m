Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB98DC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D0322244
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="bcnSKedP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895476AbgDPQO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:14:58 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:4002 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2636557AbgDPQO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:14:29 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GGDTqs026413;
        Thu, 16 Apr 2020 18:14:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=eeai/sSDA7yw0YAME0STQXmQf2U/BhDMnF4JiuPgFGA=;
 b=bcnSKedPRhpuXMGraK7fOequ647brxc0twauwXsfPDLuUr6ADcgmdS7LFCYJk99eDQhL
 Y7WeZi/RWbBzeNmcen8C0lAJFOFIuMqlzOyCKtPbWbHt1iFbZxChtOJDYbmhBFIooe3m
 zBTaagj7COUYEBoPbnfRye7vRjLPa6XYdFyDpLILZqknErg994I4hh4gvw/bhZLbvde3
 wfSWzvQsFBJb8W1+MLdAOWcUJORX4xyohu5huMFlY4ikRAdHXPHE/raRq/3iCE/Z8xKV
 oL2LoTanrdBVCHbu2GhhI2T0TeTwRC+J/ucDp5Fuw/bED3/8/upTkr3Z/db01svb9Scs zA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30dn8s3knd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 18:14:26 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B56FC10002A;
        Thu, 16 Apr 2020 18:14:25 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AA3AD2B2D2A;
        Thu, 16 Apr 2020 18:14:25 +0200 (CEST)
Received: from localhost (10.75.127.45) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Apr 2020 18:14:25
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [RFC 13/18] remoteproc: Add memory default allocator helper
Date:   Thu, 16 Apr 2020 18:13:26 +0200
Message-ID: <20200416161331.7606-14-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416161331.7606-1-arnaud.pouliquen@st.com>
References: <20200416161331.7606-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_06:2020-04-14,2020-04-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a default basic allocator based on ioremap, to allocate
carveout memories. These functions can be used by
platforms that do not need specific management of the memory
region (no MPU, no IOMMU, ...)

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c     | 50 ++++++++++++++++++++++++
 drivers/remoteproc/remoteproc_internal.h |  2 +
 2 files changed, 52 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 9238aa292644..f9d04e59081c 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -220,6 +220,56 @@ void *rproc_da_to_va(struct rproc *rproc, u64 da, int len)
 }
 EXPORT_SYMBOL(rproc_da_to_va);
 
+/**
+ * rproc_default_mem_alloc() - Simple mmap of the memory
+ * @rproc: handle of a remote processor
+ * @mem: memory entry descriptor
+ *
+ * Memory allocator for  basic remote processors that do not need to manage
+ * specific memory allocation ( no MPU; no IOMMU, ....). In this case the
+ * memory is just mapped in in kernel space.
+ *
+ * Return: 0 on success else error
+ */
+int rproc_default_mem_alloc(struct rproc *rproc, struct rproc_mem_entry *mem)
+{
+	struct device *dev = rproc->dev.parent;
+	void *va;
+
+	dev_dbg(dev, "map memory: %pa+%x\n", &mem->dma, mem->len);
+	va = ioremap_wc(mem->dma, mem->len);
+	if (IS_ERR_OR_NULL(va)) {
+		dev_err(dev, "Unable to map memory region: %pa+%x\n",
+			&mem->dma, mem->len);
+		return -ENOMEM;
+	}
+
+	/* Update memory entry va */
+	mem->va = va;
+
+	return 0;
+}
+EXPORT_SYMBOL(rproc_default_mem_alloc);
+
+/**
+ * rproc_default_mem_release() - release of the mmaped memory
+ * @rproc: handle of a remote processor
+ * @mem: memory entry descriptor
+ *
+ * Memory release for  basic remote processors allocated by
+ * @rproc_default_mem_alloc
+ *
+ * Return: 0 on success else error
+ */
+int rproc_default_mem_release(struct rproc *rproc, struct rproc_mem_entry *mem)
+{
+	dev_dbg(rproc->dev.parent, "unmap memory: %pa\n", &mem->dma);
+	iounmap(mem->va);
+
+	return 0;
+}
+EXPORT_SYMBOL(rproc_default_mem_release);
+
 /**
  * rproc_find_carveout_by_name() - lookup the carveout region by a name
  * @rproc: handle of a remote processor
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index 5139cca646ca..608aeea564b4 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -65,6 +65,8 @@ int rproc_elf_load_segments(struct rproc *rproc, const struct firmware *fw);
 int rproc_elf_load_rsc_table(struct rproc *rproc, const struct firmware *fw);
 struct resource_table *rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
 						       const struct firmware *fw);
+int rproc_default_mem_alloc(struct rproc *rproc, struct rproc_mem_entry *mem);
+int rproc_default_mem_release(struct rproc *rproc, struct rproc_mem_entry *mem);
 struct rproc_mem_entry *
 rproc_find_carveout_by_name(struct rproc *rproc, const char *name, ...);
 int rproc_check_carveout_da(struct rproc *rproc, struct rproc_mem_entry *mem,
-- 
2.17.1

