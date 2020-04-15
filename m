Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A5DC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61BCC206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 11:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586951120;
	bh=DancS/jE/qVPq2YgrwJDoEAbIRcgJGeQhXOSY2s0B1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X9pH3u/yKZhCZr2mKEh0WbjMTurX84ciGJkGf/kGF89W/RrqNCDxm8Egjgy5ICdgP
	 Q+yhHBLPTpxXTtLazBwudquBLNTibQ+KYLFWBsgFpeTAYAuxhXz0lWZzyy08XE1maB
	 g/nsfzuDewVu4jUrt41NDNvRuQEJwKogr5YdmgXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406151AbgDOLpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 07:45:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897226AbgDOLhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 07:37:17 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AA1921569;
        Wed, 15 Apr 2020 11:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586950636;
        bh=DancS/jE/qVPq2YgrwJDoEAbIRcgJGeQhXOSY2s0B1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p2oTCfO/77ijyoVR9Qz6c7dv2nnXmYhFBunD9dEHJ0IdqUV1YWvqn19zogM0CUNs7
         f8F2ZXrad1tJlV2ma1dHGrOoL3EP4fTdMU9cRzu4DwbyALfANQOVlaqoYgTky2dlEI
         7184QNPJghciq7zKK8wtQCXcFI3GG34lvl7fCzCU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Biggers <ebiggers@google.com>, Chao Yu <yuchao0@huawei.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 5.6 127/129] f2fs: fix leaking uninitialized memory in compressed clusters
Date:   Wed, 15 Apr 2020 07:34:42 -0400
Message-Id: <20200415113445.11881-127-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415113445.11881-1-sashal@kernel.org>
References: <20200415113445.11881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

[ Upstream commit 7fa6d59816e7d81cfd4f854468c477c12b85c789 ]

When the compressed data of a cluster doesn't end on a page boundary,
the remainder of the last page must be zeroed in order to avoid leaking
uninitialized memory to disk.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/compress.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 11b13b881ada5..837e14b7ef523 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -385,11 +385,15 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 	for (i = 0; i < COMPRESS_DATA_RESERVED_SIZE; i++)
 		cc->cbuf->reserved[i] = cpu_to_le32(0);
 
+	nr_cpages = DIV_ROUND_UP(cc->clen + COMPRESS_HEADER_SIZE, PAGE_SIZE);
+
+	/* zero out any unused part of the last page */
+	memset(&cc->cbuf->cdata[cc->clen], 0,
+	       (nr_cpages * PAGE_SIZE) - (cc->clen + COMPRESS_HEADER_SIZE));
+
 	vunmap(cc->cbuf);
 	vunmap(cc->rbuf);
 
-	nr_cpages = DIV_ROUND_UP(cc->clen + COMPRESS_HEADER_SIZE, PAGE_SIZE);
-
 	for (i = nr_cpages; i < cc->nr_cpages; i++) {
 		f2fs_put_compressed_page(cc->cpages[i]);
 		cc->cpages[i] = NULL;
-- 
2.20.1

