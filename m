Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5EEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 05:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3E34206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 05:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+hYaEb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgHLFRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 01:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbgHLFRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 01:17:21 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD67C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 22:17:21 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id l60so540070pjb.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 22:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Po0Y4p2+iqQSTXjlLpva9c3LO+7SRYD5DhzkCojY0rw=;
        b=T+hYaEb0HCElY2tWsbM5W2OErXBuUOKpwFlxWyU7GeFOuaA7VmANP6Sm/ojvkoW6Lj
         ze6hRFfp+XqHCTjiR01H78yxPYc9QQGbTKy2M7wL09Aa38GzciSlWvcU8VSjoHkkUVVp
         kQ860FhamX+2VAkRTCRGhiMh27zsRbsHVTV9W7zdGy25I4pS4R8fywWs438zzsIg00ZQ
         3Z71uvfqJiztHgUc+wDKPCOten49RAnUM6uNI/CvSdwb0xNozlxG7q183B2aNkUk+ju2
         ZbgdBcvPHOaDezWYuaW5ZyDcLYv9jDbOBY6HCslSNJgzBi+u51hlW0aTw6OPLLYZMUjU
         PfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Po0Y4p2+iqQSTXjlLpva9c3LO+7SRYD5DhzkCojY0rw=;
        b=d3XFEQjdPdTSh/u9mdURZmandFxGDkazgyyERp2m9DQrIzVajqFrAxFpHUwgnFgz4t
         7MPm8lR3wUHQILTAhuQPyjfL8PXwvUMmtruBNeZbLSZdbEAVSwGZgrod/LXe7xjYwkME
         efE69XvbKU3M1HZxcqjLGSdSo0JvLc4FN8RcfACX17FZGvmGWleYCqIwL8q8zaO0OIm2
         DQ5fH9Nlko7ITBjn/Zp4tlNQd12to58yMyJ0m0C0rVdznCguNj3mGddjwHUZ9pD95pSJ
         yGXZiA1l+s7DIh9jXd2Yjyb7nFqgDIALMTX0JUOOOrEcFxuS18FqZHUpbAYKlUJPBevZ
         9HcA==
X-Gm-Message-State: AOAM533I05YschGJgE36CXHLfFqvzQl+SDIItU8EUUuOLP99vdRt3k1T
        Gwb1d9W+rOKr+f3LHywidctbGlLJdRg=
X-Google-Smtp-Source: ABdhPJyeBNwymK1KUM8ISupJ71mP+GdrxXLlbOSEw6ff1QuP1H/mgJ4B+Fn1heF/hO7NcLul0DcWNQ==
X-Received: by 2002:a17:90a:ee8d:: with SMTP id i13mr4604727pjz.19.1597209440187;
        Tue, 11 Aug 2020 22:17:20 -0700 (PDT)
Received: from daehojeong1.seo.corp.google.com ([2401:fa00:d:1:a6ae:11ff:fe18:6ce2])
        by smtp.gmail.com with ESMTPSA id z6sm841051pfg.68.2020.08.11.22.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 22:17:19 -0700 (PDT)
From:   Daeho Jeong <daeho43@gmail.com>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Cc:     Daeho Jeong <daehojeong@google.com>
Subject: [PATCH v3] f2fs: change virtual mapping way for compression pages
Date:   Wed, 12 Aug 2020 14:17:11 +0900
Message-Id: <20200812051711.2147716-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daeho Jeong <daehojeong@google.com>

By profiling f2fs compression works, I've found vmap() callings have
unexpected hikes in the execution time in our test environment and
those are bottlenecks of f2fs decompression path. Changing these with
vm_map_ram(), we can enhance f2fs decompression speed pretty much.

[Verification]
Android Pixel 3(ARM64, 6GB RAM, 128GB UFS)
Turned on only 0-3 little cores(at 1.785GHz)

dd if=/dev/zero of=dummy bs=1m count=1000
echo 3 > /proc/sys/vm/drop_caches
dd if=dummy of=/dev/zero bs=512k

- w/o compression -
1048576000 bytes (0.9 G) copied, 2.082554 s, 480 M/s
1048576000 bytes (0.9 G) copied, 2.081634 s, 480 M/s
1048576000 bytes (0.9 G) copied, 2.090861 s, 478 M/s

- before patch -
1048576000 bytes (0.9 G) copied, 7.407527 s, 135 M/s
1048576000 bytes (0.9 G) copied, 7.283734 s, 137 M/s
1048576000 bytes (0.9 G) copied, 7.291508 s, 137 M/s

- after patch -
1048576000 bytes (0.9 G) copied, 1.998959 s, 500 M/s
1048576000 bytes (0.9 G) copied, 1.987554 s, 503 M/s
1048576000 bytes (0.9 G) copied, 1.986380 s, 503 M/s

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
Changes in v2:
 - Added test environment description.
Changes in v3:
 - Re-tested using only ARM little cores and maximzing cpu clock.
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

