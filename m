Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27094C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8D4C20775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585055673;
	bh=XUdUlETjks8qrFnK1gLjeXhW3mVL5ZwRP1Z9nq7bTSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O/+ycxtqo7Grlscz9+9o+Mzdxjo3SCjL4WH2dcRg0CqNvOGuavw83NGrvJGjiY7jE
	 v5nJTnhHhrun4GgdURoT2BOK7Tj+ZfdxF7ClEim7LK4Lf80vYHS75WGgjnFx2Dx6QP
	 L47ocYHXDr7L220YQNkfTdaWc3ITSnFqumPgYk6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgCXNOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:14:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:32876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727164AbgCXNO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:14:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF8B1208D5;
        Tue, 24 Mar 2020 13:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585055668;
        bh=XUdUlETjks8qrFnK1gLjeXhW3mVL5ZwRP1Z9nq7bTSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kWIbPalKWdYS54pZcl0sP7PdFSAUiEW8UzYqrAYJdgBlryzxrp3F1RKGcd26rtIv2
         bkYGsYW4nARa6vWKRLS7sIcJPMGMXxvzMXvCNrDr4rQXxRvseH2fddWTh/SihDJ1iw
         Uz5Y6gxHv96lLHYcpB8kR5+UNNOoIv/LWscX2ivo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rong Chen <rong.a.chen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 57/65] futex: Unbreak futex hashing
Date:   Tue, 24 Mar 2020 14:11:18 +0100
Message-Id: <20200324130803.953923099@linuxfoundation.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200324130756.679112147@linuxfoundation.org>
References: <20200324130756.679112147@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

commit 8d67743653dce5a0e7aa500fcccb237cde7ad88e upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/futex.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -395,9 +395,9 @@ static inline int hb_waiters_pending(str
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
 


