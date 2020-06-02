Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07659C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4C0220679
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="lJkZ+qas"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgFBMmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:42:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:57159 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgFBMmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:42:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591101743; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=5Vd/bdUNGvly/grt98Jx4x27H8iSAXBdUqjZmOyOWf0=; b=lJkZ+qasACzeUN5DUiJLgkZn6GQiL0C1lJvHB2XwveQGOs3hDF/ieKZH9SC8PaYyYg4uIM/7
 NklFtDNYRas2SRT0e9lA3xZdWpA27QuzxUgncW7XKni8m7Bbo8ARj3+Q2o3CfCX7zSmlIZEz
 0O0n+zJEs9d3ejkH0fr0vfGDvnk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5ed64919082f42857f6b8f85 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Jun 2020 12:42:01
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DFA9DC43395; Tue,  2 Jun 2020 12:42:00 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 62AFCC433C6;
        Tue,  2 Jun 2020 12:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 62AFCC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] f2fs: fix retry logic in f2fs_write_cache_pages()
Date:   Tue,  2 Jun 2020 18:11:47 +0530
Message-Id: <1591101707-18802-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case a compressed file is getting overwritten, the current retry
logic doesn't include the current page to be retried now as it sets
the new start index as 0 and new end index as writeback_index - 1.
This causes the corresponding cluster to be uncompressed and written
as normal pages without compression. Fix this by allowing writeback to
be retried for the current page as well (in case of compressed page
getting retried due to index mismatch with cluster index). So that
this cluster can be written compressed in case of overwrite.

Also, align f2fs_write_cache_pages() according to the change -
<64081362e8ff>("mm/page-writeback.c: fix range_cyclic writeback vs
writepages deadlock").

Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
v2: 
- Align the code to <64081362e8ff>("mm/page-writeback.c: fix range_cyclic
  writeback vs writepages deadlock") and adjust the retry logic also as per
  Chao's suggestion.

 fs/f2fs/data.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4af5fcd..31af29f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2825,7 +2825,6 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	pgoff_t index;
 	pgoff_t end;		/* Inclusive */
 	pgoff_t done_index;
-	int cycled;
 	int range_whole = 0;
 	xa_mark_t tag;
 	int nwritten = 0;
@@ -2843,17 +2842,12 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 	if (wbc->range_cyclic) {
 		writeback_index = mapping->writeback_index; /* prev offset */
 		index = writeback_index;
-		if (index == 0)
-			cycled = 1;
-		else
-			cycled = 0;
 		end = -1;
 	} else {
 		index = wbc->range_start >> PAGE_SHIFT;
 		end = wbc->range_end >> PAGE_SHIFT;
 		if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
 			range_whole = 1;
-		cycled = 1; /* ignore range_cyclic tests */
 	}
 	if (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages)
 		tag = PAGECACHE_TAG_TOWRITE;
@@ -3021,12 +3015,13 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 		}
 	}
 #endif
-	if ((!cycled && !done) || retry) {
-		cycled = 1;
+	if (retry) {
 		index = 0;
-		end = writeback_index - 1;
+		end = -1;
 		goto retry;
 	}
+	if (wbc->range_cyclic && !done)
+		done_index = 0;
 	if (wbc->range_cyclic || (range_whole && wbc->nr_to_write > 0))
 		mapping->writeback_index = done_index;
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

