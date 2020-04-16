Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25502C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED8742051A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587048924;
	bh=YdurenuvYXqj8lZs7kKY9HUmHPXOIkJEorYnYCGwvPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vjk0PR/cSHf1tJEpR5pIshnePW/ic5eif0oPGnLTk9A+gTgbEJMIzxjGSr/NUK4nS
	 A5jko+VjbEIbxKMIpsC15XZCSSlFNio93rjnGSthpqKe1MiCmF6Y9QyDcNbqMAby6A
	 aBNPywdcBqEMzHx7e8Z7EirPaJ4IHfXPKstB/ww0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbgDPOzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:55:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:43664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441809AbgDPN4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:56:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 850EE21734;
        Thu, 16 Apr 2020 13:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587045396;
        bh=YdurenuvYXqj8lZs7kKY9HUmHPXOIkJEorYnYCGwvPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TbzGU5anfUvuW3ToxIuvo5J6R8V52d4f11WANrJlMIldXX7LWjrZZgqKGJUw8FEdX
         fzLTo64OHzibywkVFYh3dRfBnup5FY6JDB/o4/STxinBY4icSWRER3SXUruZjOuMa0
         TkDMQul9kkCjBHi7nxuIlxkbjVgXdNp93tJwqFGU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5.6 117/254] io_uring: fix ctx refcounting in io_submit_sqes()
Date:   Thu, 16 Apr 2020 15:23:26 +0200
Message-Id: <20200416131340.873146158@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.804095985@linuxfoundation.org>
References: <20200416131325.804095985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

commit 48bdd849e967f1c573d2b2bc24308e24a83f39c2 upstream.

If io_get_req() fails, it drops a ref. Then, awhile keeping @submitted
unmodified, io_submit_sqes() breaks the loop and puts @nr - @submitted
refs. For each submitted req a ref is dropped in io_put_req() and
friends. So, for @nr taken refs there will be
(@nr - @submitted + @submitted + 1) dropped.

Remove ctx refcounting from io_get_req(), that at the same time makes
it clearer.

Fixes: 2b85edfc0c90 ("io_uring: batch getting pcpu references")
Cc: stable@vger.kernel.org # v5.6
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/io_uring.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -1242,7 +1242,6 @@ fallback:
 	req = io_get_fallback_req(ctx);
 	if (req)
 		goto got_it;
-	percpu_ref_put(&ctx->refs);
 	return NULL;
 }
 


