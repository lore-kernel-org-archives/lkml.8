Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6396C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C834220739
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583966320;
	bh=tVph8m/LGo8XOafjuleRQg1aTu5D2sTdBUwn5Og/bag=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Fn0m3f85s/ngdjAHL3Rp0JSOoOywaBfu1/8UMf6Mri5grzrefUJ27tVS/Ch7UNuYB
	 cg/AgA/QlKeiBDTCnBS/Cob43+6uAINczteZoS1/m33DKjOHMj1JZu0euARF7orfBL
	 0AHubuo8gBcpCviKhBM9iSNrWKKiAZJXewWyeO3g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbgCKWij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:38:39 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:26360 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729881AbgCKWij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:38:39 -0400
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 02BMbYqf019805;
        Thu, 12 Mar 2020 07:37:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 02BMbYqf019805
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1583966255;
        bh=tiAHJid7/WA3U3683+xwU6rGIWKb4aM8B2wj4c+paIQ=;
        h=From:To:Cc:Subject:Date:From;
        b=MV/GMLbmCnGT0J0XdohjNCc2KP58qmnj+qvhKNL/fsrbcvMC3bDunxeqpcOOSGB8o
         VbnlRGNVZq/4ekRn0VrO25hw3SeikvzgF4LyU555iQJQARlhH/4CJ+K3ktLCLeWAZh
         DvuWDq1y84t2/htCFsT276osv+/7n3tzeMhNFoQ2/WowYBRwz+rh7Oj5GxqtcRdkXM
         glOUVtqjY6M1oG7sHZBcwkHNEbx76LVuBZXdzqA2t9HguwSHrbxrkL2eGLCOFmz4kg
         eJAPbpJ31cLQw2R2QwAUfWSeMK1Fy8XyU80HYst1ZavOuRrXfS+8ujd9GrA8AkyjuU
         KsFGU67GeGA3w==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        clang-built-linux@googlegroups.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 1/2] sparc: revive __HAVE_ARCH_STRLEN for 32bit sparc
Date:   Thu, 12 Mar 2020 07:37:24 +0900
Message-Id: <20200311223725.27662-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prior to commit 70a6fcf3283a ("[sparc] unify 32bit and 64bit string.h"),
__HAVE_ARCH_STRLEN was defined in both of string_32.h and string_64.h

It did not unify __HAVE_ARCH_STRLEN, but deleted it from string_32.h

This issue was reported by the kbuild test robot in the trial of
forcible linking of $(lib-y) to vmlinux.

Fixes: 70a6fcf3283a ("[sparc] unify 32bit and 64bit string.h")
Reported-by: kbuild test robot <lkp@intel.com>
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Insert a new patch to avoid sparc32 build error

 arch/sparc/include/asm/string.h    | 4 ++++
 arch/sparc/include/asm/string_64.h | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/string.h b/arch/sparc/include/asm/string.h
index 3d9cd082716b..001a17baf2d5 100644
--- a/arch/sparc/include/asm/string.h
+++ b/arch/sparc/include/asm/string.h
@@ -37,6 +37,10 @@ void *memmove(void *, const void *, __kernel_size_t);
 #define __HAVE_ARCH_MEMCMP
 int memcmp(const void *,const void *,__kernel_size_t);
 
+/* Now the str*() stuff... */
+#define __HAVE_ARCH_STRLEN
+__kernel_size_t strlen(const char *);
+
 #define __HAVE_ARCH_STRNCMP
 int strncmp(const char *, const char *, __kernel_size_t);
 
diff --git a/arch/sparc/include/asm/string_64.h b/arch/sparc/include/asm/string_64.h
index ee9ba67321bd..d5c563058a5b 100644
--- a/arch/sparc/include/asm/string_64.h
+++ b/arch/sparc/include/asm/string_64.h
@@ -12,8 +12,4 @@
 
 #include <asm/asi.h>
 
-/* Now the str*() stuff... */
-#define __HAVE_ARCH_STRLEN
-__kernel_size_t strlen(const char *);
-
 #endif /* !(__SPARC64_STRING_H__) */
-- 
2.17.1

