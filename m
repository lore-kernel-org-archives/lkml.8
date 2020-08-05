Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11872C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C42F9206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BiZf+SQP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgHET1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:27:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28579 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728641AbgHERNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QZtQO+RPpH+qMcVX7UHHBecNGQz0/LWgC7hfTGQuckU=;
        b=BiZf+SQPkhv15UyvVHjdinZ8N64kunXFOU480/nrQ+Q6i2WtsSuhBm1xF0pKbHTSEHp4Gq
        6VWu/B67wiEHqI9Y/k8pl+mm+Ij6oj5aNKw1sTZ16P/8yOu3J0jqIVx/SLakOd/KVRcE9H
        CbXypTR4lZ4wOsDMEH87QCkj4r0UT28=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-iAbHYY24O7u1B-70GkGgqw-1; Wed, 05 Aug 2020 09:43:21 -0400
X-MC-Unique: iAbHYY24O7u1B-70GkGgqw-1
Received: by mail-wr1-f71.google.com with SMTP id f14so13524862wrm.22
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QZtQO+RPpH+qMcVX7UHHBecNGQz0/LWgC7hfTGQuckU=;
        b=ajFoYkR3jy1reHEfBLayaRLG8ts6mf3u6xCtN14VRrZGzkdjdOpcH8fTDAbgvVHdkV
         n6fg/8y0L0i181KyLsZ+FqwDtk3OSJXcfGAOGZSCAwyTP6qAbvIBAAZEtLG/7vbFlucb
         lhhwkMfWnq0sLb2viYxKTs5c0dBeg1UVY+iYeI7EFBZkC/gvLdsj21Loqr5UbnjLL4iq
         7AeUV+MUe9Ygl/qgkf1y8NK4VkL4d0V8E5shYbfjh0h5RTCwFhJCrCMYnFkniA1tQ2Ea
         2Y+8k7jofGZCD3bkHMiABiL56O7fnKRQw4xlLvmWnztrpbui6AaZIAOUbdA4dC/89SpZ
         yxDg==
X-Gm-Message-State: AOAM531ybiMO90teg4EBXxyaxksCFtWBa0RJq9yQzTrjiuN7N6FWbzfp
        imjmJS5XGXmXFnzF7rtF/bNqJmBjQsj0D6Pu97zdJrO9AJzHeCZj29b/MPkn0nRoochS6DMw/Zz
        u1SRqPG2wRjnEgs4SP2SknIpl
X-Received: by 2002:a05:600c:2189:: with SMTP id e9mr3594946wme.171.1596634999574;
        Wed, 05 Aug 2020 06:43:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaUQx57cc7JttIMX2xKEoawmsqxvIFhQa983nt+oNgyKZc7lcEC6u20fEKG5dxWjJXOX9tYA==
X-Received: by 2002:a05:600c:2189:: with SMTP id e9mr3594934wme.171.1596634999421;
        Wed, 05 Aug 2020 06:43:19 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
        by smtp.gmail.com with ESMTPSA id x6sm594339wmx.28.2020.08.05.06.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:43:18 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:43:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 01/38] virtio_balloon: fix sparse warning
Message-ID: <20200805134226.1106164-2-mst@redhat.com>
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

balloon uses virtio32_to_cpu instead of cpu_to_virtio32
to convert a native endian number to virtio.
No practical difference but makes sparse warn.
Fix it up.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 54fd989f9353..8bc1704ffdf3 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -600,7 +600,7 @@ static int send_cmd_id_start(struct virtio_balloon *vb)
 	while (virtqueue_get_buf(vq, &unused))
 		;
 
-	vb->cmd_id_active = virtio32_to_cpu(vb->vdev,
+	vb->cmd_id_active = cpu_to_virtio32(vb->vdev,
 					virtio_balloon_cmd_id_received(vb));
 	sg_init_one(&sg, &vb->cmd_id_active, sizeof(vb->cmd_id_active));
 	err = virtqueue_add_outbuf(vq, &sg, 1, &vb->cmd_id_active, GFP_KERNEL);
-- 
MST

