Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A10C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 759A020738
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592203767;
	bh=PW9Q9Rza1Ft5d+Y1Xvp+VMcPsWF+aTDSQqNL4AP5hME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tfoTOxpXiGlhlf8RJvBEp9R42jps+4y0hbb2VPGas0eZ+2yTtRbuCinK/9l/oord3
	 ABcQ2h8CR+KdXpT/Bwp6/6MY8Z4vHH+ghTb7tq5NxsQxtvRbqcQ9TlzJQqLLk5g+xE
	 daERMc0yyoRkNUTHGEmeE4LscEzkTAmmalMYuTd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgFOGt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:49:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbgFOGrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:47:13 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBEDF207D4;
        Mon, 15 Jun 2020 06:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203632;
        bh=PW9Q9Rza1Ft5d+Y1Xvp+VMcPsWF+aTDSQqNL4AP5hME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u6fYrewWRmselqLG9JODA72OGGQjbGxxp8ZbLZyegyMElYHPqyGjvqufdf///qz+e
         uCIzSXfz3k1Hzp+T+k6ESVtG5rl9wzh3f8HtPPYy78gE5m3Lm4ftfqZQqH0RYZRhEA
         r5626n7m50PHZaUhlBHxBj+Qd6D33YDVosaEXEEQ=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkith-009nmP-IX; Mon, 15 Jun 2020 08:47:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/29] fs: fs.h: fix a kernel-doc parameter description
Date:   Mon, 15 Jun 2020 08:46:46 +0200
Message-Id: <e6b1201c3b5fa88085919908f01ea7337d9c9359.1592203542.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203542.git.mchehab+huawei@kernel.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
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
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6c4ab4dc1cd7..7e17ecc461d5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2829,7 +2829,7 @@ static inline errseq_t filemap_sample_wb_err(struct address_space *mapping)
 
 /**
  * file_sample_sb_err - sample the current errseq_t to test for later errors
- * @mapping: mapping to be sampled
+ * @file: file pointer to be sampled
  *
  * Grab the most current superblock-level errseq_t value for the given
  * struct file.
-- 
2.26.2

