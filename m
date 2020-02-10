Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F86C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C7E20714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581340390;
	bh=woBNc1etvzbOqdR0JwFBLJUqICi0lJEjoZkrPEyPtC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NEkGXg3tO/DhJVBIVSNTMSbBnsj2T5jYfyidT3z0EeHHJKsTxZcrJkSl89OfYqgfJ
	 zf3iPujBdtcG8J7/H/42jhIsMAAV4n6DlzgXd4Y03OE6Gmi9K7QCB+kibHjYy5OUi9
	 0fTu6dijvY4DVEpqq/5R13h3rB4+hYRX6vedUv28=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgBJNNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:13:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:34822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbgBJMin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:38:43 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A27620842;
        Mon, 10 Feb 2020 12:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338323;
        bh=woBNc1etvzbOqdR0JwFBLJUqICi0lJEjoZkrPEyPtC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G3hv8ir6Y1iosLB+s4CYHNcUlxstrxg5r2Dq/bWhCxG+N7qUS6f0G5ZX4fu7uCaCw
         lIuXh+XOrDQQjLK2tWNdqbB4Cb38Hkti9pLZG9pQbZ9qKOJYoPa+cGAkTf3zBsmnWt
         uA1qW/yLi+nqzcbcTRpjxXhpCPIbs3KC4SIYc0Cc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Liang Li <liang.z.li@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH 5.4 256/309] virtio-balloon: Fix memory leak when unloading while hinting is in progress
Date:   Mon, 10 Feb 2020 04:33:32 -0800
Message-Id: <20200210122431.167308054@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122406.106356946@linuxfoundation.org>
References: <20200210122406.106356946@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Hildenbrand <david@redhat.com>

commit 6c22dc61c76b7e7d355f1697ba0ecf26d1334ba6 upstream.

When unloading the driver while hinting is in progress, we will not
release the free page blocks back to MM, resulting in a memory leak.

Fixes: 86a559787e6f ("virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT")
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>
Cc: Liang Li <liang.z.li@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20200205163402.42627-2-david@redhat.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/virtio/virtio_balloon.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -967,6 +967,10 @@ static void remove_common(struct virtio_
 		leak_balloon(vb, vb->num_pages);
 	update_balloon_size(vb);
 
+	/* There might be free pages that are being reported: release them. */
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
+		return_free_pages_to_mm(vb, ULONG_MAX);
+
 	/* Now we reset the device so we can clean up the queues. */
 	vb->vdev->config->reset(vb->vdev);
 


