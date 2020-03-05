Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45435C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9DD206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 22:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wqa6CYXe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgCEWlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 17:41:19 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49158 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbgCEWlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 17:41:19 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 025MfG8V128542;
        Thu, 5 Mar 2020 16:41:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583448076;
        bh=UDxDPhpvCVuvdegOP8p0ZmjTKioDGinq2lw5CQF6aq8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wqa6CYXeXa9JlCz+7P86soPxQKNzNeWney8R2aLj8/zvf13t46wLev/YNxPgS7LNY
         wxQ7WsWs56ngWohUFD91GOSPxDZPbwFidOdTwoWYr8tWlHXyRgGVNfa4emNlMue94f
         tc74kOPdlAM3qPW5XOc9XmgIVLK9yS8N7bPworsw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 025MfGNN102981
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 5 Mar 2020 16:41:16 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 5 Mar
 2020 16:41:15 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 5 Mar 2020 16:41:15 -0600
Received: from lelv0597.itg.ti.com (lelv0597.itg.ti.com [10.181.64.32])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 025MfFKR026645;
        Thu, 5 Mar 2020 16:41:15 -0600
Received: from localhost (irmo.dhcp.ti.com [128.247.81.254])
        by lelv0597.itg.ti.com (8.14.7/8.14.7) with ESMTP id 025MfFPC098950;
        Thu, 5 Mar 2020 16:41:15 -0600
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Pallardy <loic.pallardy@st.com>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Tero Kristo <t-kristo@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/2] remoteproc: fall back to using parent memory pool if no dedicated available
Date:   Thu, 5 Mar 2020 16:41:07 -0600
Message-ID: <20200305224108.21351-2-s-anna@ti.com>
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
 drivers/remoteproc/remoteproc_virtio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 8c07cb2ca8ba..4723ebe574b8 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -368,6 +368,16 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev, int id)
 				goto out;
 			}
 		}
+	} else {
+		struct device_node *np = rproc->dev.parent->of_node;
+
+		/*
+		 * If we don't have dedicated buffer, just attempt to
+		 * re-assign the reserved memory from our parent.
+		 * Failure is non-critical so don't check return value
+		 * either.
+		 */
+		of_reserved_mem_device_init_by_idx(dev, np, 0);
 	}
 
 	/* Allocate virtio device */
-- 
2.23.0

