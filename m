Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CD7C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D9A92078E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 16:07:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="C3VoeExZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgDTQHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:07:36 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54350 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgDTQHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 12:07:36 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03KG7S4s089873;
        Mon, 20 Apr 2020 11:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587398848;
        bh=lcvEvtPwtP61yUBg+r2EgVAD5UpkYUAqN8eUwsfynf4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=C3VoeExZcdGJCtyAZfthp1DwYbpsS5Bfigy902ZTf1i4To3bRBELXziW22+Qp7NMS
         zSJO1cva/CRkTQNtzizuHnwIJfxH53+RAIh59U5bpxm7iq5d9U+mfL/OkBPBNFNbtH
         S7A940LNwZo0BXKz/4nE54Trzw1JDgbCObsLxSpQ=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03KG7STS127053
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Apr 2020 11:07:28 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 20
 Apr 2020 11:06:09 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 20 Apr 2020 11:06:09 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03KG691s005433;
        Mon, 20 Apr 2020 11:06:09 -0500
Received: from localhost ([10.250.70.56])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 03KG69LA128209;
        Mon, 20 Apr 2020 11:06:09 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Tero Kristo <t-kristo@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH v3 1/2] remoteproc: Fall back to using parent memory pool if no dedicated available
Date:   Mon, 20 Apr 2020 11:05:59 -0500
Message-ID: <20200420160600.10467-2-s-anna@ti.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200420160600.10467-1-s-anna@ti.com>
References: <20200420160600.10467-1-s-anna@ti.com>
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
v3:
 - Go back to v1 logic (removed the vdevbuf_mem_id variable added in v2)
 - Revised the comment to remove references to vdevbuf_mem_id
 - Capitalize the patch header
v2: https://patchwork.kernel.org/patch/11447651/

 drivers/remoteproc/remoteproc_virtio.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index e61d738d9b47..44187fe43677 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -376,6 +376,18 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
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
+		 * the rvdev dev to allocate from. Failure is non-critical and
+		 * the allocations will fall back to global pools, so don't
+		 * check return value either.
+		 */
+		of_reserved_mem_device_init_by_idx(dev, np, 0);
 	}
 
 	/* Allocate virtio device */
-- 
2.26.0

