Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F221DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3372074B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 20:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgGQUSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 16:18:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35818 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgGQUSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:18:04 -0400
Received: by mail-qt1-f195.google.com with SMTP id b25so8640828qto.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 13:18:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U+b+56aZeJ+dA/DwFU4piC2yXOfEGm7UE3mUYxXe5/o=;
        b=h/S2Bu3ujWssPVfqL/tgiv1yXqnNdxyn2g3kP+JWhRDdrdVwdlff0yduX3/1GJvXxk
         tABqhF2shLcG7cbVSpvr8wTiWPT9SbfhIB7rtp2+9ZvLI5EBg5PRb/6Y0QRMsdIuCoie
         doPJ3kwQdwG8htfiWs6EGFEvmXLSQ34U+XSzmzcd/GHMMNo6HHoqOAHSBoitThDLQiKY
         q8+yO/g6or7J5zj4g1ca1lm1Z74VmvPLgqTLGxatqxchoysAggp8H7hpkHyZBKHzH8Xo
         vQfF8d/KYb7ewlHMgv7ft01/5Bqt+h5l/zW1nSZgiUWyCdK9TVFR93sZGdGZX4K6LbTK
         W8dQ==
X-Gm-Message-State: AOAM5339uuqfauiCS1mOhc1At40I9w5m7TEfoxYDR7RDL1nCDe+/KFHO
        rpb/SYQYeZcGxJR7ohjO8fI=
X-Google-Smtp-Source: ABdhPJy0ulfttu50rtos+L+iPl7N2mnAIZgC0i8/WaAA5Jibz1Smsp7KlfPtFLDkq9WfVCLW6UzhBw==
X-Received: by 2002:ac8:7b38:: with SMTP id l24mr12617917qtu.122.1595017083332;
        Fri, 17 Jul 2020 13:18:03 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a28sm9509977qko.45.2020.07.17.13.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 13:18:02 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Subject: [PATCH-next v5 0/7] x86/boot: Remove run-time relocations from compressed kernel
Date:   Fri, 17 Jul 2020 16:17:54 -0400
Message-Id: <20200717201801.3661843-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CAKwvOdnTbatx8VB-rJSzyFPwfYnkMYK28yLBn1G+hUu8dyfYRA@mail.gmail.com>
References: <CAKwvOdnTbatx8VB-rJSzyFPwfYnkMYK28yLBn1G+hUu8dyfYRA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same as v5 previously posted, but rebased onto next-20200717.

v5: https://lore.kernel.org/lkml/20200715004133.1430068-1-nivedita@alum.mit.edu/

Ard Biesheuvel (3):
  x86/boot/compressed: Move .got.plt entries out of the .got section
  x86/boot/compressed: Force hidden visibility for all symbol references
  x86/boot/compressed: Get rid of GOT fixup code

Arvind Sankar (4):
  x86/boot: Add .text.* to setup.ld
  x86/boot: Remove run-time relocations from .head.text code
  x86/boot: Remove run-time relocations from head_{32,64}.S
  x86/boot: Check that there are no run-time relocations

 arch/x86/boot/compressed/Makefile      |  39 +-----
 arch/x86/boot/compressed/head_32.S     |  99 +++++----------
 arch/x86/boot/compressed/head_64.S     | 165 ++++++++++---------------
 arch/x86/boot/compressed/mkpiggy.c     |   6 +
 arch/x86/boot/compressed/vmlinux.lds.S |  24 +++-
 arch/x86/boot/setup.ld                 |   2 +-
 drivers/firmware/efi/libstub/Makefile  |   2 +-
 drivers/firmware/efi/libstub/hidden.h  |   6 -
 include/linux/hidden.h                 |  19 +++
 9 files changed, 153 insertions(+), 209 deletions(-)
 delete mode 100644 drivers/firmware/efi/libstub/hidden.h
 create mode 100644 include/linux/hidden.h


base-commit: aab7ee9f8ff0110bfcd594b33dc33748dc1baf46
-- 
2.26.2

