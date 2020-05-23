Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A840C433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 01:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 132C32072C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 01:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="z7HrSHy4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387564AbgEWBvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 21:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387550AbgEWBvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 21:51:04 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F93C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 18:51:03 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x10so5117995plr.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 18:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L1+j2GDKy7H0PZDITKGHQ/OK2MPTBbiVlQTxtSNa/Ns=;
        b=z7HrSHy4DQ2KZLhor2+yKvhwKT3M5/avWRT8S5R2AJrrVQ/VvR19prxLmKkLZNkWzq
         pHUgk9D6XUmUkOewAT1qi3cXjH9XC3tQueuJoJCrrykyAZZ+GOo3XUCGFcpuqJUu77Cz
         qk5yHlSqkNewDc77Jj62TymY5U/UdV7bywroR1YBrukWND7+OAWlQLM4T/pruKlF8ECE
         ovOPYa9TZGG1f8t1lGBZ7YpIwfOtGCnVq9R2LgjgwzOVpCW9Vx8hYR07sVJrBcwLrhzj
         MPtjnH9yMF6hgSftEGBDEHfwTDDM2yWJWVxvIHOfr8e5Wc+D/P6S2Jyk9whuX1JG/BB8
         N9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L1+j2GDKy7H0PZDITKGHQ/OK2MPTBbiVlQTxtSNa/Ns=;
        b=AhY5bcYk5bc7s/Lc4UsAF9LmH88cqb5G9qaSJvbNmRuP+V9Gu7jz71Ac4CAnylzJDw
         41Pfoo5zr3KLszJz8siaJckUAk5chMZ2BDlYCl57oE4l/ZHkReU+IHEdnwLJ+Z71RM1P
         XtjpF6FqqSi+cpxX6Tu8KfJDK1ROwVMhNxWvL5Zf+6Lsrg5xYLe85BCHt3apqIcSFi+d
         F0fEf/CcIg0ZQ9sxTLnNpfkEQ1k30wSV0F8LkvmymMcR3ZctQ4jl7Zb5TRa7o1xpkOnq
         7l7paFoqAzYro/by4WCs3KENPDOFv34aPoPlMJy8wg73b2GUWtFQpmJ+F0zdEDJDalzV
         NdhA==
X-Gm-Message-State: AOAM531x356jlB8Mv5pVNMKxn52MhPZQJyAHKQ2mh41X14AFiXpacUSP
        FjRhHrZBUXfWQGk5AdalVfIyjA==
X-Google-Smtp-Source: ABdhPJw9gKQXC8DtehX4lEQgYciMv55f8G+1qS4JkrtGXjBLDVm3iWFTcJNG1joBJBOAhIVEQbPUvQ==
X-Received: by 2002:a17:90a:268f:: with SMTP id m15mr8317135pje.190.1590198662520;
        Fri, 22 May 2020 18:51:02 -0700 (PDT)
Received: from x1.lan ([2605:e000:100e:8c61:e0db:da55:b0a4:601])
        by smtp.gmail.com with ESMTPSA id a71sm8255477pje.0.2020.05.22.18.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 18:51:02 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/11] mm: support async buffered reads in generic_file_buffered_read()
Date:   Fri, 22 May 2020 19:50:42 -0600
Message-Id: <20200523015049.14808-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523015049.14808-1-axboe@kernel.dk>
References: <20200523015049.14808-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the async page locking infrastructure, if IOCB_WAITQ is set in the
passed in iocb. The caller must expect an -EIOCBQUEUED return value,
which means that IO is started but not done yet. This is similar to how
O_DIRECT signals the same operation. Once the callback is received by
the caller for IO completion, the caller must retry the operation.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 mm/filemap.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index a01daafd49fd..b49836ff0fdc 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2086,17 +2086,25 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 					index, last_index - index);
 		}
 		if (!PageUptodate(page)) {
-			if (iocb->ki_flags & IOCB_NOWAIT) {
-				put_page(page);
-				goto would_block;
-			}
-
 			/*
 			 * See comment in do_read_cache_page on why
 			 * wait_on_page_locked is used to avoid unnecessarily
 			 * serialisations and why it's safe.
 			 */
-			error = wait_on_page_locked_killable(page);
+			if (iocb->ki_flags & IOCB_WAITQ) {
+				if (written) {
+					put_page(page);
+					goto out;
+				}
+				error = wait_on_page_locked_async(page,
+								iocb->private);
+			} else {
+				if (iocb->ki_flags & IOCB_NOWAIT) {
+					put_page(page);
+					goto would_block;
+				}
+				error = wait_on_page_locked_killable(page);
+			}
 			if (unlikely(error))
 				goto readpage_error;
 			if (PageUptodate(page))
@@ -2184,7 +2192,10 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 page_not_up_to_date:
 		/* Get exclusive access to the page ... */
-		error = lock_page_killable(page);
+		if (iocb->ki_flags & IOCB_WAITQ)
+			error = lock_page_async(page, iocb->private);
+		else
+			error = lock_page_killable(page);
 		if (unlikely(error))
 			goto readpage_error;
 
-- 
2.26.2

