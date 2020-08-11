Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A879C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00CE0206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JuLJo6yV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgHKDiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 23:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbgHKDiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 23:38:03 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33050C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 20:38:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kr4so1158415pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 20:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uvnYmX5PBlwpImHnXxxWchHoc30rMXnuTKNbFFXi55o=;
        b=JuLJo6yVUGZojVryoUBe6GbWigpZF/q+mCKcpHEwcXIJ8jU7evVbMDRdm8h80V9Yk2
         VxkElGRUdfxwnBeeoHJ2ismfNOhXh7yy2g4UqgKY7Jk5MVSK5ZbNvb9XLHD5tzoacOl1
         4Y+yYHoXnSxLzNZv+oQ1ITAXY45dRAEZb5DwrG0gmjk/rdDuyDU+ZjZ4HjYVvHdRKOI/
         6pbMDuR+Yx0GhqFVwzC1q4fPFk0LsA5X/+0n+P6Q+zLqddz5lfUTSXx9uDYSxNAAbtLe
         hdVx6IylxTk3jVXeVyLfHCfj8arrME6AJdBFmfwCaqBs0NRd1sFjpSmMUTo8kEDn8ZIB
         YT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uvnYmX5PBlwpImHnXxxWchHoc30rMXnuTKNbFFXi55o=;
        b=UYysIVfjzeqZMIyyAr0GVKeaGM3/JuR8DByk+mZo0JTNl9ir7WY+Z9owLVbu9HkKts
         tTTbyP0iLBcHz9HtfNZAQnw2whDgvh8PHHaNcJHvsE+NGkbv7rDbe+DM9SvokrHKeC6S
         axFTVOlPDMgwNLaTs2D4wX4aSaPTS29oja+s/tkHcmF8c0UdMwdCBm7LCq+q1LcDX0Ss
         KyzbjP5Bw4fE2rkdcqsezl0fCZ3X+2eeMsSQAVJNDq/D1+zOMGMyxKDNqoGsFLOJTEHV
         HalnfpAaPqYuK8n2OlBzeQLpSKl0XAa+wiGi4BuLswgWY309uLQbIHEyx3AHQbmnlOrN
         DdBQ==
X-Gm-Message-State: AOAM530c4gu8fb+ksAgPsFxhQ43ofWpZAb7EAedg2hPPojczJ+4qBH0W
        dxdfwzEA1YpfB1EJpKD2uqW4I8UmA/8=
X-Google-Smtp-Source: ABdhPJxId44YKFt1dP26u0IpbkikiLFA5z6pJm4cqWwvbFvtVNjGOeRyzD/l2ipwCHY0sWi3Ogs62A==
X-Received: by 2002:a17:90b:94c:: with SMTP id dw12mr2592970pjb.214.1597117082121;
        Mon, 10 Aug 2020 20:38:02 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id e22sm19307183pgi.62.2020.08.10.20.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 20:38:01 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH] f2fs: change virtual mapping way for compression pages
Date:   Tue, 11 Aug 2020 12:37:53 +0900
Message-Id: <20200811033753.783276-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

By profiling f2fs compression works, I've found vmap() callings are
bottlenecks of f2fs decompression path. Changing these with
vm_map_ram(), we can enhance f2fs decompression speed pretty much.

[Verification]
dd if=/dev/zero of=dummy bs=1m count=1000
echo 3 > /proc/sys/vm/drop_caches
dd if=dummy of=/dev/zero bs=512k

- w/o compression -
1048576000 bytes (0.9 G) copied, 1.999384 s, 500 M/s
1048576000 bytes (0.9 G) copied, 2.035988 s, 491 M/s
1048576000 bytes (0.9 G) copied, 2.039457 s, 490 M/s

- before patch -
1048576000 bytes (0.9 G) copied, 9.146217 s, 109 M/s
1048576000 bytes (0.9 G) copied, 9.997542 s, 100 M/s
1048576000 bytes (0.9 G) copied, 10.109727 s, 99 M/s

- after patch -
1048576000 bytes (0.9 G) copied, 2.253441 s, 444 M/s
1048576000 bytes (0.9 G) copied, 2.739764 s, 365 M/s
1048576000 bytes (0.9 G) copied, 2.185649 s, 458 M/s

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/compress.c | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 6e7db450006c..46b7e359f313 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -554,6 +554,8 @@ static void f2fs_compress_free_page(struct page *page)
 	mempool_free(page, compress_page_pool);
 }
 
+#define MAX_VMAP_RETRIES	3
+
 static int f2fs_compress_pages(struct compress_ctx *cc)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
@@ -590,13 +592,23 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 		}
 	}
 
-	cc->rbuf = vmap(cc->rpages, cc->cluster_size, VM_MAP, PAGE_KERNEL_RO);
+	for (i = 0; i < MAX_VMAP_RETRIES; i++) {
+		cc->rbuf = vm_map_ram(cc->rpages, cc->cluster_size, -1);
+		if (cc->rbuf)
+			break;
+		vm_unmap_aliases();
+	}
 	if (!cc->rbuf) {
 		ret = -ENOMEM;
 		goto out_free_cpages;
 	}
 
-	cc->cbuf = vmap(cc->cpages, cc->nr_cpages, VM_MAP, PAGE_KERNEL);
+	for (i = 0; i < MAX_VMAP_RETRIES; i++) {
+		cc->cbuf = vm_map_ram(cc->cpages, cc->nr_cpages, -1);
+		if (cc->cbuf)
+			break;
+		vm_unmap_aliases();
+	}
 	if (!cc->cbuf) {
 		ret = -ENOMEM;
 		goto out_vunmap_rbuf;
@@ -624,8 +636,8 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 	memset(&cc->cbuf->cdata[cc->clen], 0,
 	       (nr_cpages * PAGE_SIZE) - (cc->clen + COMPRESS_HEADER_SIZE));
 
-	vunmap(cc->cbuf);
-	vunmap(cc->rbuf);
+	vm_unmap_ram(cc->cbuf, cc->nr_cpages);
+	vm_unmap_ram(cc->rbuf, cc->cluster_size);
 
 	for (i = nr_cpages; i < cc->nr_cpages; i++) {
 		f2fs_compress_free_page(cc->cpages[i]);
@@ -642,9 +654,9 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 	return 0;
 
 out_vunmap_cbuf:
-	vunmap(cc->cbuf);
+	vm_unmap_ram(cc->cbuf, cc->nr_cpages);
 out_vunmap_rbuf:
-	vunmap(cc->rbuf);
+	vm_unmap_ram(cc->rbuf, cc->cluster_size);
 out_free_cpages:
 	for (i = 0; i < cc->nr_cpages; i++) {
 		if (cc->cpages[i])
@@ -715,13 +727,23 @@ void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity)
 			goto out_free_dic;
 	}
 
-	dic->rbuf = vmap(dic->tpages, dic->cluster_size, VM_MAP, PAGE_KERNEL);
+	for (i = 0; i < MAX_VMAP_RETRIES; i++) {
+		dic->rbuf = vm_map_ram(dic->tpages, dic->cluster_size, -1);
+		if (dic->rbuf)
+			break;
+		vm_unmap_aliases();
+	}
 	if (!dic->rbuf) {
 		ret = -ENOMEM;
 		goto destroy_decompress_ctx;
 	}
 
-	dic->cbuf = vmap(dic->cpages, dic->nr_cpages, VM_MAP, PAGE_KERNEL_RO);
+	for (i = 0; i < MAX_VMAP_RETRIES; i++) {
+		dic->cbuf = vm_map_ram(dic->cpages, dic->nr_cpages, -1);
+		if (dic->cbuf)
+			break;
+		vm_unmap_aliases();
+	}
 	if (!dic->cbuf) {
 		ret = -ENOMEM;
 		goto out_vunmap_rbuf;
@@ -738,9 +760,9 @@ void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity)
 	ret = cops->decompress_pages(dic);
 
 out_vunmap_cbuf:
-	vunmap(dic->cbuf);
+	vm_unmap_ram(dic->cbuf, dic->nr_cpages);
 out_vunmap_rbuf:
-	vunmap(dic->rbuf);
+	vm_unmap_ram(dic->rbuf, dic->cluster_size);
 destroy_decompress_ctx:
 	if (cops->destroy_decompress_ctx)
 		cops->destroy_decompress_ctx(dic);
-- 
2.28.0.236.gb10cc79966-goog

