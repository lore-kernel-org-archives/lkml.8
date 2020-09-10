Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47859C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04C1D221E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599773282;
	bh=5sjo0tXKJRGNz/5YzFh7BGtbbE7WXRIZGpqowisukko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=igrKYF8JOx4rzr2WK6TznvQT2UUX/NVqp7u++a8ExRuMRV757l5kHDnFmmqMdK3+h
	 AurbuEhFRMOWhagXYS4VcDwZVoKNQfbmW1nZFq1JftH2HitGFsQ6DLqVaP6nNvesRT
	 QW1i+U+C18aMuMaT1n2SYb/RK0lAyuyo3tZwx8fM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgIJV2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:28:00 -0400
Received: from condef-02.nifty.com ([202.248.20.67]:35240 "EHLO
        condef-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730976AbgIJOJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:09:47 -0400
Received: from conuserg-10.nifty.com ([10.126.8.73])by condef-02.nifty.com with ESMTP id 08ADtFZO023217;
        Thu, 10 Sep 2020 22:55:15 +0900
Received: from oscar.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 08ADpSJ0001308;
        Thu, 10 Sep 2020 22:51:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 08ADpSJ0001308
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1599745893;
        bh=K01RYjZ9wy1tuci78KttomtfIouE9FTDhkSr4QzxpNo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1OH9UBl3mJpDIo0SH3Q8bILjszIxHdnVNj6Za9phRQiubjlbRAFg0W4DpIhREkpfY
         IzcvFpjVKKtz83ChLHqV5HavmKP3HuDNxXrlFawgFJVBCsn1jUQdfbiY4fON3vFkRB
         n7JQj++2onXAhbaUjzwcrT9Z2g022EgyV76pJ12+JwE8YsDGuJqA7xC5eBJMvQfg0k
         u8Tbx7HcDmKf8KxpAWs1rEIU9S8UorSqDOOGdCFBZAeQTG5ZdJUcbiJVUMDcYDHKy6
         ttp/K1VP/fUSA8NSW2NRyi5xldWaoRUxztJ+067BgCmzvWoDpskFgfy0y3McjFqte4
         gbl5M7iRalKfA==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>,
        clang-built-linux@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] kbuild: remove cc-option test of -Werror=date-time
Date:   Thu, 10 Sep 2020 22:51:20 +0900
Message-Id: <20200910135120.3527468-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200910135120.3527468-1-masahiroy@kernel.org>
References: <20200910135120.3527468-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The minimal compiler versions, GCC 4.9 and Clang 10 support this flag.

Here is the godbolt:
https://godbolt.org/z/xvjcMa

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                          | 2 +-
 arch/arm64/kernel/vdso32/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 5102c89d3167..1d7c58684fda 100644
--- a/Makefile
+++ b/Makefile
@@ -940,7 +940,7 @@ KBUILD_CFLAGS  += -fno-stack-check
 KBUILD_CFLAGS   += $(call cc-option,-fconserve-stack)
 
 # Prohibit date/time macros, which would make the build non-deterministic
-KBUILD_CFLAGS   += $(call cc-option,-Werror=date-time)
+KBUILD_CFLAGS   += -Werror=date-time
 
 # enforce correct pointer usage
 KBUILD_CFLAGS   += $(call cc-option,-Werror=incompatible-pointer-types)
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index dfffd55175a3..1feb4f8e556e 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -92,7 +92,7 @@ VDSO_CFLAGS += $(call cc32-option,-Wdeclaration-after-statement,)
 VDSO_CFLAGS += $(call cc32-option,-Wno-pointer-sign)
 VDSO_CFLAGS += -fno-strict-overflow
 VDSO_CFLAGS += $(call cc32-option,-Werror=strict-prototypes)
-VDSO_CFLAGS += $(call cc32-option,-Werror=date-time)
+VDSO_CFLAGS += -Werror=date-time
 VDSO_CFLAGS += $(call cc32-option,-Werror=incompatible-pointer-types)
 
 # The 32-bit compiler does not provide 128-bit integers, which are used in
-- 
2.25.1

