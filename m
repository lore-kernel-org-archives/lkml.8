Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761FAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41DEE20826
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729716AbgEUOHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbgEUOHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:07:23 -0400
X-Greylist: delayed 1231 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 May 2020 07:07:22 PDT
Received: from ou.quest-ce.net (unknown [IPv6:2001:bc8:3541:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14BDC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:07:22 -0700 (PDT)
Received: from [2a01:e35:39f2:1220:ab87:b468:44f5:c88a] (helo=quest-ce.net)
        by ou.quest-ce.net with esmtpsa (TLS1.1:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <ydroneaud@opteya.com>)
        id 1jblXC-000EQM-4n; Thu, 21 May 2020 15:46:54 +0200
From:   Yann Droneaud <ydroneaud@opteya.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Theodore Ts'o <tytso@mit.edu>
Cc:     Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org,
        Yann Droneaud <ydroneaud@opteya.com>
Date:   Thu, 21 May 2020 15:46:27 +0200
Message-Id: <131dbec917562033ce87793c9902f4cd6a7b9ec0.1590068270.git.ydroneaud@opteya.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1590068270.git.ydroneaud@opteya.com>
References: <cover.1590068270.git.ydroneaud@opteya.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a01:e35:39f2:1220:ab87:b468:44f5:c88a
X-SA-Exim-Mail-From: ydroneaud@opteya.com
Subject: [PATCH 3/4] random/trace: remove unused trace_extract_entropy_user()
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on ou.quest-ce.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 90ea1c6436d2 ('random: remove the blocking pool')
trace_extract_entropy_user() is unused.

As the result, trace_extract_entropy() is the only trace
function needed, thus there's no need for a separate event
class / event.

Cc: Andy Lutomirski <luto@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 include/trace/events/random.h | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/include/trace/events/random.h b/include/trace/events/random.h
index d5aa662294fe..c2256250e3ef 100644
--- a/include/trace/events/random.h
+++ b/include/trace/events/random.h
@@ -198,7 +198,7 @@ DEFINE_EVENT(random__get_random_bytes, get_random_bytes_arch,
 	TP_ARGS(nbytes, IP)
 );
 
-DECLARE_EVENT_CLASS(random__extract_entropy,
+TRACE_EVENT(extract_entropy,
 	TP_PROTO(const char *pool_name, int nbytes, int entropy_count,
 		 unsigned long IP),
 
@@ -223,21 +223,6 @@ DECLARE_EVENT_CLASS(random__extract_entropy,
 		  (void *)__entry->IP)
 );
 
-
-DEFINE_EVENT(random__extract_entropy, extract_entropy,
-	TP_PROTO(const char *pool_name, int nbytes, int entropy_count,
-		 unsigned long IP),
-
-	TP_ARGS(pool_name, nbytes, entropy_count, IP)
-);
-
-DEFINE_EVENT(random__extract_entropy, extract_entropy_user,
-	TP_PROTO(const char *pool_name, int nbytes, int entropy_count,
-		 unsigned long IP),
-
-	TP_ARGS(pool_name, nbytes, entropy_count, IP)
-);
-
 TRACE_EVENT(urandom_read,
 	TP_PROTO(int got_bits, int pool_left, int input_left),
 
-- 
2.25.4

