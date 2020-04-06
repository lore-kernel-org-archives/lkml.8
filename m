Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E23C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3A920768
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NFSSmi+/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgDFVC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:02:29 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22276 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726663AbgDFVCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586206943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c0TsndpJVTVi+maigb4wqF83+v7IC6vuTnjCeLiosRo=;
        b=NFSSmi+/cfeX8LSNJYZoRa01FAfMatZ9O5vahKxXEJcFYeSnGt1XsL9B/MLBbGMnBxoU5M
        FemcW1v28pQbHUwkEBKv9lIz4s8CChiRRwSGtVvj5al1Lb+agXVrAuhoutng32gLoi3DAV
        pyerZBJPnhcODbS5Uq1Dcjl3WFKalXM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-504-KHp3wko3NymMNVJYrFjNiw-1; Mon, 06 Apr 2020 17:02:21 -0400
X-MC-Unique: KHp3wko3NymMNVJYrFjNiw-1
Received: by mail-wr1-f71.google.com with SMTP id y6so510327wrq.21
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c0TsndpJVTVi+maigb4wqF83+v7IC6vuTnjCeLiosRo=;
        b=cYMY3EBztiR03l+fr2X7YJj69Ztlx8B/LW0j89FsASG4rV9PgHR8hlS0ecmp7+LN3O
         knbwc2AFk9jlLmPEcwM9JOXigW9UA7/1KAhBa7mx0OylxR8CgISy43JVYCVmD+I/bEq/
         DqnnvxiuCKSPmtRDaHn7I8frpKxT/0enmFQYei0MKh/KIj63EZwO3QH89SQZrOEpHGrR
         HrCZkofHMkxOtiRn8kJxq3M6RgKPSVuJRgf7qgpoKsdlqBaVNAyycX5rsNKEpGaIx4ei
         h9GVo/HtPikBPJ5tz79eTUIyyRnBfs5Gtw1rdxXRY8SkwBopztSL+iiatz6xPONId3Bf
         VsNA==
X-Gm-Message-State: AGi0Pua5tkTdtbhqGZRHWOp6Nyvvl3vkkPs4Jh3pjw8uq/m9FBYNqWJ4
        hL5RFqP0qCn7MKp7yL+0ctEGIyWCrqNSaKv4W55I65HbJaFrIMtba+dBT3UHhnFZnxXSAALQjDa
        ZOQWVbwVFYf5E0N8jpxg4/XQl
X-Received: by 2002:a05:6000:105:: with SMTP id o5mr1140872wrx.395.1586206940298;
        Mon, 06 Apr 2020 14:02:20 -0700 (PDT)
X-Google-Smtp-Source: APiQypKIrPYFPbzjPlWje3cehQSPwSKmpRF4J8aJ0cjsFyb5G1zSVTqx+JyfqOMTdrfebQUwk8AetQ==
X-Received: by 2002:a05:6000:105:: with SMTP id o5mr1140841wrx.395.1586206939931;
        Mon, 06 Apr 2020 14:02:19 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id z3sm922928wma.22.2020.04.06.14.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:02:18 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:02:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v4 12/12] mellanox: switch to virtio_legacy_init/size
Message-ID: <20200406210108.148131-13-mst@redhat.com>
References: <20200406210108.148131-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406210108.148131-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are used for legacy ring format, switch to APIs that make this
explicit.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/platform/mellanox/mlxbf-tmfifo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
index 5739a9669b29..f42b1fb713f1 100644
--- a/drivers/platform/mellanox/mlxbf-tmfifo.c
+++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
@@ -214,7 +214,7 @@ static void mlxbf_tmfifo_free_vrings(struct mlxbf_tmfifo *fifo,
 	for (i = 0; i < ARRAY_SIZE(tm_vdev->vrings); i++) {
 		vring = &tm_vdev->vrings[i];
 		if (vring->va) {
-			size = vring_size(vring->num, vring->align);
+			size = vring_legacy_size(vring->num, vring->align);
 			dma_free_coherent(tm_vdev->vdev.dev.parent, size,
 					  vring->va, vring->dma);
 			vring->va = NULL;
@@ -245,7 +245,7 @@ static int mlxbf_tmfifo_alloc_vrings(struct mlxbf_tmfifo *fifo,
 		vring->vdev_id = tm_vdev->vdev.id.device;
 		dev = &tm_vdev->vdev.dev;
 
-		size = vring_size(vring->num, vring->align);
+		size = vring_legacy_size(vring->num, vring->align);
 		va = dma_alloc_coherent(dev->parent, size, &dma, GFP_KERNEL);
 		if (!va) {
 			mlxbf_tmfifo_free_vrings(fifo, tm_vdev);
@@ -935,7 +935,7 @@ static int mlxbf_tmfifo_virtio_find_vqs(struct virtio_device *vdev,
 		vring = &tm_vdev->vrings[i];
 
 		/* zero vring */
-		size = vring_size(vring->num, vring->align);
+		size = vring_legacy_size(vring->num, vring->align);
 		memset(vring->va, 0, size);
 		vq = vring_new_virtqueue(i, vring->num, vring->align, vdev,
 					 false, false, vring->va,
-- 
MST

