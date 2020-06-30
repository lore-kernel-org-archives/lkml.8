Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9526FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E5AB20672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K42pSZg1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388892AbgF3O1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:27:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25183 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388878AbgF3O1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593527223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DPcgoQSd9zgD8sRNB0iEyYsKFokxdsQN2mBN3e3fHKE=;
        b=K42pSZg1k+0ac1hSaZVr9ogrJBR5vlzANZpyvWOdNcfeOtOEbzaeYETQ0MMkrOy2+lhrxo
        lqwEe0wnqf+MNmcxqD4Hrzofzl74LQ3zPilm6k2d/zNqEWvNMpUl6uuFXL3s+qkVxvN3dm
        Rs4NVrsu6TEQsAZgCG06DQ8PdqSyf98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-FNQn-3sHMjaEZBpM4I6OMw-1; Tue, 30 Jun 2020 10:26:58 -0400
X-MC-Unique: FNQn-3sHMjaEZBpM4I6OMw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC4C68BF8C2;
        Tue, 30 Jun 2020 14:26:57 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-56.ams2.redhat.com [10.36.114.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F6E019C4F;
        Tue, 30 Jun 2020 14:26:56 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v1 5/6] mm/page_alloc: restrict ZONE_MOVABLE optimization in has_unmovable_pages() to memory offlining
Date:   Tue, 30 Jun 2020 16:26:38 +0200
Message-Id: <20200630142639.22770-6-david@redhat.com>
In-Reply-To: <20200630142639.22770-1-david@redhat.com>
References: <20200630142639.22770-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can already have pages that can be offlined but not allocated in
ZONE_MOVABLE - PageHWPoison pages. While these pages can be skipped when
offlining ("moving them to /dev/null"), we cannot move them when
allocating.

virtio-mem managed memory is similar. The logical memory holes
corresponding to unplug memory ranges can be skipped when offlining,
however, the pages cannot be moved. Currently, virtio-mem special-cases
ZONE_MOVABLE, such that:
- partially plugged memory blocks it added to Linux cannot be onlined to
  ZONE_MOVABLE
- when unplugging memory, it will never consider memory blocks that were
  onlined to ZONE_MOVABLE

We also want to support ZONE_MOVABLE in virtio-mem for both cases. Note
that virtio-mem does not blindly try to unplug random pages within its
managed memory region. It always plugs memory left-to-right and tries to
unplug memory right-to-left - in roughly MAX_ORDER - 1 granularity. In
theory, the movable ZONE part would only shrink when unplugging memory
from ZONE_MOVABLE.

Let's perform the ZONE_MOVABLE optimization only for memory offlining,
such that we reduce the number of false positives from
has_unmovable_pages() in case of alloc_contig_range() on ZONE_MOVABLE.

Note: We currently don't seem to have any user of alloc_contig_range()
that actually uses ZONE_MOVABLE. This change is mostly valuable for the
documentation.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_alloc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index bd3ebf08f09b9..45077d74d975d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8237,9 +8237,12 @@ struct page *has_unmovable_pages(struct zone *zone, struct page *page,
 		/*
 		 * If the zone is movable and we have ruled out all reserved
 		 * pages then it should be reasonably safe to assume the rest
-		 * is movable.
+		 * is movable. As we can have some pages in the movable zone
+		 * that are only considered movable for memory offlining (esp.,
+		 * PageHWPoison and PageOffline that will be skipped), we
+		 * perform this optimization only for memory offlining.
 		 */
-		if (zone_idx(zone) == ZONE_MOVABLE)
+		if ((flags & MEMORY_OFFLINE) && zone_idx(zone) == ZONE_MOVABLE)
 			continue;
 
 		/*
-- 
2.26.2

