Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E51EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B9652075D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCKs6z6f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgHET0y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:26:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20102 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728643AbgHERNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:13:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596647582;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sf4mb/ld3dK0n/pClGJVnIPC6I0ejWcYW7v5x6Bo1+M=;
        b=iCKs6z6fV/9+pxC7PMJPeaEbJdXLKBCF8LEvizUetVN/hhNwgPEye1fLWVkOaQsZ6LI0BJ
        hb9HYuDyP1RUKNfY6BmlcEi7onBeMOn3kDN6SIgHKdDOycxTVA0sSjvPw3pScH9eo5f8TQ
        Fku8JEE6mwVC0Xs9SH+Av5oxLuhQSGs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-ncr9fZwDNQO2mYp7Gqmqog-1; Wed, 05 Aug 2020 09:44:54 -0400
X-MC-Unique: ncr9fZwDNQO2mYp7Gqmqog-1
Received: by mail-wm1-f71.google.com with SMTP id a207so2470224wme.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 06:44:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sf4mb/ld3dK0n/pClGJVnIPC6I0ejWcYW7v5x6Bo1+M=;
        b=TumJeN9qCJY7yJZX0pW762FU916ouyTGhMgeMPgsYsOh9YTv4tHBr+C/jEgFqYw8NZ
         1su0vkpmsl4jqXjkRvOh/Uvx64deS4NeL2Vb582dfZGqlcUpGY9FV+2OR99cNnnpxX/B
         g6U5eyjmbgm5JwMLEDWqA05VNPEMA5qqJUgQOwqFQKMJiZpe9GNYetAFpxIrUN0ddBR7
         5ByKJXpC9bBkqhNqniteLCWkrGUvglut3mkBDtao6+WigCdO/td2975hWlRHAjeduHQm
         u06NFu4nghJnlcI55+Gv33NJd/M+lJWijSNnan7Mj6zooLtQH3SI8/+DlNtjjbNMKXr3
         /Tow==
X-Gm-Message-State: AOAM531TGAzAvf+T9aMtPQDYeqOPGrF3aGAfGEQFYTHDwlmJizoi/OHy
        5ZVnBrWNf2aVinz3mq+Kr7LuPKIUblSflEE9gdiaWd32tYn8CgDJo1rgIIuwQDZgEhjFNB6uRWs
        MQhdd9RxQ4q+ZSNO8qavDyh+q
X-Received: by 2002:a1c:c913:: with SMTP id f19mr3240851wmb.173.1596635093532;
        Wed, 05 Aug 2020 06:44:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwflRN35X8m9gQQJIZ3vjZ5SU2XnNfJs8gjixlHntqQFa+r3w98pkq2rkqq6VjoBWUYewG77w==
X-Received: by 2002:a1c:c913:: with SMTP id f19mr3240842wmb.173.1596635093367;
        Wed, 05 Aug 2020 06:44:53 -0700 (PDT)
Received: from redhat.com (bzq-79-180-0-181.red.bezeqint.net. [79.180.0.181])
        by smtp.gmail.com with ESMTPSA id 130sm2886172wme.26.2020.08.05.06.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:44:52 -0700 (PDT)
Date:   Wed, 5 Aug 2020 09:44:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v3 35/38] virtio_mem: convert to LE accessors
Message-ID: <20200805134226.1106164-36-mst@redhat.com>
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

Virtio mem is modern-only. Use LE accessors for config space.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_mem.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index f26f5f64ae82..c08512fcea90 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1530,21 +1530,21 @@ static void virtio_mem_refresh_config(struct virtio_mem *vm)
 	uint64_t new_plugged_size, usable_region_size, end_addr;
 
 	/* the plugged_size is just a reflection of what _we_ did previously */
-	virtio_cread(vm->vdev, struct virtio_mem_config, plugged_size,
-		     &new_plugged_size);
+	virtio_cread_le(vm->vdev, struct virtio_mem_config, plugged_size,
+			&new_plugged_size);
 	if (WARN_ON_ONCE(new_plugged_size != vm->plugged_size))
 		vm->plugged_size = new_plugged_size;
 
 	/* calculate the last usable memory block id */
-	virtio_cread(vm->vdev, struct virtio_mem_config,
-		     usable_region_size, &usable_region_size);
+	virtio_cread_le(vm->vdev, struct virtio_mem_config,
+			usable_region_size, &usable_region_size);
 	end_addr = vm->addr + usable_region_size;
 	end_addr = min(end_addr, phys_limit);
 	vm->last_usable_mb_id = virtio_mem_phys_to_mb_id(end_addr) - 1;
 
 	/* see if there is a request to change the size */
-	virtio_cread(vm->vdev, struct virtio_mem_config, requested_size,
-		     &vm->requested_size);
+	virtio_cread_le(vm->vdev, struct virtio_mem_config, requested_size,
+			&vm->requested_size);
 
 	dev_info(&vm->vdev->dev, "plugged size: 0x%llx", vm->plugged_size);
 	dev_info(&vm->vdev->dev, "requested size: 0x%llx", vm->requested_size);
@@ -1677,16 +1677,16 @@ static int virtio_mem_init(struct virtio_mem *vm)
 	}
 
 	/* Fetch all properties that can't change. */
-	virtio_cread(vm->vdev, struct virtio_mem_config, plugged_size,
-		     &vm->plugged_size);
-	virtio_cread(vm->vdev, struct virtio_mem_config, block_size,
-		     &vm->device_block_size);
-	virtio_cread(vm->vdev, struct virtio_mem_config, node_id,
-		     &node_id);
+	virtio_cread_le(vm->vdev, struct virtio_mem_config, plugged_size,
+			&vm->plugged_size);
+	virtio_cread_le(vm->vdev, struct virtio_mem_config, block_size,
+			&vm->device_block_size);
+	virtio_cread_le(vm->vdev, struct virtio_mem_config, node_id,
+			&node_id);
 	vm->nid = virtio_mem_translate_node_id(vm, node_id);
-	virtio_cread(vm->vdev, struct virtio_mem_config, addr, &vm->addr);
-	virtio_cread(vm->vdev, struct virtio_mem_config, region_size,
-		     &vm->region_size);
+	virtio_cread_le(vm->vdev, struct virtio_mem_config, addr, &vm->addr);
+	virtio_cread_le(vm->vdev, struct virtio_mem_config, region_size,
+			&vm->region_size);
 
 	/*
 	 * We always hotplug memory in memory block granularity. This way,
-- 
MST

