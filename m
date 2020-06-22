Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28E3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5B6220776
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DooZtDOK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgFVTcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbgFVTby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:31:54 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BA4C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:31:53 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i12so317110pju.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 12:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dNG40zysheY5oB4//u6Wgw3XPF1EPVf4SWmTm1L7IBk=;
        b=DooZtDOKEbuL4Lmq0EjvgBqtOhkWAVzaD4OoBh35ywAVTh+8jjPlVrIL5pPZ1PCtVX
         +7Qt9x93Bf6jWHUSYtMRAfTERsAnE8XlcUxfZu12iJaw18sHA1rR1SQN279dsa6bQ3wr
         FyhdWobCP/rLa3NIoSLGX9JY/N9OLOfKVoKSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dNG40zysheY5oB4//u6Wgw3XPF1EPVf4SWmTm1L7IBk=;
        b=XqvVdfW6N7PKQZROhBy9Kycafgv8/oaQAvqRHdxPiDU5UbHgmq/+y0WunyLc+p4mWi
         UhnEUtNh6CYdCC3Uwe1yweCHpxqKP6iaNnNol1SF7bqrwpMiLMuGpImikOzoLGSHUyqo
         dR1kkGyTzELMnNksLlJQVFARdU79OVltRa+3IRpfIQ+WXeuEySNB2yH83WkSrjKijM8G
         BKvPDTa9D/hd0SQFJO4OKxLxkqDZ8jEaEwU1H+oZ6NwvUxe3uc291f2WtUxMQzsqb7qY
         nBGfcXIj9IoxYAn9ZIMqn5hJBPTfMsMHE7JKESGLLYersYDzKiqRxO/DMzZjjuXr7UIP
         tUlw==
X-Gm-Message-State: AOAM531rH1SVNg0aIwktI0erDUDY64+2jqOBiu7ElAcZ+Rt4lvH9MqKt
        PzeMJ9y8X9lYyIm4CsDneavSbw==
X-Google-Smtp-Source: ABdhPJwzvg0AysINBE9mrBB80x8GFaUJiCmnxanMRMBRbZ6JfPpnLr9CRvHSZ2l6hQg9n7Rg0F4HWg==
X-Received: by 2002:a17:90a:9f81:: with SMTP id o1mr19808289pjp.139.1592854313385;
        Mon, 22 Jun 2020 12:31:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q129sm13899450pfc.60.2020.06.22.12.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 12:31:50 -0700 (PDT)
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
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] Optionally randomize kernel stack offset each syscall
Date:   Mon, 22 Jun 2020 12:31:41 -0700
Message-Id: <20200622193146.2985288-1-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4:
- rebase to v5.8-rc2
v3: https://lore.kernel.org/lkml/20200406231606.37619-1-keescook@chromium.org/
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

Note that for v5.8, this depends on this fix (due to how x86 changed its
stack protector removal for syscall entry):
https://lore.kernel.org/lkml/202006221201.3641ED037E@keescook/

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
 arch/arm64/kernel/Makefile       |  5 ++++
 arch/arm64/kernel/syscall.c      | 10 ++++++++
 arch/x86/Kconfig                 |  1 +
 arch/x86/entry/common.c          | 11 +++++++++
 include/linux/jump_label.h       | 19 +++++++++++++++
 include/linux/mm.h               | 18 +++++---------
 include/linux/randomize_kstack.h | 40 ++++++++++++++++++++++++++++++++
 init/main.c                      | 23 ++++++++++++++++++
 mm/page_alloc.c                  | 12 ++--------
 12 files changed, 145 insertions(+), 22 deletions(-)
 create mode 100644 include/linux/randomize_kstack.h

-- 
2.25.1

