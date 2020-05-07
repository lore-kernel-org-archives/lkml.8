Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3072EC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C1462063A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcH+NEEs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbgEGODz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:03:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22123 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727937AbgEGODw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:03:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588860230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tQSI93WDnJ16nEtoeWpgKm4iRZohoBJubdiofU1fO/E=;
        b=TcH+NEEsVa8fUU78TBOvtCaRVWCLf5sduxwbuDenjPDHJ1ccoNX+oQAW0aR4u/1I91atpG
        ZnAgvUf33kF7NFdMNp4491ujJr2as1FMezwTIT7GhmwMnS6Eq7m4pef/s7Xe34E/1iECWi
        J2W4RaeFzk0QWn6FVt1ZV7heDBmyYwE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-qfwtH60tNo6ptdwVBH69jQ-1; Thu, 07 May 2020 10:03:45 -0400
X-MC-Unique: qfwtH60tNo6ptdwVBH69jQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81E171895950;
        Thu,  7 May 2020 14:03:43 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-245.ams2.redhat.com [10.36.113.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7EEFE60CCC;
        Thu,  7 May 2020 14:03:41 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v4 15/15] virtio-mem: Try to unplug the complete online memory block first
Date:   Thu,  7 May 2020 16:01:39 +0200
Message-Id: <20200507140139.17083-16-david@redhat.com>
In-Reply-To: <20200507140139.17083-1-david@redhat.com>
References: <20200507140139.17083-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, we always try to unplug single subblocks when processing an
online memory block. Let's try to unplug the complete online memory block
first, in case it is fully plugged and the unplug request is large
enough. Fallback to single subblocks in case the memory block cannot get
unplugged as a whole.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 88 ++++++++++++++++++++++++-------------
 1 file changed, 57 insertions(+), 31 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index abd93b778a26..9e523db3bee1 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1307,6 +1307,46 @@ static int virtio_mem_mb_unplug_any_sb_offline(struct virtio_mem *vm,
 	return 0;
 }
 
+/*
+ * Unplug the given plugged subblocks of an online memory block.
+ *
+ * Will modify the state of the memory block.
+ */
+static int virtio_mem_mb_unplug_sb_online(struct virtio_mem *vm,
+					  unsigned long mb_id, int sb_id,
+					  int count)
+{
+	const unsigned long nr_pages = PFN_DOWN(vm->subblock_size) * count;
+	unsigned long start_pfn;
+	int rc;
+
+	start_pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
+			     sb_id * vm->subblock_size);
+	rc = alloc_contig_range(start_pfn, start_pfn + nr_pages,
+				MIGRATE_MOVABLE, GFP_KERNEL);
+	if (rc == -ENOMEM)
+		/* whoops, out of memory */
+		return rc;
+	if (rc)
+		return -EBUSY;
+
+	/* Mark it as fake-offline before unplugging it */
+	virtio_mem_set_fake_offline(start_pfn, nr_pages, true);
+	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
+
+	/* Try to unplug the allocated memory */
+	rc = virtio_mem_mb_unplug_sb(vm, mb_id, sb_id, count);
+	if (rc) {
+		/* Return the memory to the buddy. */
+		virtio_mem_fake_online(start_pfn, nr_pages);
+		return rc;
+	}
+
+	virtio_mem_mb_set_state(vm, mb_id,
+				VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL);
+	return 0;
+}
+
 /*
  * Unplug the desired number of plugged subblocks of an online memory block.
  * Will skip subblock that are busy.
@@ -1321,16 +1361,21 @@ static int virtio_mem_mb_unplug_any_sb_online(struct virtio_mem *vm,
 					      unsigned long mb_id,
 					      uint64_t *nb_sb)
 {
-	const unsigned long nr_pages = PFN_DOWN(vm->subblock_size);
-	unsigned long start_pfn;
 	int rc, sb_id;
 
-	/*
-	 * TODO: To increase the performance we want to try bigger, consecutive
-	 * subblocks first before falling back to single subblocks. Also,
-	 * we should sense via something like is_mem_section_removable()
-	 * first if it makes sense to go ahead any try to allocate.
-	 */
+	/* If possible, try to unplug the complete block in one shot. */
+	if (*nb_sb >= vm->nb_sb_per_mb &&
+	    virtio_mem_mb_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
+		rc = virtio_mem_mb_unplug_sb_online(vm, mb_id, 0,
+						    vm->nb_sb_per_mb);
+		if (!rc) {
+			*nb_sb -= vm->nb_sb_per_mb;
+			goto unplugged;
+		} else if (rc != -EBUSY)
+			return rc;
+	}
+
+	/* Fallback to single subblocks. */
 	for (sb_id = vm->nb_sb_per_mb - 1; sb_id >= 0 && *nb_sb; sb_id--) {
 		/* Find the next candidate subblock */
 		while (sb_id >= 0 &&
@@ -1339,34 +1384,15 @@ static int virtio_mem_mb_unplug_any_sb_online(struct virtio_mem *vm,
 		if (sb_id < 0)
 			break;
 
-		start_pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
-				     sb_id * vm->subblock_size);
-		rc = alloc_contig_range(start_pfn, start_pfn + nr_pages,
-					MIGRATE_MOVABLE, GFP_KERNEL);
-		if (rc == -ENOMEM)
-			/* whoops, out of memory */
-			return rc;
-		if (rc)
-			/* memory busy, we can't unplug this chunk */
+		rc = virtio_mem_mb_unplug_sb_online(vm, mb_id, sb_id, 1);
+		if (rc == -EBUSY)
 			continue;
-
-		/* Mark it as fake-offline before unplugging it */
-		virtio_mem_set_fake_offline(start_pfn, nr_pages, true);
-		adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
-
-		/* Try to unplug the allocated memory */
-		rc = virtio_mem_mb_unplug_sb(vm, mb_id, sb_id, 1);
-		if (rc) {
-			/* Return the memory to the buddy. */
-			virtio_mem_fake_online(start_pfn, nr_pages);
+		else if (rc)
 			return rc;
-		}
-
-		virtio_mem_mb_set_state(vm, mb_id,
-					VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL);
 		*nb_sb -= 1;
 	}
 
+unplugged:
 	/*
 	 * Once all subblocks of a memory block were unplugged, offline and
 	 * remove it. This will usually not fail, as no memory is in use
-- 
2.25.3

