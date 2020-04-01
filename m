Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EFBC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC5D2063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585759329;
	bh=NGlbUHeGAsmj8DvLjo4wsyyd7AsWiHPZuZbnLUQ9UIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vt0QFm86xV5TDRUMC5AZ2lrSslvwM3hvRx1ZsqGpdoZXBHAikcOj1n1/fVo2JkUEo
	 T4R6RT4cwIOHsPk2t6oC41Tqtql8e7cZs/827L3feEZGpCpeQxKQBSuKy3vRyXbh/G
	 pPaEzNzxVjDTKt/O5H2eE4GZ+6I7QNSve3wPOtl4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389490AbgDAQmH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:42:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389486AbgDAQmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:42:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC20820857;
        Wed,  1 Apr 2020 16:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585759323;
        bh=NGlbUHeGAsmj8DvLjo4wsyyd7AsWiHPZuZbnLUQ9UIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hPHEMwmN/By4t6PVFu3Ua/aRYUyGZWclR9b36IitoKdfnYXT0LwyQ88zkM3uEOw+W
         nTFMrnj1hXdpB/o1NsBbVJlmY9lWU/AzxgNV0s9wlnXg77iD9rj+BJVqNV/MyQZyGn
         sxzpfCXlH6nAezLVOe/28umZIGVTn/nYjLXEfjnw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rong Chen <rong.a.chen@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 046/148] futex: Unbreak futex hashing
Date:   Wed,  1 Apr 2020 18:17:18 +0200
Message-Id: <20200401161557.348239612@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161552.245876366@linuxfoundation.org>
References: <20200401161552.245876366@linuxfoundation.org>
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
@@ -401,9 +401,9 @@ static inline int hb_waiters_pending(str
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
 


