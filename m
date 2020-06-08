Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D12C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82CCE20814
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591658396;
	bh=DeTCi+evNa25ktxq1NUlS81kxYThJ6DbPYwt78qnKrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sKBI8jynrSpGyi3lwTJHJ6CckQ3ANz2ar57cBnYGLKi4fkvfS1vzrSYLgtiaTB5pK
	 irI1RPJ6prGMyDT7hk7aCvh6STH5yKibI011UYFDW7sFWYAfxSg8MgW5hb8reGG+XM
	 SpzGflPMM6FTlAGRp66+iJlhJB6CNzEGgbWMVz24=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbgFHXTy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:37292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730163AbgFHXQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:16:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 914762076C;
        Mon,  8 Jun 2020 23:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658163;
        bh=DeTCi+evNa25ktxq1NUlS81kxYThJ6DbPYwt78qnKrc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pnSKcxu0oHzosChxZachnqvWDKSeL3Oufd18X6/oMM034JwiLhHy+JJn4+eto5GbP
         Xeowak7D8p12Q6qA5YLfE7u2Pc28VgNU35yjPSMQIqrESnYIqsi2Y4Bd1yA9OvYp0u
         uOjk2lpmVwhriM3zADYIwi5almyPw18o1hSqHejs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Qian Cai <cai@lca.pw>, Raymond Jennings <shentino@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org
Subject: [PATCH AUTOSEL 5.6 192/606] z3fold: fix use-after-free when freeing handles
Date:   Mon,  8 Jun 2020 19:05:17 -0400
Message-Id: <20200608231211.3363633-192-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uladzislau Rezki <uladzislau.rezki@sony.com>

commit d8f117abb380ba968b5e3ef2042d901c02872a4c upstream.

free_handle() for a foreign handle may race with inter-page compaction,
what can lead to memory corruption.

To avoid that, take write lock not read lock in free_handle to be
synchronized with __release_z3fold_page().

For example KASAN can detect it:

  ==================================================================
  BUG: KASAN: use-after-free in LZ4_decompress_safe+0x2c4/0x3b8
  Read of size 1 at addr ffffffc976695ca3 by task GoogleApiHandle/4121

  CPU: 0 PID: 4121 Comm: GoogleApiHandle Tainted: P S         OE     4.19.81-perf+ #162
  Hardware name: Sony Mobile Communications. PDX-203(KONA) (DT)
  Call trace:
     LZ4_decompress_safe+0x2c4/0x3b8
     lz4_decompress_crypto+0x3c/0x70
     crypto_decompress+0x58/0x70
     zcomp_decompress+0xd4/0x120
     ...

Apart from that, initialize zhdr->mapped_count in init_z3fold_page() and
remove "newpage" variable because it is not used anywhere.

Signed-off-by: Uladzislau Rezki <uladzislau.rezki@sony.com>
Signed-off-by: Vitaly Wool <vitaly.wool@konsulko.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Qian Cai <cai@lca.pw>
Cc: Raymond Jennings <shentino@gmail.com>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20200520082100.28876-1-vitaly.wool@konsulko.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/z3fold.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index 42f31c4b53ad..8c3bb5e508b8 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -318,16 +318,16 @@ static inline void free_handle(unsigned long handle)
 	slots = handle_to_slots(handle);
 	write_lock(&slots->lock);
 	*(unsigned long *)handle = 0;
-	write_unlock(&slots->lock);
-	if (zhdr->slots == slots)
+	if (zhdr->slots == slots) {
+		write_unlock(&slots->lock);
 		return; /* simple case, nothing else to do */
+	}
 
 	/* we are freeing a foreign handle if we are here */
 	zhdr->foreign_handles--;
 	is_free = true;
-	read_lock(&slots->lock);
 	if (!test_bit(HANDLES_ORPHANED, &slots->pool)) {
-		read_unlock(&slots->lock);
+		write_unlock(&slots->lock);
 		return;
 	}
 	for (i = 0; i <= BUDDY_MASK; i++) {
@@ -336,7 +336,7 @@ static inline void free_handle(unsigned long handle)
 			break;
 		}
 	}
-	read_unlock(&slots->lock);
+	write_unlock(&slots->lock);
 
 	if (is_free) {
 		struct z3fold_pool *pool = slots_to_pool(slots);
@@ -422,6 +422,7 @@ static struct z3fold_header *init_z3fold_page(struct page *page, bool headless,
 	zhdr->start_middle = 0;
 	zhdr->cpu = -1;
 	zhdr->foreign_handles = 0;
+	zhdr->mapped_count = 0;
 	zhdr->slots = slots;
 	zhdr->pool = pool;
 	INIT_LIST_HEAD(&zhdr->buddy);
-- 
2.25.1

