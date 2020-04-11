Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD0BC2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7669520692
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586607411;
	bh=Eobpd9rfyW8Qda/LHzk612GzKUUTgzhzbdaqq0G/zYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QqmT4/S3bUsgF9x3XzGJDerwjpB4qsR0EaypVqvUXJtuhvk6tViNWnU2BJh+JaVB7
	 tCtPFi/DutDyK68ynRbfQxWonPvylbePka2afCE5H/I+7knMxXGiDv6j4AQMfLOq/R
	 Ym1bmILbkjdu4NYj/3okB0lI6iBu1eUDiVR9VIrM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgDKMQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:16:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:51150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbgDKMQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:16:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD68020692;
        Sat, 11 Apr 2020 12:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607407;
        bh=Eobpd9rfyW8Qda/LHzk612GzKUUTgzhzbdaqq0G/zYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tWwjG30LFsx7k1Ltz53Ti0EoqnbQ+2bzCb9HP/mVDNjCEX2iX6NVzO4DxI8uizTWF
         BXM9MGeKjqLLACZlvyb6xFnyCLicebo+AuhAq49eO9IyTaas5kyDdOABljYQBrlcLm
         sLkqHsQ74PMdkMOFvXQK6xQP50vW49wtEgS0vUZk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        Theodore Tso <tytso@mit.edu>
Subject: [PATCH 4.19 25/54] bitops: protect variables in set_mask_bits() macro
Date:   Sat, 11 Apr 2020 14:09:07 +0200
Message-Id: <20200411115511.029870714@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115508.284500414@linuxfoundation.org>
References: <20200411115508.284500414@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

commit 18127429a854e7607b859484880b8e26cee9ddab upstream.

Unprotected naming of local variables within the set_mask_bits() can easily
lead to using the wrong scope.

Noticed this when "set_mask_bits(&foo->bar, 0, mask)" behaved as no-op.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Fixes: 00a1a053ebe5 ("ext4: atomically set inode->i_flags in ext4_set_inode_flags()")
Cc: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/bitops.h |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -236,17 +236,17 @@ static __always_inline void __assign_bit
 #ifdef __KERNEL__
 
 #ifndef set_mask_bits
-#define set_mask_bits(ptr, _mask, _bits)	\
+#define set_mask_bits(ptr, mask, bits)	\
 ({								\
-	const typeof(*ptr) mask = (_mask), bits = (_bits);	\
-	typeof(*ptr) old, new;					\
+	const typeof(*(ptr)) mask__ = (mask), bits__ = (bits);	\
+	typeof(*(ptr)) old__, new__;				\
 								\
 	do {							\
-		old = READ_ONCE(*ptr);			\
-		new = (old & ~mask) | bits;			\
-	} while (cmpxchg(ptr, old, new) != old);		\
+		old__ = READ_ONCE(*(ptr));			\
+		new__ = (old__ & ~mask__) | bits__;		\
+	} while (cmpxchg(ptr, old__, new__) != old__);		\
 								\
-	new;							\
+	new__;							\
 })
 #endif
 


