Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2C14C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 11:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E67E206BE
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 11:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgF1LXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 07:23:20 -0400
Received: from mx139-tc.baidu.com ([61.135.168.139]:51103 "EHLO
        tc-sys-mailedm01.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726225AbgF1LXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 07:23:20 -0400
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm01.tc.baidu.com (Postfix) with ESMTP id 0772F2040055;
        Sun, 28 Jun 2020 19:23:05 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     tytso@mit.edu, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: [PATCH] random: get rid of dead codes from credit_entropy_bits
Date:   Sun, 28 Jun 2020 19:23:04 +0800
Message-Id: <1593343384-1292-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit 90ea1c6436d2 ("random: remove the blocking pool"),
has_initialized is zero always, and initialized of struct
entropy_store is not used

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/char/random.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index a7cf6aa65908..288cc4464a69 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -500,7 +500,6 @@ struct entropy_store {
 	unsigned short add_ptr;
 	unsigned short input_rotate;
 	int entropy_count;
-	unsigned int initialized:1;
 	unsigned int last_data_init:1;
 	__u8 last_data[EXTRACT_SIZE];
 };
@@ -660,7 +659,7 @@ static void process_random_ready_list(void)
  */
 static void credit_entropy_bits(struct entropy_store *r, int nbits)
 {
-	int entropy_count, orig, has_initialized = 0;
+	int entropy_count, orig;
 	const int pool_size = r->poolinfo->poolfracbits;
 	int nfrac = nbits << ENTROPY_SHIFT;
 
@@ -717,11 +716,6 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 	if (cmpxchg(&r->entropy_count, orig, entropy_count) != orig)
 		goto retry;
 
-	if (has_initialized) {
-		r->initialized = 1;
-		kill_fasync(&fasync, SIGIO, POLL_IN);
-	}
-
 	trace_credit_entropy_bits(r->name, nbits,
 				  entropy_count >> ENTROPY_SHIFT, _RET_IP_);
 
-- 
2.16.2

