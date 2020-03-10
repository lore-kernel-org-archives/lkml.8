Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EF5C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1EB24649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 10:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cgnU3RxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgCJKjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 06:39:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26446 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725845AbgCJKjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 06:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583836759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=It91N9Ss3jHQcSRgUpYty5Hr9t/9xazGZMMjPEKfjUw=;
        b=cgnU3RxC1wkw+38NtCkR83M8C/cuosSLqtr8wHCMvphDusCZQ2WNZH+joZuZ8d40RUoKIY
        zI2rZnhMaRq2/M/JojS7zZjAZ2t4wji9LMgbp6gvbDOZZTdj40o/tkZzdIsvL77V6+v6Se
        tgKHeNcK62xh7u3YEuKpbrnkJEYxS5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-9I-LSo7ONXy6_6bN5FlMKQ-1; Tue, 10 Mar 2020 06:39:15 -0400
X-MC-Unique: 9I-LSo7ONXy6_6bN5FlMKQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DAC69800D5B;
        Tue, 10 Mar 2020 10:39:13 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.36.118.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B02EB60C99;
        Tue, 10 Mar 2020 10:39:04 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Hildenbrand <david@redhat.com>,
        Tyler Sanderson <tysand@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Nadav Amit <namit@vmware.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] virtio-balloon: Switch back to OOM handler for VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Date:   Tue, 10 Mar 2020 11:39:03 +0100
Message-Id: <20200310103903.6014-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker"=
)
changed the behavior when deflation happens automatically. Instead of
deflating when called by the OOM handler, the shrinker is used.

However, the balloon is not simply some other slab cache that should be
shrunk when under memory pressure. The shrinker does not have a concept o=
f
priorities yet, so this behavior cannot be configured. Eventually once
that is in place, we might want to switch back after doing proper
testing.

There was a report that this results in undesired side effects when
inflating the balloon to shrink the page cache. [1]
	"When inflating the balloon against page cache (i.e. no free memory
	 remains) vmscan.c will both shrink page cache, but also invoke the
	 shrinkers -- including the balloon's shrinker. So the balloon
	 driver allocates memory which requires reclaim, vmscan gets this
	 memory by shrinking the balloon, and then the driver adds the
	 memory back to the balloon. Basically a busy no-op."

The name "deflate on OOM" makes it pretty clear when deflation should
happen - after other approaches to reclaim memory failed, not while
reclaiming. This allows to minimize the footprint of a guest - memory
will only be taken out of the balloon when really needed.

Keep using the shrinker for VIRTIO_BALLOON_F_FREE_PAGE_HINT, because
this has no such side effects. Always register the shrinker with
VIRTIO_BALLOON_F_FREE_PAGE_HINT now. We are always allowed to reuse free
pages that are still to be processed by the guest. The hypervisor takes
care of identifying and resolving possible races between processing a
hinting request and the guest reusing a page.

In contrast to pre commit 71994620bb25 ("virtio_balloon: replace oom
notifier with shrinker"), don't add a moodule parameter to configure the
number of pages to deflate on OOM. Can be re-added if really needed.
Also, pay attention that leak_balloon() returns the number of 4k pages -
convert it properly in virtio_balloon_oom_notify().

Testing done by Tyler for future reference:
  Test setup: VM with 16 CPU, 64GB RAM. Running Debian 10. We have a 42
  GB file full of random bytes that we continually cat to /dev/null.
  This fills the page cache as the file is read. Meanwhile we trigger
  the balloon to inflate, with a target size of 53 GB. This setup causes
  the balloon inflation to pressure the page cache as the page cache is
  also trying to grow. Afterwards we shrink the balloon back to zero (so
  total deflate =3D total inflate).

  Without patch (kernel 4.19.0-5):
  Inflation never reaches the target until we stop the "cat file >
  /dev/null" process. Total inflation time was 542 seconds. The longest
  period that made no net forward progress was 315 seconds (see attached
  graph).
  Result of "grep balloon /proc/vmstat" after the test:
  balloon_inflate 154828377
  balloon_deflate 154828377

  With patch (kernel 5.6.0-rc4+):
  Total inflation duration was 63 seconds. No deflate-queue activity
  occurs when pressuring the page-cache.
  Result of "grep balloon /proc/vmstat" after the test:
  balloon_inflate 12968539
  balloon_deflate 12968539

  Conclusion: This patch fixes the issue. In the test it reduced
  inflate/deflate activity by 12x, and reduced inflation time by 8.6x.
  But more importantly, if we hadn't killed the "grep balloon
  /proc/vmstat" process then, without the patch, the inflation process
  would never reach the target.

[1] https://www.spinics.net/lists/linux-virtualization/msg40863.html

Reported-by: Tyler Sanderson <tysand@google.com>
Tested-by: Tyler Sanderson <tysand@google.com>
Fixes: 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker"=
)
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>
Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

v1 -> v2:
- Rebase on top of linux-next (free page reporting)
- Clarified some parts in the patch description and added testing
  instructions/results
- Added Fixes: and Tested-by:

As this patch is based on free page reporting, MST suggested to take this
via Andrew's tree.

---
 drivers/virtio/virtio_balloon.c | 103 +++++++++++++++-----------------
 1 file changed, 47 insertions(+), 56 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ball=
oon.c
index 8511d258dbb4..05c14b541623 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/module.h>
 #include <linux/balloon_compaction.h>
+#include <linux/oom.h>
 #include <linux/wait.h>
 #include <linux/mm.h>
 #include <linux/mount.h>
@@ -28,7 +29,9 @@
  */
 #define VIRTIO_BALLOON_PAGES_PER_PAGE (unsigned)(PAGE_SIZE >> VIRTIO_BAL=
LOON_PFN_SHIFT)
 #define VIRTIO_BALLOON_ARRAY_PFNS_MAX 256
-#define VIRTBALLOON_OOM_NOTIFY_PRIORITY 80
+/* Maximum number of (4k) pages to deflate on OOM notifications. */
+#define VIRTIO_BALLOON_OOM_NR_PAGES 256
+#define VIRTIO_BALLOON_OOM_NOTIFY_PRIORITY 80
=20
 #define VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG (__GFP_NORETRY | __GFP_NOWAR=
N | \
 					     __GFP_NOMEMALLOC)
@@ -114,9 +117,12 @@ struct virtio_balloon {
 	/* Memory statistics */
 	struct virtio_balloon_stat stats[VIRTIO_BALLOON_S_NR];
=20
-	/* To register a shrinker to shrink memory upon memory pressure */
+	/* Shrinker to return free pages - VIRTIO_BALLOON_F_FREE_PAGE_HINT */
 	struct shrinker shrinker;
=20
+	/* OOM notifier to deflate on OOM - VIRTIO_BALLOON_F_DEFLATE_ON_OOM */
+	struct notifier_block oom_nb;
+
 	/* Free page reporting device */
 	struct virtqueue *reporting_vq;
 	struct page_reporting_dev_info pr_dev_info;
@@ -830,50 +836,13 @@ static unsigned long shrink_free_pages(struct virti=
o_balloon *vb,
 	return blocks_freed * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
 }
=20
-static unsigned long leak_balloon_pages(struct virtio_balloon *vb,
-                                          unsigned long pages_to_free)
-{
-	return leak_balloon(vb, pages_to_free * VIRTIO_BALLOON_PAGES_PER_PAGE) =
/
-		VIRTIO_BALLOON_PAGES_PER_PAGE;
-}
-
-static unsigned long shrink_balloon_pages(struct virtio_balloon *vb,
-					  unsigned long pages_to_free)
-{
-	unsigned long pages_freed =3D 0;
-
-	/*
-	 * One invocation of leak_balloon can deflate at most
-	 * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages, so we call it
-	 * multiple times to deflate pages till reaching pages_to_free.
-	 */
-	while (vb->num_pages && pages_freed < pages_to_free)
-		pages_freed +=3D leak_balloon_pages(vb,
-						  pages_to_free - pages_freed);
-
-	update_balloon_size(vb);
-
-	return pages_freed;
-}
-
 static unsigned long virtio_balloon_shrinker_scan(struct shrinker *shrin=
ker,
 						  struct shrink_control *sc)
 {
-	unsigned long pages_to_free, pages_freed =3D 0;
 	struct virtio_balloon *vb =3D container_of(shrinker,
 					struct virtio_balloon, shrinker);
=20
-	pages_to_free =3D sc->nr_to_scan;
-
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
-		pages_freed =3D shrink_free_pages(vb, pages_to_free);
-
-	if (pages_freed >=3D pages_to_free)
-		return pages_freed;
-
-	pages_freed +=3D shrink_balloon_pages(vb, pages_to_free - pages_freed);
-
-	return pages_freed;
+	return shrink_free_pages(vb, sc->nr_to_scan);
 }
=20
 static unsigned long virtio_balloon_shrinker_count(struct shrinker *shri=
nker,
@@ -881,12 +850,22 @@ static unsigned long virtio_balloon_shrinker_count(=
struct shrinker *shrinker,
 {
 	struct virtio_balloon *vb =3D container_of(shrinker,
 					struct virtio_balloon, shrinker);
-	unsigned long count;
=20
-	count =3D vb->num_pages / VIRTIO_BALLOON_PAGES_PER_PAGE;
-	count +=3D vb->num_free_page_blocks * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
+	return vb->num_free_page_blocks * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
+}
=20
-	return count;
+static int virtio_balloon_oom_notify(struct notifier_block *nb,
+				     unsigned long dummy, void *parm)
+{
+	struct virtio_balloon *vb =3D container_of(nb,
+						 struct virtio_balloon, oom_nb);
+	unsigned long *freed =3D parm;
+
+	*freed +=3D leak_balloon(vb, VIRTIO_BALLOON_OOM_NR_PAGES) /
+		  VIRTIO_BALLOON_PAGES_PER_PAGE;
+	update_balloon_size(vb);
+
+	return NOTIFY_OK;
 }
=20
 static void virtio_balloon_unregister_shrinker(struct virtio_balloon *vb=
)
@@ -971,7 +950,22 @@ static int virtballoon_probe(struct virtio_device *v=
dev)
 						  VIRTIO_BALLOON_CMD_ID_STOP);
 		spin_lock_init(&vb->free_page_list_lock);
 		INIT_LIST_HEAD(&vb->free_page_list);
+		/*
+		 * We're allowed to reuse any free pages, even if they are
+		 * still to be processed by the host.
+		 */
+		err =3D virtio_balloon_register_shrinker(vb);
+		if (err)
+			goto out_del_balloon_wq;
 	}
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM)) {
+		vb->oom_nb.notifier_call =3D virtio_balloon_oom_notify;
+		vb->oom_nb.priority =3D VIRTIO_BALLOON_OOM_NOTIFY_PRIORITY;
+		err =3D register_oom_notifier(&vb->oom_nb);
+		if (err < 0)
+			goto out_unregister_shrinker;
+	}
+
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
 		/* Start with poison val of 0 representing general init */
 		__u32 poison_val =3D 0;
@@ -986,15 +980,6 @@ static int virtballoon_probe(struct virtio_device *v=
dev)
 		virtio_cwrite(vb->vdev, struct virtio_balloon_config,
 			      poison_val, &poison_val);
 	}
-	/*
-	 * We continue to use VIRTIO_BALLOON_F_DEFLATE_ON_OOM to decide if a
-	 * shrinker needs to be registered to relieve memory pressure.
-	 */
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM)) {
-		err =3D virtio_balloon_register_shrinker(vb);
-		if (err)
-			goto out_del_balloon_wq;
-	}
=20
 	vb->pr_dev_info.report =3D virtballoon_free_page_report;
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
@@ -1003,12 +988,12 @@ static int virtballoon_probe(struct virtio_device =
*vdev)
 		capacity =3D virtqueue_get_vring_size(vb->reporting_vq);
 		if (capacity < PAGE_REPORTING_CAPACITY) {
 			err =3D -ENOSPC;
-			goto out_unregister_shrinker;
+			goto out_unregister_oom;
 		}
=20
 		err =3D page_reporting_register(&vb->pr_dev_info);
 		if (err)
-			goto out_unregister_shrinker;
+			goto out_unregister_oom;
 	}
=20
 	virtio_device_ready(vdev);
@@ -1017,8 +1002,11 @@ static int virtballoon_probe(struct virtio_device =
*vdev)
 		virtballoon_changed(vdev);
 	return 0;
=20
+out_unregister_oom:
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
+		unregister_oom_notifier(&vb->oom_nb);
 out_unregister_shrinker:
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		virtio_balloon_unregister_shrinker(vb);
 out_del_balloon_wq:
 	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
@@ -1061,7 +1049,10 @@ static void virtballoon_remove(struct virtio_devic=
e *vdev)
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
 		page_reporting_unregister(&vb->pr_dev_info);
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
+		unregister_oom_notifier(&vb->oom_nb);
+	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
 		virtio_balloon_unregister_shrinker(vb);
+
 	spin_lock_irq(&vb->stop_update_lock);
 	vb->stop_update =3D true;
 	spin_unlock_irq(&vb->stop_update_lock);
--=20
2.24.1

