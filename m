Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED937C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C503D20738
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597691362;
	bh=FF9yg5Lc3uJgdvr2qf/PcEfwb6Gc7NL6cBLxzjc8CS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cR7CHbP9I+viuwuJAfSPgYjG7trcUgGoOkKON1JLtA3sh8X1YgrSZcBhfsvIHyxuk
	 Dj8fY5Ab0H3UhLmwJrhUdB5c+69KOKFLWN6K5c49EDrYz890XWZhNwrKl3D7nTU5sh
	 hn+kVhuZSuR/6YIpZ3vJBx6byLk+0QBeNp041940=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392059AbgHQTJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387552AbgHQPmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:42:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B746320760;
        Mon, 17 Aug 2020 15:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678951;
        bh=FF9yg5Lc3uJgdvr2qf/PcEfwb6Gc7NL6cBLxzjc8CS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P2gkoS6wIXckcogzlS5Sy1DmJGwqLJ95lpaipXMZU4Wg2o4KWC9hNe5uf0SDwNOFd
         2pAEpQSLAw749w4fj4PeR0WH1sMJy4YmyeIIV43a41J4WujAAnMqeHUKSMIbR5xoQE
         vGF8aTHv+dPSEMMMXYiyt0aczs7zli4YmoXttL8Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Hristo Venev <hristo@venev.name>, io-uring@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 045/393] io_uring: fix sq array offset calculation
Date:   Mon, 17 Aug 2020 17:11:35 +0200
Message-Id: <20200817143821.785749994@linuxfoundation.org>
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

From: Dmitry Vyukov <dvyukov@google.com>

[ Upstream commit b36200f543ff07a1cb346aa582349141df2c8068 ]

rings_size() sets sq_offset to the total size of the rings (the returned
value which is used for memory allocation). This is wrong: sq array should
be located within the rings, not after them. Set sq_offset to where it
should be.

Fixes: 75b28affdd6a ("io_uring: allocate the two rings together")
Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Hristo Venev <hristo@venev.name>
Cc: io-uring@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/io_uring.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 5405362ae35f1..04694f6c30a04 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -7139,6 +7139,9 @@ static unsigned long rings_size(unsigned sq_entries, unsigned cq_entries,
 		return SIZE_MAX;
 #endif
 
+	if (sq_offset)
+		*sq_offset = off;
+
 	sq_array_size = array_size(sizeof(u32), sq_entries);
 	if (sq_array_size == SIZE_MAX)
 		return SIZE_MAX;
@@ -7146,9 +7149,6 @@ static unsigned long rings_size(unsigned sq_entries, unsigned cq_entries,
 	if (check_add_overflow(off, sq_array_size, &off))
 		return SIZE_MAX;
 
-	if (sq_offset)
-		*sq_offset = off;
-
 	return off;
 }
 
-- 
2.25.1



