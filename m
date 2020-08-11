Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A929EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84D44206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="cjWNsYWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgHKM6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 08:58:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:18407 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728566AbgHKM6q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 08:58:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597150726; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Sx3ep+KIHVu/tITGzEEH1tzVULyGxJl+pKTXi6iVWK8=; b=cjWNsYWzWb33DrKDncz97NkbXdzEnEu3DwgdjKs9c9v42VJKVbAqU8LT/qZK9B8GH+8krfRb
 ktiriFbgAlGBBGAK17isw+k/WeIipj206QuQ+uJKlYh87kDTWU8AoAoGQ4WOaGSIjuwBcjIf
 Hjz7TmOWDLPvdKMJ1qdCj/PWuz0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5f3296002f4952907d83f9c8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 11 Aug 2020 12:58:40
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 22D42C433CA; Tue, 11 Aug 2020 12:58:40 +0000 (UTC)
Received: from charante-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F332C433C9;
        Tue, 11 Aug 2020 12:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F332C433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        david@redhat.com, rientjes@google.com, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vinmenon@codeaurora.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH V2] mm, page_alloc: fix core hung in free_pcppages_bulk()
Date:   Tue, 11 Aug 2020 18:28:23 +0530
Message-Id: <1597150703-19003-1-git-send-email-charante@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following race is observed with the repeated online, offline and a
delay between two successive online of memory blocks of movable zone.

P1						P2

Online the first memory block in
the movable zone. The pcp struct
values are initialized to default
values,i.e., pcp->high = 0 &
pcp->batch = 1.

					Allocate the pages from the
					movable zone.

Try to Online the second memory
block in the movable zone thus it
entered the online_pages() but yet
to call zone_pcp_update().
					This process is entered into
					the exit path thus it tries
					to release the order-0 pages
					to pcp lists through
					free_unref_page_commit().
					As pcp->high = 0, pcp->count = 1
					proceed to call the function
					free_pcppages_bulk().
Update the pcp values thus the
new pcp values are like, say,
pcp->high = 378, pcp->batch = 63.
					Read the pcp's batch value using
					READ_ONCE() and pass the same to
					free_pcppages_bulk(), pcp values
					passed here are, batch = 63,
					count = 1.

					Since num of pages in the pcp
					lists are less than ->batch,
					then it will stuck in
					while(list_empty(list)) loop
					with interrupts disabled thus
					a core hung.

Avoid this by ensuring free_pcppages_bulk() is called with proper count
of pcp list pages.

The mentioned race is some what easily reproducible without [1] because
pcp's are not updated for the first memory block online and thus there
is a enough race window for P2 between alloc+free and pcp struct values
update through onlining of second memory block.

With [1], the race is still exists but it is very much narrow as we
update the pcp struct values for the first memory block online itself.

[1]: https://patchwork.kernel.org/patch/11696389/

Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---

v1: https://patchwork.kernel.org/patch/11707637/

 mm/page_alloc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e4896e6..839039f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1304,6 +1304,11 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	struct page *page, *tmp;
 	LIST_HEAD(head);
 
+	/*
+	 * Ensure proper count is passed which otherwise would stuck in the
+	 * below while (list_empty(list)) loop.
+	 */
+	count = min(pcp->count, count);
 	while (count) {
 		struct list_head *list;
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

