Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD75C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 935CD2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580410150;
	bh=sTk4HzVHw0/UkgxkEPe5mIgaFekq7MtnMu76lCkb6po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c8189igtvhkCsGGfKe4jMv+/LtOcZIJ26pxL/1Q2GLQ9zLzz6yJoN92av2tc+9Et4
	 VuZb6r9VIxst0y2Y6jtBz/HepkQ80jl0xuHi3zhUkBbIq0tSCrjMTaO2TNHwHMg4RY
	 83m52OMMOmIgVYMJyTGVrFDkOTZAJqeI3oXUVDGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731647AbgA3Ss6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:48:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:60148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731628AbgA3Ssy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:48:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D01372082E;
        Thu, 30 Jan 2020 18:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580410134;
        bh=sTk4HzVHw0/UkgxkEPe5mIgaFekq7MtnMu76lCkb6po=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O9794AP+QiXYRa7csQ5ZbTdp6QqdA2DOOEsYqljdi21Y6/eSUc9cfu0s5BAIDdv1b
         FLRJ6OlL+KD3sCTque3g9uZJ27XHktKPG6PKfrNzxQGqDvj3nk12AoVAoBaGnw8Ra2
         QBR0TLFVyEdUkKm2HLQ0nClASsuHMab+VfSDnt1g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>, Xiao Ni <xni@redhat.com>,
        Mariusz Dabrowski <mariusz.dabrowski@intel.com>,
        Rui Salvaterra <rsalvaterra@gmail.com>,
        Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Subject: [PATCH 4.19 53/55] block: cleanup __blkdev_issue_discard()
Date:   Thu, 30 Jan 2020 19:39:34 +0100
Message-Id: <20200130183618.023559040@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183608.563083888@linuxfoundation.org>
References: <20200130183608.563083888@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

commit ba5d73851e71847ba7f7f4c27a1a6e1f5ab91c79 upstream.

Cleanup __blkdev_issue_discard() a bit:

- remove local variable of 'end_sect'
- remove code block of 'fail'

Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Xiao Ni <xni@redhat.com>
Cc: Mariusz Dabrowski <mariusz.dabrowski@intel.com>
Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 block/blk-lib.c |   23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -52,15 +52,12 @@ int __blkdev_issue_discard(struct block_
 	if ((sector | nr_sects) & bs_mask)
 		return -EINVAL;
 
-	while (nr_sects) {
-		unsigned int req_sects = nr_sects;
-		sector_t end_sect;
-
-		if (!req_sects)
-			goto fail;
-		req_sects = min(req_sects, bio_allowed_max_sectors(q));
+	if (!nr_sects)
+		return -EINVAL;
 
-		end_sect = sector + req_sects;
+	while (nr_sects) {
+		unsigned int req_sects = min_t(unsigned int, nr_sects,
+				bio_allowed_max_sectors(q));
 
 		bio = next_bio(bio, 0, gfp_mask);
 		bio->bi_iter.bi_sector = sector;
@@ -68,8 +65,8 @@ int __blkdev_issue_discard(struct block_
 		bio_set_op_attrs(bio, op, 0);
 
 		bio->bi_iter.bi_size = req_sects << 9;
+		sector += req_sects;
 		nr_sects -= req_sects;
-		sector = end_sect;
 
 		/*
 		 * We can loop for a long time in here, if someone does
@@ -82,14 +79,6 @@ int __blkdev_issue_discard(struct block_
 
 	*biop = bio;
 	return 0;
-
-fail:
-	if (bio) {
-		submit_bio_wait(bio);
-		bio_put(bio);
-	}
-	*biop = NULL;
-	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(__blkdev_issue_discard);
 


