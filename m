Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FDDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B38912067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597689414;
	bh=y708uWgSHbGvpVbbWkqv/I//b1Eb3citB2TGp3O3MF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qMQHsfMWxgVdvz4LJLCZTs8bMJHLww/8GcZnGm5rMiekfH5JVExLWRE9CSKQFHM48
	 gQDqSkrBtQGHSlkhHMLGDKokLQjZTdyx5FdxANCQnrc1GVarQS/H97onjCVAWUzecz
	 1mVISStpp3zSvFXgIVYNGhLQuVL5hR0fzyN9JXxE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390719AbgHQSgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:46322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730946AbgHQP7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:59:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5998120729;
        Mon, 17 Aug 2020 15:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679943;
        bh=y708uWgSHbGvpVbbWkqv/I//b1Eb3citB2TGp3O3MF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ug2euTPlRM3ZFSvwQ1n30i/mPfcoRs59oUty+2RYW6VH+F6XBnXJAAG3esGt4D0PR
         EyOK3HEf6garx4oszAZAQXQRq9CQ+piv6+qyVWtfT3FobQWZSCuabjHdgbYX4Flwqy
         OaouDioUklLXGoDbW09rL29tCN0a/NQV5jWlqfZE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+a730016dc0bdce4f6ff5@syzkaller.appspotmail.com,
        Stefano Garzarella <sgarzare@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.7 357/393] io_uring: fail poll arm on queue proc failure
Date:   Mon, 17 Aug 2020 17:16:47 +0200
Message-Id: <20200817143836.915920303@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

commit a36da65c46565d2527eec3efdb546251e38253fd upstream.

Check the ipt.error value, it must have been either cleared to zero or
set to another error than the default -EINVAL if we don't go through the
waitqueue proc addition. Just give up on poll at that point and return
failure, this will fallback to async work.

io_poll_add() doesn't suffer from this failure case, as it returns the
error value directly.

Cc: stable@vger.kernel.org # v5.7+
Reported-by: syzbot+a730016dc0bdce4f6ff5@syzkaller.appspotmail.com
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/io_uring.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -4544,7 +4544,7 @@ static bool io_arm_poll_handler(struct i
 
 	ret = __io_arm_poll_handler(req, &apoll->poll, &ipt, mask,
 					io_async_wake);
-	if (ret) {
+	if (ret || ipt.error) {
 		io_poll_remove_double(req, apoll->double_poll);
 		spin_unlock_irq(&ctx->completion_lock);
 		memcpy(&req->work, &apoll->work, sizeof(req->work));


