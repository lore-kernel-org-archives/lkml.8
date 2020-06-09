Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A46C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:34:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A0220734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rRn6/k2K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgFIOeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbgFIOeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:34:22 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE51C05BD1E;
        Tue,  9 Jun 2020 07:34:21 -0700 (PDT)
Received: from Q.local (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id C8219291;
        Tue,  9 Jun 2020 16:34:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1591713257;
        bh=0agNJjMqAgbhptd9szuIECxsg77Xz5IU7DFai665Qsg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rRn6/k2KQ1mipGk67KnjVjebbei7C7lTbTMDXm/CgMrvl5ODofqN6pDcsA2wJ9njZ
         zy17vrqPTyuaLRQQMibavu5GGAEEuyib6BTvZSm+0SlL9Bh93oI3F5T4x3pVD+f0Vw
         pmQqLkzJf+DmnG5n9JULJMjPc1TvzdX3AQnYSp0Q=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Kosina <trivial@kernel.org>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO CORE AND
        NET DRIVERS), linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] mm/balloon_compaction: Fix trivial spelling
Date:   Tue,  9 Jun 2020 15:34:12 +0100
Message-Id: <20200609143412.3456484-1-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200609124610.3445662-16-kieran.bingham+renesas@ideasonboard.com>
References: <20200609124610.3445662-16-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The word 'descriptor' is misspelled throughout the tree.

Fix it up accordingly:
    decriptors -> descriptors

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/balloon_compaction.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 26de020aae7b..907fefde2572 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -58,7 +58,7 @@ EXPORT_SYMBOL_GPL(balloon_page_list_enqueue);
 /**
  * balloon_page_list_dequeue() - removes pages from balloon's page list and
  *				 returns a list of the pages.
- * @b_dev_info: balloon device decriptor where we will grab a page from.
+ * @b_dev_info: balloon device descriptor where we will grab a page from.
  * @pages: pointer to the list of pages that would be returned to the caller.
  * @n_req_pages: number of requested pages.
  *
@@ -157,7 +157,7 @@ EXPORT_SYMBOL_GPL(balloon_page_enqueue);
 /*
  * balloon_page_dequeue - removes a page from balloon's page list and returns
  *			  its address to allow the driver to release the page.
- * @b_dev_info: balloon device decriptor where we will grab a page from.
+ * @b_dev_info: balloon device descriptor where we will grab a page from.
  *
  * Driver must call this function to properly dequeue a previously enqueued page
  * before definitively releasing it back to the guest system.
-- 
2.25.1

