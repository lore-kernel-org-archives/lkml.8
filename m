Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB983C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BE5A2076C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599592017;
	bh=xTbTZQwcFfwTu49vSPOjDxR+iw+rx0T18NBD7Z6Jznw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1PT4/UU8Q4lDps9Ztk+So95AxoySjTou+WwSmP0CFBOLxO4AVdcQLY4BIcuAho7ik
	 ArxcGpG9Z8HC1XF5mWJNnoVb98A3pYTwpTFBlaBerY61J1KbXzzybsco75EhS5eVkx
	 EDl1iEDyS5YYfFOpTChd++LlHmBGrHFckuNoSw2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731667AbgIHTGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:06:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:52114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731177AbgIHQHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:07:21 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88BBC23DC4;
        Tue,  8 Sep 2020 15:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599580014;
        bh=xTbTZQwcFfwTu49vSPOjDxR+iw+rx0T18NBD7Z6Jznw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MJEDcbPWQvFSf6PB3+UUksknb391BExWzYezHLlSwFc14IjnFlWt8fXPiDJ5e7O/z
         XTHpB3OlO0f2e61an5APJ7zo10ogShiNUGUcgBafLA9AjWnyFvK1vTUTmFk0YobNtg
         rDDal2/9mRfBN4LABufyJm9thgGx49JBfWoWsOVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.4 108/129] block: ensure bdi->io_pages is always initialized
Date:   Tue,  8 Sep 2020 17:25:49 +0200
Message-Id: <20200908152235.235494023@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152229.689878733@linuxfoundation.org>
References: <20200908152229.689878733@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

commit de1b0ee490eafdf65fac9eef9925391a8369f2dc upstream.

If a driver leaves the limit settings as the defaults, then we don't
initialize bdi->io_pages. This means that file systems may need to
work around bdi->io_pages == 0, which is somewhat messy.

Initialize the default value just like we do for ->ra_pages.

Cc: stable@vger.kernel.org
Fixes: 9491ae4aade6 ("mm: don't cap request size based on read-ahead setting")
Reported-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -502,6 +502,7 @@ struct request_queue *blk_alloc_queue_no
 		goto fail_stats;
 
 	q->backing_dev_info->ra_pages = VM_READAHEAD_PAGES;
+	q->backing_dev_info->io_pages = VM_READAHEAD_PAGES;
 	q->backing_dev_info->capabilities = BDI_CAP_CGROUP_WRITEBACK;
 	q->backing_dev_info->name = "block";
 	q->node = node_id;


