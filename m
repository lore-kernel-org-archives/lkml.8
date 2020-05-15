Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD385C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B98CB207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RR/K1jJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgEOPDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgEOPDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:03:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1F6C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:03:46 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id k15so2892082ybt.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=c51QaJvL6D/qqlVaG3mfBJRBx6GYLLBQHT61u+1oODA=;
        b=RR/K1jJtCOCT/6JoMxAIcZZsnTpgmVGsN47iiF7gTmxQ1alXp4PRAIRh+MoKcy8b9v
         T2YhTNDT4X3MBhI8ET/gYm5l5QFMySt2DIBTp4lDPGFcB8eMJJIWMR2iKzfIGRwhfhws
         v/GcyunXI6xYenGssjZYfbvrKTR+yseCHZnW5ZI3CiX5ew72KVYuNQqgfppGIzSswOjD
         ypl4HmlsT7dzJFX+/28WcP7r9WgtaX+tPQ9otTUpFNIK7yd/9rCTOlud2QhcC5oBi4k0
         uW0DmtigCNI/HbEn8g1ipIp44W+acGcWEaV2hZs+bDI0yTxu/YP8f++QB4/c0i1O2Oyu
         LLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=c51QaJvL6D/qqlVaG3mfBJRBx6GYLLBQHT61u+1oODA=;
        b=IIi9DCD/o63R4ySnDDH3nnOl3+e0D6KEx8nisaOl2P47i8Za6VzdVaG40odb5065UF
         0QGAyDkKsXxBk5w7qCSCK5AKcVjBOc9I+7L6q8W9ggNl+FiZ6X74fiRUxSuAQwbUMp6y
         pq1mH4Eb+796Quoafk0D3P1PUpVF9TNTJ8sPk5FoNsW3UwuYz2HN5sWeOmDXrDy7VmHC
         FNiBBPdAhhQHHWEmsP76U4AWhPFXRHtjR8AqN9X7krFxoO5iDkvVQDh3zdr0baLC0TL4
         3XjEByYE62/8GJFiw79MToHWwBoFD4SJ36DQ0xx+wDNMBz25tcGHajOQwvuIERZJXDjq
         cXtQ==
X-Gm-Message-State: AOAM532bGuH+seCcNhGuOgSQuxkNqCrKR/dnU5KwGSbQYPjwyDdGvzTT
        J2Bfioc8px/m4hKKk8sGF3h0IM7hMA==
X-Google-Smtp-Source: ABdhPJzOUfRS5O3oReRqmfbWku++WCbyJMTiwsoZfbDnP+oYAarTN+2y0VZa4z3iyt/UFTJZKzQV/w4uCA==
X-Received: by 2002:a25:2054:: with SMTP id g81mr6167148ybg.470.1589555025225;
 Fri, 15 May 2020 08:03:45 -0700 (PDT)
Date:   Fri, 15 May 2020 17:03:28 +0200
Message-Id: <20200515150338.190344-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip 00/10] Fix KCSAN for new ONCE (require Clang 11)
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, will@kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is the conclusion to [1], where we determined that due
to various interactions with no_sanitize attributes and the new
{READ,WRITE}_ONCE(), KCSAN will require Clang 11 or later. Other
sanitizers are largely untouched, and only KCSAN now has a hard
dependency on Clang 11. To test, a recent Clang development version will
suffice [2]. While a little inconvenient for now, it is hoped that in
future we may be able to fix GCC and re-enable GCC support.

The patch "kcsan: Restrict supported compilers" contains a detailed list
of requirements that led to this decision.

Most of the patches are related to KCSAN, however, the first patch also
includes an UBSAN related fix and is a dependency for the remaining
ones. The last 2 patches clean up the attributes by moving them to the
right place, and fix KASAN's way of defining __no_kasan_or_inline,
making it consistent with KCSAN.

The series has been tested by running kcsan-test several times and
completed successfully.

[1] https://lkml.kernel.org/r/CANpmjNOGFqhtDa9wWpXs2kztQsSozbwsuMO5BqqW0c0g0zGfSA@mail.gmail.com
[2] https://github.com/llvm/llvm-project

Arnd Bergmann (1):
  ubsan, kcsan: don't combine sanitizer with kcov on clang

Marco Elver (9):
  kcsan: Avoid inserting __tsan_func_entry/exit if possible
  kcsan: Support distinguishing volatile accesses
  kcsan: Pass option tsan-instrument-read-before-write to Clang
  kcsan: Remove 'noinline' from __no_kcsan_or_inline
  kcsan: Restrict supported compilers
  kcsan: Update Documentation to change supported compilers
  READ_ONCE, WRITE_ONCE: Remove data_race() wrapping
  compiler.h: Move function attributes to compiler_types.h
  compiler_types.h, kasan: Use __SANITIZE_ADDRESS__ instead of
    CONFIG_KASAN to decide inlining

 Documentation/dev-tools/kcsan.rst |  9 +------
 include/linux/compiler.h          | 35 ++-----------------------
 include/linux/compiler_types.h    | 32 +++++++++++++++++++++++
 kernel/kcsan/core.c               | 43 +++++++++++++++++++++++++++++++
 lib/Kconfig.kcsan                 | 20 +++++++++++++-
 lib/Kconfig.ubsan                 | 11 ++++++++
 scripts/Makefile.kcsan            | 15 ++++++++++-
 7 files changed, 122 insertions(+), 43 deletions(-)

-- 
2.26.2.761.g0e0b3e54be-goog

