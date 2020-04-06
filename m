Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9DDC2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 803762078A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PMcAl8Od"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgDFVfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:35:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33653 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726633AbgDFVe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586208895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c0TsndpJVTVi+maigb4wqF83+v7IC6vuTnjCeLiosRo=;
        b=PMcAl8OdvS1+pCgyqdHGl3ffCSCd5mpy9ZW5eaPUBiqR+J5ZB1W2T2Werd5oodVEGb3drF
        A8NRvBJulp/OHHXMNa4BKPyZL0O1qOZydw+OkQQ/1fYWEMvTanlg55t5rxJcYYkxnXZbWk
        s6CB9OfjNxEOuR03ivGQrDmBdjdRiDQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-5SE042fjN86JdGJGMaVrVA-1; Mon, 06 Apr 2020 17:34:53 -0400
X-MC-Unique: 5SE042fjN86JdGJGMaVrVA-1
Received: by mail-wr1-f70.google.com with SMTP id i18so564007wrx.17
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c0TsndpJVTVi+maigb4wqF83+v7IC6vuTnjCeLiosRo=;
        b=En/R6m/ENgYsxNiFBSi7cpmCtgZNjmvpHETdrJIbiYZw2v3FKL0ak/GRXoYD54OhB9
         iTgpj4XR0kafRb1WZJYX2RLP/YmnSCRBfP2dAFMJuYEH9sh5GiiZEAGInAv7wB9OqiFS
         u3bBKx7UZz0YzA9JwoOs7wXjOtOB3RPGyRd/UISV52P1xAXjYQKs+bi9UEMj0otMGEMj
         zN1X0/59abFKizt1yeAurfNPISDwyTxHNWhWMfa8m/sTdg+mFizOwavzogdpXMddt87P
         PurYD5Gi9C+TcshzAWnOi1RoMpXxbr7cxjsr92ZxbCIs6J5Xx8B26ngAQNpPhYGrbt2h
         k79g==
X-Gm-Message-State: AGi0PuaVQFpXXrnClDhyuxcM6WhbqfNbrwpwAnr01sXoTGHGHhB8S3OK
        tNLGJZl5oQOChlwivUS0Aw7verZ0iHHmwTfzhgZqAjdbwkbzjW7udf+evq/6g+e5YUFfWzRk6ut
        BoDCcan8sBgSH6Rb0CdAlznvS
X-Received: by 2002:a05:600c:24e:: with SMTP id 14mr1035591wmj.62.1586208892452;
        Mon, 06 Apr 2020 14:34:52 -0700 (PDT)
X-Google-Smtp-Source: APiQypLHlC2n03+GN3TkoQMJkZiKiJsJtlQihSdECc8VmU6MYBk5RPyGnEo0jVCg7ih0qinNIwtYtg==
X-Received: by 2002:a05:600c:24e:: with SMTP id 14mr1035577wmj.62.1586208892234;
        Mon, 06 Apr 2020 14:34:52 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id n6sm1476779wrs.81.2020.04.06.14.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:34:51 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:34:50 -0400
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
Message-ID: <20200406213450.0eSIncp3KeEpZIjG1pKUaBQIB-lDYmJsRLk0a0uAxDA@z>

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

