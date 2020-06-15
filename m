Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3975C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC98E2068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="v9yU02AT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgFOJ56 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:57:58 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:22915 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbgFOJ56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:57:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592215077; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=x4pbcEfTHQQiuFcc3iK26RbpCmgWr/+nQ32We6j78BY=; b=v9yU02ATy0OU8HwregNCUzz1g15wYolwOw0Sq8f3Swm2+FH/Bsox9iRCZFU0no+t5CgGu7TP
 0vFCSIoxRmgh3ccQNJZX/6LIjrKAer4XS5NS+XLMq5rWzd4mrVjVv40+TWAved9abGkej1lp
 fOoshIMM0GfuZoUSpLrUtEwlejY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 5ee7460da3d8a44743f9532d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 15 Jun 2020 09:57:33
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4BD4DC433CB; Mon, 15 Jun 2020 09:57:32 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 40C02C433CA;
        Mon, 15 Jun 2020 09:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 40C02C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Satya Tangirala <satyat@google.com>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Sahitya Tummala <stummala@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] f2fs: fix use-after-free when accessing bio->bi_crypt_context
Date:   Mon, 15 Jun 2020 15:27:15 +0530
Message-Id: <1592215035-27365-1-git-send-email-stummala@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be a potential race between these two paths below,
leading to use-after-free when accessing  bio->bi_crypt_context.

f2fs_write_cache_pages
->f2fs_do_write_data_page on page#1
  ->f2fs_inplace_write_data
    ->f2fs_merge_page_bio
      ->add_bio_entry
->f2fs_do_write_data_page on page#2
  ->f2fs_inplace_write_data
    ->f2fs_merge_page_bio
      ->f2fs_crypt_mergeable_bio
        ->fscrypt_mergeable_bio
  				       f2fs_write_begin on page#1
				       ->f2fs_wait_on_page_writeback
				         ->f2fs_submit_merged_ipu_write
					   ->__submit_bio
					The bio gets completed, calling
					bio_endio
					->bio_uninit
					  ->bio_crypt_free_ctx
	  ->use-after-free issue

Fix this by moving f2fs_crypt_mergeable_bio() check within
add_ipu_page() so that it's done under bio_list_lock to prevent
the above race.

Fixes: 15e76ad23e72 ("f2fs: add inline encryption support")
Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
---
v2:
  - simplify the logic as per Eric's suggestion to submit the bio in
    add_ipu_page() itself instead of using f2fs_submit_merged_ipu_write()

 fs/f2fs/data.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0dfa8d3..9710555 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -762,9 +762,10 @@ static void del_bio_entry(struct bio_entry *be)
 	kmem_cache_free(bio_entry_slab, be);
 }
 
-static int add_ipu_page(struct f2fs_sb_info *sbi, struct bio **bio,
+static int add_ipu_page(struct f2fs_io_info *fio, struct bio **bio,
 							struct page *page)
 {
+	struct f2fs_sb_info *sbi = fio->sbi;
 	enum temp_type temp;
 	bool found = false;
 	int ret = -EAGAIN;
@@ -780,6 +781,16 @@ static int add_ipu_page(struct f2fs_sb_info *sbi, struct bio **bio,
 				continue;
 
 			found = true;
+			if (page_is_mergeable(sbi, *bio, *fio->last_block,
+						fio->new_blkaddr) &&
+			    f2fs_crypt_mergeable_bio(*bio,
+						    fio->page->mapping->host,
+						    fio->page->index, fio) &&
+			    bio_add_page(*bio, page, PAGE_SIZE, 0) ==
+					    PAGE_SIZE) {
+				ret = 0;
+				break;
+			}
 
 			if (bio_add_page(*bio, page, PAGE_SIZE, 0) ==
 							PAGE_SIZE) {
@@ -787,7 +798,7 @@ static int add_ipu_page(struct f2fs_sb_info *sbi, struct bio **bio,
 				break;
 			}
 
-			/* bio is full */
+			/* page can't be merged into bio; submit the bio */
 			del_bio_entry(be);
 			__submit_bio(sbi, *bio, DATA);
 			break;
@@ -872,11 +883,6 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	trace_f2fs_submit_page_bio(page, fio);
 	f2fs_trace_ios(fio, 0);
 
-	if (bio && (!page_is_mergeable(fio->sbi, bio, *fio->last_block,
-				       fio->new_blkaddr) ||
-		    !f2fs_crypt_mergeable_bio(bio, fio->page->mapping->host,
-					      fio->page->index, fio)))
-		f2fs_submit_merged_ipu_write(fio->sbi, &bio, NULL);
 alloc_new:
 	if (!bio) {
 		bio = __bio_alloc(fio, BIO_MAX_PAGES);
@@ -886,7 +892,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 
 		add_bio_entry(fio->sbi, bio, page, fio->temp);
 	} else {
-		if (add_ipu_page(fio->sbi, &bio, page))
+		if (add_ipu_page(fio, &bio, page))
 			goto alloc_new;
 	}
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

