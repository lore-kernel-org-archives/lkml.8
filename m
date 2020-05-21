Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA62CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94E442083E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N53ce3W4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgEUOWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgEUOWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:22:22 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A323C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:22:21 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s8so5409529ybj.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=oGh0kqYNNAZM+Pjnllixvw53KGUxiJ/hODIqL9XqSI8=;
        b=N53ce3W4F1IpXl4ChkhdD3LWxnFiRQVJTDL/wOUQii97P48NWSVAOdhXhgVaK48dk2
         Nt+pmmEb6P2ovsbhfKsEFFJSCEh04b4IQXvk5tWHWPZB0OwsKf9HGGkpT9xSP+2cE+Jw
         feBQA60lAHIvLnpOGDdkBImyHOP2cSc8S44i3uHeB7sydq7ipF07dXaD07zKMLwfaHB0
         7UuBbFsW5XcbfHbbdvwMg36zr8EGAu1uAJCzt4XR1ghuFjJ1MU9KRNUzD0y2mPkd12zn
         6LSIa0TMbDakv/vL8ba+Kzlfali/1fW2BgEIqAUE59I9Fk9i+6XG8BPCy0dWyRthf+rR
         B46g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=oGh0kqYNNAZM+Pjnllixvw53KGUxiJ/hODIqL9XqSI8=;
        b=bcYVt2gAOOcPRLd35ZpuBqWRStySLG8oDOvpvwoyVRxoV55a4tnDduDxW2Sk6WQtC8
         qTRkX1DhWodJ6dhoH0H+bC8RUgamY7ZlZTWcima7ZEUiGDdwksNWjz/gTXnr9xXpFi+d
         Fd6+1Pf51yh5faKZdamVwTPl/4sTSWeL0bQCCdalY2p0OsmwiHlgl3B0+GsONJ1Yh2dI
         NnS3w9lvMufW2WGGUq1GVbgivP0Z1SrO2t1hn8/7u8mQREzJlAvtuPOgLWDe9xZ5/qH1
         vLI4U5/Je62yu0bq84JrSjgg1sGNvixk2mhVMDpiGIRKFRqC6DDzy6DPUqnFIZfwCZup
         5QaQ==
X-Gm-Message-State: AOAM531fWbGALVNsOaf2vwN4pw8UHRmdVr+keHbu4hcZCUycvkYkude/
        nYfIwBLTaebpDuEEPWS9gH8DOWATJw==
X-Google-Smtp-Source: ABdhPJwmv+6MclTJ+EllMyykRGDynVdX1CSwgVjgvmo8lvm1yGwryMBM851g6lmcfGhz8fsMcz0wMyHVXQ==
X-Received: by 2002:a25:e86:: with SMTP id 128mr16977291ybo.344.1590070940186;
 Thu, 21 May 2020 07:22:20 -0700 (PDT)
Date:   Thu, 21 May 2020 16:20:36 +0200
Message-Id: <20200521142047.169334-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip v3 00/11] Fix KCSAN for new ONCE (require Clang 11)
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, will@kernel.org,
        clang-built-linux@googlegroups.com, bp@alien8.de
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

v3:
* data_race() fix for 'const' non-scalar expressions.
* Add a missing commit message.
* Add Will's Acked-by.

v2: https://lkml.kernel.org/r/20200521110854.114437-1-elver@google.com
* Remove unnecessary kcsan_check_atomic in ONCE.
* Simplify __READ_ONCE_SCALAR and remove __WRITE_ONCE_SCALAR. This
  effectively restores Will Deacon's pre-KCSAN version:
  https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/tree/include/linux/compiler.h?h=rwonce/cleanup#n202
* Introduce patch making data_race() a single statement expression in
  response to apparent issues that compilers are having with nested
  statement expressions.

Arnd Bergmann (1):
  ubsan, kcsan: don't combine sanitizer with kcov on clang

Marco Elver (10):
  kcsan: Avoid inserting __tsan_func_entry/exit if possible
  kcsan: Support distinguishing volatile accesses
  kcsan: Pass option tsan-instrument-read-before-write to Clang
  kcsan: Remove 'noinline' from __no_kcsan_or_inline
  kcsan: Restrict supported compilers
  kcsan: Update Documentation to change supported compilers
  READ_ONCE, WRITE_ONCE: Remove data_race() and unnecessary checks
  data_race: Avoid nested statement expression
  compiler.h: Move function attributes to compiler_types.h
  compiler_types.h, kasan: Use __SANITIZE_ADDRESS__ instead of
    CONFIG_KASAN to decide inlining

 Documentation/dev-tools/kcsan.rst |  9 +-----
 include/linux/compiler.h          | 54 ++++---------------------------
 include/linux/compiler_types.h    | 32 ++++++++++++++++++
 kernel/kcsan/core.c               | 43 ++++++++++++++++++++++++
 lib/Kconfig.kcsan                 | 20 +++++++++++-
 lib/Kconfig.ubsan                 | 11 +++++++
 scripts/Makefile.kcsan            | 15 ++++++++-
 7 files changed, 127 insertions(+), 57 deletions(-)

-- 
2.26.2.761.g0e0b3e54be-goog

