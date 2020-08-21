Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024FDC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D17B92087D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 09:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X00bfB2H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgHUJ2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 05:28:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55426 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728461AbgHUJ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 05:28:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598002125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=JjMCOzpJotfhpqv5rwTIXLpouUojwObpb+Um6+p3l6o=;
        b=X00bfB2HtEnZd/lTuxC4yr7gzI+tnAV00o/5mkdVe6Zi4DGSE2FZP4A+PMff7DjCgskYwE
        MXRsi0FLhfwYyUyTIDJuJnHlZUzf+GyGMEQZW7/rn8/W3NCYUgfRs73/yVawOsj0CYkCeq
        Fjlub1DK0q+swnAYN+QT8XYYRnMXReg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-UHmgBtRlMzi2jd2R4zBR0A-1; Fri, 21 Aug 2020 05:28:43 -0400
X-MC-Unique: UHmgBtRlMzi2jd2R4zBR0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C195873084;
        Fri, 21 Aug 2020 09:28:42 +0000 (UTC)
Received: from hp-dl380pg8-01.lab.eng.pek2.redhat.com (hp-dl380pg8-01.lab.eng.pek2.redhat.com [10.73.8.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5BA2B7E30F;
        Fri, 21 Aug 2020 09:28:34 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     rob.miller@broadcom.com, lingshan.zhu@intel.com,
        eperezma@redhat.com, lulu@redhat.com, shahafs@mellanox.com,
        hanand@xilinx.com, mhabets@solarflare.com, gdawar@xilinx.com,
        saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn, eli@mellanox.com,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH V2 3/3] vdpa_sim: implement get_iova_range()
Date:   Fri, 21 Aug 2020 05:28:13 -0400
Message-Id: <20200821092813.8952-4-jasowang@redhat.com>
In-Reply-To: <20200821092813.8952-1-jasowang@redhat.com>
References: <20200821092813.8952-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 62d640327145..89854e17c3c2 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -574,6 +574,16 @@ static u32 vdpasim_get_generation(struct vdpa_device *vdpa)
 	return vdpasim->generation;
 }
 
+struct vdpa_iova_range vdpasim_get_iova_range(struct vdpa_device *vdpa)
+{
+	struct vdpa_iova_range range = {
+		.first = 0ULL,
+		.last = ULLONG_MAX,
+	};
+
+	return range;
+}
+
 static int vdpasim_set_map(struct vdpa_device *vdpa,
 			   struct vhost_iotlb *iotlb)
 {
@@ -657,6 +667,7 @@ static const struct vdpa_config_ops vdpasim_net_config_ops = {
 	.get_config             = vdpasim_get_config,
 	.set_config             = vdpasim_set_config,
 	.get_generation         = vdpasim_get_generation,
+	.get_iova_range         = vdpasim_get_iova_range,
 	.dma_map                = vdpasim_dma_map,
 	.dma_unmap              = vdpasim_dma_unmap,
 	.free                   = vdpasim_free,
@@ -683,6 +694,7 @@ static const struct vdpa_config_ops vdpasim_net_batch_config_ops = {
 	.get_config             = vdpasim_get_config,
 	.set_config             = vdpasim_set_config,
 	.get_generation         = vdpasim_get_generation,
+	.get_iova_range         = vdpasim_get_iova_range,
 	.set_map                = vdpasim_set_map,
 	.free                   = vdpasim_free,
 };
-- 
2.18.1

