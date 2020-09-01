Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A50C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BAD72145D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="rVVSYY3/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgIAAXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 20:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgIAAXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 20:23:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7587CC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:23:32 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o16so179967ybe.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=NEi5SY5avnbdRDKWM6EkMbB9CYf2qgLLnorTM1MWHus=;
        b=rVVSYY3/7bGkSisltWS7LTEuDoxZTUtYDTG6fiC1A2JdGxyVJcz25weD53cbc7nbhw
         COqtL/ji6xKg+PjkWLuv2xh+LODFH2E4Q6oMlPn7I3ebDC3xVw7+rtqfV4WhK7aAekxx
         OpN2iroTjKwbjk/7Eopfs8qqP/fSPd22wCzsUYRNN8BjGdWFTxRG5Ge3b3qJ2mbWTKwn
         c2prJuXrfHRZP0f5v+N8WkC0rEw+0wAvh2n6M/HEYJdqVQd4noDC0yyMENwDVg1miLPU
         YoEZWfqeykUK9//6AIRnoHLp2rak/P0mrVNYC4pFDP+ASatFXQiFIoigTQNlgodHlWPK
         QGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=NEi5SY5avnbdRDKWM6EkMbB9CYf2qgLLnorTM1MWHus=;
        b=REm5JiHplpIkZONjSl1hsMnmDWYMCUuD8+kzl5kvPrMjoFaIrZIO8bLhEHRnJzCCIe
         BfPMauew6y8ruxpIumY/S9CPZhQdonxj6obntUKpKEGo3BwVcp7FaraxQk9G5moHBLB9
         eRhCdy3SJN2hLzWov75yOBEqn+DpSXA8FGNgbijIU7ownwnk8FHz7Gm0ESY3+Ccd/BDF
         20AaULxVgkVbAuYqPSEVYdR1Eavayu7K2e0B4kxkuPc5bjRlaF1s5R3tjvIp0f621zJ7
         A40U4jSfFAKvRYIr1RaChdCBYmqjVaHSkHMa9XGZ04X9/uCY7vYT2oQH/0cMAzQZwBAx
         aaUw==
X-Gm-Message-State: AOAM533UjMcFMFPpnRr9ObuRKCXD9kriETsT4cYgN1umQ0pEfvqzY2Ee
        11iRMVgjtkq9ZIyFsxbIZ3/KlMwiFNEDPzGSJXc=
X-Google-Smtp-Source: ABdhPJw5hScYOdiK6tdHyX+jSfRjvP8SrGOXGcVVoZitQU5liu210XuiGzC84PRxVEmbKYHp0iot1a0E52po9gC5FCI=
X-Received: from ndesaulniers1.mtv.corp.google.com ([2620:15c:211:202:f693:9fff:fef4:4d25])
 (user=ndesaulniers job=sendgmr) by 2002:a25:32c7:: with SMTP id
 y190mr6412975yby.441.1598919811518; Mon, 31 Aug 2020 17:23:31 -0700 (PDT)
Date:   Mon, 31 Aug 2020 17:23:19 -0700
Message-Id: <20200901002326.1137289-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v2 0/7] set clang minimum version to 10.0.1
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

Marco Elver (1):
  kasan: Remove mentions of unsupported Clang versions

Nick Desaulniers (6):
  compiler-clang: add build check for clang 10.0.1
  Revert "kbuild: disable clang's default use of -fmerge-all-constants"
  Revert "arm64: bti: Require clang >= 10.0.1 for in-kernel BTI support"
  Revert "arm64: vdso: Fix compilation with clang older than 8"
  Partial revert "ARM: 8905/1: Emit __gnu_mcount_nc when using Clang
    10.0.0 or newer"
  compiler-gcc: improve version warning

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

