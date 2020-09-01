Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484F3C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 107F82067C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598978637;
	bh=jJzN0qvUgOE1cdUaazlXbpW9jjzT4Ui/+dJXl3ovzjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UJYll2n++R8v2Ra/xYyVW2LGyU70UZAiOOz2RTjIPh71w8v46XfLkXlUT27pgtWOX
	 Zz9bAd3+ylY7kb0NbiaHg5sPpdqtGigXKVrAbOYFqn5ca29ngUuyFJpraAfI56mvO3
	 J0AzPrlZFM6svRjZEFHvEdW0p57+ctQNWvlvxNr4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbgIAP1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:27:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729201AbgIAPYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:24:05 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 367B92100A;
        Tue,  1 Sep 2020 15:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973844;
        bh=jJzN0qvUgOE1cdUaazlXbpW9jjzT4Ui/+dJXl3ovzjA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DBSTd633kkcAEJT8+SyfE6IoI/DdtpYXW4mxw04BSfnR2Dr4oGAX70+0fVq1OZGW0
         wujUup4queHN0hM/qG2jOoPKvSDyDZRzhM2S1KN6e7ysKyAbjaJx9isiJPVTNwK+7C
         B5E7CEMFsPIWGZ+BiCjz5qeQWU/tHQ7//fxcK+xA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>,
        Theodore Tso <tytso@mit.edu>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 062/125] jbd2: abort journal if free a async write error metadata buffer
Date:   Tue,  1 Sep 2020 17:10:17 +0200
Message-Id: <20200901150937.613171075@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150934.576210879@linuxfoundation.org>
References: <20200901150934.576210879@linuxfoundation.org>
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
index 5a0de78a5d71a..8c305593fb51f 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -2009,6 +2009,7 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal,
 {
 	struct buffer_head *head;
 	struct buffer_head *bh;
+	bool has_write_io_error = false;
 	int ret = 0;
 
 	J_ASSERT(PageLocked(page));
@@ -2033,11 +2034,26 @@ int jbd2_journal_try_to_free_buffers(journal_t *journal,
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



