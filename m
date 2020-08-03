Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AC7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4068B20738
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Ozwq4TKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgHCNiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 09:38:12 -0400
Received: from m15112.mail.126.com ([220.181.15.112]:43282 "EHLO
        m15112.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728213AbgHCNiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=GF5NkU1Owa5eZCpSTh
        UERjt0ONcFG8WTLeHpFY0eUC8=; b=Ozwq4TKAKvCRm+AUmeZy2NaxuxjEyRjHkF
        XRwO05xF6XV0aQtCH4SWIrNxbkiLGWH63LZS8lQfIpYl7viyVarXzAW4rgQAvG9T
        wSPKtwQKfQNHRz6d474ff8EaOHxyPUZ3f5rlx2AOXmO2t5+MywOiek743sEBWScJ
        /y3/nC3qs=
Received: from 192.168.137.249 (unknown [112.10.84.202])
        by smtp2 (Coremail) with SMTP id DMmowADXsfLwEihfNwDqFw--.30116S3;
        Mon, 03 Aug 2020 21:36:49 +0800 (CST)
From:   Xianting Tian <xianting_tian@126.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: use blk_io_schedule() for avoiding task hung in sync io
Date:   Mon,  3 Aug 2020 09:36:47 -0400
Message-Id: <1596461807-21087-1-git-send-email-xianting_tian@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DMmowADXsfLwEihfNwDqFw--.30116S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZw4rKr1ktFy8Aw4xXr4kXrb_yoWfuwcEk3
        yxKrna9w1YkF97ur13Cay3J34UKayI9F4UZF4jgFy5t34Iva4UXF1xtFs3XF1fX3yjvayD
        GFZ0yFWUAr42gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8WE_tUUUUU==
X-Originating-IP: [112.10.84.202]
X-CM-SenderInfo: h0ld03plqjs3xldqqiyswou0bp/1tbiHhR1pF16HThDMwAAsp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

swap_readpage() does the sync io for one page, the io is not big, normally,
the io can be finished quickly, but it may take long time or wait forever
in case of io failure or discard.
This patch is to use blk_io_schedule() instead of io_schedule() to avoid
task hung and crash(when set /proc/sys/kernel/hung_task_panic) in case of
above exception occur.
We have prevented task hung in submit_bio_wait(), blk_execute_rq() and
__blkdev_direct_IO().

Signed-off-by: Xianting Tian <xianting_tian@126.com>
---
 mm/page_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index e8726f3..5d52f7b 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -424,7 +424,7 @@ int swap_readpage(struct page *page, bool synchronous)
 			break;
 
 		if (!blk_poll(disk->queue, qc, true))
-			io_schedule();
+			blk_io_schedule();
 	}
 	__set_current_state(TASK_RUNNING);
 	bio_put(bio);
-- 
1.8.3.1

