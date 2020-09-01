Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430BFC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14D242065F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598978045;
	bh=jOLWPXhtVbQojFkMlCNxaLLUR8fKNV7LxXom8aJxz/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gRq1imfU67hLS452VFGRibhEL0FIiDLt6GAun7ZcnQ4P+2ujzLHDsYrEaSweHbiLo
	 yjUAGkgykT5j11cTmgSz90LDNxGjVhIxuNhu1a5MQR1jh3BigDxuZEon07ajUOkLWc
	 byI2PcOl6Ww7lpoAZrR6ksQioCyMsKwwGMN8imAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730811AbgIAQeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:34:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730029AbgIAPb0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:31:26 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0AFF20866;
        Tue,  1 Sep 2020 15:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598974286;
        bh=jOLWPXhtVbQojFkMlCNxaLLUR8fKNV7LxXom8aJxz/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kRTkShe7kvV4zkmI9GGKO5cO5TSPM4+QRDO41xyoySR6n+ksWNh6+e4+vrUT5a+Ax
         5smd6sh2AprfRuJQ8ynfE3bJbyxCeCPToaf36BqRhnXnqDcVo5DJoJvqfqURJtL7oT
         AqQq5cnoq+lo4odrcShyfCXY49ErDbC6LdTlxgIU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 117/214] jbd2: abort journal if free a async write error metadata buffer
Date:   Tue,  1 Sep 2020 17:09:57 +0200
Message-Id: <20200901150958.593490171@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150952.963606936@linuxfoundation.org>
References: <20200901150952.963606936@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangyi (F) <yi.zhang@huawei.com>

[ Upstream commit c044f3d8360d2ecf831ba2cc9f08cf9fb2c699fb ]

If we free a metadata buffer which has been failed to async write out
in the background, the jbd2 checkpoint procedure will not detect this
failure in jbd2_log_do_checkpoint(), so it may lead to filesystem
inconsistency after cleanup journal tail. This patch abort the journal
if free a buffer has write_io_error flag to prevent potential further
inconsistency.

Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Link: https://lore.kernel.org/r/20200620025427.1756360-5-yi.zhang@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/transaction.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 0b663269771d4..90453309345d5 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2077,6 +2077,7 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal,
 {
 	struct buffer_head *head;
 	struct buffer_head *bh;
+	bool has_write_io_error = false;
 	int ret = 0;
 
 	J_ASSERT(PageLocked(page));
@@ -2101,11 +2102,26 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal,
 		jbd_unlock_bh_state(bh);
 		if (buffer_jbd(bh))
 			goto busy;
+
+		/*
+		 * If we free a metadata buffer which has been failed to
+		 * write out, the jbd2 checkpoint procedure will not detect
+		 * this failure and may lead to filesystem inconsistency
+		 * after cleanup journal tail.
+		 */
+		if (buffer_write_io_error(bh)) {
+			pr_err("JBD2: Error while async write back metadata bh %llu.",
+			       (unsigned long long)bh->b_blocknr);
+			has_write_io_error = true;
+		}
 	} while ((bh = bh->b_this_page) != head);
 
 	ret = try_to_free_buffers(page);
 
 busy:
+	if (has_write_io_error)
+		jbd2_journal_abort(journal, -EIO);
+
 	return ret;
 }
 
-- 
2.25.1



