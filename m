Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE11C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 488F720825
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="gKh73fs8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgHJQLG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:11:06 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:13841 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726486AbgHJQLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 12:11:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597075865; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=dEsKv9hzNjliBML00TJmrjA5+nUkRn13a4PtjeFm8Uk=; b=gKh73fs8p60nrMets7flcN3rOyrPa4SnirhmEQBk4WNv/EFdNeNItaXFsjKyxqrvtg2iO9e+
 WVo/kytOCaFt+9bB5b4DiCeQ671uKBqv3gYHKxvOIcrFsJIy4L0efEVO/mOoX5j7N0GFq5sj
 tLDML0+mNnQW46Yl4NKkzmES+XI=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n19.prod.us-east-1.postgun.com with SMTP id
 5f317187f2b697637a420105 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 10 Aug 2020 16:10:47
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 04A76C433AD; Mon, 10 Aug 2020 16:10:45 +0000 (UTC)
Received: from charante-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7EFFDC433C6;
        Mon, 10 Aug 2020 16:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7EFFDC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     akpm@linux-foundation.org, mhocko@suse.com, vbabka@suse.cz,
        david@redhat.com, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vinmenon@codeaurora.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH] mm, page_alloc: fix core hung in free_pcppages_bulk()
Date:   Mon, 10 Aug 2020 21:40:33 +0530
Message-Id: <1597075833-16736-1-git-send-email-charante@codeaurora.org>
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

Avoid this by ensuring free_pcppages_bulk() called with proper count of
pcp list pages.

The mentioned race is some what easily reproducible without [1] because
pcp's are not updated for the first memory block online and thus there
is a enough race window for P2 between alloc+free and pcp struct values
update through onlining of second memory block.

With [1], the race is still exists but it is very much narrow as we
update the pcp struct values for the first memory block online itself.

[1]: https://patchwork.kernel.org/patch/11696389/

Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---
 mm/page_alloc.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e4896e6..25e7e12 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3106,6 +3106,7 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn)
 	struct zone *zone = page_zone(page);
 	struct per_cpu_pages *pcp;
 	int migratetype;
+	int high;
 
 	migratetype = get_pcppage_migratetype(page);
 	__count_vm_event(PGFREE);
@@ -3128,8 +3129,19 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn)
 	pcp = &this_cpu_ptr(zone->pageset)->pcp;
 	list_add(&page->lru, &pcp->lists[migratetype]);
 	pcp->count++;
-	if (pcp->count >= pcp->high) {
-		unsigned long batch = READ_ONCE(pcp->batch);
+	high = READ_ONCE(pcp->high);
+	if (pcp->count >= high) {
+		int batch;
+
+		batch = READ_ONCE(pcp->batch);
+		/*
+		 * For non-default pcp struct values, high is always
+		 * greater than the batch. If high < batch then pass
+		 * proper count to free the pcp's list pages.
+		 */
+		if (unlikely(high < batch))
+			batch = min(pcp->count, batch);
+
 		free_pcppages_bulk(zone, batch, pcp);
 	}
 }
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

