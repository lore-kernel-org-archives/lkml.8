Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DF3CC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A7992076D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586360916;
	bh=HotOvguNSrEPHftfF9hKyBfJBsne6Ihdoy/T4tXbhYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RCAzjsrY3dOgQGgqAKK3L9xQTsoQWkTVguZNyb1TDnTO+FrGHiP8i1oyGXWU6bodm
	 2wrT8eSyjuICZCnwY9BCIArE8X+KIzEj/D5vT+j28ib55jUiINpPTCOTMjpvIBjuJn
	 yh4zl7yoV6Kiu2NT9czMc9u0ZYWL9bC3Zh6STdlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbgDHPsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:49316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729656AbgDHPqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:32 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6826F214DB;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360791;
        bh=HotOvguNSrEPHftfF9hKyBfJBsne6Ihdoy/T4tXbhYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lt+jV6NLjjSUuzvM1eh6p/kV/VaMpuQUMZVN8yaKKRxUlpPOayhxIQDzSJ1wEy0xy
         OzbOGzT97CWn02pDKeakWgMeP+MFRk0VTYLAjgaO8/ZEdLORAktBNo8aDkoIRwvLXW
         Szm00x1GzRlp+bwEsJb28bfqGazCDew33krW7rvM=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuL-000cBN-JO; Wed, 08 Apr 2020 17:46:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/35] fs: inode.c: get rid of docs warnings
Date:   Wed,  8 Apr 2020 17:46:06 +0200
Message-Id: <6f8105480235e30fb0193f493072b97625c8d5ea.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use *foo makes the toolchain to think that this is an emphasis, causing
those warnings:

	./fs/inode.c:1609: WARNING: Inline emphasis start-string without end-string.
	./fs/inode.c:1609: WARNING: Inline emphasis start-string without end-string.
	./fs/inode.c:1615: WARNING: Inline emphasis start-string without end-string.

So, use, instead, ``*foo``, in order to mark it as a literal block.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 fs/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 93d9252a00ab..37226a9cfa4f 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1606,14 +1606,14 @@ EXPORT_SYMBOL(iput);
  *	@inode:  inode owning the block number being requested
  *	@block: pointer containing the block to find
  *
- *	Replaces the value in *block with the block number on the device holding
+ *	Replaces the value in ``*block`` with the block number on the device holding
  *	corresponding to the requested block number in the file.
  *	That is, asked for block 4 of inode 1 the function will replace the
- *	4 in *block, with disk block relative to the disk start that holds that
+ *	4 in ``*block``, with disk block relative to the disk start that holds that
  *	block of the file.
  *
  *	Returns -EINVAL in case of error, 0 otherwise. If mapping falls into a
- *	hole, returns 0 and *block is also set to 0.
+ *	hole, returns 0 and ``*block`` is also set to 0.
  */
 int bmap(struct inode *inode, sector_t *block)
 {
-- 
2.25.2

