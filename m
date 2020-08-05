Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A6AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:14:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9803722D2C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QlDAUxwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgHERO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:14:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52874 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728583AbgHERKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647428;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jWci/+5/mBvE1F6mvnsX+8niF7C1kxp9FouMHNJqkcQ=;
        b=QlDAUxwvYnzztDQDoaCni0fOw/AM1Te1ZPuF4ZEk2mawLdu3DNB+FIIBCrQScbgHEVMfd7
        XQo/MZFzPjdFI1uLj3+XIZlNT3eEy7JR44rf+dhjxPD+Xh6bt5eDPVbwUSnC1nQw9Vj3CN
        ir8PGxLOHc4t3y1vLX4rb0iVt+4X+IA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-RbT_waU2OgyU3WLgIvOd9w-1; Wed, 05 Aug 2020 09:44:44 -0400
X-MC-Unique: RbT_waU2OgyU3WLgIvOd9w-1
Received: by mail-wm1-f72.google.com with SMTP id p23so2475198wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jWci/+5/mBvE1F6mvnsX+8niF7C1kxp9FouMHNJqkcQ=;
        b=gZcev/ZoOe6g4gjkXFmTle85Jq7KeTcSA8gtfxjOhO0nveHmo2msyU5NADL0UY2try
         epAtWqbceT2zLgs7yCmhgKQcDE3cSyYtdV3ngDOW/Sog4JKNP6nXG+MT4IfHsLA76QEU
         UeoLi9V9IXWrIl3UVwGdvACyWf8wSMr0454ozRqG+2oh6JGUk4qm18yfClGZOe8NrJQD
         EvOX2hGNL/hCpLeUAq//qrd1vd0RCHxaHFafHiw9Rfx+vLc8FRRQkgjpQQhfPnhLIDY9
         zlIg8JGJGTWlOnhowPyheD+3U+nPARPXmhOiiEa+ueR7zRmUa5CkIFg+BTFmdw6XeeES
         AN+Q==
X-Gm-Message-State: AOAM530GOv9KwkYzObwDG+OYPx4XHxSm7u5B5CH+m1Qefj6wOHDDLXAY
        b1w1Wowa2Oi3ou3QyLFQLBKNCc71OBWrtNiApkET9m4oRUqBE5aupT039ZJOoe9rqVajWxj44Ax
        snt5uKhuE8oNO7XoHv6ih9V6N
X-Received: by 2002:a05:6000:18a:: with SMTP id p10mr2648512wrx.33.1596635082516;
        Wed, 05 Aug 2020 06:44:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzh/KIN/KZmvjqAkTq6wQd3jfmeRt/1lbO1zvA9EzKkakixioTV1omDTRNwjFLeWiuqYQR30A==
X-Received: by 2002:a05:6000:18a:: with SMTP id p10mr2648497wrx.33.1596635082345;
        Wed, 05 Aug 2020 06:44:42 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id j5sm2967022wmb.15.2020.08.05.06.44.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:44:41 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:44:39 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        virtualization@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 31/38] virtio_fs: convert to LE accessors
Message-ID: <20200805134226.1106164-32-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Virtio fs is modern-only. Use LE accessors for config space.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 fs/fuse/virtio_fs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 4c4ef5d69298..104f35de5270 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -606,8 +606,8 @@ static int virtio_fs_setup_vqs(struct virtio_device *vdev,
 	unsigned int i;
 	int ret = 0;
 
-	virtio_cread(vdev, struct virtio_fs_config, num_request_queues,
-		     &fs->num_request_queues);
+	virtio_cread_le(vdev, struct virtio_fs_config, num_request_queues,
+			&fs->num_request_queues);
 	if (fs->num_request_queues == 0)
 		return -EINVAL;
 
-- 
MST

