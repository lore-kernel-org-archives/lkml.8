Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD92FC4332E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0E921655
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 21:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584565600;
	bh=TBZeX4sIzJu+9MVlo1e1hl4wfdCTUJS2iCsE73tS2eI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yaASVDnthvn6eJDbJhxi6c3S0lwS7EFJWNegVZHxWWdwRaljzyANdoAYA09q0s3vV
	 mQs8sPodgvW82Lv5PnTxMSr8aEx/CPTt3b36sea1OICMQEADa2tHIHbLMjgy+Ee/VH
	 XsocFbWlV7guk/kCUiJNZgvHanTDxbpyDjdCQAwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgCRVGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 17:06:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:54082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgCRUyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:54:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60728208DB;
        Wed, 18 Mar 2020 20:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584564872;
        bh=TBZeX4sIzJu+9MVlo1e1hl4wfdCTUJS2iCsE73tS2eI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eD3PaxVaRxjffXHHPj8HMi0NZyImRIColXG265knM5iN5um4TIraDG9amfo+yFKs8
         EKvpop1TIYrqO+q+ONLYWJhZb4BIC8HMDKN6aNFs/Hy8Wi5OQHoiHPBKdMMCmYe2zG
         bwrvOMEkvxN76i3dRuoYOATUaTqeyQurxsFItqBQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rong Chen <rong.a.chen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 43/73] futex: Unbreak futex hashing
Date:   Wed, 18 Mar 2020 16:53:07 -0400
Message-Id: <20200318205337.16279-43-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200318205337.16279-1-sashal@kernel.org>
References: <20200318205337.16279-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

[ Upstream commit 8d67743653dce5a0e7aa500fcccb237cde7ad88e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/futex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 07ab324885ac0..5660c02b01b05 100644
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
 
-- 
2.20.1

