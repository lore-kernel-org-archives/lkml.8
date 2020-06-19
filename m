Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F66C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FAA221BE5
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592579301;
	bh=shKfPmny0Xk+z6QTEuZIiryuf3ktSCpn4+P8VnIPKmM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H57GrIMEGfeJF12uYfDR+4ihEpUYiJH6ThJ03+Ze6jeVWUU/O9Bcw6ySk0UL2fmkG
	 7Glxh5XD1sIZvJliLvNW1r41rL54mF+o1P0Ui69pY8d7g9Mkh0s18hnlNrwE9NFhwZ
	 UDx7OQDhDT2PJoCgetsI7nYsi8PUr7EQ2sDlBbI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391261AbgFSPIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:08:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391711AbgFSPIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:08:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B81D521852;
        Fri, 19 Jun 2020 15:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579293;
        bh=shKfPmny0Xk+z6QTEuZIiryuf3ktSCpn4+P8VnIPKmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w63iFt2Ejs788GYVc8sPkINnFxEKZxjXp4EiSzM5hNY3zp6nwKRFnaYo6WEhjr8CV
         b05PhB7ByfZnc5xGFDKAFIGdh8hORv4zJBRGVT+8lshPVsKjSji9BmgV7r25byMW8w
         HaZKOPDK1ZUbrl3KyhbMSnHpqA3BxH4HpQbyAWhA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Golovin <dima@golovin.in>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 080/261] lib/mpi: Fix 64-bit MIPS build with Clang
Date:   Fri, 19 Jun 2020 16:31:31 +0200
Message-Id: <20200619141653.728067309@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141649.878808811@linuxfoundation.org>
References: <20200619141649.878808811@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 891e1c3549c4..afbd99987cf8 100644
--- a/lib/mpi/longlong.h
+++ b/lib/mpi/longlong.h
@@ -653,7 +653,7 @@ do {						\
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



