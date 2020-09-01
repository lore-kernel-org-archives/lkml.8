Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C1CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5DD120E65
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="vXbvBt0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgIAAXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 20:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgIAAXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 20:23:36 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEF8C061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:23:36 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w1so7332740qto.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=OpCRtcsPpFRLic5hvjC2zaEKYM15+afAD1UpP9e19yY=;
        b=vXbvBt0ydWJpSbrePzJiwyZF3yTIoFQqhrG+f71LvHy1hBFePv6+9A0LM2YOL/J1pH
         UenXtaEO3Swyb6owdtq+v60ovlxyeuGW63KCw9s7UshgzIGFDweCmb93nVehvu09zoj7
         9vW+O4MLF9sHxq/G2EHutXhyTN9ARP4A1dhnm1cOT+wCb9VixqmN9Te8L17J8QGj3WzY
         Ts1u9PaCBq8evxOj696mLzImp6zv3GN9xylZzOpLnZ1ZekH9W+BcOIR9j6CNCoWeNXfW
         sd4E11kGHUHuZUqqYUPuRcsfXDD4sf6fwa/58oTH9CaY0OppljOHfSny2ohj0+7kbKb4
         jruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OpCRtcsPpFRLic5hvjC2zaEKYM15+afAD1UpP9e19yY=;
        b=oX7IX737XI39DfctHwEX8Rvxatwhlny8kWjN7kKirr6FF98GWpLpd85YvR3kbUjQj1
         3JUgAmqsrSEWCm1I+SX5186crzXoFUDKbc8AbMhYIP4qStN9qtMVTsy6Mn9ZoW++Gwn2
         Z/JiBNQjznGFmnsTvC1exSfRF5h1N5ZiDBjckrUIX1Mk1y99EpM1B33XwYlc1L5HYSVn
         CrW9RvTlbG21oqGNswvoTrYUbq0Bu70A3vB1kCSqTzUZEHfIhEjFPGj+Q3e6VnSLRk8e
         VTMbHjshmY3Q/+YbLlac6bW391uoytH60ArTtKqFosvMMgyRNVTtJFuPFmuW+DCrpIiz
         BYgg==
X-Gm-Message-State: AOAM5314DlREynmZxpkYRuxLw4SET/mzKPtyFPmHDP7dCM5Mpgou37lp
        CQO2qudeLSqSRLWze/eQxJdqLwGgaT8eiblWLb8=
X-Google-Smtp-Source: ABdhPJzmB9zUGYUYDfr5ruRvfjynhXPf5vtI696h1nnKit+Ix1PRIw2niAYqN5275XDAgcB2xOsAo/RhfHQwLmqkv+A=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a0c:a789:: with SMTP id
 v9mr923919qva.2.1598919815516; Mon, 31 Aug 2020 17:23:35 -0700 (PDT)
Date:   Mon, 31 Aug 2020 17:23:21 -0700
In-Reply-To: <20200901002326.1137289-1-ndesaulniers@google.com>
Message-Id: <20200901002326.1137289-3-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200901002326.1137289-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v2 2/7] Revert "kbuild: disable clang's default use of -fmerge-all-constants"
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

This reverts commit 87e0d4f0f37fb0c8c4aeeac46fff5e957738df79.

This was fixed in clang-6; the minimum supported version of clang in the
kernel is clang-10 (10.0.1).

Link: https://reviews.llvm.org/rL329300.
Link: https://github.com/ClangBuiltLinux/linux/issues/9
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 Makefile | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/Makefile b/Makefile
index 37739ee53f27..144ac6a073ff 100644
--- a/Makefile
+++ b/Makefile
@@ -932,15 +932,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, maybe-uninitialized)
 # disable invalid "can't wrap" optimizations for signed / pointers
 KBUILD_CFLAGS	+= $(call cc-option,-fno-strict-overflow)
 
-# clang sets -fmerge-all-constants by default as optimization, but this
-# is non-conforming behavior for C and in fact breaks the kernel, so we
-# need to disable it here generally.
-KBUILD_CFLAGS	+= $(call cc-option,-fno-merge-all-constants)
-
-# for gcc -fno-merge-all-constants disables everything, but it is fine
-# to have actual conforming behavior enabled.
-KBUILD_CFLAGS	+= $(call cc-option,-fmerge-constants)
-
 # Make sure -fstack-check isn't enabled (like gentoo apparently did)
 KBUILD_CFLAGS  += $(call cc-option,-fno-stack-check,)
 
-- 
2.28.0.402.g5ffc5be6b7-goog

