Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8508C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F11F20663
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592946022;
	bh=hqwlWRvWf4VkvJjmn5Un+sLTMPd1nj+0kGTnJUVPEWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n/IpHIk5FV5MrxJhezahvEBdroMPF8nBkvQbe/nAgrQN5JZJ5GDAb2hex2invvNt4
	 +ztwR/3bWSpsrC2GLnnx8Ux0sCW6n81UNCyv11GizCi0uDMgja0TLgKQ+lOLix/NKi
	 k6V/UZxHHMfK+zMDRPUN+fO1y3Bg+5qN3Dsbcc+U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392221AbgFWUkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:40:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:36364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390938AbgFWUkV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:40:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6033D20702;
        Tue, 23 Jun 2020 20:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592944821;
        bh=hqwlWRvWf4VkvJjmn5Un+sLTMPd1nj+0kGTnJUVPEWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vdmA6IjtTimoC0tKoa/JvBX7BXKAJoNdIXiaTD9gVykW0d0grLRJELijv72rsWIqf
         /7hnPeR1p3bGZfIT28YL9tnSHKRlRnlcryhOCj7RIFRbpVFKgMLPBWFFMeObjok85V
         YjtY5Jbc02GwlWIj63Opah14xkNi+K/RdGh3OC4Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 139/206] blktrace: use errno instead of bi_status
Date:   Tue, 23 Jun 2020 21:57:47 +0200
Message-Id: <20200623195323.824707592@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195316.864547658@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
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
index 6cea8bbca03cb..5c84f7421871d 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1004,8 +1004,10 @@ static void blk_add_trace_split(void *ignore,
 
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
@@ -1042,7 +1044,8 @@ static void blk_add_trace_bio_remap(void *ignore,
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



