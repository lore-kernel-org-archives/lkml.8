Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F03C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C774207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A8yrTvao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgEULJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgEULJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:09:51 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14B3C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:09:49 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id d11so6749886qvv.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IzoT0kShpKOHmhw0CGt76GVflwk27IMd1HUpDtAtB68=;
        b=A8yrTvao4Yqh2hmgoNh7HHUty4psgZkGzPbI46+MroPSIa/qOEc2UmHxKFZtk9W10k
         +aMCN6l7qNTI01FUjFQWfHqq+6dz9I+e7zLG4pMaPL8+EzX09nHWlvn6J1DFVak9CFVE
         wXTYWoyefv1U9NlK5VvgSEKl62zVEkOPbppIT4+nCo4oN3tKEHDVZdjQHa7HQy6EWDsY
         ZFZPhda4MhZKFz0g/VZnMv32ekCvhm+fX3gdDYyCYLGxX2SdDBI+QKZ7Fzjz9NfSFc1j
         TpW3sMjK/zxngkOzCe9doZ/3A9am5iBgHUKl8xl/2cgDQFMUcp9oc5vKzu/A2iMa2H4M
         iHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IzoT0kShpKOHmhw0CGt76GVflwk27IMd1HUpDtAtB68=;
        b=TEtUPeolZWEMx6TRulDj+JWLDkOM0oXZbqvCQC5dswGT70M04bKrjGKBBrZKVtT4jy
         L+a6CmsT/aIWqRQwLNTMMZ14PdWLJI3QU25PnO6i1ZsTxVIposZM2bGZLAyncj4xjtxR
         Bs+tTArFqiluDwpZHzjA0uY7/r4Gq5XGmnPzDhd6PnlRGyDguiA5FZ98+C49TZPDQQ3/
         5V0Y3OHQ8yfyzxuF1nKX93ARjiEn00k/52Yvl+DJhP4McSZbn22l0T1adeFk37k6CrKD
         Wpi4lkjSiIshSfzcuwspmPatfH4KMDOS3Ek9nkJL27U3a5BnPROJRz8hT2tJin3VrqRh
         a8KQ==
X-Gm-Message-State: AOAM531imseHCPjNN/brxKi1p3DuqF0egRCBRh3tqQ8SMxGIh+TGHMZp
        q3AHGnWodFcNh+6Eq4VnzSuwVlQS5Q==
X-Google-Smtp-Source: ABdhPJwJo+XYEyORIjfJ/oSzEKLBYEV6H46TO2do9QgqL5sD7FHZ3l7WYxBtZHpOZI/SCI1YT6CR8GHuug==
X-Received: by 2002:ad4:4e6a:: with SMTP id ec10mr9092247qvb.225.1590059388762;
 Thu, 21 May 2020 04:09:48 -0700 (PDT)
Date:   Thu, 21 May 2020 13:08:43 +0200
Message-Id: <20200521110854.114437-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip v2 00/11] Fix KCSAN for new ONCE (require Clang 11)
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

v2:
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
 include/linux/compiler.h          | 53 ++++---------------------------
 include/linux/compiler_types.h    | 32 +++++++++++++++++++
 kernel/kcsan/core.c               | 43 +++++++++++++++++++++++++
 lib/Kconfig.kcsan                 | 20 +++++++++++-
 lib/Kconfig.ubsan                 | 11 +++++++
 scripts/Makefile.kcsan            | 15 ++++++++-
 7 files changed, 126 insertions(+), 57 deletions(-)

-- 
2.26.2.761.g0e0b3e54be-goog

