Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27CFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE64206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592896217;
	bh=+2be6Yi2voY5EWY7d9UhVNBdVOyv5kCl0Vkr2aU3GDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BHi18uzU8iSi6jddf27jr6hn55toyqisdzX+mGiZVm0F3rGu3kEqOIiIjXxdGDLzK
	 /qMqArcbwg8gyUJThNwD6yWiVBOG3dH4xjXWJABRMEjx48v87n9d9bFJMZmN6Nn/Di
	 cazIbZqTn9WxpmXgHzNu//lJchJ0rxEOH1dx82bo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731780AbgFWHKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:10:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:39878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731253AbgFWHJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:09:16 -0400
Received: from mail.kernel.org (unknown [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45C2E20786;
        Tue, 23 Jun 2020 07:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592896155;
        bh=+2be6Yi2voY5EWY7d9UhVNBdVOyv5kCl0Vkr2aU3GDg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=woy6NiLZFi3sOp7s8DRf4FwzoCvWwYg3fI4y+45T1oLiXMmnmP63HsJv/K9MR4HNc
         y3XWuzPCHMxaNuX6hZM/VtrkNuxeTpUgwI4xc7TK/uRo3JW+M+/gV/DNePf5sHf/lG
         dxKhyVtP0BN/s3pY6IbOdLRV6aupZUNZEcNVvk6Y=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jnd3R-003qj8-5Y; Tue, 23 Jun 2020 09:09:13 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 07/15] fs: fs.h: fix a kernel-doc parameter description
Date:   Tue, 23 Jun 2020 09:09:03 +0200
Message-Id: <7b33bbceb29ac80874622a2bc84127bb10103245.1592895969.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592895969.git.mchehab+huawei@kernel.org>
References: <cover.1592895969.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 3b0311e7ca71 ("vfs: track per-sb writeback errors and report them to syncfs")
added a variant of filemap_sample_wb_err(), but it forgot to
rename the arguments at the kernel-doc markup. Fix it.

Fix those warnings:
	./include/linux/fs.h:2845: warning: Function parameter or member 'file' not described in 'file_sample_sb_err'
	./include/linux/fs.h:2845: warning: Excess function parameter 'mapping' description in 'file_sample_sb_err'

Fixes: 3b0311e7ca71 ("vfs: track per-sb writeback errors and report them to syncfs")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 633c50cd24aa..523705fd8146 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2852,7 +2852,7 @@ static inline errseq_t filemap_sample_wb_err(struct address_space *mapping)
 
 /**
  * file_sample_sb_err - sample the current errseq_t to test for later errors
- * @mapping: mapping to be sampled
+ * @file: file pointer to be sampled
  *
  * Grab the most current superblock-level errseq_t value for the given
  * struct file.
-- 
2.26.2

