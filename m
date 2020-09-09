Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DA5C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 02:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F9E2177B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 02:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlkYED+X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgIICgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 22:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgIICgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 22:36:43 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F12C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 19:36:42 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 34so927162pgo.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 19:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X+oobIN4EvT4cXwyPHq/3JQFjuqR9WTF4FN1mEu2D/4=;
        b=FlkYED+XJPr51CjGG6agsxTpvDCUkcSOwP1LO9wQcPFzPZrbXh0tBBoqTxxJeqFVYT
         pHvykXbaACBsNolxBT8lcMyq/g2JT/xQuGB96JIoXX9BuatufvoXD5HkQY4KKLjaW0it
         C/+JWqNaYXkQ8PlhETWvh1pAG/fQO9IqUNiDOTH/aYimjUyzSeyZEzWe+TvRx8i/jOH4
         n9SLFduLKyHUW3oUbS1e/JtvBDnZdTFkDPifUprOdZImKM+0eipidcdrTmXd/JDhz89O
         +ckCSYOjDhClqOEsNbuW0F/2kejTj99oXShSL4zlpwkgBrzjyAQkjtcXMamuZzst/nw7
         Cogg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X+oobIN4EvT4cXwyPHq/3JQFjuqR9WTF4FN1mEu2D/4=;
        b=WHEDXApL/BCltVhP8FpBtaPi74A6DkCMaVfIHbmfld2qBfOC9C2WZ/qRUE7vJpmrVM
         ZpGcwiMuCC8m0jEw4lRmQ4aIGgjB7Wa1mYrbVO0A94gujOxb1CE//PR0Oo0H+MRnF6d5
         /oIE15a3v1UuZ4Ry6tNzXNBijSokFDcjBAQ8R8oJ9Fb4NgZ7e23QYIt4eJyKu1h0HAt6
         65pIKPuMYcrVRu6GybIIDgaXcnhmN8/FRJ99hzIFDZ6p7cuJPYyGZgJlCq+1YnX/Za7P
         Nw8TNcGJIvEsxcXLiEdBxoMI/X92A5PruyNHWJx7lf+KhHH4f1Tm4ax+pJ0dAzJ0pPXn
         WvfQ==
X-Gm-Message-State: AOAM531UfDzym2KhGbXhWurjVxvgfwgkdKQ5PV4wB8zQ8RDFQbAw7css
        l6IfmjJHF/Z5J0inDUx4HcvYnYFvOSI=
X-Google-Smtp-Source: ABdhPJxRm6GJqFBhoaYprpeyr+sd1af/4h2Oci/9Abej87t39HWxdhaB2mSpi18/QD+3HEnTM/eaBA==
X-Received: by 2002:a17:902:d714:b029:d0:cbe1:e7a2 with SMTP id w20-20020a170902d714b02900d0cbe1e7a2mr1913266ply.19.1599619001994;
        Tue, 08 Sep 2020 19:36:41 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id s67sm760464pfs.117.2020.09.08.19.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 19:36:41 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: clean up vm_map_ram() call
Date:   Wed,  9 Sep 2020 11:36:34 +0900
Message-Id: <20200909023634.3821423-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

Made f2fs_vmap() wrapper to handle vm_map_ram() stuff.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/compress.c | 42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 357303d8514b..7895186cc765 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -557,6 +557,20 @@ static void f2fs_compress_free_page(struct page *page)
 
 #define MAX_VMAP_RETRIES	3
 
+static void *f2fs_vmap(struct page **pages, unsigned int count)
+{
+	int i;
+	void *buf = NULL;
+
+	for (i = 0; i < MAX_VMAP_RETRIES; i++) {
+		buf = vm_map_ram(pages, count, -1);
+		if (buf)
+			break;
+		vm_unmap_aliases();
+	}
+	return buf;
+}
+
 static int f2fs_compress_pages(struct compress_ctx *cc)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
@@ -593,23 +607,13 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 		}
 	}
 
-	for (i = 0; i < MAX_VMAP_RETRIES; i++) {
-		cc->rbuf = vm_map_ram(cc->rpages, cc->cluster_size, -1);
-		if (cc->rbuf)
-			break;
-		vm_unmap_aliases();
-	}
+	cc->rbuf = f2fs_vmap(cc->rpages, cc->cluster_size);
 	if (!cc->rbuf) {
 		ret = -ENOMEM;
 		goto out_free_cpages;
 	}
 
-	for (i = 0; i < MAX_VMAP_RETRIES; i++) {
-		cc->cbuf = vm_map_ram(cc->cpages, cc->nr_cpages, -1);
-		if (cc->cbuf)
-			break;
-		vm_unmap_aliases();
-	}
+	cc->cbuf = f2fs_vmap(cc->cpages, cc->nr_cpages);
 	if (!cc->cbuf) {
 		ret = -ENOMEM;
 		goto out_vunmap_rbuf;
@@ -728,23 +732,13 @@ void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity)
 			goto out_free_dic;
 	}
 
-	for (i = 0; i < MAX_VMAP_RETRIES; i++) {
-		dic->rbuf = vm_map_ram(dic->tpages, dic->cluster_size, -1);
-		if (dic->rbuf)
-			break;
-		vm_unmap_aliases();
-	}
+	dic->rbuf = f2fs_vmap(dic->tpages, dic->cluster_size);
 	if (!dic->rbuf) {
 		ret = -ENOMEM;
 		goto destroy_decompress_ctx;
 	}
 
-	for (i = 0; i < MAX_VMAP_RETRIES; i++) {
-		dic->cbuf = vm_map_ram(dic->cpages, dic->nr_cpages, -1);
-		if (dic->cbuf)
-			break;
-		vm_unmap_aliases();
-	}
+	dic->cbuf = f2fs_vmap(dic->cpages, dic->nr_cpages);
 	if (!dic->cbuf) {
 		ret = -ENOMEM;
 		goto out_vunmap_rbuf;
-- 
2.28.0.526.ge36021eeef-goog

