Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAECC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E39E2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eyYy5OkS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgFQDaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 23:30:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55627 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726703AbgFQDaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592364621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N+42FNXKIBA3SLmmXlWtUDtUR9h03h5BkA4akBDJ4BI=;
        b=eyYy5OkSER9A66xyZP4KRUMUg2VnaToBV/GDY6K0Q4YRAB54r1hyXezepPaA9bwwtl7FoD
        USVKS/Ryq80D4ZKi7+YK687ntdE+ZZtaE/Gismix43piG9CW+qPG2LxsfMtzmKBryCduXE
        /m0L2MF7xOD89S7pfCZmswiOpo0jSXQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-_Fs2v4dOOqel8S6cuann0w-1; Tue, 16 Jun 2020 23:30:20 -0400
X-MC-Unique: _Fs2v4dOOqel8S6cuann0w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14D2380F5E0;
        Wed, 17 Jun 2020 03:30:18 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com (ovpn-13-217.pek2.redhat.com [10.72.13.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 90CD45C1D4;
        Wed, 17 Jun 2020 03:30:04 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com
Subject: [PATCH 2/4] vdpa_sim: implement get_iova_range bus operation
Date:   Wed, 17 Jun 2020 11:29:45 +0800
Message-Id: <20200617032947.6371-3-jasowang@redhat.com>
In-Reply-To: <20200617032947.6371-1-jasowang@redhat.com>
References: <20200617032947.6371-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch implements get_iova_range method for vdpa_sim. Since
vdpa_sim is a software device, simply advertise a [0ULL, ~0ULL] range.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index c7334cc65bb2..b3a6dc5b9984 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -524,6 +524,16 @@ static u32 vdpasim_get_generation(struct vdpa_device *vdpa)
 	return vdpasim->generation;
 }
 
+static struct vdpa_iova_range vdpasim_get_iova_range(struct vdpa_device *vdpa)
+{
+	struct vdpa_iova_range range;
+
+	range.start = 0ULL;
+	range.end = ~0ULL;
+
+	return range;
+}
+
 static int vdpasim_set_map(struct vdpa_device *vdpa,
 			   struct vhost_iotlb *iotlb)
 {
@@ -597,6 +607,7 @@ static const struct vdpa_config_ops vdpasim_net_config_ops = {
 	.get_config             = vdpasim_get_config,
 	.set_config             = vdpasim_set_config,
 	.get_generation         = vdpasim_get_generation,
+	.get_iova_range         = vdpasim_get_iova_range,
 	.set_map                = vdpasim_set_map,
 	.dma_map                = vdpasim_dma_map,
 	.dma_unmap              = vdpasim_dma_unmap,
-- 
2.20.1

