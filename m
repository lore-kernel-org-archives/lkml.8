Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B6AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8097422B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbgGaU1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:27:48 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:40090 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbgGaU1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:27:45 -0400
Received: by mail-qv1-f67.google.com with SMTP id s15so10279144qvv.7
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 13:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/qFh9Opkyntlzw0i22olFtyaXhlBJzScI7oKFJf/9uI=;
        b=eqgZvkExtmuTQ/ylwKtcsJcgnj/iKgApe4+NS8TYK7QIEVUVrGmB9/Kb/IRS3xCUP/
         0lmgJOaKxweCOIMreZgo9P2RgRN0dmu+W1xfeS/s9tmsV/2RQ5HTQGCO3l3XWyJGETrF
         2uHu+zdoPgUwkhUUzkhX6k7jXHteHZQ+UqpeBn1oTqO7dO/Skec07Fe3mGHuh2r6fQRY
         Vg+AqDj0ZnchlxPma4LYq8bCMTpLlXl2ysM6KAFFXBjVlityfb2KY4Huxd0wO62t2Vxj
         vPAvteagvZw1vHsgL9+ocKzMAdWloBB/WKkzK+xJ1gBn8PytJx/Elz2cuUjRx998zqHY
         TjuA==
X-Gm-Message-State: AOAM532SK/+7c9EJegfIQxRpeqjvai0j0LabMTKm/bG6deZkdbkcbPmh
        Iq7OSCV9CRcCgHvsqPb4HHo=
X-Google-Smtp-Source: ABdhPJxuvr4l9s6SfO05PReAHFDsQIom+od03MDWOQzNjzXVN0/zuAlk64HfbfSwh5vsYrbM0crdxQ==
X-Received: by 2002:ad4:438e:: with SMTP id s14mr5764504qvr.18.1596227264159;
        Fri, 31 Jul 2020 13:27:44 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t35sm10607976qth.79.2020.07.31.13.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 13:27:43 -0700 (PDT)
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
Subject: [PATCH v6 4/7] x86/boot: Add .text.* to setup.ld
Date:   Fri, 31 Jul 2020 16:27:35 -0400
Message-Id: <20200731202738.2577854-5-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200731202738.2577854-1-nivedita@alum.mit.edu>
References: <CA+icZUV2=hj=+9DtbH47wtdE=GM5AZjS1xTgH7PKE+NxsRa2jw@mail.gmail.com>
 <20200731202738.2577854-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc puts the main function into .text.startup when compiled with -Os (or
-O2). This results in arch/x86/boot/main.c having a .text.startup
section which is currently not included explicitly in the linker script
setup.ld in the same directory.

The BFD linker places this orphan section immediately after .text, so
this still works. However, LLD git, since [1], is choosing to place it
immediately after the .bstext section instead (this is the first code
section). This plays havoc with the section layout that setup.elf
requires to create the setup header, for eg on 64-bit:

    LD      arch/x86/boot/setup.elf
  ld.lld: error: section .text.startup file range overlaps with .header
  >>> .text.startup range is [0x200040, 0x2001FE]
  >>> .header range is [0x2001EF, 0x20026B]

  ld.lld: error: section .header file range overlaps with .bsdata
  >>> .header range is [0x2001EF, 0x20026B]
  >>> .bsdata range is [0x2001FF, 0x200398]

  ld.lld: error: section .bsdata file range overlaps with .entrytext
  >>> .bsdata range is [0x2001FF, 0x200398]
  >>> .entrytext range is [0x20026C, 0x2002D3]

  ld.lld: error: section .text.startup virtual address range overlaps
  with .header
  >>> .text.startup range is [0x40, 0x1FE]
  >>> .header range is [0x1EF, 0x26B]

  ld.lld: error: section .header virtual address range overlaps with
  .bsdata
  >>> .header range is [0x1EF, 0x26B]
  >>> .bsdata range is [0x1FF, 0x398]

  ld.lld: error: section .bsdata virtual address range overlaps with
  .entrytext
  >>> .bsdata range is [0x1FF, 0x398]
  >>> .entrytext range is [0x26C, 0x2D3]

  ld.lld: error: section .text.startup load address range overlaps with
  .header
  >>> .text.startup range is [0x40, 0x1FE]
  >>> .header range is [0x1EF, 0x26B]

  ld.lld: error: section .header load address range overlaps with
  .bsdata
  >>> .header range is [0x1EF, 0x26B]
  >>> .bsdata range is [0x1FF, 0x398]

  ld.lld: error: section .bsdata load address range overlaps with
  .entrytext
  >>> .bsdata range is [0x1FF, 0x398]
  >>> .entrytext range is [0x26C, 0x2D3]

Add .text.* to the .text output section to fix this, and also prevent
any future surprises if the compiler decides to create other such
sections.

[1] https://reviews.llvm.org/D75225

Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Fangrui Song <maskray@google.com>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/setup.ld | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/boot/setup.ld b/arch/x86/boot/setup.ld
index 24c95522f231..49546c247ae2 100644
--- a/arch/x86/boot/setup.ld
+++ b/arch/x86/boot/setup.ld
@@ -20,7 +20,7 @@ SECTIONS
 	.initdata	: { *(.initdata) }
 	__end_init = .;
 
-	.text		: { *(.text) }
+	.text		: { *(.text .text.*) }
 	.text32		: { *(.text32) }
 
 	. = ALIGN(16);
-- 
2.26.2

