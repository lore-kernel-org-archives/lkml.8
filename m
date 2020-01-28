Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645F8C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2EA24681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580220427;
	bh=gTKXZqGSWTCaq/2mjRbkSq8dGOn8KG/W2Ti1fQPskK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h7p+NI71RHM9EFXUfafy6Oiac/7+JE1yjfLvf6Ywfmn14EX7CCDC7ZtdY8LzFqmti
	 DxeCdpn/grDnZY/71pdiReOKf6sHA9jeJ0xh8hcgV99gUnvtrWWF/Zxt5BqoXdkUL5
	 R1HlCVwuQ6dCbcaRdUy6vFd8LX4/MpAW7W0hSUXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbgA1OD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:03:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727942AbgA1ODu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:03:50 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 347D624683;
        Tue, 28 Jan 2020 14:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220229;
        bh=gTKXZqGSWTCaq/2mjRbkSq8dGOn8KG/W2Ti1fQPskK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rlNw7l5hjOPp3t8xT6uTo7jgzjHSk3P41QtL8fwPVWSUiKA8K2CszvH3AQl4I+k4k
         /q+Mx+Fm9yPc+lq1Wo4uv3+gg9Yh1Lep9tkntFvHJdMMZoiIuLKrujhGuGe9YpU39d
         Fr8b6axcSgKVw/nx+Fa6LCKtYU+yjEyXjQW6Gi88=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Stezenbach <js@sig21.net>,
        Alexander Potapenko <glider@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 5.4 041/104] PM: hibernate: fix crashes with init_on_free=1
Date:   Tue, 28 Jan 2020 15:00:02 +0100
Message-Id: <20200128135823.321759348@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135817.238524998@linuxfoundation.org>
References: <20200128135817.238524998@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Potapenko <glider@google.com>

commit 18451f9f9e5810b8bd1245c5ae166f257e0e2b9d upstream.

Upon resuming from hibernation, free pages may contain stale data from
the kernel that initiated the resume. This breaks the invariant
inflicted by init_on_free=1 that freed pages must be zeroed.

To deal with this problem, make clear_free_pages() also clear the free
pages when init_on_free is enabled.

Fixes: 6471384af2a6 ("mm: security: introduce init_on_alloc=1 and init_on_free=1 boot options")
Reported-by: Johannes Stezenbach <js@sig21.net>
Signed-off-by: Alexander Potapenko <glider@google.com>
Cc: 5.3+ <stable@vger.kernel.org> # 5.3+
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/power/snapshot.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1147,24 +1147,24 @@ void free_basic_memory_bitmaps(void)
 
 void clear_free_pages(void)
 {
-#ifdef CONFIG_PAGE_POISONING_ZERO
 	struct memory_bitmap *bm = free_pages_map;
 	unsigned long pfn;
 
 	if (WARN_ON(!(free_pages_map)))
 		return;
 
-	memory_bm_position_reset(bm);
-	pfn = memory_bm_next_pfn(bm);
-	while (pfn != BM_END_OF_MAP) {
-		if (pfn_valid(pfn))
-			clear_highpage(pfn_to_page(pfn));
-
+	if (IS_ENABLED(CONFIG_PAGE_POISONING_ZERO) || want_init_on_free()) {
+		memory_bm_position_reset(bm);
 		pfn = memory_bm_next_pfn(bm);
+		while (pfn != BM_END_OF_MAP) {
+			if (pfn_valid(pfn))
+				clear_highpage(pfn_to_page(pfn));
+
+			pfn = memory_bm_next_pfn(bm);
+		}
+		memory_bm_position_reset(bm);
+		pr_info("free pages cleared after restore\n");
 	}
-	memory_bm_position_reset(bm);
-	pr_info("free pages cleared after restore\n");
-#endif /* PAGE_POISONING_ZERO */
 }
 
 /**


