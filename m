Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D65C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BAC02063A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588255292;
	bh=FUdsD2vebhAd1eNJ+Evte29+cETCgh/IN/PwJdEDKaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F2/mJxSxcbLFpsczK/37XsBdArnrj8lPmznIQ/zeor872KErCNS/fRArrRh3xqRgz
	 /+X9seBXqqHM6NqSnMrk8ymZOLFjjZUxHUyBQ7SoS47wGmhXM+g+zuausoPOtCjzU6
	 zfkob8VqeXB3L2U2wGrxZcKM09f+fuS1m1u9m+eg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729329AbgD3OBb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:01:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:35986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728034AbgD3Nx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:53:56 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46AF22072A;
        Thu, 30 Apr 2020 13:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588254836;
        bh=FUdsD2vebhAd1eNJ+Evte29+cETCgh/IN/PwJdEDKaM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SJu5mELce+WamO2PVhUmxInukpzTk3cRjyYjNkeUjFj8gktmQlgRjsSMY1wA+O3hD
         dP11rcKb0ZEvKY2n3m03R4Edn575Sd24HsTaMrg11/ZL0FdPbL9TVY9/lGzKbVvoDa
         WasgUJ7w7uwusy+1jlK25cfeTJq7g2ViRK+Y0U3Y=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        kbuild test robot <lkp@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 27/30] lib/mpi: Fix building for powerpc with clang
Date:   Thu, 30 Apr 2020 09:53:22 -0400
Message-Id: <20200430135325.20762-27-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200430135325.20762-1-sashal@kernel.org>
References: <20200430135325.20762-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 5990cdee689c6885b27c6d969a3d58b09002b0bc ]

0day reports over and over on an powerpc randconfig with clang:

lib/mpi/generic_mpih-mul1.c:37:13: error: invalid use of a cast in a
inline asm context requiring an l-value: remove the cast or build with
-fheinous-gnu-extensions

Remove the superfluous casts, which have been done previously for x86
and arm32 in commit dea632cadd12 ("lib/mpi: fix build with clang") and
commit 7b7c1df2883d ("lib/mpi/longlong.h: fix building with 32-bit
x86").

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Link: https://github.com/ClangBuiltLinux/linux/issues/991
Link: https://lore.kernel.org/r/20200413195041.24064-1-natechancellor@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/mpi/longlong.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/lib/mpi/longlong.h b/lib/mpi/longlong.h
index 08c60d10747fd..e01b705556aa6 100644
--- a/lib/mpi/longlong.h
+++ b/lib/mpi/longlong.h
@@ -756,22 +756,22 @@ do {									\
 do { \
 	if (__builtin_constant_p(bh) && (bh) == 0) \
 		__asm__ ("{a%I4|add%I4c} %1,%3,%4\n\t{aze|addze} %0,%2" \
-		: "=r" ((USItype)(sh)), \
-		"=&r" ((USItype)(sl)) \
+		: "=r" (sh), \
+		"=&r" (sl) \
 		: "%r" ((USItype)(ah)), \
 		"%r" ((USItype)(al)), \
 		"rI" ((USItype)(bl))); \
 	else if (__builtin_constant_p(bh) && (bh) == ~(USItype) 0) \
 		__asm__ ("{a%I4|add%I4c} %1,%3,%4\n\t{ame|addme} %0,%2" \
-		: "=r" ((USItype)(sh)), \
-		"=&r" ((USItype)(sl)) \
+		: "=r" (sh), \
+		"=&r" (sl) \
 		: "%r" ((USItype)(ah)), \
 		"%r" ((USItype)(al)), \
 		"rI" ((USItype)(bl))); \
 	else \
 		__asm__ ("{a%I5|add%I5c} %1,%4,%5\n\t{ae|adde} %0,%2,%3" \
-		: "=r" ((USItype)(sh)), \
-		"=&r" ((USItype)(sl)) \
+		: "=r" (sh), \
+		"=&r" (sl) \
 		: "%r" ((USItype)(ah)), \
 		"r" ((USItype)(bh)), \
 		"%r" ((USItype)(al)), \
@@ -781,36 +781,36 @@ do { \
 do { \
 	if (__builtin_constant_p(ah) && (ah) == 0) \
 		__asm__ ("{sf%I3|subf%I3c} %1,%4,%3\n\t{sfze|subfze} %0,%2" \
-		: "=r" ((USItype)(sh)), \
-		"=&r" ((USItype)(sl)) \
+		: "=r" (sh), \
+		"=&r" (sl) \
 		: "r" ((USItype)(bh)), \
 		"rI" ((USItype)(al)), \
 		"r" ((USItype)(bl))); \
 	else if (__builtin_constant_p(ah) && (ah) == ~(USItype) 0) \
 		__asm__ ("{sf%I3|subf%I3c} %1,%4,%3\n\t{sfme|subfme} %0,%2" \
-		: "=r" ((USItype)(sh)), \
-		"=&r" ((USItype)(sl)) \
+		: "=r" (sh), \
+		"=&r" (sl) \
 		: "r" ((USItype)(bh)), \
 		"rI" ((USItype)(al)), \
 		"r" ((USItype)(bl))); \
 	else if (__builtin_constant_p(bh) && (bh) == 0) \
 		__asm__ ("{sf%I3|subf%I3c} %1,%4,%3\n\t{ame|addme} %0,%2" \
-		: "=r" ((USItype)(sh)), \
-		"=&r" ((USItype)(sl)) \
+		: "=r" (sh), \
+		"=&r" (sl) \
 		: "r" ((USItype)(ah)), \
 		"rI" ((USItype)(al)), \
 		"r" ((USItype)(bl))); \
 	else if (__builtin_constant_p(bh) && (bh) == ~(USItype) 0) \
 		__asm__ ("{sf%I3|subf%I3c} %1,%4,%3\n\t{aze|addze} %0,%2" \
-		: "=r" ((USItype)(sh)), \
-		"=&r" ((USItype)(sl)) \
+		: "=r" (sh), \
+		"=&r" (sl) \
 		: "r" ((USItype)(ah)), \
 		"rI" ((USItype)(al)), \
 		"r" ((USItype)(bl))); \
 	else \
 		__asm__ ("{sf%I4|subf%I4c} %1,%5,%4\n\t{sfe|subfe} %0,%3,%2" \
-		: "=r" ((USItype)(sh)), \
-		"=&r" ((USItype)(sl)) \
+		: "=r" (sh), \
+		"=&r" (sl) \
 		: "r" ((USItype)(ah)), \
 		"r" ((USItype)(bh)), \
 		"rI" ((USItype)(al)), \
@@ -821,7 +821,7 @@ do { \
 do { \
 	USItype __m0 = (m0), __m1 = (m1); \
 	__asm__ ("mulhwu %0,%1,%2" \
-	: "=r" ((USItype) ph) \
+	: "=r" (ph) \
 	: "%r" (__m0), \
 	"r" (__m1)); \
 	(pl) = __m0 * __m1; \
-- 
2.20.1

