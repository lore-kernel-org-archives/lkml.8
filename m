Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A3BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98C522087C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729519AbgGaU1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:27:41 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36018 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaU1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:27:41 -0400
Received: by mail-qk1-f196.google.com with SMTP id g26so30048837qka.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 13:27:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mXwPeMu1XjGHX9Op5CjnYwN6D6BW1B34DbH0SYA/L18=;
        b=gCNZYk74q9tedNqWjL5zkADM26tKrLy2WBpm5uwKPKR4AI8wSQQYg5tJ9OUv7EwkNe
         ehfLkwg8ZKQ4whgIRIRcwHjltZdHpD12Jtk+TuEVL5fjcWQv9LRGBG6zaL1wHuSHBRPm
         FPdMiDQCwd6A98fwjotDOdI4DV4l7738wIf3N38NKjWFURnE3HC5i9uyAJsSxVhBgv5R
         gAXk2DhfoDRWhbMGxfPeerHAMx5f75lJWPynFr5JdY7f1rxSVEryffnMytUIUSYvUuTK
         gH2XmJNUapN2AVvm1bkpXN9c2h1hEJO7uIBT0MbkmSx39oviyzuufNNYVPTc7lP+62YD
         Y+YA==
X-Gm-Message-State: AOAM531VFKULcgFEh/rhGUCkTb527fgQ9bAvCLRjBb/e9VHPDl1VjMM4
        xAQ80QhprozrS+ShStqnLLQ=
X-Google-Smtp-Source: ABdhPJwP2oxSh22stI4dtpl8U/+EoVi0C1gKXBMqGjUQJky6XK6h5xG856i3BOP7OvzoEJzeIQR3IQ==
X-Received: by 2002:a37:6556:: with SMTP id z83mr5396568qkb.406.1596227259986;
        Fri, 31 Jul 2020 13:27:39 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t35sm10607976qth.79.2020.07.31.13.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 13:27:39 -0700 (PDT)
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
Subject: [PATCH v6 0/7] x86/boot: Remove run-time relocations from compressed kernel
Date:   Fri, 31 Jul 2020 16:27:31 -0400
Message-Id: <20200731202738.2577854-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CA+icZUV2=hj=+9DtbH47wtdE=GM5AZjS1xTgH7PKE+NxsRa2jw@mail.gmail.com>
References: <CA+icZUV2=hj=+9DtbH47wtdE=GM5AZjS1xTgH7PKE+NxsRa2jw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v5:
- Rebase onto v5.8-rc7 to resolve Makefile conflict

v5: https://lore.kernel.org/lkml/20200715004133.1430068-1-nivedita@alum.mit.edu/

Changes from v4:
- Move -pie --no-dynamic-linker from KBUILD_LDFLAGS to LDFLAGS_vmlinux
  Sedat: I'm not clear on whether you tested with the final LDFLAGS,
  could you confirm: i.e. if you tested with -pie passed to LLD?
- Replace runtime -> run-time to be consistent in wording

Changes from v3:
- Move hidden.h to include/linux so the EFI stub and the compressed
  kernel can share the same file

Changes from v2:
- Incorporate Ard's patches for eliminating GOT references into this
  series
- Rebase on v5.8-rc3

Changes from v1:
- Add .text.* to setup.ld instead of just .text.startup
- Rename the la() macro introduced in the second patch for 64-bit to
  rva(), and rework the explanatory comment.
- In the last patch, check both .rel.dyn and .rela.dyn, instead of just
  one per arch.

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


base-commit: 92ed301919932f777713b9172e525674157e983d
-- 
2.26.2

