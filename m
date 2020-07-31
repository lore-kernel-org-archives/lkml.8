Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918FAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BCAA2087C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbgGaU1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:27:45 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:43290 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaU1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:27:42 -0400
Received: by mail-qk1-f195.google.com with SMTP id 2so25893476qkf.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 13:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=30+E7Q1Ff3fv5bN3vjge8KnB00o20EUIV34lHxLtCPk=;
        b=MApNo6yhZzDSAZicQw0rJ/ek03Vo8Q83GVZE7PT0B0OhUY4T7+FVo8QqZqLJQM3tBY
         Liijtqdph0xj+gS5IUMx73lE6fjywkX5RJjPZBi9JI2xHHhJI6godybyMboj5tKZBLy9
         ykJZAuD5Yla1fn+TXaiEim5l5Wmq20Y0Uuf5zlusHlcw2BLn+xtckwwkTPsAfABB3Cyc
         HzRGFeBmCtVWbLKa+8YpLx6mnPBDnRTUluyJ5gpXL5PWzCZ11mpgTDrkmQLt2AbUc9sm
         7QyX6Y9E8woluladJb6KhAu9Ppo7/uEAxc54wMyLwNoBB9C6VdPUyQMT4BfCblpvxoIo
         VODw==
X-Gm-Message-State: AOAM531fahEh0MZOI6Bj9+mbF+5wk9ljybmmYeHQ8oWPPTIrUgQhpiWv
        YxX8GMu1JrffedDkJoFT2pE=
X-Google-Smtp-Source: ABdhPJz2tbbJF3nDAMVD4Ar0oOF+eCbsvSQORYxh7h6mSCkm4Z0DXxhW1vg5e8MEIv55d2De2jGyxQ==
X-Received: by 2002:a37:e86:: with SMTP id 128mr5583050qko.314.1596227261197;
        Fri, 31 Jul 2020 13:27:41 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t35sm10607976qth.79.2020.07.31.13.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 13:27:40 -0700 (PDT)
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
Subject: [PATCH v6 1/7] x86/boot/compressed: Move .got.plt entries out of the .got section
Date:   Fri, 31 Jul 2020 16:27:32 -0400
Message-Id: <20200731202738.2577854-2-nivedita@alum.mit.edu>
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

From: Ard Biesheuvel <ardb@kernel.org>

The .got.plt section contains the part of the GOT which is used by PLT
entries, and which gets updated lazily by the dynamic loader when
function calls are dispatched through those PLT entries.

On fully linked binaries such as the kernel proper or the decompressor,
this never happens, and so in practice, the .got.plt section consists
only of the first 3 magic entries that are meant to point at the _DYNAMIC
section and at the fixup routine in the loader. However, since we don't
use a dynamic loader, those entries are never populated or used.

This means that treating those entries like ordinary GOT entries, and
updating their values based on the actual placement of the executable in
memory is completely pointless, and we can just ignore the .got.plt
section entirely, provided that it has no additional entries beyond
the first 3 ones.

So add an assertion in the linker script to ensure that this assumption
holds, and move the contents out of the [_got, _egot) memory range that
is modified by the GOT fixup routines.

While at it, drop the KEEP(), since it has no effect on the contents
of output sections that are created by the linker itself.

Tested-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Acked-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
From: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20200523120021.34996-2-ardb@kernel.org
---
 arch/x86/boot/compressed/vmlinux.lds.S | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 8f1025d1f681..b17d218ccdf9 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -44,10 +44,13 @@ SECTIONS
 	}
 	.got : {
 		_got = .;
-		KEEP(*(.got.plt))
 		KEEP(*(.got))
 		_egot = .;
 	}
+	.got.plt : {
+		*(.got.plt)
+	}
+
 	.data :	{
 		_data = . ;
 		*(.data)
@@ -77,3 +80,9 @@ SECTIONS
 
 	DISCARDS
 }
+
+#ifdef CONFIG_X86_64
+ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
+#else
+ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0xc, "Unexpected GOT/PLT entries detected!")
+#endif
-- 
2.26.2

