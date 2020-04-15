Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BF9C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBC142076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aI+z+lZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394031AbgDOObE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729358AbgDOOa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:30:59 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1982C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 07:30:58 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i10so34364wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 07:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WVkuuzK4PgjgPcUecDamfN8lzj8+MFn49CFhMsiWU1Q=;
        b=aI+z+lZqN8RAwrcKL+PCcVV/AGw8n+hw19895VT4bcqnDE5Cp1jrnS6q0SwOzFjzmb
         DwBpehbCR8/Rri5EztTcWYD/Z2sST/psPaLENQfz1DpcB7I//+TXN0cvL1bpH0UnYK2t
         aJY4dmMnmgeXFU547rapqdnZU45uO9nU28eJmqqwIyediN/QNKIuhVfoRmwX5ZLm4gFP
         aAHPblw6eQS0t5hQhV4mgmswHYp7LvQFWW7n+BidKtpupUZ66SOosxuf6bFFHok5PqK+
         bWKLX2wVw4AKvBGOwJgqEb6rCwNABsVUFDJP2lFLUzoKNPH0CN1tbMLbFyq5Tj7+7WWD
         fE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WVkuuzK4PgjgPcUecDamfN8lzj8+MFn49CFhMsiWU1Q=;
        b=OxmhEBo+vAYuP6FNK+ruYoNUALU/nGSPEPeemW8T4wv7KFCssoT5LqiLVOhDGG0RiG
         BYwtHFWjm6jjxSp8GN7z2LxQCNDLDi3S4Fb7BNPYNO/ZEPRLWKmgmg8tujcWmhNYDKBi
         XqSPtkZTiQhZcHjqxua70sJqzRXy6pQoWLAVGgWMfb9XvFnP6tbeTZSBXymi+nw2w9CW
         e6sTcOwiI9uvj0ZoTqgd9p+izcnFKUFDQnjd+RljRzv9GKOrYyMdEpE+ArKoAZkAtcUf
         5R2ZlySViXivdbsEmQ7e10Pm96nSq2XPfNcE9gmoCp+yKHZMRvCC8ch+tZBYYI+BATHc
         YEsA==
X-Gm-Message-State: AGi0PuZQWiICIVaeeHhyHMyd33qik/DWo8jy/zpVLNPTh6LGMpidwzN8
        NSc7LZO3Cr5veYBABHt4OV8=
X-Google-Smtp-Source: APiQypJgmDGWzHD2azrLJ0tSCMDRhVQQy9AkQtBwXMC9rDCLnUfEwsYJJ2qrIMFvOSOZwZ+LfT1Vqw==
X-Received: by 2002:adf:9564:: with SMTP id 91mr30246242wrs.246.1586961057372;
        Wed, 15 Apr 2020 07:30:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a58:8532:8700:d5dc:b247:cff7:f693])
        by smtp.gmail.com with ESMTPSA id x13sm11679305wmc.5.2020.04.15.07.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 07:30:56 -0700 (PDT)
From:   Ilie Halip <ilie.halip@gmail.com>
To:     linux-riscv@lists.infradead.org
Cc:     Fangrui Song <maskray@google.com>,
        Jordan Rupprecht <rupprecht@google.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mao Han <han_mao@c-sky.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH v2] riscv: fix vdso build with lld
Date:   Wed, 15 Apr 2020 17:29:58 +0300
Message-Id: <20200415142959.25673-1-ilie.halip@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with the LLVM linker this error occurrs:
    LD      arch/riscv/kernel/vdso/vdso-syms.o
  ld.lld: error: no input files

This happens because the lld treats -R as an alias to -rpath, as opposed
to ld where -R means --just-symbols.

Use the long option name for compatibility between the two.

Link: https://github.com/ClangBuiltLinux/linux/issues/805
Reported-by: Dmitry Golovin <dima@golovin.in>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Ilie Halip <ilie.halip@gmail.com>

---
Changed in v2:
  * a comment line dropped, another one slightly reworded
  * added Nick's Reviewed-by
---
 arch/riscv/kernel/vdso/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index 33b16f4212f7..a4ee3a0e7d20 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -33,15 +33,15 @@ $(obj)/vdso.so.dbg: $(src)/vdso.lds $(obj-vdso) FORCE
 	$(call if_changed,vdsold)
 
 # We also create a special relocatable object that should mirror the symbol
-# table and layout of the linked DSO.  With ld -R we can then refer to
-# these symbols in the kernel code rather than hand-coded addresses.
+# table and layout of the linked DSO. With ld --just-symbols we can then
+# refer to these symbols in the kernel code rather than hand-coded addresses.
 
 SYSCFLAGS_vdso.so.dbg = -shared -s -Wl,-soname=linux-vdso.so.1 \
 	-Wl,--build-id -Wl,--hash-style=both
 $(obj)/vdso-dummy.o: $(src)/vdso.lds $(obj)/rt_sigreturn.o FORCE
 	$(call if_changed,vdsold)
 
-LDFLAGS_vdso-syms.o := -r -R
+LDFLAGS_vdso-syms.o := -r --just-symbols
 $(obj)/vdso-syms.o: $(obj)/vdso-dummy.o FORCE
 	$(call if_changed,ld)
 
-- 
2.17.1

