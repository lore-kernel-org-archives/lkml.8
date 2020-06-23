Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A24CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD9A220E65
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943289;
	bh=8YYy4IJZKQXxkpqZmR/qPfJb8IQWnmR6BkrYt1kPC/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xO/0Oa4JQr8r18RUSaHa985+ju1hx4K8BwIIqYbk+qI18MFtuBtyncsgta+DAKid8
	 zA1xgb2SxFF9j2ATyB3mlqfxdEMfpko+1Uu87cmYS2+w0uB7Fw8IquWjibjAp7Sf/r
	 x8pk4RZr8equQ1s2Hju2gPf39pDx80EMlrV6IF7I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389236AbgFWUOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:57324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388946AbgFWUOq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:14:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00C5920E65;
        Tue, 23 Jun 2020 20:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943285;
        bh=8YYy4IJZKQXxkpqZmR/qPfJb8IQWnmR6BkrYt1kPC/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LVpiAf+Z6TzpxTurWWt8F/dh4d4patupxl3JuKwik3d7Ke9m4Yh4RoPcjlW18LAld
         Ir+1mGLMNGWb6Djvm/KWvVDhA9/WFroTPf+NdYvOHlE/SjiStY659rNCpag8ex2aOD
         B2mfWBgpp/irgq12uenSoEVADocezMe6FNub82P0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 331/477] blktrace: use errno instead of bi_status
Date:   Tue, 23 Jun 2020 21:55:28 +0200
Message-Id: <20200623195423.188125683@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

[ Upstream commit 48bc3cd3e07a1486f45d9971c75d6090976c3b1b ]

In blk_add_trace_spliti() blk_add_trace_bio_remap() use
blk_status_to_errno() to pass the error instead of pasing the bi_status.
This fixes the sparse warning.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/blktrace.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index ca39dc3230cb3..c6d59a457f50c 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -995,8 +995,10 @@ static void blk_add_trace_split(void *ignore,
 
 		__blk_add_trace(bt, bio->bi_iter.bi_sector,
 				bio->bi_iter.bi_size, bio_op(bio), bio->bi_opf,
-				BLK_TA_SPLIT, bio->bi_status, sizeof(rpdu),
-				&rpdu, blk_trace_bio_get_cgid(q, bio));
+				BLK_TA_SPLIT,
+				blk_status_to_errno(bio->bi_status),
+				sizeof(rpdu), &rpdu,
+				blk_trace_bio_get_cgid(q, bio));
 	}
 	rcu_read_unlock();
 }
@@ -1033,7 +1035,8 @@ static void blk_add_trace_bio_remap(void *ignore,
 	r.sector_from = cpu_to_be64(from);
 
 	__blk_add_trace(bt, bio->bi_iter.bi_sector, bio->bi_iter.bi_size,
-			bio_op(bio), bio->bi_opf, BLK_TA_REMAP, bio->bi_status,
+			bio_op(bio), bio->bi_opf, BLK_TA_REMAP,
+			blk_status_to_errno(bio->bi_status),
 			sizeof(r), &r, blk_trace_bio_get_cgid(q, bio));
 	rcu_read_unlock();
 }
-- 
2.25.1



