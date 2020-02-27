Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF94C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C401624656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814361;
	bh=0yykBS6MIZWIYyvz4tIC205U5lYukMIJgO3DEgv1NnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s/RL0w3rnaKXMGSSva/QoXrpk+/Ew6bp0yowa4PuIn25taeLj7P1krGVade0iRuiK
	 tb1AGXzDk5NzOPDCMH59ABk9TQlRJhk743ZTswHCK118C9cRfiDicKAKUA93Z/Q5i0
	 QLFkV7UhsL08vYHduY6rTXxl1gvZPcfynVVcQMVY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732563AbgB0OjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:39:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:55188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731931AbgB0Ny7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:54:59 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A456C2469B;
        Thu, 27 Feb 2020 13:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811699;
        bh=0yykBS6MIZWIYyvz4tIC205U5lYukMIJgO3DEgv1NnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tladFDftksfHAMOfw+wZ1EFNLOIgQKk6S/j3kIDLnFNHyRtgjh5TFRaCjo0qB1Agg
         mSOGN9DeOGO4DpUCuzFwFgqD/0GToqc8viygMBaYwbCNsF72PFiWerP1ARK43q4clq
         NjnGne/rL6RSm5VYxYBtjRBiEKUzELpkOyTZXv/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 066/237] ext4, jbd2: ensure panic when aborting with zero errno
Date:   Thu, 27 Feb 2020 14:34:40 +0100
Message-Id: <20200227132301.908303534@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhangyi (F) <yi.zhang@huawei.com>

[ Upstream commit 51f57b01e4a3c7d7bdceffd84de35144e8c538e7 ]

JBD2_REC_ERR flag used to indicate the errno has been updated when jbd2
aborted, and then __ext4_abort() and ext4_handle_error() can invoke
panic if ERRORS_PANIC is specified. But if the journal has been aborted
with zero errno, jbd2_journal_abort() didn't set this flag so we can
no longer panic. Fix this by always record the proper errno in the
journal superblock.

Fixes: 4327ba52afd03 ("ext4, jbd2: ensure entering into panic after recording an error in superblock")
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20191204124614.45424-3-yi.zhang@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/checkpoint.c |  2 +-
 fs/jbd2/journal.c    | 15 ++++-----------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
index fe4fe155b7fbe..15d129b7494b0 100644
--- a/fs/jbd2/checkpoint.c
+++ b/fs/jbd2/checkpoint.c
@@ -168,7 +168,7 @@ void __jbd2_log_wait_for_space(journal_t *journal)
 				       "journal space in %s\n", __func__,
 				       journal->j_devname);
 				WARN_ON(1);
-				jbd2_journal_abort(journal, 0);
+				jbd2_journal_abort(journal, -EIO);
 			}
 			write_lock(&journal->j_state_lock);
 		} else {
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index b72be822f04f2..eae9ced846d51 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2128,12 +2128,10 @@ static void __journal_abort_soft (journal_t *journal, int errno)
 
 	__jbd2_journal_abort_hard(journal);
 
-	if (errno) {
-		jbd2_journal_update_sb_errno(journal);
-		write_lock(&journal->j_state_lock);
-		journal->j_flags |= JBD2_REC_ERR;
-		write_unlock(&journal->j_state_lock);
-	}
+	jbd2_journal_update_sb_errno(journal);
+	write_lock(&journal->j_state_lock);
+	journal->j_flags |= JBD2_REC_ERR;
+	write_unlock(&journal->j_state_lock);
 }
 
 /**
@@ -2175,11 +2173,6 @@ static void __journal_abort_soft (journal_t *journal, int errno)
  * failure to disk.  ext3_error, for example, now uses this
  * functionality.
  *
- * Errors which originate from within the journaling layer will NOT
- * supply an errno; a null errno implies that absolutely no further
- * writes are done to the journal (unless there are any already in
- * progress).
- *
  */
 
 void jbd2_journal_abort(journal_t *journal, int errno)
-- 
2.20.1



