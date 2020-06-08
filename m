Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207DEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00AE920823
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591659217;
	bh=1sDm6efkE6nUzcgVIsySaFaYUqIUIjrhlE1ECDiwrtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MmyaPGPnxERhT9OGj3VD4RMvkX9hrTtYh4S3vZBE3iJGB1rjeaUvh96kiFdew4jE8
	 9qrp0+vZeaadw6s3uzTrE77ZRbh458wDY8DAg0r0iVTaP4G2lk+buceeY+tIMkIw2r
	 Xmf34u/TP3VpSXxN0VCo26Fw3LKLbHb//DVL4i6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731668AbgFHXdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:33:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:55482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732098AbgFHX1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:27:14 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E1602068D;
        Mon,  8 Jun 2020 23:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658834;
        bh=1sDm6efkE6nUzcgVIsySaFaYUqIUIjrhlE1ECDiwrtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0SPSZHJk21a9UeBzsHpdfVuRmBXg88wu5MIG6wxlAI/5xs1rgxPpcefIv+1QOk4GH
         mUC04zFTeUaAqE12ODi58cJTFX0fKpNl1tR3QpCCoRBsHVGi0qbPm/rjbmTk9PEnhL
         4y4ZBazIHhm6bl9Y7aBkrYYN15BWTAVYhFucWUGA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Dmitry Golovin <dima@golovin.in>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>,
        clang-built-linux@googlegroups.com
Subject: [PATCH AUTOSEL 4.9 24/50] lib/mpi: Fix 64-bit MIPS build with Clang
Date:   Mon,  8 Jun 2020 19:26:14 -0400
Message-Id: <20200608232640.3370262-24-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232640.3370262-1-sashal@kernel.org>
References: <20200608232640.3370262-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

[ Upstream commit 18f1ca46858eac22437819937ae44aa9a8f9f2fa ]

When building 64r6_defconfig with CONFIG_MIPS32_O32 disabled and
CONFIG_CRYPTO_RSA enabled:

lib/mpi/generic_mpih-mul1.c:37:24: error: invalid use of a cast in a
inline asm context requiring an l-value: remove the cast
or build with -fheinous-gnu-extensions
                umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
                ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/mpi/longlong.h:664:22: note: expanded from macro 'umul_ppmm'
                 : "=d" ((UDItype)(w0))
                         ~~~~~~~~~~^~~
lib/mpi/generic_mpih-mul1.c:37:13: error: invalid use of a cast in a
inline asm context requiring an l-value: remove the cast
or build with -fheinous-gnu-extensions
                umul_ppmm(prod_high, prod_low, s1_ptr[j], s2_limb);
                ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
lib/mpi/longlong.h:668:22: note: expanded from macro 'umul_ppmm'
                 : "=d" ((UDItype)(w1))
                         ~~~~~~~~~~^~~
2 errors generated.

This special case for umul_ppmm for MIPS64r6 was added in
commit bbc25bee37d2b ("lib/mpi: Fix umul_ppmm() for MIPS64r6"), due to
GCC being inefficient and emitting a __multi3 intrinsic.

There is no such issue with clang; with this patch applied, I can build
this configuration without any problems and there are no link errors
like mentioned in the commit above (which I can still reproduce with
GCC 9.3.0 when that commit is reverted). Only use this definition when
GCC is being used.

This really should have been caught by commit b0c091ae04f67 ("lib/mpi:
Eliminate unused umul_ppmm definitions for MIPS") when I was messing
around in this area but I was not testing 64-bit MIPS at the time.

Link: https://github.com/ClangBuiltLinux/linux/issues/885
Reported-by: Dmitry Golovin <dima@golovin.in>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/mpi/longlong.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/mpi/longlong.h b/lib/mpi/longlong.h
index 8f383cca6bb1..623440d3d365 100644
--- a/lib/mpi/longlong.h
+++ b/lib/mpi/longlong.h
@@ -671,7 +671,7 @@ do {						\
 	**************  MIPS/64  **************
 	***************************************/
 #if (defined(__mips) && __mips >= 3) && W_TYPE_SIZE == 64
-#if defined(__mips_isa_rev) && __mips_isa_rev >= 6
+#if defined(__mips_isa_rev) && __mips_isa_rev >= 6 && defined(CONFIG_CC_IS_GCC)
 /*
  * GCC ends up emitting a __multi3 intrinsic call for MIPS64r6 with the plain C
  * code below, so we special case MIPS64r6 until the compiler can do better.
-- 
2.25.1

