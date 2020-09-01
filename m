Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D5FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E73D42073A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="YDk70Rux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgIAAXp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 20:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgIAAXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 20:23:38 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E60C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:23:37 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id x125so1676903pfc.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=x7hoSHeAWK5P4oeCQGgLVlcI02P7mwgUY7iVKcw4mtY=;
        b=YDk70RuxUX7JQxUoCoDpBMB4Nx2aegPpci+1o9QaktjEfeowcrNv+0ouGv724IqC8j
         E2Tqc64XZ/ymVWNhnLAcq3uKinmAGRj0iXaYmqfvusL+IBKOp3hXe8RzakZ5TZtykMsP
         H21xkmRpBkBTJmxSSOJ4IGQFh9HCTudfkATQ7LeIrQmZ7sueou1bCu0WJuOndNJDE2/1
         MmheDrpYbHtKEjwVaDI+x3ZjkV64wIByHFUc90xTNlh5v7f9PVEri1cFA94LJwOlYH4q
         kd8a6w0sQ8Mvc1aLNaD6Rrj/d902fu/fbBEYwOJGOq6isRAf+dQf/mQPdQTlkcAmH9G+
         3Stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x7hoSHeAWK5P4oeCQGgLVlcI02P7mwgUY7iVKcw4mtY=;
        b=aqG1V8ditnppGvvrxCG+jgNv0VDEuKw2JLT6oLhd8jvJJYbtH0CSdNONR1moL8IZ1M
         92dAeU31g7piPBMaQha8tTrPX64cqcXpgMrDuaxOwGC0bx3d4r2lsP3T85Xdgci1mWNg
         nOF+gIDLyTGAUsOT/b7l0NYcazPy8RxZ6D2O9ZaBH+CtnaSu3tcutPyGyWEnrUThQ5ES
         Ag47KfKpyRkAq6Zr64PtjdTyv+2IA58UNSzxXz3uWI1D7R5ioAy9uQMNT53pzl0+NPog
         0cwp+r3WUS95PRezwXQt1/sLB7gCksCybbb+f3cCsIITTlbxLytHQ+crvrxTPhCtIKFF
         DyPQ==
X-Gm-Message-State: AOAM530UrYQJHMJc5kQMxT606Qsx94zb4qv3vireG7ImR5s3ega3VV0u
        D1lBr2D4jZeOyniGkYH6dH/Rf4loIXMrJj1t0JE=
X-Google-Smtp-Source: ABdhPJwED4nLxHhSz5AKhDraPa+/J0fY4ButKN1zuzXmRYkgkklqlX1iwDxieuNT/RU/gbhQkyoLgKvW/jlXNgldQ10=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a62:4c5:0:b029:138:413e:3e65 with
 SMTP id 188-20020a6204c50000b0290138413e3e65mr782938pfe.3.1598919817460; Mon,
 31 Aug 2020 17:23:37 -0700 (PDT)
Date:   Mon, 31 Aug 2020 17:23:22 -0700
In-Reply-To: <20200901002326.1137289-1-ndesaulniers@google.com>
Message-Id: <20200901002326.1137289-4-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200901002326.1137289-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v2 3/7] Revert "arm64: bti: Require clang >= 10.0.1 for
 in-kernel BTI support"
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux@googlegroups.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit b9249cba25a5dce5de87e5404503a5e11832c2dd.

The minimum supported version of clang is now 10.0.1.

Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/arm64/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 6d232837cbee..2a70b85b1a61 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1630,8 +1630,6 @@ config ARM64_BTI_KERNEL
 	depends on CC_HAS_BRANCH_PROT_PAC_RET_BTI
 	# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94697
 	depends on !CC_IS_GCC || GCC_VERSION >= 100100
-	# https://reviews.llvm.org/rGb8ae3fdfa579dbf366b1bb1cbfdbf8c51db7fa55
-	depends on !CC_IS_CLANG || CLANG_VERSION >= 100001
 	depends on !(CC_IS_CLANG && GCOV_KERNEL)
 	depends on (!FUNCTION_GRAPH_TRACER || DYNAMIC_FTRACE_WITH_REGS)
 	help
-- 
2.28.0.402.g5ffc5be6b7-goog

