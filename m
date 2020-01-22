Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42B0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9797F205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699141;
	bh=qFu7OqLxiAfjXgCPK2D2NL2a2kSle7lyuguriALwEBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2T55sVZuBKCTmE7/c7cm6+hi3P7z9G9ldaw068lk0nnfl+NKN2X1tiyTRMZyktHu8
	 zxPjodgStAm9MbYBBF+qGXs8nn+kxDq74LSIVLrFttIhpKPJLFHYeL71wjykaczyLU
	 K2aHc6aSailHxUtHccNCwIhaoDfQp8y+gidbvEfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgAVNTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:19:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:34656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbgAVNSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:18:53 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E39AA205F4;
        Wed, 22 Jan 2020 13:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699132;
        bh=qFu7OqLxiAfjXgCPK2D2NL2a2kSle7lyuguriALwEBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=daqRY0ALQ0zTZqWQqfNUG8tg0r6WEcVQKZZfF7He1v71WNRvgFQnT0Uahfl53JVzx
         2mKQc9I1AAxtZs8Kb4vjgb3hXdw5CTyk/zjNUpnHyhvokx0aYMteNfB+OsNsnqYeVf
         7EaSC+vAU9jWYTnFxaJ8OC2ruOIs2wlcSJfitF08=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefan Metzmacher <metze@samba.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.4 033/222] io_uring: only allow submit from owning task
Date:   Wed, 22 Jan 2020 10:26:59 +0100
Message-Id: <20200122092835.852416399@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

commit 44d282796f81eb1debc1d7cb53245b4cb3214cb5 upstream.

If the credentials or the mm doesn't match, don't allow the task to
submit anything on behalf of this ring. The task that owns the ring can
pass the file descriptor to another task, but we don't want to allow
that task to submit an SQE that then assumes the ring mm and creds if
it needs to go async.

Cc: stable@vger.kernel.org
Suggested-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


---
 fs/io_uring.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -3716,6 +3716,12 @@ SYSCALL_DEFINE6(io_uring_enter, unsigned
 			wake_up(&ctx->sqo_wait);
 		submitted = to_submit;
 	} else if (to_submit) {
+		if (current->mm != ctx->sqo_mm ||
+		    current_cred() != ctx->creds) {
+			ret = -EPERM;
+			goto out;
+		}
+
 		to_submit = min(to_submit, ctx->sq_entries);
 
 		mutex_lock(&ctx->uring_lock);


