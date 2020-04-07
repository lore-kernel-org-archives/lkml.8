Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686A6C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4D2207FF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEIXnwCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgDGBRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:17:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31066 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726830AbgDGBRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586222226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tGzj3Xy5+PE0S44YeXdrCLBeKxIojEvp8oKLEKl/XHc=;
        b=MEIXnwCndMWUO1M0uynO55gwDJLTSW/PFf5yhuMuLcZrjmvm6s/OO/+H5878/5ryABEZvx
        OjjKztJl1fA0DUQJKgk0HeZhNYS/9QJQWJsMDOnuMSixu0HjoZZZiamfOnv2hGOBXWhH1k
        k5LJRHcaKKWAEPCqYlaR87L9kL5qoN8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-cHr8JsLyOE2w786zD8KuUA-1; Mon, 06 Apr 2020 21:17:04 -0400
X-MC-Unique: cHr8JsLyOE2w786zD8KuUA-1
Received: by mail-wm1-f69.google.com with SMTP id f9so33171wme.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tGzj3Xy5+PE0S44YeXdrCLBeKxIojEvp8oKLEKl/XHc=;
        b=aKGe6iQl2D+b6yQgkPcthi1mqT3M/ncc7arNgxOUZ9uBoORvv5mLF5Lsyz+zEmN/Iv
         ScHji0BpWbFz9ZwYtqPvncWHcgKhK9zWjRngXJHiwzQBW95YmWae69v9EgAlz3i4GeMJ
         JEkZBJQPAcbEIfDJ2MTewbzUODUjrSGMTpIxMnT8bJV0oDbOHifK5L33EIqa1H93U+c8
         r9pe6G+ETcdA+LReZoPp+o6QwwfPtD3CIcxN1XoUMtSq6c9I7h4AGy5lSxcwfIb/sJyW
         wo/Wl3KMKd3XrsRv1HhhEE4CwI3BLgpBBqVBUbi3V0+6L5SfPGAHkA+Npb4II/rVRYnG
         fT3w==
X-Gm-Message-State: AGi0PuaPKUSN9hyEJfgT6ro4TM4xezycvMXPRwVIUwlBw6reUXQQX/S8
        2gOspCq6k4wTNQ+pCYCrA66gbZcOg0bFTsIK0WJevTKFRsUDJq6NKIfHqbim17w6UdlwKsQH7jd
        nGd84T4iR1fYwvilEKHQ75m8y
X-Received: by 2002:a05:6000:2:: with SMTP id h2mr2042963wrx.112.1586222223170;
        Mon, 06 Apr 2020 18:17:03 -0700 (PDT)
X-Google-Smtp-Source: APiQypIEn11jC0tGjNxm7Fs9YE85y7WQxqWpdu3lnz8HpXzuK+KjkQRa6rbOz9+IGoBWozZn6MgbFg==
X-Received: by 2002:a05:6000:2:: with SMTP id h2mr2042947wrx.112.1586222223007;
        Mon, 06 Apr 2020 18:17:03 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id z3sm116362wma.22.2020.04.06.18.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:17:02 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:17:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH v8 16/19] mellanox: switch to virtio_legacy_init/size
Message-ID: <20200407011612.478226-17-mst@redhat.com>
References: <20200407011612.478226-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407011612.478226-1-mst@redhat.com>
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

