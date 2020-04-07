Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E0CC2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C382078C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:08:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGAt4mXc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgDGBIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:08:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27343 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726681AbgDGBIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586221688;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tGzj3Xy5+PE0S44YeXdrCLBeKxIojEvp8oKLEKl/XHc=;
        b=NGAt4mXczMWBLXOgRxKJezwDCixDpGlk93Fgn+5CpoxloSvQIudDCzxDX9QXx3brTXK9qm
        YDiPp/K7ZIOr5477XNSNnGB7IvyFUX/tt0rmX9kPna5dJQu+aVp8BDNF4bAHrbZ9KFBWVN
        3j79QZrytd0rzyBJskMM6FIrwOMQ/zU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-500-nrLPphOFN82ELZDbxA-Yhw-1; Mon, 06 Apr 2020 21:08:06 -0400
X-MC-Unique: nrLPphOFN82ELZDbxA-Yhw-1
Received: by mail-wr1-f69.google.com with SMTP id w12so830745wrl.23
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:08:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tGzj3Xy5+PE0S44YeXdrCLBeKxIojEvp8oKLEKl/XHc=;
        b=ruHRkRPuhy3GBbuWQiJBIcvG7w96/ZGsX87ivDVu/rmUmNqm0I6ft8XOXDr+caFXh4
         BAYixbW3KAx1ZIVnURPBMVQ2sSZIcPfUlyflSr+tRNapHHawgDZd0JtvUsVnpMSgOtDu
         ElnA68Z0IPMBUCcrTbZMGQK/p1K2k9OlYQhhGcZorJTC50QY4FOTS2jhB99A32Ciy6+x
         RlhllOp2DTRi3S5JVn25oB5tItCHlxF4GyL5aPi9hRe46S8Ms8Tonw/KqQg3iXxXL20B
         +4Eh4qeDEnJmugOu+wKKR5k8qI2+T2VS/xQldTCMvPB/6Gm9SweZLOyoaTLr0I2nLfPY
         f1Lw==
X-Gm-Message-State: AGi0PuYd0i4PK2gvnsL3Z+HCJ8JWUGP6Zh9mVuynrroiLPrFY4f78zb0
        l0nLPvqbZCGdXYC4wWy1yn3xYXhIruiFfOIxCc1y6kFoahMGhTqVLqeycrajbLBkmUr7X8fzFDL
        JLyrY1WxaNvYaUjy61heRNnpi
X-Received: by 2002:a5d:6a43:: with SMTP id t3mr1944490wrw.87.1586221685578;
        Mon, 06 Apr 2020 18:08:05 -0700 (PDT)
X-Google-Smtp-Source: APiQypJOYPrm0BpL822A167zoqe2yatDB+PJHHZa0T7EJnIUzZJgCtY2T5VptGribbSNFHHfdJHOOA==
X-Received: by 2002:a5d:6a43:: with SMTP id t3mr1944479wrw.87.1586221685374;
        Mon, 06 Apr 2020 18:08:05 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id n11sm31357283wrg.72.2020.04.06.18.08.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:08:04 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:08:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v7 16/19] mellanox: switch to virtio_legacy_init/size
Message-ID: <20200407010700.446571-17-mst@redhat.com>
References: <20200407010700.446571-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407010700.446571-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are used for legacy ring format, switch to APIs that make this
explicit.

Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
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

