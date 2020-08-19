Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB97C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 199812078D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+1Ydzdb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgHSTRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbgHSTRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:17:16 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4980C061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:17:15 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id r1so27192210ybg.4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=G8ovRmWPY2eQRm47H6TIcE569Ii4rdR2xUKKDLx0xDw=;
        b=f+1YdzdbnkY01Pd/XYpVHaD7EAlrtO9o1mqgVX3oLPHx/Z792m3feItpAM1uCZKM5Z
         3OHZXnaEfnVJasRQIYFL47vXV28lja2DfwwSkfM1PeelFbEGLA8m5KNjWGbiK8gx43xs
         A7OyFY/vF+3FIkW8hJ1M5iw/Cw9gJzmt6lbZioPhP5xoRqa3E/0VCeIA0Gx9xnq3h53F
         63mraLAdmwu/r42O86ItTteBSJ6AsNhCADk/PUC2wzLpRFvqFC+Yt1u85x6Zp4WcWMWN
         9oeDse8CDkhlS2eDIt1rkFdG9oBT3asrqJaAY42oHIat6X6YD2LDWxbBc7yFsAvA+d08
         n7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=G8ovRmWPY2eQRm47H6TIcE569Ii4rdR2xUKKDLx0xDw=;
        b=fsaHaBspC3KWZ89iQ3HbgeQCyjwQSkA6LPALhSuD3zNmUhCXt/5DNtvKrDHA52eYfU
         MHvA47pSqJeG1JxoiZ2bNxDdXYxzWgFGhf7bDELR7nBWB3kqZo8Vcx2Ps2tqhadOClAS
         JT2m1/IzP4IJEhGQpKiufjIXFyQ42KWCXQ6+NlSV65ZddZejvKwu/+5mwKKC7CfcNytM
         dryu95RYRC78UWHbWnrfcQO/GPRLihJXvK3UL+He1U6f4Q9R7xnrAt5hYTvdWKxUrceL
         Fp0pymKeegT9O4Wv2mcpUSOofDRDAD5MPl3ThrY44GJV+qoyXn7ehP9xTW8FCrnUMTUD
         +72w==
X-Gm-Message-State: AOAM533t+BdKNtCWBY6YmVYawZd8xLGAXhZdA0RlxpasvQkJCJSKyFW0
        VHWERQE4+e8NpOUvB3tZWJeMXCcExwYCp/15pnY=
X-Google-Smtp-Source: ABdhPJxebFBr0V9uyPj7gam8rQ7tQWQYUw52l6hiIAwQkCgQg2ecyY0cl/X05nt6T3z7kD96UyI7rJ2SUevAe92Z0d4=
X-Received: by 2002:a25:502:: with SMTP id 2mr34973593ybf.6.1597864635052;
 Wed, 19 Aug 2020 12:17:15 -0700 (PDT)
Date:   Wed, 19 Aug 2020 12:16:51 -0700
In-Reply-To: <20200819191654.1130563-1-ndesaulniers@google.com>
Message-Id: <20200819191654.1130563-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200819191654.1130563-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v2 2/5] Makefile: add -fno-builtin-bcmp
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Yury Norov <yury.norov@gmail.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Marco Elver <elver@google.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        Andi Kleen <ak@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "=?UTF-8?q?D=C3=A1vid=20Bolvansk=C3=BD?=" <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The issue with using `-fno-builtin-*` flags was that they were not
retained during an LTO link with LLVM.  This was fixed in clang-11 by
https://reviews.llvm.org/D71193
(0508c994f0b14144041f2cfd3ba9f9a80f03de08), which is also the minimum
supported version of clang for LTO.  Use `-fno-builtin-bcmp` instead.

With this applid, we can cleanly revert
commit 5f074f3e192f ("lib/string.c: implement a basic bcmp")

Reviewed-by: Kees Cook <keescook@chromium.org>
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index e523dc8d30e0..def590b743a9 100644
--- a/Makefile
+++ b/Makefile
@@ -579,6 +579,7 @@ CLANG_FLAGS	+= -no-integrated-as
 endif
 CLANG_FLAGS	+= -Werror=unknown-warning-option
 CLANG_FLAGS	+= -fno-builtin-stpcpy
+CLANG_FLAGS	+= -fno-builtin-bcmp
 KBUILD_CFLAGS	+= $(CLANG_FLAGS)
 KBUILD_AFLAGS	+= $(CLANG_FLAGS)
 export CLANG_FLAGS
-- 
2.28.0.297.g1956fa8f8d-goog

