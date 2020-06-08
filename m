Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D7AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 06:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8486F2076C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 06:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GE4YsnD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgFHGOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:14:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54145 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726929AbgFHGOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 02:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591596853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ZOLB3s6xQQ4ednjFNYYSfonH3ht+KP5v3mHEujT+RI8=;
        b=GE4YsnD7G4Hawxgxb9ksu7nAURqEMp1fpdh3SUy08nEo47qT+/lD1NPnZaUZKL8yepINjZ
        zrGYP03pgV5fMy0R2KVIHTxp+X8Qwwp2P0g1O+vXF2J1RpbKFkxAKbi2q+Nn62WpBtqSLg
        tVduec1TI/YI0G+yzqWRh9fSi5PXQvQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-dIaAOml_ORuT1jFADjB4PQ-1; Mon, 08 Jun 2020 02:14:11 -0400
X-MC-Unique: dIaAOml_ORuT1jFADjB4PQ-1
Received: by mail-wm1-f71.google.com with SMTP id t145so4851265wmt.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 23:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZOLB3s6xQQ4ednjFNYYSfonH3ht+KP5v3mHEujT+RI8=;
        b=V9tQZWYnWw1qgTERzMIahIT0SpcC/L4aPTcCQhvgtf+va428E7PfD3JD0mKEn1rYaF
         6yNm5HpdXCgjwit5OrUkXhmSQaL4wPy7gOGiGjiFlBzqRLg9oHqj+vh77N7M9vbo6OWn
         vtieh8dFCU/5CaEwWEd/Y+5cH3RZAVwW8ZiWknnD96u2DFFZkaRjnQ+zF7+p7zp/FZik
         RoKzLUgy2wMYYUmdmvVlKFQDJr0J7zW1Lxf7K0NG3FDS9pP6mzT+KWO+NMu8MWzWJZta
         QdxLRvCDIT3ELK8SaZwcqlILDESYhZe89rRdRKb9BbZnB9K4URtrlW8ozN/U+3gc/UaS
         kxzQ==
X-Gm-Message-State: AOAM531/k5thGddv5eqPqtgV7xNP6aPeorMO9+dU5CEtCvLYl4D+NY6Z
        DXEbjduGPEFjwhNXka51UGXwwpVeov+qZ7WEZVxyPrhLhZ3ueoX67KNn62yIGYimEvMaPyySQj8
        L8oQMda9JviMkD79uJNoakpWt
X-Received: by 2002:a5d:6288:: with SMTP id k8mr20862585wru.94.1591596850427;
        Sun, 07 Jun 2020 23:14:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3paOhRaZ3mteITaSKV7CYWRhDU9MgQhrYToEZH5MAJhJq/5hQ5hCudXdUIPtpRl+F6Cv3bg==
X-Received: by 2002:a5d:6288:: with SMTP id k8mr20862568wru.94.1591596850188;
        Sun, 07 Jun 2020 23:14:10 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id j5sm21776545wrq.39.2020.06.07.23.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 23:14:09 -0700 (PDT)
Date:   Mon, 8 Jun 2020 02:14:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] virtio_mem: prevent overflow with subblock size
Message-ID: <20200608061406.709211-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If subblock size is large (e.g. 1G) 32 bit math involving it
can overflow. Rather than try to catch all instances of that,
let's tweak block size to 64 bit.

It ripples through UAPI which is an ABI change, but it's not too late to
make it, and it will allow supporting >4Gbyte blocks while might
become necessary down the road.

Fixes: 5f1f79bbc9e26 ("virtio-mem: Paravirtualized memory hotplug")
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/virtio/virtio_mem.c     | 14 +++++++-------
 include/uapi/linux/virtio_mem.h |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 2f357142ea5e..7b1bece8a331 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -77,7 +77,7 @@ struct virtio_mem {
 	uint64_t requested_size;
 
 	/* The device block size (for communicating with the device). */
-	uint32_t device_block_size;
+	uint64_t device_block_size;
 	/* The translated node id. NUMA_NO_NODE in case not specified. */
 	int nid;
 	/* Physical start address of the memory region. */
@@ -86,7 +86,7 @@ struct virtio_mem {
 	uint64_t region_size;
 
 	/* The subblock size. */
-	uint32_t subblock_size;
+	uint64_t subblock_size;
 	/* The number of subblocks per memory block. */
 	uint32_t nb_sb_per_mb;
 
@@ -1698,9 +1698,9 @@ static int virtio_mem_init(struct virtio_mem *vm)
 	 * - At least the device block size.
 	 * In the worst case, a single subblock per memory block.
 	 */
-	vm->subblock_size = PAGE_SIZE * 1u << max_t(uint32_t, MAX_ORDER - 1,
-						    pageblock_order);
-	vm->subblock_size = max_t(uint32_t, vm->device_block_size,
+	vm->subblock_size = PAGE_SIZE * 1ul << max_t(uint32_t, MAX_ORDER - 1,
+						     pageblock_order);
+	vm->subblock_size = max_t(uint64_t, vm->device_block_size,
 				  vm->subblock_size);
 	vm->nb_sb_per_mb = memory_block_size_bytes() / vm->subblock_size;
 
@@ -1713,8 +1713,8 @@ static int virtio_mem_init(struct virtio_mem *vm)
 
 	dev_info(&vm->vdev->dev, "start address: 0x%llx", vm->addr);
 	dev_info(&vm->vdev->dev, "region size: 0x%llx", vm->region_size);
-	dev_info(&vm->vdev->dev, "device block size: 0x%x",
-		 vm->device_block_size);
+	dev_info(&vm->vdev->dev, "device block size: 0x%llx",
+		 (unsigned long long)vm->device_block_size);
 	dev_info(&vm->vdev->dev, "memory block size: 0x%lx",
 		 memory_block_size_bytes());
 	dev_info(&vm->vdev->dev, "subblock size: 0x%x",
diff --git a/include/uapi/linux/virtio_mem.h b/include/uapi/linux/virtio_mem.h
index a455c488a995..a9ffe041843c 100644
--- a/include/uapi/linux/virtio_mem.h
+++ b/include/uapi/linux/virtio_mem.h
@@ -185,10 +185,10 @@ struct virtio_mem_resp {
 
 struct virtio_mem_config {
 	/* Block size and alignment. Cannot change. */
-	__u32 block_size;
+	__u64 block_size;
 	/* Valid with VIRTIO_MEM_F_ACPI_PXM. Cannot change. */
 	__u16 node_id;
-	__u16 padding;
+	__u8 padding[6];
 	/* Start address of the memory region. Cannot change. */
 	__u64 addr;
 	/* Region size (maximum). Cannot change. */
-- 
MST

