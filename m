Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64478C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA592078C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgEUOHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729717AbgEUOHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:07:34 -0400
Received: from ou.quest-ce.net (unknown [IPv6:2001:bc8:3541:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CAAC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:07:34 -0700 (PDT)
Received: from [2a01:e35:39f2:1220:ab87:b468:44f5:c88a] (helo=quest-ce.net)
        by ou.quest-ce.net with esmtpsa (TLS1.1:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ydroneaud@opteya.com>)
        id 1jblX5-000EQ5-KL; Thu, 21 May 2020 15:46:48 +0200
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Theodore Ts'o <tytso@mit.edu>
Cc:     Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org,
        Yann Droneaud <ydroneaud@opteya.com>
Date:   Thu, 21 May 2020 15:46:25 +0200
Message-Id: <e2dfe40c522770566c0ec6013e4680a973219d63.1590068270.git.ydroneaud@opteya.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1590068270.git.ydroneaud@opteya.com>
References: <cover.1590068270.git.ydroneaud@opteya.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a01:e35:39f2:1220:ab87:b468:44f5:c88a
X-SA-Exim-Mail-From: ydroneaud@opteya.com
Subject: [PATCH 1/4] random/trace: remove unused trace_random_read()
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on ou.quest-ce.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 30c08efec888 ('random: make /dev/random be almost like /dev/urandom'),
trace_random_read() is unused.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 include/trace/events/random.h | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/include/trace/events/random.h b/include/trace/events/random.h
index 32c10a515e2d..087ae7e8ae13 100644
--- a/include/trace/events/random.h
+++ b/include/trace/events/random.h
@@ -260,31 +260,6 @@ DEFINE_EVENT(random__extract_entropy, extract_entropy_user,
 	TP_ARGS(pool_name, nbytes, entropy_count, IP)
 );
 
-TRACE_EVENT(random_read,
-	TP_PROTO(int got_bits, int need_bits, int pool_left, int input_left),
-
-	TP_ARGS(got_bits, need_bits, pool_left, input_left),
-
-	TP_STRUCT__entry(
-		__field(	  int,	got_bits		)
-		__field(	  int,	need_bits		)
-		__field(	  int,	pool_left		)
-		__field(	  int,	input_left		)
-	),
-
-	TP_fast_assign(
-		__entry->got_bits	= got_bits;
-		__entry->need_bits	= need_bits;
-		__entry->pool_left	= pool_left;
-		__entry->input_left	= input_left;
-	),
-
-	TP_printk("got_bits %d still_needed_bits %d "
-		  "blocking_pool_entropy_left %d input_entropy_left %d",
-		  __entry->got_bits, __entry->got_bits, __entry->pool_left,
-		  __entry->input_left)
-);
-
 TRACE_EVENT(urandom_read,
 	TP_PROTO(int got_bits, int pool_left, int input_left),
 
-- 
2.25.4

