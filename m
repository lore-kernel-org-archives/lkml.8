Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDC6C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E19B222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 16:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="ZY/pYxop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgANQCA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 11:02:00 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:52378 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbgANQCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 11:02:00 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00EFqmCZ023389;
        Tue, 14 Jan 2020 17:01:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=STMicroelectronics;
 bh=KeXOO+1WsfSVo0lfgop46WH6FenYc5RdLaETc/7oy0w=;
 b=ZY/pYxopehsbFtLy9zZF2soSTNe9ZZk4v9ojulZb0OZ5Z8+cHXdwYrLeIt2M8+BWMwFL
 jqUUL45B5zuREzBCE1fDggznSHgTYheUfuPULOT2pf9V7uGs9+gwNNvvR5HiErFbMENC
 SAPkWGR+Smizh2j2WOm+2zQOKyrlyDf5DBvSNuUateFgY/AvsGPoIJwxiqgLtLUhWqlO
 vt0TcM8YSVENgS6rHxVQPNy0+YSnN5JP9txtAY66sw0kRFGnXZvEY0uD3taTGBL9bjes
 d+otxUxZH7hr+zjEqYrYs1KpMaCZrd57Ixa+U9HEsxqlfLJOIJGM87r6sYCocasoDOlh 4g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2xf7jpebc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jan 2020 17:01:41 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 34DBA100039;
        Tue, 14 Jan 2020 17:01:40 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 241252C38AA;
        Tue, 14 Jan 2020 17:01:40 +0100 (CET)
Received: from localhost (10.75.127.45) by SFHDAG3NODE3.st.com (10.75.127.9)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 14 Jan 2020 17:01:39
 +0100
From:   Benjamin Gaignard <benjamin.gaignard@st.com>
To:     <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <airlied@linux.ie>, <daniel@ffwll.ch>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] drm: fix parameters documentation style
Date:   Tue, 14 Jan 2020 17:01:35 +0100
Message-ID: <20200114160135.14990-1-benjamin.gaignard@st.com>
X-Mailer: git-send-email 2.15.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG3NODE3.st.com
 (10.75.127.9)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_04:2020-01-14,2020-01-14 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove old documentation style and use new one to avoid warnings when
compiling with W=1

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
CC: Randy Dunlap <rdunlap@infradead.org>
version 2:
- fix return documentation

 drivers/gpu/drm/drm_dma.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/drm_dma.c b/drivers/gpu/drm/drm_dma.c
index e45b07890c5a..a7add55a85b4 100644
--- a/drivers/gpu/drm/drm_dma.c
+++ b/drivers/gpu/drm/drm_dma.c
@@ -42,10 +42,10 @@
 #include "drm_legacy.h"
 
 /**
- * Initialize the DMA data.
+ * drm_legacy_dma_setup() - Initialize the DMA data.
  *
- * \param dev DRM device.
- * \return zero on success or a negative value on failure.
+ * @dev: DRM device.
+ * Return: zero on success or a negative value on failure.
  *
  * Allocate and initialize a drm_device_dma structure.
  */
@@ -71,9 +71,9 @@ int drm_legacy_dma_setup(struct drm_device *dev)
 }
 
 /**
- * Cleanup the DMA resources.
+ * drm_legacy_dma_takedown() - Cleanup the DMA resources.
  *
- * \param dev DRM device.
+ * @dev: DRM device.
  *
  * Free all pages associated with DMA buffers, the buffers and pages lists, and
  * finally the drm_device::dma structure itself.
@@ -120,10 +120,10 @@ void drm_legacy_dma_takedown(struct drm_device *dev)
 }
 
 /**
- * Free a buffer.
+ * drm_legacy_free_buffer() - Free a buffer.
  *
- * \param dev DRM device.
- * \param buf buffer to free.
+ * @dev: DRM device.
+ * @buf: buffer to free.
  *
  * Resets the fields of \p buf.
  */
@@ -139,9 +139,10 @@ void drm_legacy_free_buffer(struct drm_device *dev, struct drm_buf * buf)
 }
 
 /**
- * Reclaim the buffers.
+ * drm_legacy_reclaim_buffers() - Reclaim the buffers.
  *
- * \param file_priv DRM file private.
+ * @dev: DRM device.
+ * @file_priv: DRM file private.
  *
  * Frees each buffer associated with \p file_priv not already on the hardware.
  */
-- 
2.15.0

