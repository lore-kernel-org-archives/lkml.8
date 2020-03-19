Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB83C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01AC62072C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TfC6MYlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgCSQXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:23:33 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:56776 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbgCSQXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 12:23:31 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02JGNQ74025510;
        Thu, 19 Mar 2020 11:23:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584635006;
        bh=lGsXIdBBDeCl9BXLknAF5FNesbgy4vakhzEJrnxzea8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=TfC6MYlLf+Wh7U6hUUViricRMheByV5hxwEWBkxhXOev+bLRVVcKEQiztt+XPkR0e
         BaTTLaBsvci/SiUcAmRVCGgqZVys4e+HJ8/Nd5Alyxvp3DEIebNd51/Qd1Fc53iTDW
         RDsAWLy2WnJStEnLCNsj01vASXtXFGkp9pEGCbl4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02JGNQCP007186
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Mar 2020 11:23:26 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Mar 2020 11:23:25 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Mar 2020 11:23:26 -0500
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02JGNQQa037838;
        Thu, 19 Mar 2020 11:23:26 -0500
Received: from localhost ([10.250.86.212])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 02JGNPOb066549;
        Thu, 19 Mar 2020 11:23:25 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Tero Kristo <t-kristo@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 1/2] remoteproc: fall back to using parent memory pool if no dedicated available
Date:   Thu, 19 Mar 2020 11:23:20 -0500
Message-ID: <20200319162321.20632-2-s-anna@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200319162321.20632-1-s-anna@ti.com>
References: <20200319162321.20632-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tero Kristo <t-kristo@ti.com>

In some cases, like with OMAP remoteproc, we are not creating dedicated
memory pool for the virtio device. Instead, we use the same memory pool
for all shared memories. The current virtio memory pool handling forces
a split between these two, as a separate device is created for it,
causing memory to be allocated from bad location if the dedicated pool
is not available. Fix this by falling back to using the parent device
memory pool if dedicated is not available.

Fixes: 086d08725d34 ("remoteproc: create vdev subdevice with specific dma memory pool")
Signed-off-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
v2:
 - Address Arnaud's concerns about hard-coded memory-region index 0
 - Update the comment around the new code addition
v1: https://patchwork.kernel.org/patch/11422721/

 drivers/remoteproc/remoteproc_virtio.c | 15 +++++++++++++++
 include/linux/remoteproc.h             |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index eb817132bc5f..b687715cdf4b 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -369,6 +369,21 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
 				goto out;
 			}
 		}
+	} else {
+		struct device_node *np = rproc->dev.parent->of_node;
+
+		/*
+		 * If we don't have dedicated buffer, just attempt to re-assign
+		 * the reserved memory from our parent. A default memory-region
+		 * at index 0 from the parent's memory-regions is assigned for
+		 * the rvdev dev to allocate from, and this can be customized
+		 * by updating the vdevbuf_mem_id in platform drivers if
+		 * desired. Failure is non-critical and the allocations will
+		 * fall back to global pools, so don't check return value
+		 * either.
+		 */
+		of_reserved_mem_device_init_by_idx(dev, np,
+						   rproc->vdevbuf_mem_id);
 	}
 
 	/* Allocate virtio device */
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index ed127b2d35ca..07bd73a6d72a 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -481,6 +481,7 @@ struct rproc_dump_segment {
  * @auto_boot: flag to indicate if remote processor should be auto-started
  * @dump_segments: list of segments in the firmware
  * @nb_vdev: number of vdev currently handled by rproc
+ * @vdevbuf_mem_id: default memory-region index for allocating vdev buffers
  */
 struct rproc {
 	struct list_head node;
@@ -514,6 +515,7 @@ struct rproc {
 	bool auto_boot;
 	struct list_head dump_segments;
 	int nb_vdev;
+	u8 vdevbuf_mem_id;
 	u8 elf_class;
 };
 
-- 
2.23.0

