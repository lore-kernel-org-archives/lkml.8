Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB4FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 23:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D844B206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 23:16:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rnk2RVuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgDFXQN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 19:16:13 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:38303 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDFXQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 19:16:13 -0400
Received: by mail-pj1-f66.google.com with SMTP id m15so575429pje.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 16:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kj0fYRHBAuDC6xz5T3+IMY573Uf4TkncfKhylRhRKr8=;
        b=Rnk2RVuDB3re41BD3czt9clTzzC/cySvN48by3vzvbYksd47leEn0+g33oR+D6OVLF
         uXnS/s3ykH8Z394kfgC1rK54rvOztdgYEYgrOrRJV5V3tiF0pL7Q/1fZwsVEAzo0r6Bj
         pI05/jTCAIBznKwWxphMyFNjRNChw4MmGQa1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Kj0fYRHBAuDC6xz5T3+IMY573Uf4TkncfKhylRhRKr8=;
        b=l/N3wBWwa0her1baGGUxtgK6P6gBKQ0xe79XwUl/7uwh3pdKCHpjElK8oy5e9WsVbT
         7dkkNjzLzAyAvxdyn7nXM2n8gVMMQDyLxw1dxkrrqiwgAE5cH4HNYRmoWyl+tZGav1lC
         uOf+nOCS3Plo25QTTS2G+CB1ZVU+EKgh3wWW/q/MIub8OfcRhR1fcakUcMxyCn7Od9ch
         Pc0tTUOcmbINVIScTnMdqrO6Fecrc3a660rZ+i2JOxXhK7QUTMiClDgFwM+NSJD6OKEZ
         5CzbneSB5YkRN9Kj0oobCX4hzV2GrBv6NQBTRx7K7i9/H2XHURiOk0lLq7oUQziYPgxC
         lRtQ==
X-Gm-Message-State: AGi0PuarXd5WvdrEphM0kO1bwmyVDku0Fe0Ug2IWjSTgtcZfIEiDwWsg
        VO2TXA0R9CMDOqy1dhFU6pY2Vw==
X-Google-Smtp-Source: APiQypLe1NK0ouaCbwea2Ar/mlZdKQ8TmXJhYkOr0ndqJkk1T9pLSfqEkeDLbIKHtYCq5a4S/3PzgQ==
X-Received: by 2002:a17:902:22e:: with SMTP id 43mr21611580plc.119.1586214972026;
        Mon, 06 Apr 2020 16:16:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a24sm12522914pfl.115.2020.04.06.16.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 16:16:10 -0700 (PDT)
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
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] Optionally randomize kernel stack offset each syscall
Date:   Mon,  6 Apr 2020 16:16:01 -0700
Message-Id: <20200406231606.37619-1-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
- added review/ack tags (peterz, glider)
- further clarified commit logs and public attack references
- added -fstack-protector downgrades and details
v2: https://lore.kernel.org/lkml/20200324203231.64324-1-keescook@chromium.org/
rfc: https://lore.kernel.org/kernel-hardening/20190329081358.30497-1-elena.reshetova@intel.com/

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
branch clean ups, and addresses some surprise performance issues due to
the stack canary[3].

Thanks!

-Kees

[1] https://a13xp0p0v.github.io/2020/02/15/CVE-2019-18683.html
[2] https://repositorio-aberto.up.pt/bitstream/10216/125357/2/374717.pdf
[3] https://lore.kernel.org/lkml/202003281520.A9BFF461@keescook/

Kees Cook (5):
  jump_label: Provide CONFIG-driven build state defaults
  init_on_alloc: Unpessimize default-on builds
  stack: Optionally randomize kernel stack offset each syscall
  x86/entry: Enable random_kstack_offset support
  arm64: entry: Enable random_kstack_offset support

 Makefile                         |  4 ++++
 arch/Kconfig                     | 23 ++++++++++++++++++
 arch/arm64/Kconfig               |  1 +
 arch/arm64/kernel/Makefile       |  4 ++++
 arch/arm64/kernel/syscall.c      | 10 ++++++++
 arch/x86/Kconfig                 |  1 +
 arch/x86/entry/Makefile          |  9 +++++++
 arch/x86/entry/common.c          | 12 +++++++++-
 include/linux/jump_label.h       | 19 +++++++++++++++
 include/linux/mm.h               | 18 +++++---------
 include/linux/randomize_kstack.h | 40 ++++++++++++++++++++++++++++++++
 init/main.c                      | 23 ++++++++++++++++++
 mm/page_alloc.c                  | 12 ++--------
 13 files changed, 153 insertions(+), 23 deletions(-)
 create mode 100644 include/linux/randomize_kstack.h

-- 
2.20.1

