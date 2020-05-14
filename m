Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFA15C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:26:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0E0F205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cVwKQqYo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgENH0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 03:26:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35002 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725909AbgENH0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 03:26:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589441159;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=z22Wqt719gzXO2RzDZasKjbiB6qd6XqJTkPElK0QqYg=;
        b=cVwKQqYotTK08vNqIq5z1XLxOfLEouO37AjXo1msbGan0AbAeOD3NkKDapmBkfV3vM1gNU
        POwz97QmCNs3kKXdfg2avYbLe9EtjntRpF0Hgcv7Teu7vlXLrHgI/ltH2ExjEKgrpG8R6K
        +j+BzVOB5QiRrB4E9X+n+iI68fhUxkU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-1SZ4swkBOJa4iBMd9c1R7A-1; Thu, 14 May 2020 03:25:57 -0400
X-MC-Unique: 1SZ4swkBOJa4iBMd9c1R7A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E630A0BD8;
        Thu, 14 May 2020 07:25:56 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-12-133.pek2.redhat.com [10.72.12.133])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BEFE52BFF0;
        Thu, 14 May 2020 07:25:51 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vdpa_sim: do not reset IOTLB during device reset
Date:   Thu, 14 May 2020 15:25:49 +0800
Message-Id: <20200514072549.29694-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We reset IOTLB during device reset this breaks the assumption that the
mapping needs to be controlled via vDPA DMA ops explicitly in a
incremental way. So the networking will be broken after e.g a guest
reset.

Fix this by not resetting the IOTLB during device reset.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 7957d2d41fc4..cc5525743a25 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -119,8 +119,6 @@ static void vdpasim_reset(struct vdpasim *vdpasim)
 	for (i = 0; i < VDPASIM_VQ_NUM; i++)
 		vdpasim_vq_reset(&vdpasim->vqs[i]);
 
-	vhost_iotlb_reset(vdpasim->iommu);
-
 	vdpasim->features = 0;
 	vdpasim->status = 0;
 	++vdpasim->generation;
-- 
2.20.1

