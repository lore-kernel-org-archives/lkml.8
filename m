Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9A2FC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EFF1206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HkYQcweB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgCEWlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:41:23 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49160 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgCEWlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:41:20 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 025MfHC2128546;
        Thu, 5 Mar 2020 16:41:17 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583448077;
        bh=xLnhFXjcntooqJEdFx6nrAVNHWk6LDOKQ7ZIRr8tZrc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=HkYQcweBCpizFmpL+mWD/faZrLtKoAIhAHEm7TvhfOt6zz6UG2Qv/Jv3/Z3u8XMEY
         SNzC2FMGpncnvBYLl9Fii3xhanZABmHXeoj6DfUtd5mouU+voMWO7GxUibLgGwEAKm
         r+my3HLz8qrRyJT919dttANLC15T4joHumQ7t/8U=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 025MfHb3027248
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Mar 2020 16:41:17 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 5 Mar
 2020 16:41:16 -0600
Received: from localhost.localdomain (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 5 Mar 2020 16:41:16 -0600
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 025MfG0c003914;
        Thu, 5 Mar 2020 16:41:16 -0600
Received: from localhost (irmo.dhcp.ti.com [128.247.81.254])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 025MfGog098953;
        Thu, 5 Mar 2020 16:41:16 -0600
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Tero Kristo <t-kristo@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH 2/2] remoteproc: Fix and restore the parenting hierarchy for vdev
Date:   Thu, 5 Mar 2020 16:41:08 -0600
Message-ID: <20200305224108.21351-3-s-anna@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200305224108.21351-1-s-anna@ti.com>
References: <20200305224108.21351-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 086d08725d34 ("remoteproc: create vdev subdevice with specific
dma memory pool") has introduced a new vdev subdevice for each vdev
declared in the firmware resource table and made it as the parent for the
created virtio rpmsg devices instead of the previous remoteproc device.
This changed the overall parenting hierarchy for the rpmsg devices, which
were children of virtio devices, and does not allow the corresponding
rpmsg drivers to retrieve the parent rproc device through the
rproc_get_by_child() API.

Fix this by restoring the remoteproc device as the parent. The new vdev
subdevice can continue to inherit the DMA attributes from the remoteproc's
parent device (actual platform device).

Fixes: 086d08725d34 ("remoteproc: create vdev subdevice with specific dma memory pool")
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/remoteproc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 097f33e4f1f3..ba18f32bd0c4 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -510,7 +510,7 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 
 	/* Initialise vdev subdevice */
 	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
-	rvdev->dev.parent = rproc->dev.parent;
+	rvdev->dev.parent = &rproc->dev;
 	rvdev->dev.dma_pfn_offset = rproc->dev.parent->dma_pfn_offset;
 	rvdev->dev.release = rproc_rvdev_release;
 	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
-- 
2.23.0

