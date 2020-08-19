Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-25.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B22FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE1DD2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hU5/8DJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgHSTRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgHSTRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:17:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758D3C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:17:09 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d26so26943187yba.20
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 12:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=AYTx8OTXrfy1fkjiQ/QJZUTx1nYyS440PAIctrO8h/4=;
        b=hU5/8DJYdBVIul76iBEmEZ0CUUQxYYOOHdwBe4d4zyPtB5gIZh8vrm6Ccwlw+L7mfG
         jT4Y2xyv2gvx6x+GF1XuIP6lvuA20HdADAoN96ldTrsTtbKn1/+bcvafV0ipxVGPvx5T
         OVGD/OW/Rm/RcYoUIfpfQAlOuAUQ5mPdB6lE+Pq/kfD1VWh7KsAWKxXxroLPwLw40+1i
         kvI45eNE7kkOgbXRICBXBMXLPlBDZYoiRoJLP51z6Bh+cy81LCawEG//TZN3rxPJtz6E
         aLLhREs3LcMxpShnPm0ZN5pRx9wDMtIvvkd7xgXg9RTXshqTL+GmUQ2DHv1Dd734CK3p
         ZQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=AYTx8OTXrfy1fkjiQ/QJZUTx1nYyS440PAIctrO8h/4=;
        b=hjPWQDh3PvJI0CarBgkOPQgdmLnjsijC7IRVhDzCQgVnZze7yjSEDfeH+LMobgbP1N
         2VLRNKeEUHkMon++bHfHygQTaJptR/9htJBT0hIwuxrctgOUMGV743nKYQJUI+M06LHv
         IkZx/YpRLZ5NRTQeJmhLnHXSYc8HIryOk4/g/LaqVzYGATA+3/ofyN3qy44v26S8yDsc
         ErlVitCUVjpznNGi0nGP5BV0gwyr7kp49XTX1V0eWVXduKo/6YZLY3OVwCDhAbY9Cucb
         l6LMGA9BCtyxMrGZ4F+HM13a/LCcW+cWF78MdCjz6qpysLFLnqNldC9SjtdRD8OTfOFm
         as4w==
X-Gm-Message-State: AOAM5339SRgp12vRAgJ4uloSUXVAWZ/G94AwTsLy37u6yPrwQHQ8W0At
        acVDEFvK4c/tgH5Ab1BJ/4eJCB7NgjWyc7RO1hA=
X-Google-Smtp-Source: ABdhPJxETf8t+SYq21D8M+YylDYX3q4MAl4M/CU8Tsm+guyliSGVos5yJOYpig0Mf0L2E13QKLQC7j9HxW70uBCx9fg=
X-Received: by 2002:a5b:c08:: with SMTP id f8mr34030464ybq.198.1597864628624;
 Wed, 19 Aug 2020 12:17:08 -0700 (PDT)
Date:   Wed, 19 Aug 2020 12:16:50 -0700
In-Reply-To: <20200819191654.1130563-1-ndesaulniers@google.com>
Message-Id: <20200819191654.1130563-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200819191654.1130563-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d-goog
Subject: [PATCH v2 1/5] Makefile: add -fno-builtin-stpcpy
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
        stable@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LLVM implemented a recent "libcall optimization" that lowers calls to
`sprintf(dest, "%s", str)` where the return value is used to
`stpcpy(dest, str) - dest`. This generally avoids the machinery involved
in parsing format strings. This optimization was introduced into
clang-12. Because the kernel does not provide an implementation of
stpcpy, we observe linkage failures for almost all targets when building
with ToT clang.

The interface is unsafe as it does not perform any bounds checking.
Disable this "libcall optimization" via `-fno-builtin-stpcpy`.

Cc: stable@vger.kernel.org # 4.4
Link: https://bugs.llvm.org/show_bug.cgi?id=3D47162
Link: https://github.com/ClangBuiltLinux/linux/issues/1126
Link: https://reviews.llvm.org/D85963
Reported-by: Sami Tolvanen <samitolvanen@google.com>
Suggested-by: D=C3=A1vid Bolvansk=C3=BD <david.bolvansky@gmail.com>
Suggested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 9cac6fde3479..e523dc8d30e0 100644
--- a/Makefile
+++ b/Makefile
@@ -578,6 +578,7 @@ ifneq ($(LLVM_IAS),1)
 CLANG_FLAGS	+=3D -no-integrated-as
 endif
 CLANG_FLAGS	+=3D -Werror=3Dunknown-warning-option
+CLANG_FLAGS	+=3D -fno-builtin-stpcpy
 KBUILD_CFLAGS	+=3D $(CLANG_FLAGS)
 KBUILD_AFLAGS	+=3D $(CLANG_FLAGS)
 export CLANG_FLAGS
--=20
2.28.0.297.g1956fa8f8d-goog

