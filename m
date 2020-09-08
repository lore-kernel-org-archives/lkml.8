Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39D8C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ED46207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599588480;
	bh=yak2AVQpBF3q7cNjcP4nggu5l/OGn/Gfsq3p4CB6I/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sbbJCeR1WVDJ/D2O55XMcs/sTRhPYsxDBs20GL9+tlvNA/r+H5jaLCGOYs+4DnXR4
	 bTeiWS43AXzWFriSEg+dtSUXCdKGtPfYzEFSFAPn1zw1FA199rZoy8cYQbww6oGvlQ
	 cmW5cWWgU6jxmDjiGyYFcMa0gqBjX60Q6+b9Mh1s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732162AbgIHSHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:07:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731501AbgIHQLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:11:52 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9C6F246EE;
        Tue,  8 Sep 2020 15:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599579623;
        bh=yak2AVQpBF3q7cNjcP4nggu5l/OGn/Gfsq3p4CB6I/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vqUQSK1j+BXDhe6teQ0z5rbp60gQjUzVfP7BR644LuSyyjUV/xh7UxqaiesWWxM+P
         ZVHoEpxvode53Z2r9+eKg9e6mUSuvnp5gGVSZvNnBKt2kelGeQgCc/Rl7wTSLnl56v
         SljReQIcvWvbQ89St1qWT/I00A8CmqVUkt+ao4TI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiufei Xue <jiufei.xue@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.8 155/186] io_uring: fix removing the wrong file in __io_sqe_files_update()
Date:   Tue,  8 Sep 2020 17:24:57 +0200
Message-Id: <20200908152249.175031831@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908152241.646390211@linuxfoundation.org>
References: <20200908152241.646390211@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiufei Xue <jiufei.xue@linux.alibaba.com>

commit 98dfd5024a2e9e170b85c07078e2d89f20a5dfbd upstream.

Index here is already the position of the file in fixed_file_table, we
should not use io_file_from_index() again to get it. Otherwise, the
wrong file which still in use may be released unexpectedly.

Cc: stable@vger.kernel.org # v5.6
Fixes: 05f3fb3c5397 ("io_uring: avoid ring quiesce for fixed file set unregister and update")
Signed-off-by: Jiufei Xue <jiufei.xue@linux.alibaba.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/io_uring.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -6928,7 +6928,7 @@ static int __io_sqe_files_update(struct
 		table = &ctx->file_data->table[i >> IORING_FILE_TABLE_SHIFT];
 		index = i & IORING_FILE_TABLE_MASK;
 		if (table->files[index]) {
-			file = io_file_from_index(ctx, index);
+			file = table->files[index];
 			err = io_queue_file_removal(data, file);
 			if (err)
 				break;


