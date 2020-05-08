Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206DEC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 012E9207DD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 06:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgEHGjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 02:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727071AbgEHGjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 02:39:00 -0400
Received: from nibbler.cm4all.net (nibbler.cm4all.net [IPv6:2001:8d8:970:e500:82:165:145:151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D75C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 23:39:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by nibbler.cm4all.net (Postfix) with ESMTP id E8B33C02BC
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 08:38:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at nibbler.cm4all.net
Received: from nibbler.cm4all.net ([127.0.0.1])
        by localhost (nibbler.cm4all.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id BMHn56dk6HsY for <linux-kernel@vger.kernel.org>;
        Fri,  8 May 2020 08:38:58 +0200 (CEST)
Received: from zero.intern.cm-ag (zero.intern.cm-ag [172.30.16.10])
        by nibbler.cm4all.net (Postfix) with SMTP id C8E6CC0280
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 08:38:58 +0200 (CEST)
Received: (qmail 3890 invoked from network); 8 May 2020 09:55:18 +0200
Received: from unknown (HELO rabbit.intern.cm-ag) (172.30.3.1)
  by zero.intern.cm-ag with SMTP; 8 May 2020 09:55:18 +0200
Received: by rabbit.intern.cm-ag (Postfix, from userid 1023)
        id 9F32F461450; Fri,  8 May 2020 08:38:58 +0200 (CEST)
From:   Max Kellermann <mk@cm4all.com>
To:     axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Max Kellermann <mk@cm4all.com>
Subject: [PATCH v2 2/2] fs/io_uring: remove unused flag fd_non_neg
Date:   Fri,  8 May 2020 08:38:46 +0200
Message-Id: <20200508063846.21067-2-mk@cm4all.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200508063846.21067-1-mk@cm4all.com>
References: <20200508063846.21067-1-mk@cm4all.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---
 fs/io_uring.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index d24f8e33323c..0aa7cd547ced 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -604,8 +604,6 @@ struct io_op_def {
 	unsigned		needs_mm : 1;
 	/* needs req->file assigned */
 	unsigned		needs_file : 1;
-	/* needs req->file assigned IFF fd is >= 0 */
-	unsigned		fd_non_neg : 1;
 	/* hash wq insertion if file is a regular file */
 	unsigned		hash_reg_file : 1;
 	/* unbound wq insertion if file is a non-regular file */
@@ -4572,8 +4570,6 @@ static int io_req_needs_file(struct io_kiocb *req, int fd)
 {
 	if (!io_op_defs[req->opcode].needs_file)
 		return 0;
-	if ((fd == -1 || fd == AT_FDCWD) && io_op_defs[req->opcode].fd_non_neg)
-		return 0;
 	return 1;
 }
 
-- 
2.20.1

