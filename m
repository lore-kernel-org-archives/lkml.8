Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190B1C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 22:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A2520767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 22:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="B3bpWMEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgIBW7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 18:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIBW7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 18:59:20 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90ECC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 15:59:20 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id n189so453091qkf.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 15:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=4LNAUj+9lqh7okdpB7PIcXz5pRABwVJmB1BY1jfRsMQ=;
        b=B3bpWMEqHpTV/lbL95UEgU273zJVk5BYS7kX5e1Jj3VpsECkzPm36tehCnZMFbCZzS
         hTFR0DkKWyqZKpoK3sAbN0drY5Os+VFaDIDQOyfBD4SNAgsj0N1dSMH2nkYbVbixpnmN
         hQguG6AkvFkihQ+YInfEBSHAMzW3Rx7Ql+7PPRrU4uHviMiunUqgq3btO7H3o2EKzDlS
         /PxyKrMBeQMwt+sd5PV1h3XxSq6ka03tAw+Pe/1dpL/eySD+HAR3OelP1DRY1j55EusS
         MoZKU2oNKRi1niIcTq5akroQWqdzTesN0sbzUDhIbOYJnKGrrv3ixYtC3QBK6hJKGagB
         IQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=4LNAUj+9lqh7okdpB7PIcXz5pRABwVJmB1BY1jfRsMQ=;
        b=kLugFkqZSwtyWJ7HFwc65JDl7tSw0m16EVssOzGY/BU4Laxy/QB4+yixGSxxhjY/Xs
         GwvoB8YptBp0EB2zgeO1GBmDdjr1HqUsMrDhIDkCjZ/u/svsVxkhzcFypsv/KwODxD3c
         0ifzLiMFr7vXH/NOURqy7u0Ept7YG9oLblSOIPMG5d11oLzSEb3KMHmiBKaV/4u8MLNm
         QgwMGBHi9YVdx3EQZNTSMuUR6y6VyLDTk+i0mvXurUfrCny82PiiRrS8uzuwKvrxw0bY
         EjrgyRq8YzwGNKGdQuY9vUcOGd3RAqBa22bL5ELLUYAOnF95UQgECzgJf3VDEOg5xTer
         /CgQ==
X-Gm-Message-State: AOAM5324SQ2qcPCcDOpJ96ZAX3FJzvLPP+qJQbztUUzZ0mTKvQaFlaJg
        r8pCGcLg+6o9Dt7d8LdlgMV5oU7Fkv/vaNJM1fc=
X-Google-Smtp-Source: ABdhPJy+R7dwneWK1QNRO5Vc4Bkx/yJXq3ynIaBTr1tSVHMcqOLYiUDYoZdlCOXCDDb2k3MhxM/lfMJhBR/nLYT4J64=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:ad4:55ce:: with SMTP id
 bt14mr741179qvb.2.1599087557977; Wed, 02 Sep 2020 15:59:17 -0700 (PDT)
Date:   Wed,  2 Sep 2020 15:59:04 -0700
Message-Id: <20200902225911.209899-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v3 0/7] set clang minimum version to 10.0.1
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

Adds a compile time #error to compiler-clang.h setting the effective
minimum supported version to clang 10.0.1. A separate patch has already
been picked up into the Documentation/ tree also confirming the version.

Next are a series of reverts. One for 32b arm is a partial revert.

Then Marco suggested fixes to KASAN docs.

Finally, improve the warning for GCC too as per Kees.

Patches after 001 are new for v2.

v3 just collects tags and fixes typos in a few commit messages.

Marco Elver (1):
  kasan: Remove mentions of unsupported Clang versions

Nick Desaulniers (6):
  compiler-clang: add build check for clang 10.0.1
  Revert "kbuild: disable clang's default use of -fmerge-all-constants"
  Revert "arm64: bti: Require clang >= 10.0.1 for in-kernel BTI support"
  Revert "arm64: vdso: Fix compilation with clang older than 8"
  Partially revert "ARM: 8905/1: Emit __gnu_mcount_nc when using Clang
    10.0.0 or newer"
  compiler-gcc: improve version error

 Documentation/dev-tools/kasan.rst | 4 ++--
 Makefile                          | 9 ---------
 arch/arm/Kconfig                  | 2 +-
 arch/arm64/Kconfig                | 2 --
 arch/arm64/kernel/vdso/Makefile   | 7 -------
 include/linux/compiler-clang.h    | 8 ++++++++
 include/linux/compiler-gcc.h      | 2 +-
 lib/Kconfig.kasan                 | 9 ++++-----
 8 files changed, 16 insertions(+), 27 deletions(-)

-- 
2.28.0.402.g5ffc5be6b7-goog

