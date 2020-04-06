Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02ABC2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782E7206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BvSzKhFH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgDFVf1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:35:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37747 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726937AbgDFVfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586208923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=p1zo9E/0T2RBJhS0NHCftwHqPvc0s/jKRL4zh5KiBdQ=;
        b=BvSzKhFHJQdJtlrI65qQyc+uWumxBkPxX7C2sbSzV28vXavSY8ov8BXkEnKXq7HlCl5CNr
        D04yXpKP+ddCpbspkaCUYVcClm2vOa40T2cRo46YSKelOJkn7vAinTscao+SQKx68k3Wah
        yFHDq0ZKaugI/cT2+/TgmE/2jIw0WEg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-YDXr2jKoMUm_kMoabCpHeQ-1; Mon, 06 Apr 2020 17:35:21 -0400
X-MC-Unique: YDXr2jKoMUm_kMoabCpHeQ-1
Received: by mail-wm1-f72.google.com with SMTP id f81so417842wmf.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p1zo9E/0T2RBJhS0NHCftwHqPvc0s/jKRL4zh5KiBdQ=;
        b=CTdzFKYzGh6i/DLxUa2dfBonkTgzsc0Pk42PgGDTh9lDqS7vTRN6VxZCFPRexC09yU
         znmokARDH1W+f22SNK9i0nADLJZzlNlcqSaN9CZk6cP7CNdD9e9m6QTb3OoFO8V5a7OF
         IBRHLmd9BvktlXYEM7c1BLNuPYu0IX6UQHUVE3CSzK31AOqvzNLpUB6bo4Z5W9u2X+nE
         YQaK9xpky60IKnfqNBPLlYckVhHUYPUy0eInLtD+eZxzby8aaO8gLbItmkBieZSGx3Ct
         9DlN71ytrBExWezfWc1uHmviECYanHD8jFG8S0qRmUFY3zUKyEOAE7KwJVS5pWvSFrBW
         bGIA==
X-Gm-Message-State: AGi0PubHqN5CC3DIiFhpQ3UYxlztNB5t0P43k+mIJj5SLO8hqwPGsgD2
        5OXiD0uWuapJneDSMKPHW4mqoCPAtzOwuAtVbU/0PaTeCVwcHTxz2ZudHebQW2jSKSCoQ8mlZQU
        HTp2GZJXtyn6vPPg4jD3e3hjv
X-Received: by 2002:adf:e98a:: with SMTP id h10mr1328612wrm.370.1586208919960;
        Mon, 06 Apr 2020 14:35:19 -0700 (PDT)
X-Google-Smtp-Source: APiQypKFsjTJU6wZbFct97kHV2BeMmwhQkfVOIaQ+Y5VpGC+kCzeP6ryUgMDqGqdvs1NHdN2FLH2hA==
X-Received: by 2002:adf:e98a:: with SMTP id h10mr1328592wrm.370.1586208919806;
        Mon, 06 Apr 2020 14:35:19 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id r20sm950812wmh.46.2020.04.06.14.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:35:19 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:35:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v5 12/12] mellanox: switch to virtio_legacy_init/size
Message-ID: <20200406213314.248038-13-mst@redhat.com>
References: <20200406213314.248038-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406213314.248038-1-mst@redhat.com>
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

maintainers, pls ack merging this through virtio tree due to dependency
on previous patches in the patchset.

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

