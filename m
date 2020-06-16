Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA83C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 209072071A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 16:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323832;
	bh=AK6OqC3xja+xnPhxSEPb+ZQP/swy05uCs5cvUpjqHzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BLrgvpRTEa9YlLBaeBfrz30VuO7J3kAsFPFYxs4z2RnVVrOA7T4wZg6XUuGf0KM49
	 WJOu7CcNTLEVZJnTM+gssJ1biNYYn+T9eeaBuYLibc+oBK+NpJ1T+LeYC8DqnzNl4/
	 peWcSUaWjTaRUZjCvmT4YVNoJbqPNGQxNJT33O+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731972AbgFPPoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:44:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:34492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731968AbgFPPoT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:44:19 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2230214DB;
        Tue, 16 Jun 2020 15:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322259;
        bh=AK6OqC3xja+xnPhxSEPb+ZQP/swy05uCs5cvUpjqHzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DZj01Tsb3/ILKpiKzxJ4dzWVgIIa1p8ORa+bV892qrvwNpAq7ZOBjaYh84auFwhK6
         DKxd0mHtBMuhkNe8LLins1ZZ+oarXCbs6XgJsN0oylKxF6j7l8v9GWrlAXC3gK9r1t
         vUadX8Jaj0WC+ZEOCi3mpl4xJtw2SwUDghu6OTJ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Efremov <efremov@linux.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.7 055/163] io_uring: use kvfree() in io_sqe_buffer_register()
Date:   Tue, 16 Jun 2020 17:33:49 +0200
Message-Id: <20200616153109.480954030@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Efremov <efremov@linux.com>

commit a8c73c1a614f6da6c0b04c393f87447e28cb6de4 upstream.

Use kvfree() to free the pages and vmas, since they are allocated by
kvmalloc_array() in a loop.

Fixes: d4ef647510b1 ("io_uring: avoid page allocation warnings")
Signed-off-by: Denis Efremov <efremov@linux.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20200605093203.40087-1-efremov@linux.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/io_uring.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -7093,8 +7093,8 @@ static int io_sqe_buffer_register(struct
 
 		ret = 0;
 		if (!pages || nr_pages > got_pages) {
-			kfree(vmas);
-			kfree(pages);
+			kvfree(vmas);
+			kvfree(pages);
 			pages = kvmalloc_array(nr_pages, sizeof(struct page *),
 						GFP_KERNEL);
 			vmas = kvmalloc_array(nr_pages,


