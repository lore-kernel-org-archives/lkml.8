Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BED5C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D2282078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 15:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598973193;
	bh=msI9Izo9L4J+yHwpIL1IKf+9sn3TvKT/LB9B3RnpodM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PR7tGlHmLFI2qGf3614zX4eiA9mviyHbV34yBZBpE9A0FlkQ5oGsTSTyi1qm2zDC6
	 pJp81zxe0grjXiH/fDswutuxZOq92imaS7BTzkPM74tdeP8bvPfAcNztUg7nCUnxey
	 pb6xgaCC0zNP+6VbFNaQ3vM5FShJbyGx8D9aD3r8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgIAPNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728810AbgIAPMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:12:48 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AFCB2078B;
        Tue,  1 Sep 2020 15:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598973167;
        bh=msI9Izo9L4J+yHwpIL1IKf+9sn3TvKT/LB9B3RnpodM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zZhrOy5jM3rzyNKVRFUGDM742ks8lRgvqSbyH6YkAtawppWRWReJ1aRHsZwHkmNia
         KiVnZ9H0HkEccEAXbGJe2NVx07DVeP9GmK6HIRWGWT6/7T2AN4d78B3stJs2+ZfvK3
         H7EjmIUbF7GZnt2r9opGXWFr9eC+mzs/ZL7zzXrg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lukas Czerner <lczerner@redhat.com>,
        Jan Kara <jack@suse.cz>, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 34/62] jbd2: make sure jh have b_transaction set in refile/unfile_buffer
Date:   Tue,  1 Sep 2020 17:10:17 +0200
Message-Id: <20200901150922.427271148@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200901150920.697676718@linuxfoundation.org>
References: <20200901150920.697676718@linuxfoundation.org>
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
index 3233e5ac9774f..622610934c9ad 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1906,6 +1906,9 @@ static void __jbd2_journal_temp_unlink_buffer(struct journal_head *jh)
  */
 static void __jbd2_journal_unfile_buffer(struct journal_head *jh)
 {
+	J_ASSERT_JH(jh, jh->b_transaction != NULL);
+	J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
+
 	__jbd2_journal_temp_unlink_buffer(jh);
 	jh->b_transaction = NULL;
 	jbd2_journal_put_journal_head(jh);
@@ -2453,6 +2456,13 @@ void __jbd2_journal_refile_buffer(struct journal_head *jh)
 
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



