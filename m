Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC650C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C549206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598979430;
	bh=0T4zPC5JFeMjiOz5QfuMmWoz2MjWto/85jlqA8H2gUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GoScM8WJ4PbGIh4bcy9S9V9iMF/TdTHaekBPccdm+e5uPnQGl7Osv1s/+6/dA6+NC
	 G7inZWDzv0CKzh97WACgfo0V08ZRJNpeyCEfIBnL02+8ojN7+TyRlO1TzBHzpqS9dk
	 Z6Zq4V2NvE93EElNCMShxdU18McnVfxq5Gr7621Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgIAQ5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:57:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:46924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729658AbgIAPXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:23:42 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD68C20FC3;
        Tue,  1 Sep 2020 15:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973822;
        bh=0T4zPC5JFeMjiOz5QfuMmWoz2MjWto/85jlqA8H2gUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q+DRM2pKRvge47mgzCaO9EloQeWrDtPA94F7wTLNU5gCLLH37Je4XIv+0ZUlCyPLd
         iqHi+RLf2GZb1uI1UkPFHlV3YT9MSBd2lpT/dBGC3fDLSKOtdo3h2bV9n2GdK+/emx
         3tLwG00gBReTmivgDJvcGSDx7QUxyP448L38mm7I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 059/125] jbd2: make sure jh have b_transaction set in refile/unfile_buffer
Date:   Tue,  1 Sep 2020 17:10:14 +0200
Message-Id: <20200901150937.471300783@linuxfoundation.org>
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

From: Lukas Czerner <lczerner@redhat.com>

[ Upstream commit 24dc9864914eb5813173cfa53313fcd02e4aea7d ]

Callers of __jbd2_journal_unfile_buffer() and
__jbd2_journal_refile_buffer() assume that the b_transaction is set. In
fact if it's not, we can end up with journal_head refcounting errors
leading to crash much later that might be very hard to track down. Add
asserts to make sure that is the case.

We also make sure that b_next_transaction is NULL in
__jbd2_journal_unfile_buffer() since the callers expect that as well and
we should not get into that stage in this state anyway, leading to
problems later on if we do.

Tested with fstests.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20200617092549.6712-1-lczerner@redhat.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/transaction.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 43693b6797105..5a0de78a5d71a 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1915,6 +1915,9 @@ static void __jbd2_journal_temp_unlink_buffer(struct journal_head *jh)
  */
 static void __jbd2_journal_unfile_buffer(struct journal_head *jh)
 {
+	J_ASSERT_JH(jh, jh->b_transaction != NULL);
+	J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
+
 	__jbd2_journal_temp_unlink_buffer(jh);
 	jh->b_transaction = NULL;
 	jbd2_journal_put_journal_head(jh);
@@ -2462,6 +2465,13 @@ void __jbd2_journal_refile_buffer(struct journal_head *jh)
 
 	was_dirty = test_clear_buffer_jbddirty(bh);
 	__jbd2_journal_temp_unlink_buffer(jh);
+
+	/*
+	 * b_transaction must be set, otherwise the new b_transaction won't
+	 * be holding jh reference
+	 */
+	J_ASSERT_JH(jh, jh->b_transaction != NULL);
+
 	/*
 	 * We set b_transaction here because b_next_transaction will inherit
 	 * our jh reference and thus __jbd2_journal_file_buffer() must not
-- 
2.25.1



