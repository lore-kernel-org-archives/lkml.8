Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D80BC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 00:24:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D2020757
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 00:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nftfqZ8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgHaAYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 20:24:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgHaAYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 20:24:11 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE7EC061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 17:24:10 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id 2so2215893pjx.5
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 17:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZnfXYUbCB2BbWKqT6zdvNTUKiLkNrjoRnmWZrCX/fz8=;
        b=nftfqZ8DnVy4hFsXpIRjiH68UiYa/itmOgKxyJ8MtRpETwtiFJSTo0RhIvPObdIiY9
         nDlO0/B9dtHyjgyLPWLM+2wCwsrBlZqGDjDp7PK1wIL/Npo5eUmrWKrMa/haOcTSEAVV
         9F7DjOt8O93v4r+x69+HXwwjF2A9xW2S8RfWZadS3vBFgW5J2MkdvDrjyTVIFPaToAVp
         daKOR28aP1Xrh0JonpUVoTEPh6ZzEhyty1DB8lwKEgQ7uH0vjBMDORM6K5i/wvPOLQkA
         UNQcpiys4UE5avtviwdPsmiuXK/GpfQgFpB4CyNoBTRCF4zHkucKJHbfx5PnuODnzFBU
         Dj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZnfXYUbCB2BbWKqT6zdvNTUKiLkNrjoRnmWZrCX/fz8=;
        b=Q2vSKk3XSwOsgqvQPFTOiyDu6+AhfanCjXDbvfip3iMIM/R54QoLFNeVV0JXEOYUua
         FCxk8UcRoGDKEmMNtQsIxw6Xt4t75BS/q/d64KkUJ5ZF7ysMFFGYU1n/tXph2ZA579zo
         YEmmOUN8kGdqXb7hxQCCNzD7oSRG1sNwghXCIOBai7E9CgMOx1fUSgm8Os3aXh8yF2Vt
         2louyDxKc8QrluSuKeDo4+L4Xgcchpmb5Y6Pv50aTN5+GvQCmz6mAoo1xjP454a9LMFs
         lKbnbo6QwAPnGHWlsxf354zh55o0yzce0TGfzDeY3isBu5hyofPsaYTXDMUYICsdOUEF
         MVXQ==
X-Gm-Message-State: AOAM530XKnuBRvH/qTPfjEeUM0IuItMBAhH9Ila0IZB6fcDRog7QACQ8
        0BfTZ8+lFXpEFK9nx67ytJg/3Ci1IeI=
X-Google-Smtp-Source: ABdhPJxU3uC9s/QR9RBkZO0HL/4Vd28NyPzLtSUUf2pebZcDvM1d2R8ZoAsqQXsstWSWBAJEn3zBIA==
X-Received: by 2002:a17:90a:eb17:: with SMTP id j23mr8148264pjz.151.1598833449671;
        Sun, 30 Aug 2020 17:24:09 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id r33sm5244826pgm.75.2020.08.30.17.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 17:24:08 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: add block address limit check to compressed file
Date:   Mon, 31 Aug 2020 09:24:01 +0900
Message-Id: <20200831002401.3159134-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Need to add block address range check to compressed file case and
avoid calling get_data_block_bmap() for compressed file.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/data.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c1b676be67b9..48cab85205e2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1755,10 +1755,6 @@ static int get_data_block_dio(struct inode *inode, sector_t iblock,
 static int get_data_block_bmap(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh_result, int create)
 {
-	/* Block number less than F2FS MAX BLOCKS */
-	if (unlikely(iblock >= F2FS_I_SB(inode)->max_file_blocks))
-		return -EFBIG;
-
 	return __get_data_block(inode, iblock, bh_result, create,
 						F2FS_GET_BLOCK_BMAP, NULL,
 						NO_CHECK_TYPE, create);
@@ -3753,11 +3749,16 @@ static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
 	if (mapping_tagged(mapping, PAGECACHE_TAG_DIRTY))
 		filemap_write_and_wait(mapping);
 
-	if (f2fs_compressed_file(inode))
-		blknr = f2fs_bmap_compress(inode, block);
+	/* Block number less than F2FS MAX BLOCKS */
+	if (unlikely(block >= F2FS_I_SB(inode)->max_file_blocks))
+		goto out;
 
-	if (!get_data_block_bmap(inode, block, &tmp, 0))
-		blknr = tmp.b_blocknr;
+	if (f2fs_compressed_file(inode)) {
+		blknr = f2fs_bmap_compress(inode, block);
+	} else {
+		if (!get_data_block_bmap(inode, block, &tmp, 0))
+			blknr = tmp.b_blocknr;
+	}
 out:
 	trace_f2fs_bmap(inode, block, blknr);
 	return blknr;
-- 
2.28.0.402.g5ffc5be6b7-goog

