Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F053AC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3F6520578
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 12:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="UtSY7tjj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731401AbgGOMtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 08:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731342AbgGOMs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 08:48:57 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477A4C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 05:48:57 -0700 (PDT)
Received: from Q.local (cpc89242-aztw30-2-0-cust488.18-1.cable.virginm.net [86.31.129.233])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id ECDFEF7E;
        Wed, 15 Jul 2020 14:48:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1594817335;
        bh=u9Cm7lA4aBFNKRUo0tffD5UvM74Xr5Kxc/Se1oDySRQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UtSY7tjjcJelEBGaEVU6X+F6L1nfEn8ne3g6gR9doTU3d66NdI1Kwl4I2gbD4XxNy
         BaTHqGt0/JNKOmxza/OunYpzCHq7SctqGr8TH+OVzFT+rjxm7CEpQTeXDcUE+BsG7t
         lmIM0NFPhXhGVgPhKvkADGNjKnQ5ZCRfn4YFJYW0=
From:   Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To:     trivial@kernel.org
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Hildenbrand <david@redhat.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO BALLOON),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 7/8] mm/balloon_compaction: Fix trivial spelling
Date:   Wed, 15 Jul 2020 13:48:38 +0100
Message-Id: <20200715124839.252822-8-kieran.bingham+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200715124839.252822-1-kieran.bingham+renesas@ideasonboard.com>
References: <20200715124839.252822-1-kieran.bingham+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The word 'descriptor' is misspelled throughout the tree.

Fix it up accordingly:
    decriptor -> descriptor

Signed-off-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
v2:
 - Fix commit message to reflect actual word replaced
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

