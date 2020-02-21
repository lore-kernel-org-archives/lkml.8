Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B084C35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3241C20578
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582273855;
	bh=ZRxvlopwdj/ZPtbwhnXfZ5htJU2YT/tx5DBERp0QAfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jT7/NjHhNR4VgcVxW9UBKyaWXxm3OdLKb3dJYwZpd6X2aeDnwDLaYrsKGLCbTd9Uv
	 tcdREeb+JjSCxIZd/O0ePNXq1R8PMgQL/wimzWIcPggbHv3QmtrsyR1tGsyhthpENV
	 oVs9DqtocuJ36A5v6ZOITdGJMVJsc4SeICFMKRvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbgBUIPQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:15:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:51856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731814AbgBUIPI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:15:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81CA124680;
        Fri, 21 Feb 2020 08:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272908;
        bh=ZRxvlopwdj/ZPtbwhnXfZ5htJU2YT/tx5DBERp0QAfM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f2tH1myNnfRtV9ABGeqC2w/ssHrJpuojBSIJymP1TOuR9sTZMNxL/UGZzXCODVdD3
         MAzt8FTfOJ4jOtYWd+2x3iZU1m7juwANQeGdEpv2Epr1/3FPN4JISKuKQMOUsXyPbM
         GQYPf5oUdcNfpXrik2mywDvomcSZ58DCVb5EMVKU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 293/344] jbd2: switch to use jbd2_journal_abort() when failed to submit the commit record
Date:   Fri, 21 Feb 2020 08:41:32 +0100
Message-Id: <20200221072416.481669508@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072349.335551332@linuxfoundation.org>
References: <20200221072349.335551332@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangyi (F) <yi.zhang@huawei.com>

[ Upstream commit d0a186e0d3e7ac05cc77da7c157dae5aa59f95d9 ]

We invoke jbd2_journal_abort() to abort the journal and record errno
in the jbd2 superblock when committing journal transaction besides the
failure on submitting the commit record. But there is no need for the
case and we can also invoke jbd2_journal_abort() instead of
__jbd2_journal_abort_hard().

Fixes: 818d276ceb83a ("ext4: Add the journal checksum feature")
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20191204124614.45424-2-yi.zhang@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/commit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 2a42904bcd62c..754ec3c47d6fb 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -784,7 +784,7 @@ start_journal_io:
 		err = journal_submit_commit_record(journal, commit_transaction,
 						 &cbh, crc32_sum);
 		if (err)
-			__jbd2_journal_abort_hard(journal);
+			jbd2_journal_abort(journal, err);
 	}
 
 	blk_finish_plug(&plug);
@@ -877,7 +877,7 @@ start_journal_io:
 		err = journal_submit_commit_record(journal, commit_transaction,
 						&cbh, crc32_sum);
 		if (err)
-			__jbd2_journal_abort_hard(journal);
+			jbd2_journal_abort(journal, err);
 	}
 	if (cbh)
 		err = journal_wait_on_commit_record(journal, cbh);
-- 
2.20.1



