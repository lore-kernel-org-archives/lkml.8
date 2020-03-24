Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D60C54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECC8C208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:32:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RCCVIU1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgCXUco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:32:44 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:56032 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgCXUcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:32:42 -0400
Received: by mail-pj1-f67.google.com with SMTP id mj6so36663pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 13:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xoyjnNIvkg+j3q/lUm3mcx/meHvti0L2223SyWgmbLU=;
        b=RCCVIU1gaUOt7SSOHOlSQWbk/wc0LVSYDRbdbvf7vkkrVHHkcc9wzrGS12OmXt54kW
         5eS34P5AROrJupwvYUnpBnA0SF51uAHA8is60V059MtkeksLPUZ0uD4HhT+sfHelhrx7
         6p/n0PbpIF84rBwBLyiZ4/znqUhgn9YMLGiuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xoyjnNIvkg+j3q/lUm3mcx/meHvti0L2223SyWgmbLU=;
        b=UC1KcgAL+nuSDkrvFgnnl6g1U1cEgveysAhfrq9D4EJLoZ+svH3ZPwaHLnA1qyqB4U
         ZzCE02kohwuW0etfC4s8dsePwmnS5KmygbnYGLFUTy5/X3D10K2mJOMRdmVCRdkunVPd
         GT+eH2YyUHz2bH4KSRmj6o1yfCS0dNBKxJJ+ocw7lNtHYQ0mF3KClfv2rv0sEU+99C/Z
         VNq8uON5vGyS2zFKhx3ZYaXY/xu27s7dP/0PLo1lZXTuIPYR8HT3UMOLp722T4Sa+Jtl
         I0QVLLVs8dBg8m0W5DhEZj2OjwMmYU33WezMvl2ky8Kxy9P6y1Kga1fDCN3nQjE0BM4J
         cWRA==
X-Gm-Message-State: ANhLgQ34OKsPNc+LrQcGoDNaaVusuyGc6b+XAhQUVkiU5rXEvC5UZxwW
        8MRC0uth9oy1fuMQT3p83KhvCw==
X-Google-Smtp-Source: ADFU+vsamiDb3vxQG8SScPpA98WBrw9+0joaymji73ZXk2ZhJ8zsjRiNpylOVu8a2158RuDNslMFDQ==
X-Received: by 2002:a17:902:82c5:: with SMTP id u5mr12381681plz.254.1585081960653;
        Tue, 24 Mar 2020 13:32:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t60sm3175485pjb.9.2020.03.24.13.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 13:32:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Elena Reshetova <elena.reshetova@intel.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        "Perla, Enrico" <enrico.perla@intel.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Optionally randomize kernel stack offset each syscall
Date:   Tue, 24 Mar 2020 13:32:26 -0700
Message-Id: <20200324203231.64324-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is a continuation and refactoring of Elena's earlier effort to add
kernel stack base offset randomization. In the time since the previous
discussions, two attacks[1][2] were made public that depended on stack
determinism, so we're no longer in the position of "this is a good idea
but we have no examples of attacks". :)

Earlier discussions also devolved into debates on entropy sources, which
is mostly a red herring, given the already low entropy available due
to stack size. Regardless, entropy can be changed/improved separately
from this series as needed.

Earlier discussions also got stuck debating how much syscall overhead
was too much, but this is also a red herring since the feature itself
needs to be selectable at boot with no cost for those that don't want it:
this is solved here with static branches.

So, here is an improved version, made as arch-agnostic as possible,
with usage added for x86 and arm64. It also includes some small static
branch clean ups.

-Kees

[1] https://a13xp0p0v.github.io/2020/02/15/CVE-2019-18683.html
[2] https://repositorio-aberto.up.pt/bitstream/10216/125357/2/374717.pdf

v2:
- move to per-cpu rdtsc() saved on syscall exit
- add static branches for zero-cost dynamic enabling
- Kconfig just selects the default state of static branch
- __builtin_alloca() produces ugly asm without -fno-stack-clash-protection
- made arch agnostic
rfc: https://lore.kernel.org/kernel-hardening/20190329081358.30497-1-elena.reshetova@intel.com/

Kees Cook (5):
  jump_label: Provide CONFIG-driven build state defaults
  init_on_alloc: Unpessimize default-on builds
  stack: Optionally randomize kernel stack offset each syscall
  x86/entry: Enable random_kstack_offset support
  arm64: entry: Enable random_kstack_offset support

 Makefile                         |  4 ++++
 arch/Kconfig                     | 19 +++++++++++++++
 arch/arm64/Kconfig               |  1 +
 arch/arm64/kernel/syscall.c      | 10 ++++++++
 arch/x86/Kconfig                 |  1 +
 arch/x86/entry/common.c          | 12 +++++++++-
 include/linux/jump_label.h       | 19 +++++++++++++++
 include/linux/mm.h               | 18 +++++---------
 include/linux/randomize_kstack.h | 40 ++++++++++++++++++++++++++++++++
 init/main.c                      | 23 ++++++++++++++++++
 mm/page_alloc.c                  | 12 ++--------
 11 files changed, 136 insertions(+), 23 deletions(-)
 create mode 100644 include/linux/randomize_kstack.h

-- 
2.20.1

