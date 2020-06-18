Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F77C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C62121924
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592442803;
	bh=68pghvoUYD3v1HKSVVgzbUPoRy6tXlI9adgXM6ncPmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ln2T0fSZBngy5YQhVy9YEAsf3KDFUvvqLJWXGcwZrGbo+AcO+k6sYLRKhQWSEzp2b
	 XHsxNeSWGt0fO9AlfDJxG6ADEJp0z1cKxuAVKqOqZvidBPcGBHoGMfHQN5gX7y36ly
	 QwEwwUDwCYVgxyFuRi9hW+1WToYrhiYybSOWp2Xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgFRBNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:13:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728888AbgFRBMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:12:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D666D221F8;
        Thu, 18 Jun 2020 01:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592442737;
        bh=68pghvoUYD3v1HKSVVgzbUPoRy6tXlI9adgXM6ncPmo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=endcrZIdAuclXe+/CvKHDIiwJ2S0NfQzgH2UToQWrnt5UG0zC6pqEQcAvjMeE8uh/
         6BikdEL8fYIT5C2xkhv/I/9Rbr6HaDv4zRWJHIrC27LJ3Q+Rj9nyFNkdItxP5oLk2t
         D01AvU3VlwLtaXbkwyOfjcPE+bkuOH20DCqphZy4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.7 192/388] unicore32: do not evaluate compiler's library path when cleaning
Date:   Wed, 17 Jun 2020 21:04:49 -0400
Message-Id: <20200618010805.600873-192-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618010805.600873-1-sashal@kernel.org>
References: <20200618010805.600873-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit 081b4b54ff6c58be2ffcf09d42e5df8f031eacd0 ]

Since commit a83e4ca26af8 ("kbuild: remove cc-option switch from
-Wframe-larger-than="), 'make ARCH=unicore32 clean' emits error
messages as follows:

  $ make ARCH=unicore32 clean
  gcc: error: missing argument to '-Wframe-larger-than='
  gcc: error: missing argument to '-Wframe-larger-than='

We do not care compiler flags when cleaning.

Use the '=' operator for lazy expansion because we do not use
GNU_LIBC_A or GNU_LIBGCC_A when cleaning.

Fixes: a83e4ca26af8 ("kbuild: remove cc-option switch from -Wframe-larger-than=")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/unicore32/lib/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/unicore32/lib/Makefile b/arch/unicore32/lib/Makefile
index 098981a01841..5af06645b8f0 100644
--- a/arch/unicore32/lib/Makefile
+++ b/arch/unicore32/lib/Makefile
@@ -10,12 +10,12 @@ lib-y	+= strncpy_from_user.o strnlen_user.o
 lib-y	+= clear_user.o copy_page.o
 lib-y	+= copy_from_user.o copy_to_user.o
 
-GNU_LIBC_A		:= $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libc.a)
+GNU_LIBC_A		= $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libc.a)
 GNU_LIBC_A_OBJS		:= memchr.o memcpy.o memmove.o memset.o
 GNU_LIBC_A_OBJS		+= strchr.o strrchr.o
 GNU_LIBC_A_OBJS		+= rawmemchr.o			# needed by strrchr.o
 
-GNU_LIBGCC_A		:= $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libgcc.a)
+GNU_LIBGCC_A		= $(shell $(CC) $(KBUILD_CFLAGS) -print-file-name=libgcc.a)
 GNU_LIBGCC_A_OBJS	:= _ashldi3.o _ashrdi3.o _lshrdi3.o
 GNU_LIBGCC_A_OBJS	+= _divsi3.o _modsi3.o _ucmpdi2.o _umodsi3.o _udivsi3.o
 
-- 
2.25.1

