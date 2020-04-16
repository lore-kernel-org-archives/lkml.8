Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A9CC2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DDD920771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 16:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="SoBzXXW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896164AbgDPQPV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:15:21 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:46915 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2440769AbgDPQOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 12:14:34 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03GGCFEW010375;
        Thu, 16 Apr 2020 18:14:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=vcBb3r+viNdyKV64k5Eo4jYHRVkTS6JjhvXLvx/2TH8=;
 b=SoBzXXW/u/aE2SWP3JwtzkUOQ+sPDRadWKLF9Gz5UhHA4quSzVHdetdyKoeHnUarJVdQ
 peJEEcO32DQ9TwMqgC7hHYB7NIe4fUpu/E6jJiGfzBQvefesaVG9CJmY6tsHdlf9wePv
 l9L+P4LLpZZlWKpOmuU/tc7sja6caj1xmrd6RZxktms6ZVaX6v7TNTL9mUAIVpQ/vU6T
 vJiMj8ZSGwXK9fIvIr2EhUyEYrREIDNFTDwD/+ng0u4HaKmg9EQrizq4UL9bpUn5hXn2
 y/st/+DLF8CmmS0G9uzQFg67yAV1nrl82rjz1GFrVPisLsAMJEF9j7GlvodnrVJZiwEQ Aw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30dn94kmx3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Apr 2020 18:14:30 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 37B8010002A;
        Thu, 16 Apr 2020 18:14:30 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 206082B2D2C;
        Thu, 16 Apr 2020 18:14:30 +0200 (CEST)
Received: from localhost (10.75.127.47) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 Apr 2020 18:14:29
 +0200
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <arnaud.pouliquen@st.com>
Subject: [RFC 15/18] remoteproc: associate memory entry to a device
Date:   Thu, 16 Apr 2020 18:13:28 +0200
Message-ID: <20200416161331.7606-16-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200416161331.7606-1-arnaud.pouliquen@st.com>
References: <20200416161331.7606-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-16_06:2020-04-14,2020-04-16 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mem entry could be registered at different levels, platform driver
or virtio device itself.
Add device information in rproc_mem_entry struct to retrieve a memory
region registered by another device.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c   | 2 ++
 drivers/remoteproc/remoteproc_virtio.c | 2 +-
 include/linux/remoteproc.h             | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 72fb97f28048..e72d681033d3 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -892,6 +892,7 @@ rproc_mem_entry_init(struct device *dev,
 	if (!mem)
 		return mem;
 
+	mem->dev = dev;
 	mem->va = va;
 	mem->dma = dma;
 	mem->da = da;
@@ -932,6 +933,7 @@ rproc_of_resm_mem_entry_init(struct device *dev, u32 of_resm_idx, int len,
 	if (!mem)
 		return mem;
 
+	mem->dev = dev;
 	mem->da = da;
 	mem->len = len;
 	mem->rsc_offset = FW_RSC_ADDR_ANY;
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 4634cd63d547..0fd938afd146 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -439,7 +439,7 @@ static int rproc_vitio_start(struct rproc_subdev *subdev)
 		phys_addr_t pa;
 
 		if (mem->of_resm_idx != -1) {
-			struct device_node *np = rproc->dev.parent->of_node;
+			struct device_node *np = mem->dev->of_node;
 
 			/* Associate reserved memory to vdev device */
 			ret = of_reserved_mem_device_init_by_idx(dev, np,
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 7b8a6c3ef519..36abc9bc4def 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -331,6 +331,7 @@ struct rproc_mem_entry {
 	dma_addr_t dma;
 	int len;
 	u32 da;
+	struct device *dev;
 	void *priv;
 	char name[32];
 	struct list_head node;
-- 
2.17.1

