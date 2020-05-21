Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBFBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EC6D20826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgEUOHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgEUOH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:07:29 -0400
Received: from ou.quest-ce.net (unknown [IPv6:2001:bc8:3541:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8A7C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:07:28 -0700 (PDT)
Received: from [2a01:e35:39f2:1220:ab87:b468:44f5:c88a] (helo=quest-ce.net)
        by ou.quest-ce.net with esmtpsa (TLS1.1:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ydroneaud@opteya.com>)
        id 1jblX9-000EQF-9F; Thu, 21 May 2020 15:46:51 +0200
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Theodore Ts'o <tytso@mit.edu>
Cc:     Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org,
        Yann Droneaud <ydroneaud@opteya.com>
Date:   Thu, 21 May 2020 15:46:26 +0200
Message-Id: <d60b9719fc664ead1f0badc7cd7fe39d365da6cf.1590068270.git.ydroneaud@opteya.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1590068270.git.ydroneaud@opteya.com>
References: <cover.1590068270.git.ydroneaud@opteya.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a01:e35:39f2:1220:ab87:b468:44f5:c88a
X-SA-Exim-Mail-From: ydroneaud@opteya.com
Subject: [PATCH 2/4] random/trace: remove unused trace_push_to_pool()
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on ou.quest-ce.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 90ea1c6436d2 ('random: remove the blocking pool')
trace_push_to_pool() is unused.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 include/trace/events/random.h | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/include/trace/events/random.h b/include/trace/events/random.h
index 087ae7e8ae13..d5aa662294fe 100644
--- a/include/trace/events/random.h
+++ b/include/trace/events/random.h
@@ -85,28 +85,6 @@ TRACE_EVENT(credit_entropy_bits,
 		  __entry->entropy_count, (void *)__entry->IP)
 );
 
-TRACE_EVENT(push_to_pool,
-	TP_PROTO(const char *pool_name, int pool_bits, int input_bits),
-
-	TP_ARGS(pool_name, pool_bits, input_bits),
-
-	TP_STRUCT__entry(
-		__field( const char *,	pool_name		)
-		__field(	  int,	pool_bits		)
-		__field(	  int,	input_bits		)
-	),
-
-	TP_fast_assign(
-		__entry->pool_name	= pool_name;
-		__entry->pool_bits	= pool_bits;
-		__entry->input_bits	= input_bits;
-	),
-
-	TP_printk("%s: pool_bits %d input_pool_bits %d",
-		  __entry->pool_name, __entry->pool_bits,
-		  __entry->input_bits)
-);
-
 TRACE_EVENT(debit_entropy,
 	TP_PROTO(const char *pool_name, int debit_bits),
 
-- 
2.25.4

