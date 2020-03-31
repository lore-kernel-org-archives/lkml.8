Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEF2C2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0FE20848
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgCaI5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:57:09 -0400
Received: from mx.sdf.org ([205.166.94.20]:59171 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726488AbgCaI5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:57:07 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02V8uxRt022439
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Tue, 31 Mar 2020 08:56:59 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02V8uxXM006430;
        Tue, 31 Mar 2020 08:56:59 GMT
Date:   Tue, 31 Mar 2020 08:56:59 GMT
Message-Id: <9916203ec97be0f24886fc8478437d161b56f053.1585644000.git.lkml@sdf.org>
From:   George Spelvin <lkml@sdf.org>
Subject: [PATCH 1/3] random: Further dead code elimination
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Yangtao Li <tiny.windzz@gmail.com>,
        linux-kernel@vger.kernel.org, lkml@sdf.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Earlier commits left some dead code behind in credit_entropy_bits().

In particular, has_initialized was always zero.

Fixes: 90ea1c6436d2 ("random: remove the blocking pool")
Signed-off-by: George Spelvin <lkml@sdf.org>
Cc: Andy Lutomirski <luto@kernel.org>
---
Just some odds & ends I noticed.

 drivers/char/random.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index c7f9584de2c8..273dcbb4a790 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -660,7 +660,7 @@ static void process_random_ready_list(void)
  */
 static void credit_entropy_bits(struct entropy_store *r, int nbits)
 {
-	int entropy_count, orig, has_initialized = 0;
+	int entropy_count, orig;
 	const int pool_size = r->poolinfo->poolfracbits;
 	int nfrac = nbits << ENTROPY_SHIFT;
 
@@ -717,24 +717,11 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
 	if (cmpxchg(&r->entropy_count, orig, entropy_count) != orig)
 		goto retry;
 
-	if (has_initialized) {
-		r->initialized = 1;
-		kill_fasync(&fasync, SIGIO, POLL_IN);
-	}
+	entropy_count >>= ENTROPY_SHIFT;	/* Convert to bits */
+	trace_credit_entropy_bits(r->name, nbits, entropy_count, _RET_IP_);
 
-	trace_credit_entropy_bits(r->name, nbits,
-				  entropy_count >> ENTROPY_SHIFT, _RET_IP_);
-
-	if (r == &input_pool) {
-		int entropy_bits = entropy_count >> ENTROPY_SHIFT;
-
-		if (crng_init < 2) {
-			if (entropy_bits < 128)
-				return;
-			crng_reseed(&primary_crng, r);
-			entropy_bits = ENTROPY_BITS(r);
-		}
-	}
+	if (r == &input_pool && crng_init < 2 && entropy_count >= 128)
+		crng_reseed(&primary_crng, r);
 }
 
 static int credit_entropy_bits_safe(struct entropy_store *r, int nbits)
-- 
2.26.0

