Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E74DC4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:23:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2145C2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="UWKk46eV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgCSQXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:23:34 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39032 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbgCSQXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 12:23:31 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02JGNRSY087050;
        Thu, 19 Mar 2020 11:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584635007;
        bh=InLyviOkfFOPkDrw3fsPx+IycNhWr/qvF9UvPT91rPQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=UWKk46eVJesUFUnliJecoZN01llOhTN+aRKM3g76mu04W7PPR/KuPD4aiszhfEPEk
         AMU9Qw6+/8lpVNXO9w7x2oIPQabg/4uGF4grRSD/FDtEB/Ds+RPNEXsNVLenczBZEk
         T4cEoTvgrRA9Kj+5buRnF78J+VpiUILfgh39ss3E=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02JGNR5v096819
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 19 Mar 2020 11:23:27 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Mar 2020 11:23:27 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Mar 2020 11:23:27 -0500
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02JGNR8w100125;
        Thu, 19 Mar 2020 11:23:27 -0500
Received: from localhost ([10.250.86.212])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 02JGNQrH066554;
        Thu, 19 Mar 2020 11:23:26 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Tero Kristo <t-kristo@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH v2 2/2] remoteproc: Fix and restore the parenting hierarchy for vdev
Date:   Thu, 19 Mar 2020 11:23:21 -0500
Message-ID: <20200319162321.20632-3-s-anna@ti.com>
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
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
v2: No code changes, picked up review tags
v1: https://patchwork.kernel.org/patch/11422725/

 drivers/remoteproc/remoteproc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index a9ac1d01e09b..0962855f27fc 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -514,7 +514,7 @@ static int rproc_handle_vdev(struct rproc *rproc, struct fw_rsc_vdev *rsc,
 
 	/* Initialise vdev subdevice */
 	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
-	rvdev->dev.parent = rproc->dev.parent;
+	rvdev->dev.parent = &rproc->dev;
 	rvdev->dev.dma_pfn_offset = rproc->dev.parent->dma_pfn_offset;
 	rvdev->dev.release = rproc_rvdev_release;
 	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);
-- 
2.23.0

