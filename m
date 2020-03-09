Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF5EC10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 976A324649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgCIVmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:42:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60342 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727080AbgCIVmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 17:42:17 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jBQA5-0000Bf-M0; Mon, 09 Mar 2020 22:42:09 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EAB231C217D;
        Mon,  9 Mar 2020 22:42:08 +0100 (CET)
Date:   Mon, 09 Mar 2020 21:42:08 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Unbreak futex hashing
Cc:     Rong Chen <rong.a.chen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87h7yy90ve.fsf@nanos.tec.linutronix.de>
References: <87h7yy90ve.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <158379012847.28353.9019650703766565146.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     8d67743653dce5a0e7aa500fcccb237cde7ad88e
Gitweb:        https://git.kernel.org/tip/8d67743653dce5a0e7aa500fcccb237cde7ad88e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 08 Mar 2020 19:07:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 09 Mar 2020 22:33:09 +01:00

futex: Unbreak futex hashing

The recent futex inode life time fix changed the ordering of the futex key
union struct members, but forgot to adjust the hash function accordingly,

As a result the hashing omits the leading 64bit and even hashes beyond the
futex key causing a bad hash distribution which led to a ~100% performance
regression.

Hand in the futex key pointer instead of a random struct member and make
the size calculation based of the struct offset.

Fixes: 8019ad13ef7f ("futex: Fix inode life-time issue")
Reported-by: Rong Chen <rong.a.chen@intel.com>
Decoded-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Rong Chen <rong.a.chen@intel.com>
Link: https://lkml.kernel.org/r/87h7yy90ve.fsf@nanos.tec.linutronix.de
---
 kernel/futex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index e14f7cd..82dfacb 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -385,9 +385,9 @@ static inline int hb_waiters_pending(struct futex_hash_bucket *hb)
  */
 static struct futex_hash_bucket *hash_futex(union futex_key *key)
 {
-	u32 hash = jhash2((u32*)&key->both.word,
-			  (sizeof(key->both.word)+sizeof(key->both.ptr))/4,
+	u32 hash = jhash2((u32 *)key, offsetof(typeof(*key), both.offset) / 4,
 			  key->both.offset);
+
 	return &futex_queues[hash & (futex_hashsize - 1)];
 }
 
