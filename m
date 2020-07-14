Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA0DC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FCCB22BEF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752896;
	bh=WDOcpm8AiqOoHahlx7bW0LSDjS5IJ/h+aOG5VQUvvuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KrEUwfAqwI43dN/vI1W8p/vTkItoOrZWdHeTlDJWanuyJAZe48qGVhS2YV+KehaAj
	 olKz0+0+AtN40BKCK9ro/tmdNfVdzXpVs/hUnSycWSDqPOgYUxgoq6XxkbfLm7gM2K
	 mwPvzwQZJiLwYVX773EcdgnWG6fmJugG3d6jCof0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbgGNSyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:54:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730794AbgGNSys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:54:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEA8F22B45;
        Tue, 14 Jul 2020 18:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752888;
        bh=WDOcpm8AiqOoHahlx7bW0LSDjS5IJ/h+aOG5VQUvvuo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OUaQIMSePprqQhBIY5+V7cPLP3mhExf7oa6GWexB+++1SODHxMx8q/Cl7tqWl3HSt
         kTESy+XdONAgwfCkfxcCILe1Mb5n3YI3h8ISdby/4LaSSJdut6dU5oIMsdYAFAxaPt
         Kr1/upw/alCJ0tmwe9+0lxzewywTvaM3AnZAAdUE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 039/166] block: release bip in a right way in error path
Date:   Tue, 14 Jul 2020 20:43:24 +0200
Message-Id: <20200714184117.750537236@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengguang Xu <cgxu519@mykernel.net>

[ Upstream commit 0b8eb629a700c0ef15a437758db8255f8444e76c ]

Release bip using kfree() in error path when that was allocated
by kmalloc().

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bio-integrity.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index ae07dd78e9518..c9dc2b17ce251 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -24,6 +24,18 @@ void blk_flush_integrity(void)
 	flush_workqueue(kintegrityd_wq);
 }
 
+void __bio_integrity_free(struct bio_set *bs, struct bio_integrity_payload *bip)
+{
+	if (bs && mempool_initialized(&bs->bio_integrity_pool)) {
+		if (bip->bip_vec)
+			bvec_free(&bs->bvec_integrity_pool, bip->bip_vec,
+				  bip->bip_slab);
+		mempool_free(bip, &bs->bio_integrity_pool);
+	} else {
+		kfree(bip);
+	}
+}
+
 /**
  * bio_integrity_alloc - Allocate integrity payload and attach it to bio
  * @bio:	bio to attach integrity metadata to
@@ -75,7 +87,7 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
 
 	return bip;
 err:
-	mempool_free(bip, &bs->bio_integrity_pool);
+	__bio_integrity_free(bs, bip);
 	return ERR_PTR(-ENOMEM);
 }
 EXPORT_SYMBOL(bio_integrity_alloc);
@@ -96,14 +108,7 @@ void bio_integrity_free(struct bio *bio)
 		kfree(page_address(bip->bip_vec->bv_page) +
 		      bip->bip_vec->bv_offset);
 
-	if (bs && mempool_initialized(&bs->bio_integrity_pool)) {
-		bvec_free(&bs->bvec_integrity_pool, bip->bip_vec, bip->bip_slab);
-
-		mempool_free(bip, &bs->bio_integrity_pool);
-	} else {
-		kfree(bip);
-	}
-
+	__bio_integrity_free(bs, bip);
 	bio->bi_integrity = NULL;
 	bio->bi_opf &= ~REQ_INTEGRITY;
 }
-- 
2.25.1



