Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED743C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D8521741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgBFIwN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:52:13 -0500
Received: from mga03.intel.com ([134.134.136.65]:9873 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbgBFIwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:52:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 00:52:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,409,1574150400"; 
   d="scan'208";a="264531173"
Received: from devel-ww.sh.intel.com ([10.239.48.128])
  by fmsmga002.fm.intel.com with ESMTP; 06 Feb 2020 00:52:10 -0800
From:   Wei Wang <wei.w.wang@intel.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     tysand@google.com, mst@redhat.com, david@redhat.com,
        alexander.h.duyck@linux.intel.com, rientjes@google.com,
        mhocko@kernel.org, namit@vmware.com,
        penguin-kernel@I-love.SAKURA.ne.jp, wei.w.wang@intel.com
Subject: [PATCH RFC] virtio_balloon: conservative balloon page shrinking
Date:   Thu,  6 Feb 2020 16:01:47 +0800
Message-Id: <1580976107-16013-1-git-send-email-wei.w.wang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are cases that users want to shrink balloon pages after the
pagecache depleted. The conservative_shrinker lets the shrinker
shrink balloon pages when all the pagecache has been reclaimed.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 drivers/virtio/virtio_balloon.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 93f995f6cf36..b4c5bb13a867 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -42,6 +42,10 @@
 static struct vfsmount *balloon_mnt;
 #endif
 
+static bool conservative_shrinker = true;
+module_param(conservative_shrinker, bool, 0644);
+MODULE_PARM_DESC(conservative_shrinker, "conservatively shrink balloon pages");
+
 enum virtio_balloon_vq {
 	VIRTIO_BALLOON_VQ_INFLATE,
 	VIRTIO_BALLOON_VQ_DEFLATE,
@@ -796,6 +800,10 @@ static unsigned long shrink_balloon_pages(struct virtio_balloon *vb,
 {
 	unsigned long pages_freed = 0;
 
+	/* Balloon pages only gets shrunk when the pagecache depleted */
+	if (conservative_shrinker && global_node_page_state(NR_FILE_PAGES))
+		return 0;
+
 	/*
 	 * One invocation of leak_balloon can deflate at most
 	 * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages, so we call it
@@ -837,7 +845,11 @@ static unsigned long virtio_balloon_shrinker_count(struct shrinker *shrinker,
 					struct virtio_balloon, shrinker);
 	unsigned long count;
 
-	count = vb->num_pages / VIRTIO_BALLOON_PAGES_PER_PAGE;
+	if (conservative_shrinker && global_node_page_state(NR_FILE_PAGES))
+		count = 0;
+	else
+		count = vb->num_pages / VIRTIO_BALLOON_PAGES_PER_PAGE;
+
 	count += vb->num_free_page_blocks * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
 
 	return count;
-- 
2.17.1

