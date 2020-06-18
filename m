Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712C6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CAC2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592446722;
	bh=o/dYuQNH4xckYpK5UE9oxtIwbQltBaG0M2jdffF5Yic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SdBXswy3roYofTzYUyPl4afO+S3eYM7STnSQ8uoVfowthiccFdJFG6lXe8gz/nQ+t
	 rXIFJZqT1tloVNA4rohTkjsNqu9Ah1NZxHFArvfO5RvdILBM+fAaWqfYSOluuUuIyr
	 UCcVZNRVB8cDofLW6xfpJXZJoEbrLBJZf2WCKYQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbgFRCSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:18:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:51448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730158AbgFRBTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:19:35 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 168D9221F1;
        Thu, 18 Jun 2020 01:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443174;
        bh=o/dYuQNH4xckYpK5UE9oxtIwbQltBaG0M2jdffF5Yic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dIfLcKj6tdxnYTwRJuWzamBwfOfLr7m18qkBWyvBBmdWuALw8xYFmBMtKN6pNBdvb
         dXO21a6ktc1jhBsw669FuBU8sUSdRmcAF3hLKNbfuIP+nO9othzk98uQgA9yqNF0UE
         jSRWZF5S8RWuKe0Z9N2CRkkcjurl1NXqgywSNE9A=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        clang-built-linux@googlegroups.com,
        David Teigland <teigland@redhat.com>,
        Sasha Levin <sashal@kernel.org>, cluster-devel@redhat.com
Subject: [PATCH AUTOSEL 5.4 138/266] dlm: remove BUG() before panic()
Date:   Wed, 17 Jun 2020 21:14:23 -0400
Message-Id: <20200618011631.604574-138-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

[ Upstream commit fe204591cc9480347af7d2d6029b24a62e449486 ]

Building a kernel with clang sometimes fails with an objtool error in dlm:

fs/dlm/lock.o: warning: objtool: revert_lock_pc()+0xbd: can't find jump dest instruction at .text+0xd7fc

The problem is that BUG() never returns and the compiler knows
that anything after it is unreachable, however the panic still
emits some code that does not get fully eliminated.

Having both BUG() and panic() is really pointless as the BUG()
kills the current process and the subsequent panic() never hits.
In most cases, we probably don't really want either and should
replace the DLM_ASSERT() statements with WARN_ON(), as has
been done for some of them.

Remove the BUG() here so the user at least sees the panic message
and we can reliably build randconfig kernels.

Fixes: e7fd41792fc0 ("[DLM] The core of the DLM for GFS2/CLVM")
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: clang-built-linux@googlegroups.com
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/dlm/dlm_internal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
index 416d9de35679..4311d01b02a8 100644
--- a/fs/dlm/dlm_internal.h
+++ b/fs/dlm/dlm_internal.h
@@ -97,7 +97,6 @@ do { \
                __LINE__, __FILE__, #x, jiffies); \
     {do} \
     printk("\n"); \
-    BUG(); \
     panic("DLM:  Record message above and reboot.\n"); \
   } \
 }
-- 
2.25.1

