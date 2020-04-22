Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C12C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A8D120575
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550046;
	bh=9+x2FW9k7r3YtG8FnuuW9O/Ga8X9b8fEaiNci1x3PEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SfNSN9inrJ/KpXqqiZcwuSPmyu+oxNT2JVNAQ0gf1zGHV159cH+NlVLuMdyHxCHde
	 qN/AGjiVwCV6cxLDwU9b2mJ6tU9DEQ9pqVm1zsFskKSCYdrP6j2yjFVjYkHDkm/A2i
	 UYhnIsL+x6H0mLTdgw5rMLwJFmIVXkKkgVTionJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgDVKHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:07:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbgDVKHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:07:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3A3120780;
        Wed, 22 Apr 2020 10:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550040;
        bh=9+x2FW9k7r3YtG8FnuuW9O/Ga8X9b8fEaiNci1x3PEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QRi1JJ0yUquZ2iXQGg16WNJaOdor6jNFDgJLISbNI/vcuHIU8D45+QBBZE/Oulm2A
         P3d2KLzShDQIUlGYItDdSGPZSikSUQnDQS033sipbgUeAidKjYyFMOjn+5mNm+9cRo
         3WstKQ98eQgQCErkuBIqa0oIzJsSwTRdyw81dnNA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ian Abbott <abbotti@mev.co.uk>, Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 111/125] compiler.h: fix error in BUILD_BUG_ON() reporting
Date:   Wed, 22 Apr 2020 11:57:08 +0200
Message-Id: <20200422095050.661714139@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095032.909124119@linuxfoundation.org>
References: <20200422095032.909124119@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vegard Nossum <vegard.nossum@oracle.com>

[ Upstream commit af9c5d2e3b355854ff0e4acfbfbfadcd5198a349 ]

compiletime_assert() uses __LINE__ to create a unique function name.  This
means that if you have more than one BUILD_BUG_ON() in the same source
line (which can happen if they appear e.g.  in a macro), then the error
message from the compiler might output the wrong condition.

For this source file:

	#include <linux/build_bug.h>

	#define macro() \
		BUILD_BUG_ON(1); \
		BUILD_BUG_ON(0);

	void foo()
	{
		macro();
	}

gcc would output:

./include/linux/compiler.h:350:38: error: call to `__compiletime_assert_9' declared with attribute error: BUILD_BUG_ON failed: 0
  _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)

However, it was not the BUILD_BUG_ON(0) that failed, so it should say 1
instead of 0. With this patch, we use __COUNTER__ instead of __LINE__, so
each BUILD_BUG_ON() gets a different function name and the correct
condition is printed:

./include/linux/compiler.h:350:38: error: call to `__compiletime_assert_0' declared with attribute error: BUILD_BUG_ON failed: 1
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)

Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Reviewed-by: Daniel Santos <daniel.santos@pobox.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Ian Abbott <abbotti@mev.co.uk>
Cc: Joe Perches <joe@perches.com>
Link: http://lkml.kernel.org/r/20200331112637.25047-1-vegard.nossum@oracle.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 0020ee1cab37a..7837afabbd78e 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -546,7 +546,7 @@ unsigned long read_word_at_a_time(const void *addr)
  * compiler has support to do so.
  */
 #define compiletime_assert(condition, msg) \
-	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
+	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
 
 #define compiletime_assert_atomic_type(t)				\
 	compiletime_assert(__native_word(t),				\
-- 
2.20.1



