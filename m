Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B486C18E5A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D912468E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844815;
	bh=RdwNiBrqBMF96enX3Y8lOCJkGzpZXUYtdAP1pkP1rzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u0Kfl4aKvO7d0s5UgQj8rTjGtuQ4nFTrqSK1F9YmhTKh0Nt9MPNplePSJ1GNUIAyP
	 L7TGSfWbuC6SAMpXDv5JieU3X1MVIJr9SDowxR4GtMp7hn77U/zNSfEWry9l9z6COH
	 D41oM5cpQED/hSQUwA1Xljcx7b8K2x8y7bXJbArc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbgCJMxd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:53:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729188AbgCJMx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:53:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5747A2253D;
        Tue, 10 Mar 2020 12:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844808;
        bh=RdwNiBrqBMF96enX3Y8lOCJkGzpZXUYtdAP1pkP1rzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CWoKq65JsGhoO1SZdy5GWbwH2rkVsRJBzz4d2newGbeVVbtHLI4OkTYfoBDKYFTj+
         fpgTV/dl5S09LjLZWsCKY+IjcyuuF6nH/ZUNBhnXSfleiCCeboOhuX9rpI2K4/5KGv
         PMEW1jrh4FytAN+WutigyXDKufN0nHgFt5GokFXs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 5.4 109/168] dm writecache: verify watermark during resume
Date:   Tue, 10 Mar 2020 13:39:15 +0100
Message-Id: <20200310123646.428917143@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

commit 41c526c5af46d4c4dab7f72c99000b7fac0b9702 upstream.

Verify the watermark upon resume - so that if the target is reloaded
with lower watermark, it will start the cleanup process immediately.

Fixes: 48debafe4f2f ("dm: add writecache target")
Cc: stable@vger.kernel.org # 4.18+
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-writecache.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -625,6 +625,12 @@ static void writecache_add_to_freelist(s
 	wc->freelist_size++;
 }
 
+static inline void writecache_verify_watermark(struct dm_writecache *wc)
+{
+	if (unlikely(wc->freelist_size + wc->writeback_size <= wc->freelist_high_watermark))
+		queue_work(wc->writeback_wq, &wc->writeback_work);
+}
+
 static struct wc_entry *writecache_pop_from_freelist(struct dm_writecache *wc)
 {
 	struct wc_entry *e;
@@ -646,8 +652,8 @@ static struct wc_entry *writecache_pop_f
 		list_del(&e->lru);
 	}
 	wc->freelist_size--;
-	if (unlikely(wc->freelist_size + wc->writeback_size <= wc->freelist_high_watermark))
-		queue_work(wc->writeback_wq, &wc->writeback_work);
+
+	writecache_verify_watermark(wc);
 
 	return e;
 }
@@ -961,6 +967,8 @@ erase_this:
 		writecache_commit_flushed(wc, false);
 	}
 
+	writecache_verify_watermark(wc);
+
 	wc_unlock(wc);
 }
 


