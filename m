Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FC5C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B9C20727
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chA/wqnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbgCJTOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:14:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42317 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgCJTOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:14:16 -0400
Received: by mail-pf1-f194.google.com with SMTP id f5so6936547pfk.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jXS+fddiboogW4J/E0/NXpTN0n1JtPDhmBZ3qFcCQP4=;
        b=chA/wqnMnfNRRpErVjOWwHfwqEReVmuaVJ1j+gJ786KskrXv1xxlMHWhSZ81FrPINb
         t7VRbkrSkhXP6B2AaNJjhiJwM2hcw8iC5vC15rnPmbKeluQ9W+ctzvfjLc8K9LQZM3XL
         U0xJCK4FrImSkd/bNujq2E/EqANq5jI44q7b434QSRqv+yT6EY0hBWqFGnzsFhfzfaEX
         vRhUSmSQpQZzlrGJtoXcF4+YLOlbZIBrxiw9vXyFDuc1hz42F1yAfIPOzTJTq7Ywtbhs
         01HAt7Ibzbj1v8/pSyh5SOldubP6Wr/hSF38V63VzmxAdrNUhTMhLqi3c/aa3U5K0xz4
         09fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jXS+fddiboogW4J/E0/NXpTN0n1JtPDhmBZ3qFcCQP4=;
        b=BdmwS6DdpXFZbtu6hBvykU+lcL0Cshes3/gqpMgqgNOMAIj4Hj8mrCXdAkb2o8Dkwa
         20FTt1lN45TYNiXWpHB0UVfq8EpEVM+Ldf62GvSPobGIvX4I6cI8baxYJEoBLo+SHnU1
         4cNM+dY/yNuRXY6Ncf7sJuoVdWKkpbX3EcwvVQ4G+OTBXuTA3lxFxR/+LPmw+DJAeHTp
         OSUs05SsLOBFSTAcSyNAk8XVx2Kk5QpepkQpkSkrvPCjSK6Yd+x0d9RUZq3+CS8Qnwwy
         gDsSH5XJM89KK/f7RitGOYIBpxg1TMg0um6Xle+w1RYfECA5vtVZULL3X8QkLTwekTsV
         XckQ==
X-Gm-Message-State: ANhLgQ1uyPnOSUHX5r6kkNF6FE3c8wEq14EUS5p4rJFtsLABGJ1ymFqZ
        L34Waobl1UWQKKZ9Ygi/wIY=
X-Google-Smtp-Source: ADFU+vs52a6rip8IWsWcP1fpdvE1kMMG2to1qSplhRkZx9BvaY+Hdl6MbNO/wIfE52DWiHve9HXUuQ==
X-Received: by 2002:aa7:8513:: with SMTP id v19mr22471763pfn.222.1583867655422;
        Tue, 10 Mar 2020 12:14:15 -0700 (PDT)
Received: from localhost.localdomain ([157.45.34.130])
        by smtp.gmail.com with ESMTPSA id p9sm2232630pgs.50.2020.03.10.12.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 10 Mar 2020 12:14:14 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] mm/filemap.c: Remove unused argument from shrink_readahead_size_eio()
Date:   Wed, 11 Mar 2020 00:51:33 +0530
Message-Id: <1583868093-24342-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first argument of shrink_readahead_size_eio() is not used. Hence
removed from function definition and from all the callers.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 mm/filemap.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 1784478..98f3703 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1962,8 +1962,7 @@ unsigned find_get_pages_range_tag(struct address_space *mapping, pgoff_t *index,
  *
  * It is going insane. Fix it by quickly scaling down the readahead size.
  */
-static void shrink_readahead_size_eio(struct file *filp,
-					struct file_ra_state *ra)
+static void shrink_readahead_size_eio(struct file_ra_state *ra)
 {
 	ra->ra_pages /= 4;
 }
@@ -2188,7 +2187,7 @@ static ssize_t generic_file_buffered_read(struct kiocb *iocb,
 					goto find_page;
 				}
 				unlock_page(page);
-				shrink_readahead_size_eio(filp, ra);
+				shrink_readahead_size_eio(ra);
 				error = -EIO;
 				goto readpage_error;
 			}
@@ -2560,7 +2559,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		goto retry_find;
 
 	/* Things didn't work out. Return zero to tell the mm layer so. */
-	shrink_readahead_size_eio(file, ra);
+	shrink_readahead_size_eio(ra);
 	return VM_FAULT_SIGBUS;
 
 out_retry:
-- 
1.9.1

