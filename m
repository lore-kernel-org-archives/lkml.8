Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD45EC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABB9720857
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="AMoIFXo6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636701AbgDPQOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:14:47 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:4082 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2636348AbgDPQOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:14:22 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GGDTaa026465;
        Thu, 16 Apr 2020 18:14:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=rdlFbvTHYiRhQAGAdaBWjnrQBxVGbSk8UU7HWs673BI=;
 b=AMoIFXo6eDSYO+z/GA7/VaaG8IzjMVl6iucdpL+KIj9VRm1gTVNgbMCfqBOVdIXUQ5A7
 nLKRy7DhZOWFlTkMTYdCfXB2MYL2L/hvqVk8Ow2UkpKPYxXNZyzWt4WavEhRG5meyod6
 xHLdYHzMuVzV34MlohhEGYncVwgtGh9T4TMw/NsEnsjXv/r8kpPmOJ3+Hjpg8HavRkoK
 HwVxYU2Ef1wu01BiVfUxVsPeGVRbWT7LjiYNPJYVRtLei9DzgOg+NUwdkCjtru+QgXA4
 gUz7Ahrz2rNyh8eMCykqyEH9qpLS7yvCQvUUiUorsCwseQ6tYgf6qPJmWBfd3gAwA5JB Pw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30dn8s3kn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 18:14:18 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 751AA10002A;
        Thu, 16 Apr 2020 18:14:18 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 686E62B2D2A;
        Thu, 16 Apr 2020 18:14:18 +0200 (CEST)
Received: from localhost (10.75.127.44) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Apr 2020 18:14:17
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [RFC 08/18] remoteproc: Externalize carveout functions
Date:   Thu, 16 Apr 2020 18:13:21 +0200
Message-ID: <20200416161331.7606-9-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416161331.7606-1-arnaud.pouliquen@st.com>
References: <20200416161331.7606-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_06:2020-04-14,2020-04-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The carveout functions are also used for the vring memories.
Externalize related functions to prepare migration of
the vring management in rproc virtio.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c     | 18 +++++++-----------
 drivers/remoteproc/remoteproc_internal.h |  4 ++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index cb40aae12b98..ac57cd8016be 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -51,11 +51,6 @@ static LIST_HEAD(rproc_list);
 typedef int (*rproc_handle_resource_t)(struct rproc *rproc,
 				 void *, int offset, int avail);
 
-static int rproc_alloc_carveout(struct rproc *rproc,
-				struct rproc_mem_entry *mem);
-static int rproc_release_carveout(struct rproc *rproc,
-				  struct rproc_mem_entry *mem);
-
 /* Unique indices for remoteproc devices */
 static DEFINE_IDA(rproc_dev_index);
 
@@ -281,8 +276,8 @@ rproc_find_carveout_by_name(struct rproc *rproc, const char *name, ...)
  *
  * Return: 0 if carveout matches request else error
  */
-static int rproc_check_carveout_da(struct rproc *rproc,
-				   struct rproc_mem_entry *mem, u32 da, u32 len)
+int rproc_check_carveout_da(struct rproc *rproc,
+			    struct rproc_mem_entry *mem, u32 da, u32 len)
 {
 	struct device *dev = &rproc->dev;
 	int delta;
@@ -315,6 +310,7 @@ static int rproc_check_carveout_da(struct rproc *rproc,
 
 	return 0;
 }
+EXPORT_SYMBOL(rproc_check_carveout_da);
 
 int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 {
@@ -695,8 +691,7 @@ static int rproc_handle_devmem(struct rproc *rproc, struct fw_rsc_devmem *rsc,
  * This function allocate specified memory entry @mem using
  * dma_alloc_coherent() as default allocator
  */
-static int rproc_alloc_carveout(struct rproc *rproc,
-				struct rproc_mem_entry *mem)
+int rproc_alloc_carveout(struct rproc *rproc, struct rproc_mem_entry *mem)
 {
 	struct rproc_mem_entry *mapping = NULL;
 	struct device *dev = &rproc->dev;
@@ -791,6 +786,7 @@ static int rproc_alloc_carveout(struct rproc *rproc,
 	dma_free_coherent(dev->parent, mem->len, va, dma);
 	return ret;
 }
+EXPORT_SYMBOL(rproc_alloc_carveout);
 
 /**
  * rproc_release_carveout() - release acquired carveout
@@ -800,8 +796,7 @@ static int rproc_alloc_carveout(struct rproc *rproc,
  * This function releases specified memory entry @mem allocated via
  * rproc_alloc_carveout() function by @rproc.
  */
-static int rproc_release_carveout(struct rproc *rproc,
-				  struct rproc_mem_entry *mem)
+int rproc_release_carveout(struct rproc *rproc, struct rproc_mem_entry *mem)
 {
 	struct device *dev = &rproc->dev;
 
@@ -809,6 +804,7 @@ static int rproc_release_carveout(struct rproc *rproc,
 	dma_free_coherent(dev->parent, mem->len, mem->va, mem->dma);
 	return 0;
 }
+EXPORT_SYMBOL(rproc_release_carveout);
 
 /**
  * rproc_handle_carveout() - handle phys contig memory allocation requests
diff --git a/drivers/remoteproc/remoteproc_internal.h b/drivers/remoteproc/remoteproc_internal.h
index f5eaffac2fcd..f230296908ac 100644
--- a/drivers/remoteproc/remoteproc_internal.h
+++ b/drivers/remoteproc/remoteproc_internal.h
@@ -71,6 +71,10 @@ struct resource_table *rproc_elf_find_loaded_rsc_table(struct rproc *rproc,
 						       const struct firmware *fw);
 struct rproc_mem_entry *
 rproc_find_carveout_by_name(struct rproc *rproc, const char *name, ...);
+int rproc_check_carveout_da(struct rproc *rproc, struct rproc_mem_entry *mem,
+			    u32 da, u32 len);
+int rproc_alloc_carveout(struct rproc *rproc, struct rproc_mem_entry *mem);
+int rproc_release_carveout(struct rproc *rproc, struct rproc_mem_entry *mem);
 
 static inline
 int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
-- 
2.17.1

