Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05855C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F0720675
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sg8XUQku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388841AbgF3O1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:27:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37123 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388902AbgF3O1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593527234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kCyTlWHFhLMVHRsezLlb/CPWvYLXIlbWUUIKk6x0xJ0=;
        b=Sg8XUQkutCTrs66N8Y7X/KWQeySmwxjKMGJSVJx+kgvj+kSLb4AlGl4F3qkZduy0DdBbQQ
        3AAaKoWwOy22pCRpacztBHOgeoGYhej6vAcI0FdT4bodFnMxVp4PgquwoOZ0rDKsbu0h2q
        lWWs7GhRfIR5CwtK1cMhdWWesDk0mGI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-ikI33Hh6NuiNYw1OUDqcJQ-1; Tue, 30 Jun 2020 10:27:10 -0400
X-MC-Unique: ikI33Hh6NuiNYw1OUDqcJQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 94277107ACCD;
        Tue, 30 Jun 2020 14:27:08 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-56.ams2.redhat.com [10.36.114.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0864419C4F;
        Tue, 30 Jun 2020 14:26:57 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v1 6/6] virtio-mem: don't special-case ZONE_MOVABLE
Date:   Tue, 30 Jun 2020 16:26:39 +0200
Message-Id: <20200630142639.22770-7-david@redhat.com>
In-Reply-To: <20200630142639.22770-1-david@redhat.com>
References: <20200630142639.22770-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's allow to online partially plugged memory blocks to ZONE_MOVABLE
and also consider memory blocks that were onlined to ZONE_MOVABLE when
unplugging memory. While unplugged memory blocks are, in general,
unmovable, they can be skipped when offlining memory.

virtio-mem only unplugs fairly big chunks (in the megabyte range) and
rather tries to shrink the memory region than randomly choosing memory. In
theory, if all other pages in the movable zone would be movable, virtio-mem
would only shrink that zone and not create any kind of fragmentation.

Note: Support for defragmentation is planned, to deal with fragmentation
after unplug due to memory chunks within memory blocks that could not
get unplugged before (e.g., somebody pinning pages within ZONE_MOVABLE
for a longer time).

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 47 +++++++------------------------------
 1 file changed, 8 insertions(+), 39 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index f26f5f64ae822..2ddfc4a0e2ee0 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -36,18 +36,10 @@ enum virtio_mem_mb_state {
 	VIRTIO_MEM_MB_STATE_OFFLINE,
 	/* Partially plugged, fully added to Linux, offline. */
 	VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL,
-	/* Fully plugged, fully added to Linux, online (!ZONE_MOVABLE). */
+	/* Fully plugged, fully added to Linux, online. */
 	VIRTIO_MEM_MB_STATE_ONLINE,
-	/* Partially plugged, fully added to Linux, online (!ZONE_MOVABLE). */
+	/* Partially plugged, fully added to Linux, online. */
 	VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL,
-	/*
-	 * Fully plugged, fully added to Linux, online (ZONE_MOVABLE).
-	 * We are not allowed to allocate (unplug) parts of this block that
-	 * are not movable (similar to gigantic pages). We will never allow
-	 * to online OFFLINE_PARTIAL to ZONE_MOVABLE (as they would contain
-	 * unmovable parts).
-	 */
-	VIRTIO_MEM_MB_STATE_ONLINE_MOVABLE,
 	VIRTIO_MEM_MB_STATE_COUNT
 };
 
@@ -526,21 +518,10 @@ static bool virtio_mem_owned_mb(struct virtio_mem *vm, unsigned long mb_id)
 }
 
 static int virtio_mem_notify_going_online(struct virtio_mem *vm,
-					  unsigned long mb_id,
-					  enum zone_type zone)
+					  unsigned long mb_id)
 {
 	switch (virtio_mem_mb_get_state(vm, mb_id)) {
 	case VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL:
-		/*
-		 * We won't allow to online a partially plugged memory block
-		 * to the MOVABLE zone - it would contain unmovable parts.
-		 */
-		if (zone == ZONE_MOVABLE) {
-			dev_warn_ratelimited(&vm->vdev->dev,
-					     "memory block has holes, MOVABLE not supported\n");
-			return NOTIFY_BAD;
-		}
-		return NOTIFY_OK;
 	case VIRTIO_MEM_MB_STATE_OFFLINE:
 		return NOTIFY_OK;
 	default:
@@ -560,7 +541,6 @@ static void virtio_mem_notify_offline(struct virtio_mem *vm,
 					VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL);
 		break;
 	case VIRTIO_MEM_MB_STATE_ONLINE:
-	case VIRTIO_MEM_MB_STATE_ONLINE_MOVABLE:
 		virtio_mem_mb_set_state(vm, mb_id,
 					VIRTIO_MEM_MB_STATE_OFFLINE);
 		break;
@@ -579,24 +559,17 @@ static void virtio_mem_notify_offline(struct virtio_mem *vm,
 	virtio_mem_retry(vm);
 }
 
-static void virtio_mem_notify_online(struct virtio_mem *vm, unsigned long mb_id,
-				     enum zone_type zone)
+static void virtio_mem_notify_online(struct virtio_mem *vm, unsigned long mb_id)
 {
 	unsigned long nb_offline;
 
 	switch (virtio_mem_mb_get_state(vm, mb_id)) {
 	case VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL:
-		BUG_ON(zone == ZONE_MOVABLE);
 		virtio_mem_mb_set_state(vm, mb_id,
 					VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL);
 		break;
 	case VIRTIO_MEM_MB_STATE_OFFLINE:
-		if (zone == ZONE_MOVABLE)
-			virtio_mem_mb_set_state(vm, mb_id,
-					    VIRTIO_MEM_MB_STATE_ONLINE_MOVABLE);
-		else
-			virtio_mem_mb_set_state(vm, mb_id,
-						VIRTIO_MEM_MB_STATE_ONLINE);
+		virtio_mem_mb_set_state(vm, mb_id, VIRTIO_MEM_MB_STATE_ONLINE);
 		break;
 	default:
 		BUG();
@@ -675,7 +648,6 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 	const unsigned long start = PFN_PHYS(mhp->start_pfn);
 	const unsigned long size = PFN_PHYS(mhp->nr_pages);
 	const unsigned long mb_id = virtio_mem_phys_to_mb_id(start);
-	enum zone_type zone;
 	int rc = NOTIFY_OK;
 
 	if (!virtio_mem_overlaps_range(vm, start, size))
@@ -717,8 +689,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 			break;
 		}
 		vm->hotplug_active = true;
-		zone = page_zonenum(pfn_to_page(mhp->start_pfn));
-		rc = virtio_mem_notify_going_online(vm, mb_id, zone);
+		rc = virtio_mem_notify_going_online(vm, mb_id);
 		break;
 	case MEM_OFFLINE:
 		virtio_mem_notify_offline(vm, mb_id);
@@ -726,8 +697,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 		mutex_unlock(&vm->hotplug_mutex);
 		break;
 	case MEM_ONLINE:
-		zone = page_zonenum(pfn_to_page(mhp->start_pfn));
-		virtio_mem_notify_online(vm, mb_id, zone);
+		virtio_mem_notify_online(vm, mb_id);
 		vm->hotplug_active = false;
 		mutex_unlock(&vm->hotplug_mutex);
 		break;
@@ -1906,8 +1876,7 @@ static void virtio_mem_remove(struct virtio_device *vdev)
 	if (vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE] ||
 	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL] ||
 	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE] ||
-	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL] ||
-	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE_MOVABLE]) {
+	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL]) {
 		dev_warn(&vdev->dev, "device still has system memory added\n");
 	} else {
 		virtio_mem_delete_resource(vm);
-- 
2.26.2

